# Remember to require this file in the environment.rb after require 'desert'
module Desert
  class Plugin
    def observers_path
      "#{@path}/app/observers"
    end
  end
end

module Desert
  class Manager
    def register_plugin_with_observers(plugin_path)
      plugin = Plugin.new(plugin_path)
      @plugins_in_registration << plugin

      yield if block_given?

      dependencies.load_paths << plugin.models_path
      dependencies.load_paths << plugin.controllers_path
      dependencies.load_paths << plugin.helpers_path
      dependencies.load_paths << plugin.observers_path

      @plugins_in_registration.pop

      if existing_plugin = find_plugin(plugin.name)
        return existing_plugin
      end

      @plugins << plugin
      plugin
    end

    alias_method_chain :register_plugin, :observers
  end
end