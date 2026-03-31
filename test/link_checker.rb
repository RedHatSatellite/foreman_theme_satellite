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
    doc_path = decompose_link(url)

    return false unless doc_path

    navigate_path(doc_path)
  end

  private

  # Will decompose URL from https://localhost:3000/documentation/en-us/red_hat_satellite/6.15/html/managing_configurations_using_ansible_integration_in_red_hat_satellite/getting_started_with_ansible_in_satellite_ansible#Importing_Ansible_Roles_and_Variables_ansible
  # to an array of parts:
  # [
  #   managing_configurations_using_ansible_integration_in_red_hat_satellite, # guide
  #   getting_started_with_ansible_in_satellite_ansible,                      # section
  #   Importing_Ansible_Roles_and_Variables_ansible                           # anchor
  # ]
  # anchor-less links will only have two elements
  def decompose_link(link)
    uri = URI.parse(link)

    doc_path = extract_doc_path(uri.path)
    anchor = uri.fragment

    (doc_path.split('/') + [anchor]).compact
  end

  def extract_doc_path(path)
    # take the right part of the path after the '/html/' from the original link
    path.split('/html/', 2)[1]
  end

  def navigate_path(path, hash = @toc, path_so_far = nil)
    return nil unless hash

    first, *rest = path

    case hash
    when Hash
      inner_hash = case_insensitive_lookup(hash, first)
    when Array
      return rest.empty? && (hash.include?(first) || hash.include?(aliased_key(path_so_far, first, separator: '#')))
    else
      raise "Not supposed to happen"
    end

    # If not found, try looking up by an auxiliary ID
    if inner_hash.nil?
      first = aliased_key(path_so_far, first)
      return if first.nil?
      inner_hash = case_insensitive_lookup(hash, first)
    end

    # rubocop:disable Rails/Blank
    return inner_hash if rest.nil? || rest.empty?
    # rubocop:enable Rails/Blank

    navigate_path(rest, inner_hash, path_join(path_so_far, first))
  end

  def path_elements(path)
    path, anchor = path.split('#', 2)
    path_parts = path.split('/')
    (path_parts + [anchor]).compact
  end

  def aliased_key(path_so_far, key, separator: '/')
    key = path_join(path_so_far, key, separator)
    k, _v = @aliases.find { |_k, vs| vs.include? key.downcase }

    return nil if k.nil?

    path_elements(k).last
  end

  def case_insensitive_lookup(hash, key)
    return hash[key] if hash[key]

    _, v = hash.find { |k, _| k.casecmp(key).zero? }
    v
  end

  def path_join(path_so_far, fragment, separator = '/')
    [path_so_far, fragment].compact.join(separator)
  end
end
