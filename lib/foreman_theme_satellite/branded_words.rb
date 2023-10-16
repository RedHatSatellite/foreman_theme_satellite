# frozen_string_literal: true

module ForemanThemeSatellite
  # This list is used for substitution of branded words by both client and server.
  # The server just uses the list as is.
  # The client is consuming it by generated .js.erb file: app/assets/javascripts/theme_client_side_branding.js.erb.
  # For now, modifiers are not supported by the generator.
  # Make sure the regexp works both with Ruby and JavaScript.
  # Entries are processed in order and first wins.
  FOREMAN_BRAND = {
    /%{proxy}/               => '%{proxy}',
    /%{foreman}/             => '%{foreman}',
    /\b[Hh][Tt][Tt][Pp] [Pp]roxy\b(?!-)/    => 'HTTP Proxy',
    /\b[Hh][Tt][Tt][Pp] [Pp]roxies\b(?!-)/ => 'HTTP Proxies',
    /\bHTTP\(S\) proxy\b(?!-)/ => 'HTTP(S) proxy',
    /\bIgnore Proxy\b(?!-)/  => 'Ignore Proxy',
    /\bIgnore proxy\b(?!-)/  => 'Ignore Proxy',
    /\bSystem-wide proxies\b(?!-)/  => 'System-wide proxies',
    /\bLeave this blank if no proxy is used\b(?!-)/ => 'Leave this blank if no proxy is used',
    /\bbypass proxy settings\b(?!-)/ => 'bypass proxy settings',
    /\bURL of the proxy\b(?!-)/ => 'URL of the proxy',
    %r{\bhttps://proxy.example.com:8080\b(?!-)} => 'https://proxy.example.com:8080',
    /\bproxy for all outgoing HTTP connections\b(?!-)/ => 'proxy for all outgoing HTTP connections',
    /\bperform various actions through those proxies\b(?!-)/ => 'perform various actions through those proxies',
    /\bForeman\b(?!-)/       => 'Satellite',
    /\bforeman\b(?!-)/       => 'satellite',
    /\bsmart-proxy\b(?!-)/   => 'capsule',
    /\bSmart-proxy\b(?!-)/   => 'Capsule',
    /\bsmart proxies\b(?!-)/ => 'capsules',
    /\bSmart proxies\b(?!-)/ => 'Capsules',
    /\bsmart-proxies\b(?!-)/ => 'capsules',
    /\bSmart-proxies\b(?!-)/ => 'Capsules',
    /\bSmart Proxies\b(?!-)/ => 'Capsules',
    /\bSmart Proxy\(ies\)(?!-)/ => 'Capsule(s)',
    /\bSmart Proxy\b(?!-)/   => 'Capsule',
    /\bsmart proxy\b(?!-)/   => 'capsule',
    /\bSmart-Proxies\b(?!-)/ => 'Capsules',
    /\bSmart proxy\b(?!-)/   => 'Capsule',
    /\bSmart-Proxy\b(?!-)/   => 'Capsule',
    /\boVirt\b(?!-)/         => 'RHEV',
    /\bovirt\b(?!-)/         => 'RHEV',
    /\bOvirt\b(?!-)/         => 'RHEV',
    /\bFreeIPA\b(?!-)/       => 'Red Hat Identity Management',
    /\bOpenStack\b(?!-)/     => 'RHEL OpenStack Platform',
    /\bopenstack\b(?!-)/     => 'RHEL OpenStack Platform',
    /\bOpenstack\b(?!-)/     => 'RHEL OpenStack Platform',
    /\bProxy\b(?!-)/         => 'Capsule',
    /\bproxy\b(?!-)/         => 'Capsule',
    /\bProxies\b(?!-)/       => 'Capsules',
    /\bproxies\b(?!-)/       => 'Capsules',
    /\b[Kk]atello 4.0\b(?!-)/       => 'Satellite 6.11',
    /\b[Kk]atello 4.10\b(?!-)/       => 'Satellite 6.15',
    /\b[Kk]atello 4.11\b(?!-)/       => 'Satellite 6.15',
    /\b[Kk]atello 4.12\b(?!-)/       => 'Satellite 6.16',
    /\b[Kk]atello 4.13\b(?!-)/       => 'Satellite 6.16',
    %r{https://theforeman.org/plugins/katello/(?!-)} => "https://access.redhat.com/documentation/en-us/red_hat_satellite/#{ForemanThemeSatellite::SATELLITE_SHORT_VERSION}/html/managing_hosts/registering_hosts#registering-a-host-to-satellite-using-the-bootstrap-script"
  }.freeze
end
