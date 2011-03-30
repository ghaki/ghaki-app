require 'ghaki/app/engine'

module Ghaki #:nodoc:
module App   #:nodoc:

  module Mixer #:nodoc:

    # Allows customizable engine mixin name.
    #
    # ==== Example
    #
    #   require 'ghaki/app/mixer'
    # 
    #   class MyWidget
    #
    #     include Ghaki::App::Mixer
    #     app_engine_mixin :sys_app
    #
    #     def do_something
    #       sys_app.logger.info 'doing something'
    #     end
    #
    #   end

    module ClassMethods

      # Generate engine mixin reader in eigen class.

      def app_engine_eigen_mixin name
        class_eval <<-"END"
          def self.#{name}
            Ghaki::App::Engine.instance
          end
        END
      end

      # Generate engine mixin reader in class.

      def app_engine_class_mixin name
        class_eval <<-"END"
          def #{name}
            Ghaki::App::Engine.instance
          end
        END
      end

      # Generate engine mixins in both the class and eigen class.

      def app_engine_mixin name
        app_engine_eigen_mixin name
        app_engine_class_mixin name
      end

    end

    def self.included klass #:nodoc:
      klass.extend ClassMethods
    end

  end

end end
