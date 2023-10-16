module RealmTheme
  extend ActiveSupport::Concern
  included do
    remove_const(:TYPES)
    const_set(:TYPES, ["Red Hat Identity Management", "Active Directory"])
    #removed validator that was using the old TYPES const
    Realm.class_eval do
      _validators.delete(:realm_type)
      _validate_callbacks.each do |callback|
        if callback.raw_filter.respond_to? :attributes
          callback.raw_filter.attributes.delete :realm_type
        end
      end
      validates :realm_type, :presence => true, :inclusion => { :in => ["Red Hat Identity Management", "Active Directory"] }
    end
  end

end
