module Rails
  class Plugin
    attr_accessor :initializer

    def plugin_present?(plugin_name)
      initializer.configuration.plugin_locators.each do |locator|
        locator.new(initializer).each do |plugin_loader|
          return true if plugin_loader.name.to_s == plugin_name.to_s
        end
      end
      return false #raise "Plugin '#{plugin_name}' does not exist"
    end
  end
end
