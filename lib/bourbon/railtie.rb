module Bourbon
  # Here's a thinker: aren't rails engines dependent on Railties or something?
  class Engine < ::Rails::Engine
    require 'bourbon/engine'
  end
  
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "bourbon.append_load_paths" do
        begin
          require 'sass'
          require 'sass/plugin'
        rescue LoadError => e
          puts "Sass is not available. Bourbon must be enjoyed with Sass 3.1 or later."
        end

        Sass::Plugin.options[:load_paths] ||= []
        Sass::Plugin.options[:load_paths] << Bourbon.stylesheets_path
      end
      
      rake_tasks do
        load "tasks/install.rake"
      end
    end
  end
end