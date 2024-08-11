# ForemanThemeSatellite

## Goals:
1. Make downstream release automated.
2. Have the same code base for all upstream/downstream projects.
3. Create one place to insert all the changes from upstream to downstream (1
project changes vs all projects).
4. Usage of downstream translations for upstream use.

## String branding

The most common task is to brand string messages shown to the user:

We want `Welcome to foreman` to become `Welcome to Satellite`.

This is done for both `.erb` and `.js` files by enabling translation:

Ruby code - erb and helpers:
``` ruby
<%= _('Welcome to Foreman') %>
# => "Welcome to Satellite"
```

React:
``` jsx
const SettingName = ({ setting }) => (
  <React.Fragment>
    {__('Welcome to Foreman')}
  </React.Fragment>
);
// =>
// <React.Fragment>
//   Welcome to Satellite
// </React.Fragment>
```

In case there is a need to add more terms to be branded **or bypass branding**,
it can be done in
[`branded_words.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/lib/foreman_theme_satellite/branded_words.rb).
This is a dictionary where the key is a
[Regular Expression](https://regex101.com/) and the value is a replacement
string.

``` ruby
FOREMAN_BRAND = {
  # string to replace:
  /\bForeman\b(?!-)/ => 'Satellite',
  /\bproxy\b(?!-)/   => 'Capsule',
  # string to bypass
  /\bHTTP\(S\) proxy\b(?!-)/ => 'HTTP(S) proxy',
}

branded_string = _('Use proxy for this')
# => "Use Capsule for this"
bypassed_string = _('HTTP(S) proxy will not be branded')
# => "HTTP(S) proxy will not be branded"
```

In order to brand translated strings too, the system assumes that the names will
appear in the translated string exactly as they appear in the original string.

For example in Russian we will use
```
"Добро пожаловать в Foreman"
```
that will be branded automatically to
```
"Добро пожаловать в Satellite"
```

## Downstream documentation

Many times we need to use a downstream link instead of an upstream one. The most
common example for this is pointing to a documentation link.

All links to documentation in Foreman are local and redirected to
`links_controller`. This controller is prepended with
`documentation_controller_branding` concern that uses dictionary stored in
`lib/foreman_theme_satellite/documentation.rb` to redirect documentation to
downstream URLs.

In foreman:
``` ruby
  <p><%= link_to _('Learn more about LDAP authentication in the documentation.'), documentation_url("4.1.1LDAPAuthentication")%></p>
```
will redirect to https://theforeman.org/manuals/2.2/index.html#4.1.1LDAPAuthentication

to change that, we need to add a downstream documentation link to [`documentation.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/lib/foreman_theme_satellite/documentation.rb):

``` ruby
USER_GUIDE_DICTIONARY = {
  # ...
  'LDAPAuthentication' => "#{ForemanThemeSatellite.documentation_root}/administering_red_hat_satellite/chap-red_hat_satellite-administering_red_hat_satellite-configuring_external_authentication",
  # ...
}
```
notice the use of
```  ruby
ForemanThemeSatellite.documentation_root
```
this constant is maintained by the theme and always point to the correct
documentation version.

### Fixing links checker failures

