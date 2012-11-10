module Fusuma

  class StatusBarWindow < NSWindow

    include Logger
    include Properties

    X = Y = 0.0
    W,  H = 50.0, 30.0

    def init(frame, controller)
      @controller = controller

      log.info 'Initializing StatusBarWindow'

      window = create(Area(frame.origin.x, (frame.origin.y - H), W, H))
      window.contentView.addSubview(create_button)
      window
    end

    def create(frame)
      window = initWithContentRect(frame, styleMask:MASK, backing:BACKING, defer:false)
      window.level     = LEVEL
      window.hasShadow = true
      window.delegate  = self
      window
    end

    def create_button
      button = NSButton.alloc.initWithFrame(Area(X, Y, W, H))
      button.bezelStyle = 11
      button.title      = 'Quit'
      button.target     = self
      button.action     = 'quit:'
      button
    end

    def show
      makeKeyAndOrderFront self
      NSApplication.sharedApplication.activateIgnoringOtherApps true
    end

    def hide
      orderOut self
    end

    def canBecomeKeyWindow
      true
    end

    def resignKeyWindow
      @controller.toggle
    end

    def quit(sender)
      NSApp.terminate nil
    end
  end

end
