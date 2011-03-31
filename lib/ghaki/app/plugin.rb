require 'singleton'
require 'ghaki/app/engine'

module Ghaki #:nodoc:
module App   #:nodoc:

  # Singleton application plugin.
  #
  # ==== Examples
  #
  #   require 'ghaki/app/plugin'
  #
  #   class Widget
  #     attr_accessor :size
  #     def initialize opts={}
  #       @size = opts[:size]
  #     end
  #   end
  #
  #   class WidgetApp < Ghaki::App::Plugin
  #     app_plugin_make Widget, :widget
  #   end
  #
  #   # Default plugin constructor options.
  #   WidgetApp.instance.widget_defs = {
  #     :size => 20,
  #   }
  #
  #   # Actual plugin constructor options.
  #   WidgetApp.instance.widget_opts = {
  #     :size => 10,
  #   }
  #
  #   # Generated plugin has set value.
  #   WidgetApp.instance.widget.size #=> 10

  class Plugin
    include Singleton

    protected

    # Generates attribute functions for the plugin class,
    # constructor options, and default constructor options.

    def self.app_plugin_make klass, name
      opts = "#{name}_opts".to_sym
      defs = "#{name}_defs".to_sym
      class_eval <<-"END"
        attr_writer :#{defs}, :#{opts}, :#{name}
        def #{defs}
          @#{defs} ||= {}
        end
        def #{opts}
          @#{opts} ||= self.#{defs}
        end
        def #{name}
          @#{name} ||= #{klass}.new( self.#{opts} )
        end
      END
    end

    # Links the plugin singleton with the engine singleton.

    def self.app_plugin_link source, target=source
      inst = "#{self}.instance"
      Ghaki::App::Engine.class_eval <<-"END"
        def #{target}_defs      ; #{inst}.#{source}_defs      end
        def #{target}_defs= val ; #{inst}.#{source}_defs= val end
        def #{target}_opts      ; #{inst}.#{source}_opts      end
        def #{target}_opts= val ; #{inst}.#{source}_opts= val end
        def #{target}           ; #{inst}.#{source}           end
        def #{target}=      val ; #{inst}.#{source}=      val end
      END
    end

  end
end end
