require 'ghaki/app/mixer'

module Ghaki #:nodoc:
module App   #:nodoc:

  # Default engine mixin name.
  #
  # ==== Example
  #
  #   require 'ghaki/app/mixin'
  #
  #   class MyWidget
  #     include Ghaki::App::Mixin
  #
  #     def do_something
  #       app.logger.info 'did something'
  #     end
  #   end
  #
  #   class OtherWidget
  #     extend Ghaki::App::Mixin
  #
  #     def self.do_something
  #       app.logger.info 'did something else'
  #     end
  #   end

  module Mixin

    def self.included klass #:nodoc:
      klass.class_exec do
        include Ghaki::App::Mixer
        app_engine_class_mixin :app
      end
    end

    def self.extended klass #:nodoc:
      klass.class_exec do
        include Ghaki::App::Mixer
        app_engine_eigen_mixin :app
      end
    end

  end

end end
