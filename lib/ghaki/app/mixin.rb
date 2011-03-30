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

  module Mixin

    def self.included klass #:nodoc:
      klass.class_exec do
        include Ghaki::App::Mixer
        app_engine_class_mixin :app
      end
    end

  end

end end
