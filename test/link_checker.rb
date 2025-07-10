require 'json'
require 'uri'

class LinksChecker
  def initialize(toc:)
    @toc = JSON.parse(File.read(toc))
  end

  def test_link(url)
    doc_path, anchor = decompose_link(url)

    return false unless doc_path

    chapters = @toc[doc_path]

    return false if chapters.nil? # no such page
    return true if anchor.nil? # the page exists, no particular anchor means we want just the page

    # Even though the ToC generated with html-multi in mind,
    # we can't properly dig due to html-single using anchors on index page for the whole section
    # dropping the intermediate path
    page = chapters.keys.map(&:downcase) + chapters.values.flatten.map(&:downcase)

    page.include?(anchor.downcase)
  end

  private

  # Will decompose URL from https://localhost:3000/documentation/en-us/red_hat_satellite/6.15/html-single/managing_configurations_using_ansible_integration_in_red_hat_satellite/index#Importing_Ansible_Roles_and_Variables_ansible
  # to two parts:
  # path: managing_configurations_using_ansible_integration_in_red_hat_satellite
  # chapter: Importing_Ansible_Roles_and_Variables_ansible
  def decompose_link(link)
    uri = URI.parse(link)

    doc_path = extract_doc_path(uri.path)
    anchor = uri.fragment

    [doc_path, anchor]
  end

  def extract_doc_path(path)
    # take the right part of the path after the '/html-single/' from the original link and remove the trailing '/index'
    path.split('/html-single/', 2)[1].sub('/index', '')
  end
end
