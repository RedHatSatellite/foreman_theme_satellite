require 'test_plugin_helper'

class DocumentationVisibilityTest < ActiveSupport::TestCase
  test 'shared Rails documentation buttons are hidden without changing URLs' do
    helper = Object.new.extend(ApplicationHelper)
    helper.expects(:documentation_url).never

    assert_equal '', helper.documentation_button
    assert_equal '', helper.help_button
    assert_equal '', helper.documentation_button('Managing_Hosts', type: 'docs', chapter: 'example')
    assert_includes ApplicationHelper.ancestors, DocumentationVisibilityHelper
  end

  test 'template help and its inline documentation remain' do
    source = File.read(Rails.root.join('app/views/templates/_form.html.erb'))
    result = Deface::Override.apply(source, virtual_path: 'templates/_form')

    assert_includes result, 'help_tab'
    assert_includes result, 'apipie_dsl_apipie_dsl_path'
    assert_includes result, 'documentation_anchor'
    assert_includes result, 'text_f f, :name'
  end

  test 'authentication documentation and its divider are removed but actions remain' do
    %w[auth_source_ldaps/_ldap_card_kebab auth_source_externals/_external_card_kebab].each do |path|
      source = File.read(Rails.root.join("app/views/#{path}.html.erb"))
      result = Deface::Override.apply(source, virtual_path: path)

      refute_includes result, 'documentation_url'
      refute_includes result, 'class="divider"'
      assert_includes result, 'link_to_if_authorized'
    end
  end

  test 'About documentation and support remain after Satellite branding' do
    source = File.read(Rails.root.join('app/views/about/index.html.erb'))
    result = Deface::Override.apply(source, virtual_path: 'about/index')

    assert_includes result, 'documentation_url'
    assert_includes result, 'apipie_apipie_path'
    assert_includes result, 'apipie_dsl_apipie_dsl_path'
    assert_includes result, 'Customer Portal'
  end
end
