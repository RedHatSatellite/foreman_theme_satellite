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
