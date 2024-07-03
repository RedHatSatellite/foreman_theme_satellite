# frozen_string_literal: true

module ForemanThemeSatellite
  # This list is used for substitution of branded words by both client and server.
  # The server just uses the list as is.
  # The client is consuming it by generated .js.erb file: app/assets/javascripts/theme_client_side_branding.js.erb.
  # For now, modifiers are not supported by the generator.
  # Make sure the regexp works both with Ruby and JavaScript.
  # Entries are processed in order and first wins.
  # Occurrences of "proxy" should be treated as a bug as it is unclear whether the author refers to a HTTP(S) proxy or a Capsule
  FOREMAN_BRAND = {
    /%{proxy}/               => '%{proxy}',
    /%{foreman}/             => '%{foreman}',
    /\b[Pp]roxy [Hh][Tt][Tt][Pp]\b(?!-)/    => 'Proxy HTTP', # Workaround for French translation
    /\b[Pp]roxies [Hh][Tt][Tt][Pp]\b(?!-)/ => 'Proxies HTTP', # Workaround for French translation
    ## BEGIN Remove after imprecise strings have been fixed in core
    /\b[Hh][Tt][Tt][Pp](?:\([sS]\))? [Pp]roxy\b(?!-)/ => 'HTTP proxy',
    /\b[Hh][Tt][Tt][Pp](?:\([sS]\))? [Pp]roxies\b(?!-)/ => 'HTTP proxies',
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
    ## END
    /\b[Ff]oreman\b(?!-)/            => 'Satellite',
    /\b[Ss]mart[- ]?[pP]roxy\b(?!-)/ => 'Capsule',
    /\b[Ss]mart[- ]?[pP]roxies\b(?!-)/ => 'Capsules',
    /\b[Pp]roxy\b(?!-)/              => 'Capsule',
    /\b[Pp]roxies\b(?!-)/              => 'Capsules',
    /\b[Oo][Vv]irt\b(?!-)/           => 'RHV',
    /\bFreeIPA\b(?!-)/               => 'Red Hat Identity Management',
    /\b[Oo]pen[Ss]tack\b(?!-)/       => 'Red Hat OpenStack Platform',
    /\b[Kk]atello 4.0\b(?!-)/        => 'Satellite 6.11',
    /\b[Kk]atello 4.10\b(?!-)/       => 'Satellite 6.15',
    /\b[Kk]atello 4.11\b(?!-)/       => 'Satellite 6.15',
    /\b[Kk]atello 4.12\b(?!-)/       => 'Satellite 6.16',
    /\b[Kk]atello 4.13\b(?!-)/       => 'Satellite 6.16',
  }.freeze
end
