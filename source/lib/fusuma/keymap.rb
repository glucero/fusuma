module Fusuma

  class KeyMap

    include Logger

    attr_reader :keys, :layout

    def activate_next_window
      # find the active window in the layout and activate the previous window
      # without changing the layout or positioning of any windows
      log.debug "Activating the next layout window."
      index = layout.index(Application.active.focused_window)
      layout[index - 1].activate
    end

    def activate_previous_window
      # Reverse the layout, find the position of the currently focused window
      # and activate the previous window. This is done because negative numbered
      # array elements start from the end of the array - so we don't have to
      # worry about the index being out of bounds.
      log.debug "Activating the previous layout window."
      reversed = layout.reverse
      index = reversed.index(Application.active.focused_window)
      reversed[index - 1].activate
    end

    def rotate_layout_clockwise
      # make the last window the main(first) window and reorganize the windows
      log.debug "Rotating the layout clockwise."
      layout.prepend layout.last
      apply_layout

      activate_previous_window
    end

    def rotate_layout_counterclockwise
      # make the main(first) window the last window and reorganize the windows
      log.debug "Rotating the layout counter clockwise."
      layout.append layout.first
      apply_layout

      activate_next_window
    end

    def main_window
      # make the active window the main(first) window (if it's not in the layout,
      # add it) and reorganize the windows
      log.debug "Setting the active window as layout's main window."
      layout.prepend Window.active
      apply_layout
    end

    def master
      if layout.main.eql? Window.active
        log.debug "The active window is already the main window."
        remove_active_window
      else
        log.debug "This active window is not in the layout or is not the main window."
        main_window
      end
    end

    def remove_active_window
      log.debug "Removing the active window from the layout."
      layout.remove Window.active
      apply_layout
    end

    def apply_layout
      log.debug "Applying the window positioning and sizing rules of the layout."
      layout.apply
    end

    def remove_all_windows
      log.debug "Removing all windows from the layout."
      layout.clear
    end

    # a set of mappings to activate windows by layout index
    def activate_window_1
      log.debug "Activating window 1."
      layout[0].activate
    end

    def activate_window_2
      log.debug "Activating window 2."
      layout[1].activate
    end

    def activate_window_3
      log.debug "Activating window 3."
      layout[2].activate
    end

    def activate_window_4
      log.debug "Activating window 4."
      layout[3].activate
    end

    def activate_window_5
      log.debug "Activating window 5."
      layout[4].activate
    end

    def activate_window_6
      log.debug "Activating window 6."
      layout[5].activate
    end

    def activate_window_7
      log.debug "Activating window 7."
      layout[6].activate
    end

    def activate_window_8
      log.debug "Activating window 8."
      layout[7].activate
    end

    def activate_window_9
      log.debug "Activating window 9."
      layout[8].activate
    end

    def activate_window_10
      log.debug "Activating window 10."
      layout[9].activate
    end

    def add(action, sequence)
      keys.addHotString(sequence, &(-> { send(action.to_sym) }))
    end

    def initialize(layout)
      @layout = layout
      @keys = HotKeys.new

      yield self
    end

  end
end
