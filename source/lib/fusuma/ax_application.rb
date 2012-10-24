module Fusuma

  module AX

    module Application

      include Properties

      def windows
        # If we're relying on AXUIElement creation we need to copy the
        # application's 'window list' attribute to a pointer and create
        # AXUIElementWindows.
        copy(WINDOWS, &:value).to_a.map { |window| create window }
      end

      def focused_window
        # AXUIElement creation requires us to copy the application's focused
        # window attribute to a pointer and create an AXUIWindowElement with
        # it.
        create copy(FOCUSED, &:value)
      end

      def create(window)
        window = Fusuma::Window.new(window, self)
        window.extend AX
        window.extend AX::Window
        window
      end

      def activate
        # If we're using an AXUIElement, we can use a function from the
        #  NSRunningApplication instance 'activateWithOptions' (some
        # applications respond to this function by opening another instance of
        # the application or another window).
        @running.activateWithOptions(2)
      end

    end

  end

end

