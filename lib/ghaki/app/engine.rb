require 'singleton'

module Ghaki #:nodoc:
module App   #:nodoc:

  # Singleton application engine.
  #
  # This is a unified loading place for application level singletons.
  #
  # ==== Examples
  #
  #   require 'ghaki/app/engine'
  #   app = Ghaki::App::Engine.instance

  class Engine
    include Singleton
  end

end end
