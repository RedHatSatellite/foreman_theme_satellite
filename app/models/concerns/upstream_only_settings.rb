# Settings to hide in downstream (will return nil for all values)
class UpstreamOnlySettings
  SETTINGS = %w[
  ].freeze

  def self.include?(key)
    new.include?(key)
  end

  def include?(key)
    SETTINGS.include?(key.to_s)
  end
end
