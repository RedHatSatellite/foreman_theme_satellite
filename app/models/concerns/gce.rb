module GCE
  module ClassMethods
    def filter_for_images
      @filter_for_images ||= 'family = rhel*'
    end
  end
end
