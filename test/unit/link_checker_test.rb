require 'test_plugin_helper'
require 'tempfile'
require_relative '../link_checker'

# Structure mirrors the real toc.json (no aliases key; aliases live in a separate file)
MINIMAL_TOC = {
  "some_guide" => {
    "new-chapter" => [
      "new-anchor",
    ],
    "chapter-with-subs" => [
      "sub-anchor-one",
      "Sub_Anchor_Mixed_Case",
    ],
  },
}.freeze

# Aliases live in a separate file, mirroring the real aliases.json
MINIMAL_ALIASES = {
  # anchor-level alias: the old anchor "old-anchor" (inside new-chapter) is now
  # "new-anchor" (inside new-chapter). A link to #old-anchor should be accepted.
  "some_guide/new-chapter#new-anchor" => [
    "some_guide/new-chapter#old-anchor",
  ],
  # section-level alias: the new section "new-chapter" is the canonical; "old-chapter" is an alias
  "some_guide/new-chapter" => [
    "some_guide/old-chapter",
  ],
  # guide-level alias: some_guide is the canonical; old_guide_name is an alias
  "some_guide" => [
    "old_guide_name",
  ],
}.freeze

class LinkCheckerTest < ActiveSupport::TestCase
  def setup
    @toc_file = Tempfile.new(['toc', '.json'])
    @toc_file.write(JSON.dump(MINIMAL_TOC))
    @toc_file.close

    @aliases_file = Tempfile.new(['aliases', '.json'])
    @aliases_file.write(JSON.dump(MINIMAL_ALIASES))
    @aliases_file.close

    @checker = LinksChecker.new(toc: @toc_file.path, aliases: @aliases_file.path)

    @toc_file.unlink
    @aliases_file.unlink
  end

  test "valid guide without anchor is valid" do
    assert @checker.test_link("some_guide/index")
  end

  test "non-existent guide is invalid" do
    assert_not @checker.test_link("nonexistent_guide/index")
  end

  test "valid guide with valid top-level chapter anchor is valid" do
    assert @checker.test_link("some_guide/index#new-chapter")
  end

  test "valid guide with invalid anchor is invalid" do
    assert_not @checker.test_link("some_guide/index#nonexistent-anchor")
  end

  test "guide and anchor matching is case-insensitive" do
    assert @checker.test_link("some_guide/index")
    assert @checker.test_link("SoMe_gUIDE/index")
    assert @checker.test_link("some_guide/index#sub_anchor_mixed_case")
    assert @checker.test_link("some_guide/index#SUB_ANCHOR_MIXED_CASE")
    assert @checker.test_link("SoMe_gUIDE/index#sub_anchor_mixed_case")
    assert @checker.test_link("SoMe_gUIDE/index#SUB_ANCHOR_MIXED_CASE")
  end

  test "old anchor resolves to new anchor via alias" do
    # The alias maps: some_guide/new-chapter#new-anchor <- some_guide/old-chapter#old-anchor
    # A link pointing to the old anchor should be accepted because the checker
    # resolves it to the canonical new-anchor, which exists in the TOC.
    assert @checker.test_link("some_guide/index#old-anchor")
  end

  test "aliases are transitive" do
    @checker.expects(:configured_redirects).returns({
      "old_guide_name" => "some_guide",
    })
    assert @checker.test_link("old_guide_name/index#old-anchor")
  end

  test "non-aliased unknown anchor is invalid" do
    assert_not @checker.test_link("some_guide/index#completely-unknown-anchor")
  end

  test "old guide name with no configured redirect is considered invalid and emits a warning" do
    # old_guide_name is listed as an alias for some_guide, but CONFIGURED_REDIRECTS
    # is empty, so guide-level aliases must not be followed silently.
    _out, err = capture_io do
      assert_not @checker.test_link("old_guide_name/index")
    end
    assert_match(/old_guide_name/, err)

    @checker.expects(:configured_redirects).returns({
      "old_guide_name" => "some_guide",
    })
    assert @checker.test_link("old_guide_name/index")
  end

  test "TOC without aliases file does not crash" do
    toc_without_aliases = Tempfile.new(['toc_no_aliases', '.json'])
    toc_without_aliases.write(JSON.dump("some_guide" => { "a-chapter" => [] }))
    toc_without_aliases.close

    checker = LinksChecker.new(toc: toc_without_aliases.path, aliases: nil)
    assert checker.test_link("some_guide/index")
    assert checker.test_link("some_guide/index#a-chapter")
    assert_not checker.test_link("some_guide/index#missing")
  ensure
    toc_without_aliases.unlink
  end
end
