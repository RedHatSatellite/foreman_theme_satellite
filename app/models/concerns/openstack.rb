module Openstack
  extend ActiveSupport::Concern
  included do
    define_singleton_method :provider_friendly_name do
      "RHEL OpenStack Platform"
    end
  end
end
