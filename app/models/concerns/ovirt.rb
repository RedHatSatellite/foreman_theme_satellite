module Ovirt
  extend ActiveSupport::Concern
  included do
    define_singleton_method :provider_friendly_name do
      "RHV"
    end
  end
end
