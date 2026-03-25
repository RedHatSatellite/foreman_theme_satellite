require 'json'
require 'uri'

class LinksChecker
  def initialize(toc:, aliases:)
    @toc = JSON.parse(File.read(toc))
    @aliases = {}

    return unless aliases && File.exist?(aliases)
    @aliases = JSON.parse(File.read(aliases)).to_h { |k, vs| [k.downcase, vs.map(&:downcase)] }
  end

  def test_link(url)
    doc_path, anchor = decompose_link(url)

    return false unless doc_path

    chapters = case_insensitive_lookup(@toc, doc_path)
    if chapters.nil?
      doc_path = guide_alias(doc_path)
      return false if doc_path.nil?
      chapters = case_insensitive_lookup(@toc, doc_path)
    end

    return false if chapters.nil? # no such page
    return true if anchor.nil? # the page exists, no particular anchor means we want just the page

    # Even though the ToC generated with html-multi in mind,
    # we can't properly dig due to html-single using anchors on index page for the whole section
    # dropping the intermediate path
    pages = chapters.keys.map(&:downcase) + chapters.values.flatten.map(&:downcase)

    pages.include?(anchor.downcase) || pages.include?(guide_anchor_aliases(doc_path, anchor))
  end

  private

  # Will decompose URL from managing_configurations_using_ansible_integration_in_red_hat_satellite/index#Importing_Ansible_Roles_and_Variables_ansible
  # to two parts:
  # path: managing_configurations_using_ansible_integration_in_red_hat_satellite
  # chapter: Importing_Ansible_Roles_and_Variables_ansible
  def decompose_link(link)
    uri = URI.parse(link)

    doc_path = uri.path.sub('/index', '')
    anchor = uri.fragment

    [doc_path, anchor]
  end

  def guide_alias(guide)
    k, _v = @aliases.find { |_k, vs| vs.include? guide.downcase }

    return if k.nil?

    k
  end

  def guide_anchor_aliases(guide, anchor)
    k, _v = @aliases.find do |_k, aliases|
      re = %r{^#{guide}/.*##{anchor}$}
      aliases.any? { |a| a =~ re }
    end

    k&.split('#')&.last
  end

  def case_insensitive_lookup(hash, key)
    return hash[key] if hash[key]

    _, v = hash.find { |k, _| k.casecmp(key).zero? }
    v
  end
end
