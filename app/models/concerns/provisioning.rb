module Provisioning
  extend ActiveSupport::Concern

  included do
    scoped_search on: :name, complete_value: { true: true, false: false }, rename: 'supported', ext_method: :search_by_supported

    def self.search_by_supported(_key, operator, value)
      value = value == 'true'
      value = !value if operator == '<>'
      op    = value ? 'IN' : 'NOT IN'
      names = ProvisioningTemplatesControllerBranding::SUPPORTED_PROVISIONING_TEMPLATES.map do |n|
        "'#{n}'"
      end.join(',')
      conditions = "templates.name #{op} (#{names})"

      {
        conditions: sanitize_sql_for_conditions([conditions])
      }
    end
  end
end
