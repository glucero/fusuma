module Fusuma

  class Application

    include Properties
    include Container

    def initialize(application)
      container = Workspace.find(application[BUNDLE])

      if container.nil?
        # There are some non-native applications that can't be controlled via
        # the SystemEvents application list. For these applications, an
        # AXUIElement reference is created for controlling windows, while the
        # SBRunningApplication instance is used for controlling the application
        # itself.
        @container = AXUIElementCreateApplication(application[PID])
        @running   = application[RUNNING]

        # Override the Application's control methods.
        extend AX
        extend AX::Application
      else
        @container = container
      end
    end

    def self.active
      # The focused application (the application listed in the menu bar).
      Application.new Workspace.active
    end

    def self.all
      # Returns an array of all applications launched by the user.
      #
      # System applications (loginwindow, Dock, Notification Center) and
      # applications that are set to be automatically opened and backgrounded
      # (Alfred, Growl, Caffeine) are not included in this list.
      Workspace.launched_applications.map do |application|
        Application.new application
      end
    end

    def windows
      # If we have a valid SBApplication container, we can rely on it returning
      # an array of valid windows. If you try to get the windows array from an
      # Application with no open windows, you get nil not an empty array.
      container.windows.to_a.map { |window| Window.new(window, self) }
    end

    def focused_window
      # SBApplication windows are returned in correct Z order, so we can just
      # create a window with the first.
      Window.new(container.windows.first, self)
    end

    def activate
      # If we have a valid SBApplication, we can just set the application to
      # 'Frontmost'.
      container.setFrontmost(true)
    end

  end
end

