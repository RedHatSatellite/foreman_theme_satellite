Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'foreman_brand' => 'FOREMAN_BRAND',
    'deprecated_templates' => 'DEPRECATED_TEMPLATES'
  )
end
