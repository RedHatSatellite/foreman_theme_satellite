require 'test_plugin_helper'
require 'tempfile'
require_relative '../link_checker'

BASE_URL = 'https://something.somewhere.com/not/really/important/html/'.freeze

# Structure mirrors the real toc.json (guides/chapters/anchors only)
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

# Structure mirrors the real aliases.json (separate from toc.json)
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
    assert @checker.test_link("#{BASE_URL}some_guide/new-chapter")
  end

  test "non-existent guide is invalid" do
    assert_not @checker.test_link("#{BASE_URL}nonexistent_guide/new-chapter")
  end

  test "valid guide with valid top-level chapter anchor is valid" do
    assert @checker.test_link("#{BASE_URL}some_guide/new-chapter#new-anchor")
  end

  test "valid guide with invalid anchor is invalid" do
    assert_not @checker.test_link("#{BASE_URL}some_guide/new-chapter#nonexistent-anchor")
  end

  test "guide, chapter and anchor matching is case-insensitive" do
    assert @checker.test_link("#{BASE_URL}some_guide/new-chapter")
    assert @checker.test_link("#{BASE_URL}SoMe_gUIDE/new-chapter")
    assert @checker.test_link("#{BASE_URL}some_guide/chapter-with-subs#Sub_Anchor_Mixed_Case")
    assert_not @checker.test_link("#{BASE_URL}some_guide/chapter-with-subs#sub_anchor_mixed_case")
    assert_not @checker.test_link("#{BASE_URL}some_guide/chapter-with-subs#SUB_ANCHOR_MIXED_CASE")
    assert @checker.test_link("#{BASE_URL}some_guide/New-Chapter")
  end

  test "old anchor resolves to new anchor via alias" do
    # The alias maps: some_guide/new-chapter#new-anchor <- some_guide/new-chapter#old-anchor
    # A link pointing to the old anchor should be accepted because the checker
    # resolves it to the canonical new-anchor, which exists in the TOC.
    assert @checker.test_link("#{BASE_URL}some_guide/new-chapter#old-anchor")
  end

  test "aliases are transitive" do
    @checker.expects(:configured_redirects).returns({ "old_guide_name" => "some_guide", "some_guide/old-chapter" => "some_guide/new-chapter" }).twice
    assert @checker.test_link("#{BASE_URL}old_guide_name/old-chapter#old-anchor")
  end

  test "non-aliased unknown anchor is invalid" do
    assert_not @checker.test_link("#{BASE_URL}some_guide/new-chapter#completely-unknown-anchor")
  end

  test "old guide name with no configured redirect is considered invalid and emits a warning" do
    # old_guide_name is listed as an alias for some_guide, but CONFIGURED_REDIRECTS
    # is empty, so guide-level aliases must not be followed silently.
    _out, err = capture_io do
      assert_not @checker.test_link("#{BASE_URL}old_guide_name/new-chapter")
    end
    assert_match(/old_guide_name/, err)

    @checker.expects(:configured_redirects).returns({ "old_guide_name" => "some_guide" })
    assert @checker.test_link("#{BASE_URL}old_guide_name/new-chapter")
  end

  test "no aliases file does not crash" do
    toc_file = Tempfile.new(['toc_no_aliases', '.json'])
    toc_file.write(JSON.dump("some_guide" => { "a-chapter" => [] }))
    toc_file.close

    checker = LinksChecker.new(toc: toc_file.path, aliases: nil)
    assert checker.test_link("#{BASE_URL}some_guide/a-chapter")
    assert_not checker.test_link("#{BASE_URL}some_guide/a-chapter#any-anchor")
    assert_not checker.test_link("#{BASE_URL}some_guide/missing-chapter")
  ensure
    toc_file.unlink
  end
end
