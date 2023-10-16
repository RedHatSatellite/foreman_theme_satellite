# Add in the localizatione below to make sure they are extracted.
N_("Version %{version}")
N_("Support")
N_("Customer portal")
N_("Documentation")
N_('Administering Red Hat Satellite')
N_('Transitioning from Red Hat Satellite 5 to Red Hat Satellite 6')
N_("API Guide")
N_("Blog")
N_('Red Hat Satellite Blog')
N_("IRC")
N_("You can find us on %{liberachat} (irc.libera.chat) in #redhat-satellite.")
N_("Version %{version} © %{year} Red Hat Inc.")
N_("Includes %{system} © 2009-%{year} Paul Kelly and Ohad Levy")
N_("If you feel this is an error with Satellite 6 itself, please open a new issue with")
N_("Satellite ticketing system")
N_("You would probably need to attach the")
N_("Full trace")
N_("and relevant log entries.")
N_("(build: %{version})")


Deface::Override.new(:virtual_path  => "home/_topbar",
                     :name          => "remove foreman name from topbar",
                     :replace       => "erb[loud]:contains('link_to')",
                     :text          =>  "")

Deface::Override.new(:virtual_path  => "home/_topbar",
                     :name          => "add link to home",
                     :surround      => "erb[loud]:contains('image_tag')",
                     :text          => "<%= link_to main_app.root_path do%><%= render_original %><% end %>")

Deface::Override.new(:virtual_path  => "about/index",
                     :name          => "change about page content",
                     # div#support
                     :replace       => "div.col-md-5 div.stats-well:nth-child(1)",
                     :text          =>  "    <div class=\"stats-well\"><h4><%= _(\"Support\") %></h4> <p>Visit the <%= link_to _('Customer Portal'), \"https://access.redhat.com/\",
                                       :rel => \"external\" %> to get support, find solutions to common questions, and more.</p><h6><%= _(\"Documentation\") %></h6>
                                        <ul>
                                        <li><%= link_to _('Complete Product Documentation for Red Hat Satellite'),\"https://access.redhat.com/documentation/en/red_hat_satellite/#{ForemanThemeSatellite::SATELLITE_SHORT_VERSION}\", :rel => \"external\" %></li>
                                        <li><%= link_to _('API Resources'), apipie_apipie_path, :title => _('Automate Satellite via a simple and powerful API') %></li>
                                        <li><%= link_to _('Templates DSL'), apipie_dsl_apipie_dsl_path, :title => _('Get DSL reference for templates writing') %></li>
                                        </ul>
                                        <h6><%= _(\"Blog\") %></h6>
                                        <ul>
                                          <li><%= link_to _('Red Hat Satellite Blog'), \"https://www.redhat.com/en/blog/channel/red-hat-satellite\", :rel => \"external\" %></li>
                                        </ul>
                                        <h6><%= _(\"IRC\") %></h6>
                                        <p><%= (_(\"You can find us on %{liberachat} (irc.libera.chat) in #redhat-satellite.\") % {:liberachat => link_to(\"libera.chat\", \"https://libera.chat\", :rel => \"external\")}).html_safe  %></p>
                                        </div>")

Deface::Override.new(:virtual_path  => "about/index",
                     :name          => "add satellite version for about page",
                     :insert_before => "p#copyright-p",
                     :text          => '<p id="sat-copyright-p">Red Hat Satellite <%= (_("(build: %{version})") % {:version => ForemanThemeSatellite::SATELLITE_VERSION}).html_safe %><br/><%= (_("Version %{version} © %{year} Red Hat Inc.") % {:version => ForemanThemeSatellite::SATELLITE_SHORT_VERSION, :year=>DateTime.now.year}).html_safe %></p>')

Deface::Override.new(:virtual_path  => "about/index",
                     :name          => "change version text for about page",
                     :replace       => "p#copyright-p",
                     :text          => '<p id="copyright-p"><%= (_("Includes %{system} © 2009-%{year} Paul Kelly and Ohad Levy") % {:system => "Foreman", :year => DateTime.now.year}).html_safe %></p>')

Deface::Override.new(:virtual_path  => "about/index",
                     :name          => "remove links to upstream plugins",
                     :replace       => "#plugins table tbody tr td:first-of-type",
                     :text          => '<td><%= plugin.name %></td>')

Deface::Override.new(:virtual_path  => "common/500",
                     :name          => "change 500 page content",
                     # p#message
                     :replace       => "p",
                     :text          => "<p id=\"message\">
                                          <%= _(\"If you feel this is an error with Satellite itself, please open a new issue with\") %>
                                          <%= link_to _(\"Satellite ticketing system\"), \"https://access.redhat.com/support/cases/#/case/new\", :rel => \"external\" %>,
                                          <% if Foreman::Logging.config[:type] == \"file\" %>
                                            <%= _(\"Please include in your report the full error log that can be acquired by running: \") %>
                                            <strong> foreman-rake errors:fetch_log request_id=<%= request_id %></strong>
                                          <% else %>
                                            <%= _('Search your logs for request-id') %> <%= request_id %>.
                                            <%= _('When using external logging, search for request UUID') %> <%= full_request_id %>
                                          <% end %>
                                            <%= _(\" and it is highly recommended to also attach the sosreport output.\") %>
                                        </p>
                     ")
