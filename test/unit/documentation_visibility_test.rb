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

  test 'standalone authentication documentation links render as removal markers' do
    helper = ApplicationController.helpers

    %w[4.1.1LDAPAuthentication 5.7ExternalAuthentication].each do |section|
      assert_equal DocumentationVisibilityHelper::DOCUMENTATION_URL_TO_REMOVE, helper.documentation_url(section)
      assert_equal(
        %(<div class="#{DocumentationVisibilityHelper::DOCUMENTATION_ELEMENT_TO_REMOVE_CLASS}"></div>),
        helper.link_to('Documentation', helper.documentation_url(section))
      )
    end
  end

  test 'template help and its inline documentation remain' do
    source = File.read(Rails.root.join('app/views/templates/_form.html.erb'))
    result = Deface::Override.apply(source, virtual_path: 'templates/_form')

    assert_includes result, 'help_tab'
    assert_includes result, 'apipie_dsl_apipie_dsl_path'
    assert_includes result, 'documentation_anchor'
    assert_includes result, 'text_f f, :name'
  end

  test 'authentication actions remain in source templates' do
    %w[auth_source_ldaps/_ldap_card_kebab auth_source_externals/_external_card_kebab].each do |path|
      source = File.read(Rails.root.join("app/views/#{path}.html.erb"))
      result = Deface::Override.apply(source, virtual_path: path)

      assert_includes result, 'documentation_url'
      assert_includes result, 'link_to_if_authorized'
    end
  end

  test 'config groups empty state keeps action but removes documentation' do
    source = puppet_view_source('foreman_puppet/config_groups/welcome.html.erb')
    result = Deface::Override.apply(source, virtual_path: 'foreman_puppet/config_groups/welcome')

    assert_not_includes result, 'documentation_url("using-config-groups")'
    assert_not_includes result, ':documentation'
    assert_includes result, "react_component('EmptyState'"
    assert_includes result, ":description => description"
    assert_includes result, ":action => action"
  end

  test 'environments empty state keeps content but removes documentation component' do
    source = puppet_view_source('foreman_puppet/environments/welcome.html.erb')
    result = Deface::Override.apply(source, virtual_path: 'foreman_puppet/environments/welcome')

    assert_not_includes result, "react_component('WelcomeEnv'"
    assert_includes result, "react_component('SatelliteWelcomeEnv'"
    assert_includes result, 'authorized_for(action: :new)'
  end

  test 'About documentation and support remain after Satellite branding' do
    source = File.read(Rails.root.join('app/views/about/index.html.erb'))
    result = Deface::Override.apply(source, virtual_path: 'about/index')

    assert_includes result, 'documentation_url'
    assert_includes result, 'apipie_apipie_path'
    assert_includes result, 'apipie_dsl_apipie_dsl_path'
    assert_includes result, 'Customer Portal'
  end

  private

  # Plugin CI does not install foreman_puppet. Use its templates when present,
  # and a snapshot of those welcome pages otherwise.
  def puppet_view_source(relative_path)
    File.read(puppet_view_path(relative_path))
  end

  def puppet_view_path(relative_path)
    return theme_fixture_file(relative_path) unless defined?(::ForemanPuppet)

    ::ForemanPuppet::Engine.root.join('app/views', relative_path)
  end
end
