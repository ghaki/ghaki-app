module Ghaki #:nodoc:
module App   #:nodoc:

  module Mixable #:nodoc:
    # ==== Examples
    #
    #   require 'ghaki/app/plugin'
    #   require 'ghaki/app/mixer'
    #
    #   class Duck
    #     attr_accessor :quack
    #   end
    #
    #   class DuckApp < Ghaki::App::Plugin
    #     app_plugin_accessor Duck, :duck
    #   end
    #
    #   class DuckMixin
    #      include Ghaki::App::Mixable
    #      app_mixin_accessor DuckApp, :duck
    #   end
    #
    #   class UsingDuck
    #     include DuckMixin
    #     def quacker
    #       duck.quack = true
    #     end
    #   end

    module ClassMethods

      # Generate mixin attribute reader.
      # Uses the singleton copy unless overwritten by the writer.

      def app_mixin_reader klass, source, target=source
        if klass.respond_to?(:instance)
          class_eval <<-"END"
            def #{target}
              @#{target} ||= #{klass}.instance.#{source}
            end
          END
          func = :instance
        elsif klass.respond_to?(:new)
          class_eval <<-"END"
            def #{target}
              @#{target} ||= #{klass}.new
            end
          END
        else
          raise ArgumentError, "Unknown Constructor: #{klass}"
        end
      end

      # Generate mixin attribute writer.
      # Allows the local copy of the singleton value to be overriden.

      def app_mixin_writer target
        class_exec do
          attr_writer target
        end
      end

      # Generate attribute reader and writer.

      def app_mixin_accessor klass, source, target=source
        app_mixin_reader klass, source, target
        app_mixin_writer target
      end

    end

    def self.included klass #:nodoc:
      klass.extend ClassMethods
    end

  end

end end
