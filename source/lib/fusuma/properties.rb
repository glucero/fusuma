module Fusuma

  module Properties

    NAME       = 'NSApplicationName'
    PID        = 'NSApplicationProcessIdentifier'
    BUNDLE     = 'NSApplicationBundleIdentifier'
    RUNNING    = 'NSWorkspaceApplicationKey'

    EVENTS     = 'com.apple.SystemEvents'

    FOCUSED    = NSAccessibilityFocusedWindowAttribute
    WINDOWS    = NSAccessibilityWindowsAttribute
    POS        = NSAccessibilityPositionAttribute
    DIM        = NSAccessibilitySizeAttribute
    MAIN       = NSAccessibilityMainAttribute
    TITLE      = NSAccessibilityTitleAttribute
    RAISE      = NSAccessibilityRaiseAction

    STATUS     = NSVariableStatusItemLength
    CENTER     = NSCenterTextAlignment
    BREAK      = NSLineBreakByTruncatingTail
    FONTSIZE   = NSFontAttributeName
    FGCOLOR    = NSForegroundColorAttributeName
    PGSTYLE    = NSParagraphStyleAttributeName
    MASK       = NSBorderlessWindowMask
    BACKING    = NSBackingStoreBuffered
    LEVEL      = NSStatusWindowLevel
    POLICY     = NSApplicationActivationPolicyAccessory

    CGSIZE     = KAXValueCGSizeType
    CGPOINT    = KAXValueCGPointType

    ACTION     = 'actT'.unpack('N').first
    POSITION   = 'posn'.unpack('N').first
    DIMENSIONS = 'ptsz'.unpack('N').first

    LAYOUTS    = File.expand_path(File.join('lib', 'fusuma', 'layouts'))
    CONFIG     = File.join('conf', 'configuration.json')

    def Area(x, y, w, h)
      NSRect.new(NSPoint.new(x, y), NSSize.new(w, h))
    end

  end

end

