module Fusuma

  module Workspace

    extend self
    include Properties

    def menubar
      # The OSX menu bar's height in pixels. It seems to always be 22 pixels no
      # matter what resolution I'm using, but it doesn't hurt to ask the system.
      NSMenu.menuBarHeight
    end

    def desktops
      # Returns the position and dimensions (as an NSRect) of each active
      # desktop for the current OSX space.
      #
      # > Workspace.desktops.first
      #   => #<NSRect origin=#<NSPoint x=4.0 y=0.0> size=#<NSSize width=1436.0 height=878.0>>

      # screens = NSScreen.screens.map(&:frame)
      screens = NSScreen.screens.map(&:visibleFrame) # ಠ_ಠ

      # Cocoa sees desktops stacked on top of each other starting with the main
      # desktop (the desktop that has the OSX menu bar) and moving down regardless
      # of the actual desktop setup.
      #
      # For example, if your main monitor's resolution is 1440x900 and the
      # secondary monitor's resolution is 1440x900 and you have the secondary
      # monitor stacked on top of the primary - the secondary monitor's origin
      # will be [0,900] while the origin of a maximized window on the secondary
      # monitor will be [0,-900].
      #
      # Yes, this is stupid.
      screens.map!.each_with_index do |screen, index|
        if index.zero?
          screen
        else
          scale = Scale.from_rect(screen)
          scale.flip_rect
        end
      end
    end

    def find(bundle)
      # You can create each SBApplication instance individually:
      #   > SBApplication.applicationWithBundleIdentifier('com.apple.finder')
      #     => <FinderApplication @0x1837140: application "Finder" (254)>
      #   > SBApplication.applicationWithProcessIdentifier(254)
      #     => <FinderApplication @0x1624920: application "Finder" (254)>
      #
      # Most of the actions and objects available to an SBApplication instance
      # require the application to have an OSX scripting definition, which in turn
      # means the application is required to be a native OSX application.
      #
      # Instead of creating each SBApplication individually, we can bypass the
      # scripting definition requirement by creating an SBApplication instance
      # of System Events (the scripting bridge application itself) and use its
      # list of all running applications.
      system_events = SBApplication.applicationWithBundleIdentifier(EVENTS)

      system_events.applicationProcesses.find do |application|
        application.bundleIdentifier.eql? bundle
      end
    end

    def launched_applications
      # A list of applications launched by the user.
      #
      #   NSApplicationPath (ex. '/System/Library/CoreServices/Finder.app')
      #   NSWorkspaceApplicationKey (an NSRunningApplication instance)
      #   NSApplicationBundleIdentifier (ex. 'com.apple.finder')
      #   NSApplicationProcessSerialNumberLow (ex 45067)
      #   NSApplicationProcessIdentifier (ex. 254)
      #   NSApplicationProcessSerialNumberHigh (ex. 0)
      #   NSApplicationName (ex. 'Finder')
      NSWorkspace.sharedWorkspace.launchedApplications
    end

    def active
      # This returns the same properties as the Workspace.launched_applications
      # list, but only the currently focused application.
      NSWorkspace.sharedWorkspace.activeApplication
    end

  end
end