The documentation table of contents is updated automatically from the downstream into the [`toc_update`](https://github.com/RedHatSatellite/foreman_theme_satellite/tree/toc_update) branch. If the links become incompatible with the new TOC, the links checker tests will fail in the PR for the new TOC. To fix the links the following procedure should be followed:

1. Create a new branch from the latest `develop`
2. Cherry pick the new TOC into the newly created branch from the `toc_update` branch.
3. Update the links to work with the new TOC.
4. Create a PR to theme's `develop` branch.

The CI for this PR should become green, since both the TOC and the links match.

## Settings

Most of the time a setting's default value should be changed to a downstream
version. This is done by adding more entries to setting changing code in
[`settings_branding.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/models/concerns/settings_branding.rb)

``` ruby
@branded_settings ||= {
  'my_new_setting' => 'satellite value'
  'email_reply_address' => "satellite-noreply@#{domain}",
  'email_subject_prefix' => '[satellite]',

  'rss_url' => 'https://www.redhat.com/en/rss/blog/channel/red-hat-satellite',
  'foreman_tasks_troubleshooting_url' => 'https://access.redhat.com/solutions/satellite6-tasks#%{label}'
}.freeze

```

## Notifications

When a feature is deprecated upstream, a deprecation notification might need
branding.

An example to this is in
[`deprecation_notification.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/models/concerns/deprecation_notification.rb)

Standard ruby override technique is used to override notification behavior

``` ruby
module DeprecationNotification
  module StringParser
    def initialize(template, options = {})
      options[:version] = '6.8' if options[:version] == '2.0'
      super(template, options)
    end
  end

  module Notification
    def create!(opts)
      if opts[:notification_blueprint] == NotificationBlueprint.find_by_name('feature_deprecation') &&
        opts.dig(:actions, :links, 0, :href) == 'https://community.theforeman.org/t/dropping-smart-variables/16176'
        opts[:actions][:links][0][:href] = "#{ForemanThemeSatellite.documentation_root}/release_notes/index"
      end
      super(opts)
    end
  end
end
```

and later on in [`engine.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/lib/foreman_theme_satellite/engine.rb)
``` ruby
UINotifications::StringParser.send :prepend, DeprecationNotification::StringParser
Notification.singleton_class.send :prepend, DeprecationNotification::Notification
```
## CSS:

There are two common tasks that need to be done:
* layout changes
* color scheme adjustments

### Layout changes

Layout constants may need adjusting since the logos e.t.c. look differently in
themed pages. This is done by adding a new SCSS file under
[`satellite`](https://github.com/RedHatSatellite/foreman_theme_satellite/tree/develop/app/assets/stylesheets/satellite)
folder in `app/assets/stylesheets`.

Make sure the CSS rules are the most specific, so that the CSS engine would use
theme version instead of the default foreman ones.

```scss
.wizard li {
  padding: 8px 12px 8px;

  &:first-child {
    -webkit-border-radius: 0;
    -moz-border-radius: 0;
    border-radius: 0;
  }
  &:last-child {
    -webkit-border-radius: 0;
    -moz-border-radius: 0;
    border-radius: 0;
  }
}
```

### Color adjustments

When a color scheme need adjustment, most of the time it should be done across
all the values. It will require generating the final CSS file (not the scss
sources) and running a transformation that will result in a set of color
changing rules that should be placed under the
[`satellite`](https://github.com/RedHatSatellite/foreman_theme_satellite/tree/develop/app/assets/stylesheets/satellite)
folder.

* For files in `app/assets/...` run `rails assets:precompile`. The source path
will be `public/assets/application-ETag.css`
* For files in `webpack/...` run `rake webpack:compile`. The source path will
be `public/webpack/bundle-ETag.css`
* Run the following command in the foreman directory:
 `rails generate foreman_theme_satellite:color_diff --source_css <PATH_TO_SOURCE_FILE> --destination_file <PATH_TO_DESTINATION_FILE>`

List of color conversion rules can be found in:
[`color_changer.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/lib/generators/foreman_theme_satellite/lib/color_changer.rb)
in case a new rule should be added.

``` ruby
COLOR_REPLACEMENT = {
  '#000000' => '#FFFFFF', # $primary_color
}
```

## HTML and components

### React components
For react components there is a need to create an extension point in the base
code by using a proper [`Slot`](https://theforeman.github.io/foreman/?path=/docs/introduction-slot-and-fill--page).
Later we will be able to register a `Fill` component in our global
[`index.js`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/webpack/index.js)
file.

Example slot [foreman](https://github.com/theforeman/foreman/blob/6ed930afb09f340ccc0106512df53e2874ba37a5/webpack/assets/javascripts/react_app/components/HostDetails/index.js#L140) code:

``` jsx
<div className="host-details-tab-item">
  <Slot
    response={response}
    id="host-details-page-tabs"
    fillID={tab}
  />
</div>
```

Later we can add a proper fill in the theme:

``` jsx
import React from 'react';
import { addGlobalFill } from '../../common/Fill/GlobalFill';
import SatelliteDetailsTab from './Details';

export const registerCoreTabs = () => {
  addGlobalFill('host-details-page-tabs', 'Details', <SatelliteDetailsTab />, 1000);
};
```

### Components added from ERB pages
Sometimes a component is added from an `.erb` file. Those components often pass
server data as props to the component.

It is advised to design such extension points with helper functions, to make the
process of replacing props easier.

For example in [`foreman`](https://github.com/theforeman/foreman/blob/develop/app/helpers/login_helper.rb)
we use

``` ruby
def login_props
  {
    token: form_authenticity_token,
    version: SETTINGS[:version].version,
    caption: Setting[:login_text],
    alerts: flash_inline,
    logoSrc: image_path("foreman_theme_satellite/login_logo.png"),
  }
end

def mount_login
  react_component('LoginPage', login_props.to_json)
end
```

to mount react login component. Once the extension point is in place, we can
override it from theme helper:

``` ruby
module ThemeLoginHelper
  def login_props
    super.merge(
      version: ForemanThemeSatellite::SATELLITE_VERSION,
      logoSrc: image_path('foreman_theme_satellite/login_logo.svg')
    )
  end
end
```

### Change-views/layouts:

Use [deface](https://github.com/spree/deface) in order to change views,
all the deface changes are located under
[`app/overrides`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/overrides/).

For example, changing about page content

```ruby
Deface::Override.new(:virtual_path  => "about/index",
                     :name          => "change about page content",
                     # div#support
                     :replace       => "div.col-md-5 div.stats-well:nth-child(1)",
                     :text          =>  "    <div class=\"stats-well\"><h4><%= _(\"Support\") %></h4> <p>Visit the <%= link_to _('Customer Portal'), \"https://access.redhat.com/\",
                                       :rel => \"external\" %> to get support, find solutions to common questions, and more.</p><h6><%= _(\"Documentation\") %></h6>
                                        <ul>
                                        <li><%= link_to _('Complete Product Documentation for Red Hat Satellite'),\"#{ForemanThemeSatellite.documentation_server}/documentation/en/red_hat_satellite/#{ForemanThemeSatellite::SATELLITE_SHORT_VERSION}\", :rel => \"external\" %></li>
                                        <li><%= link_to _('API Resources'), apipie_apipie_path, :title => _('Automate Satellite via a simple and powerful API') %></li>
                                        </ul>
                                        <h6><%= _(\"Blog\") %></h6>
                                        <ul>
                                          <li><%= link_to _('Red Hat Satellite Blog'), \"https://access.redhat.com/blogs/1169563\", :rel => \"external\" %></li>
                                        </ul>
                                        <h6><%= _(\"IRC\") %></h6>
                                        <p><%= (_(\"You can find us on %{freenode} (irc.freenode.net) on #satellite6.\") % {:freenode => link_to(\"freenode\", \"http://www.freenode.net\", :rel => \"external\")}).html_safe  %></p>
                                        </div>")
```

## Change helpers behavior

When there is need to change HTML components rendered by a helper, they could be
overridden from theme's helpers:

``` ruby
module ThemeApplicationHelper
  def association_text()
    content_tag(:p, _('When editing a Template, you must assign a list of Operating Systems with which this Template can be used. Optionally, you can restrict a template to a list of Hostgroups or Environments.')) +
      content_tag(:p, _('When a Host requests a template (e.g. during provisioning), Foreman selects the optimal match from the available templates of that type, in the following order:')) +
      (content_tag :ul do
        content_tag(:li, _('Host group and Environment'))
        content_tag(:li, _('Host group only'))
        content_tag(:li, _('Environment only'))
        content_tag(:li, _('Operating system default'))
      end)
    (_('The final entry, Operating System default, can be set by editing the %s page.') % (link_to _('Operating System'), operatingsystems_path)).html_safe
  end
end
```


## Lists of features/components e.t.c.

When there is a need to have a list of features/components e.t.c. it's
recommended to add a method or constant in upstream foreman and override it in
the theme by using concerns or redefining consts.

[Upstream](https://github.com/theforeman/foreman/blob/e801f761eb3e709a0adc7a6e6d86f514b2f919dd/app/models/compute_resource.rb#L44):
``` ruby
class ComputeResource < ApplicationRecord
  # ...
  def self.supported_providers
    {
      'Libvirt'   => 'Foreman::Model::Libvirt',
      'Ovirt'     => 'Foreman::Model::Ovirt',
      'EC2'       => 'Foreman::Model::EC2',
      'Vmware'    => 'Foreman::Model::Vmware',
      'Openstack' => 'Foreman::Model::Openstack',
    }
  end
  # ...
```

[Theme](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/models/concerns/compute_resource_branding.rb):
``` ruby
module ComputeResourceBranding
  module ClassMethods
    def supported_providers
      super.except('Rackspace')
    end

    def providers_requiring_url
      _('Libvirt, oVirt and OpenStack')
    end
  end
end
```

This approach is also applicable to other plugins too, here is an example from
Katello.

[Upstream](https://github.com/Katello/katello/blob/df7286071ce42b67cf17a30cf6b201435a6354fa/app/models/katello/ping.rb#L5)
``` ruby
module Katello
  class Ping
    PACKAGES = %w(katello candlepin pulp qpid foreman tfm hammer).freeze
  end
end
```

[Branding](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/models/concerns/satellite_packages.rb)
``` ruby
module SatellitePackages
  extend ActiveSupport::Concern
  included do
    old_packages = remove_const(:PACKAGES)
    const_set(:PACKAGES, (old_packages + ['satellite']).freeze)
  end
end
```

### Update the list of supported provisioning templates by Red Hat.
When there is a new template (supported by downstream) added in the upstream repo, please don't forget to update this [constant](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/app/controllers/concerns/provisioning_templates_controller_branding.rb#L4). You simply need to add the name of the new template to the array.

## Theme constants and metadata fields

Currently the theme maintains a list of constants and metadata that is relevant
only to the downstream version. These constants can be used throughout the theme
and can be overridden from either `ENV` variable or by setting the constant in
a specialized yaml file.

Setting up ENV variables:
``` bash
SATELLITE_VERSION='6.8.000'
SATELLITE_DOCUMENTATION_SERVER=http://access.redhat.com
SATELLITE_DOCUMENTATION_VERSION=6.6
```
Setting up the metadata file:
``` yaml
version: '6.8.000'
documentation_server: "http://access.redhat.com"
documentation_version: "6.6"
```
the metadata file should be called `/usr/share/satellite/metadata.yml` for
production style deployments, or used from
[source](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/config/metadata.yml)
directory for development and test environments.

The mechanism resides in theme's
[`engine.rb`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/lib/foreman_theme_satellite/engine.rb#L119)

## Testing documentation

Since the life cycle of our documentation differs from Satellite's, there is
need to test the links against different documentation version or instance.

These parameters are cofigurable by either setting `ENV` variables:

``` sh
SATELLITE_DOCUMENTATION_SERVER=http://access.redhat.com
SATELLITE_DOCUMENTATION_VERSION=6.6
```

Another option is to add or change keys in `/usr/share/satellite/metadata.yml`:

``` yaml
documentation_server: "http://access.redhat.com"
documentation_version: "6.6"
```

There is also an automatic test that tests all documentation links on each PR,
for the test to work
[`metadata.yml`](https://github.com/RedHatSatellite/foreman_theme_satellite/blob/develop/config/metadata.yml)
should be updated accordingly.

## Tests:

Due to all the changes made by the plugin, it is possible that some of the core tests will fail,
we solve that by skipping tests and replacing them with our own.

Skipping:

```ruby
initializer 'foreman_theme_satellite.register_plugin', :after=> :finisher_hook do |app|
  Foreman::Plugin.register :foreman_theme_satellite do
    requires_foreman '>= 1.10'
     tests_to_skip ({
                    "ComputeResourceTest" => ["friendly provider name"]
                    })
  end
end
```

Replacing:

```ruby
class ModelsTest < ActiveSupport::TestCase

  test "check openstack friendly name" do
    assert_equal Foreman::Model::Openstack::provider_friendly_name, "RHEL OpenStack Platform", "Friendly name override was unsuccessful"
  end

end
```
