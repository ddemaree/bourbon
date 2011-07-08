module Bourbon
  class << self
    def root
      Pathname.new( File.expand_path("../../", __FILE__) )
    end

    def stylesheets_path
      Bourbon.root.join("app", "assets", "stylesheets")
    end
  end
end

require 'bourbon/railtie' if defined?(Rails)