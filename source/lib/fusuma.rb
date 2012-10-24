#### remove when we're done ####
class Object

  def filter_methods
    (self.methods(true, true) - Object.methods(true, true)).sort
  end
end
################################

module Fusuma

  require 'fusuma/logger'

  require 'fusuma/properties'
  require 'fusuma/scale'
  require 'fusuma/container'

  require 'fusuma/layout'
  require 'fusuma/keymap'
  require 'fusuma/configuration'

  require 'fusuma/ax'
  require 'fusuma/ax_application'
  require 'fusuma/ax_window'

  require 'fusuma/workspace'
  require 'fusuma/application'
  require 'fusuma/window'

  require 'fusuma/status_bar'
  require 'fusuma/status_bar_icon'
  require 'fusuma/status_bar_window'

  class Fusuma

    include Logger
    include Properties

    def initialize
      log.info 'Initializing Fusuma.'
      @application = NSApplication.sharedApplication

      NSApp.setActivationPolicy POLICY
      @status_bar = StatusBar.new

      @application.delegate = self
      @application.run
    rescue => error
      log.error error.message
      log.error error.backtrace.join("\n")
    end

    def applicationDidFinishLaunching(notification)
      log.info 'Configuring Fusuma.'
      configuration = Configuration.new

      @layouts = configuration.layouts
      @keymap  = configuration.keymap(@layouts.first) # use only 1 layout right now
    rescue => error
      log.error error.message
      log.error error.backtrace.join("\n")
    end

  end

end

