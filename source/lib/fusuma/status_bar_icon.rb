module Fusuma

  class StatusBarIcon < NSView

    include Properties

    ICON = 'f'
    SIZE = 18.0

    X = Y = 0.0
    W = H = 20.0

    def initialize(controller)
      @selected = false
      @controller = controller
      initWithFrame(Area(X, Y, W, H))
    end

    def color
      @selected ? NSColor.selectedMenuItemTextColor : NSColor.controlTextColor
    end

    def highlight(rect)
      NSColor.selectedMenuItemColor.set
      NSRectFill(rect)
    end

    def icon_frame
      size = ICON.sizeWithAttributes(style)

      width = (frame.size.width - size.width) / 2.0
      height = (frame.size.height - size.height) / 2.0

      Area(width, height, size.width, size.height)
    end

    def drawRect(rect)
      highlight(rect) if @selected

      ICON.drawInRect(icon_frame, withAttributes:style)
    end

    def style
      { FONTSIZE => font_size,
        FGCOLOR  => color,
        PGSTYLE  => para_style }
    end

    def font_size
      NSFont.menuBarFontOfSize(SIZE)
    end

    def para_style
      paragraph = NSMutableParagraphStyle.alloc.init
      paragraph.setParagraphStyle(NSParagraphStyle.defaultParagraphStyle)
      paragraph.setAlignment(CENTER)
      paragraph.setLineBreakMode(BREAK)
      paragraph
    end

    def mouseDown(event)
      @controller.toggle window.frame
    end

    def show
      @selected = true
      setNeedsDisplay true
    end

    def hide
      @selected = false
      setNeedsDisplay true
    end

  end

end

