module Fusuma

  class Configuration

    include Logger
    include Properties

    def layouts
      # Build each of the listed Layouts in the configuration, then match each
      # layout to each active desktop for the current space (layout_1 is paired
      # with with desktop_1 and layout_2 to desktop_2, etc). Finally, rescale
      # the layout to the matching desktop's dimensions.
      read_configuration do |layouts, keymap|
        @keymap = keymap
        layouts = layouts.map { |l| Layout.load(l) }

        log.debug "#{layouts.count} layouts configured."

        layouts.zip(Workspace.desktops) do |layout, desktop|

          layout.scale_to desktop unless desktop.nil?
        end

        layouts
      end
    rescue => error
      log.error error.message
      log.error error.backtrace.join("\n")
    end

    def keymap(layout)
      KeyMap.new(layout) do |keymap|

        log.debug "#{@keymap.count} keymaps configured."

        @keymap.each do |action, sequence|
          keymap.add(action, sequence)
        end

        keymap.keys
      end
    rescue => error
      log.error error.message
      log.error error.backtrace.join("\n")
    end

    def read_configuration
      File.open(CONFIG, 'r') do |file|
        file = JSON.parse(file.read)

        yield file.values
      end
    rescue => error
      log.error error.message
      log.error error.backtrace.join("\n")
    end

  end
end

