require 'json'
require 'uri'

class LinksChecker
  def initialize(toc:)
    @toc = JSON.parse(File.read(toc))
  end

  def test_link(url)
    doc_path, anchor = decompose_link(url)

    return false unless doc_path

    anchors = navigate_path(doc_path)

    return anchors unless anchor

    anchors&.include?(anchor)
  end

  private

  # Will decompose URL from https://localhost:3000/documentation/en-us/red_hat_satellite/6.15/html/managing_configurations_using_ansible_integration_in_red_hat_satellite/getting_started_with_ansible_in_satellite_ansible#Importing_Ansible_Roles_and_Variables_ansible
  # to two parts:
  # path: managing_configurations_using_ansible_integration_in_red_hat_satellite/getting_started_with_ansible_in_satellite_ansible
  # chapter: Importing_Ansible_Roles_and_Variables_ansible
  def decompose_link(link)
    uri = URI.parse(link)

    doc_path = extract_doc_path(uri.path)
    anchor = uri.fragment

    [doc_path, anchor]
  end

  def extract_doc_path(path)
    # take the right part of the path after the '/html/' from the original link
    %r{/html/(.*)}.match(path)&.[](1)
  end

  def navigate_path(path, hash = @toc)
    return nil unless hash

    split = path.match(%r{([^/]*)/(.*)})
    first = split&.[](1) || path
    rest = split&.[](2)

    inner_hash = hash[first]

    return inner_hash if rest.empty?

    navigate_path(rest, inner_hash)
  end
end
