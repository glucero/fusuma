module Fusuma

  class StatusBar

    include Logger
    include Properties

    def initialize
      log.info 'Initializing StatusBar.'
      @status_bar = NSStatusBar.systemStatusBar.statusItemWithLength(STATUS)
      @status_bar.view = StatusBarIcon.new(self)
      @status_bar.highlightMode = true
    end

    def show(frame)
      @window = StatusBarWindow.alloc.init(frame, self)
      @window.show
      @status_bar.view.show
    end

    def hide(frame)
      @window.hide
      @status_bar.view.hide
      @window = frame
    end

    def toggle(frame = nil)
      @window ? hide(frame) : show(frame)
    end

  end

end
