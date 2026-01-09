module Kubevirt
  extend ActiveSupport::Concern
  prepended do
    define_singleton_method :provider_friendly_name do
      "OpenShift Virtualization"
    end
  end
end
