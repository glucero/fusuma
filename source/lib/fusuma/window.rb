module Fusuma

  class Window

    include Properties
    include Container

    def initialize(window, application)
      @container = window
      @application = application
    end

    def location
      # The window's current desktop based on whether the window's origin (x,y)
      # is within a desktop's visible range.
      Workspace.desktops.each_with_index do |desktop, index|
        x, y = position
        x_range = (desktop.origin.x..desktop.size.width)
        y_range = (desktop.origin.y..desktop.size.height)

        if x_range.include?(x) && y_range.include?(y)
          location = Struct.new(:index, :origin, :size)
          return location.new(index, desktop.origin, desktop.size)
        end
      end
    end

    def self.all
      # All open windows for all open applications that the user has launched.
      Application.all.map(&:windows)
    end

    def self.active
      # The active window of the active application.
      Application.active.focused_window
    end

    def activate
      # Raise the window's index to the top of the application's window list,
      # then activate the application. (fancy way of saying 'focus the window')
      container.elementArrayWithCode(ACTION).objectWithName(RAISE).perform

      @application.activate
    end

    def position
      # Returns Array[x, y]:
      #
      # > window.position
      #     => [0.0, 0.0]
      container.propertyWithCode(POSITION).get
    end

    def position=(position)
      # Set the window's position:
      #
      # > window.position = [0.0, 0.0]
      container.propertyWithCode(POSITION).setTo position
    end

    def dimensions
      # Returns Array[height, width]:
      #
      # > window.dimensions
      #     => [100.0, 100.0]
      container.propertyWithCode(DIMENSIONS).get
    end

    def dimensions=(dimensions)
      # Set the window's dimensions:
      #
      # > window.dimensions = [100.0, 100.0]
      container.propertyWithCode(DIMENSIONS).setTo dimensions
    end

  end
end

