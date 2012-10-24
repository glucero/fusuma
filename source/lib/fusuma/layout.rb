module Fusuma

  class Layout < Array

    include Properties

    attr_accessor :frames, :scale

    def self.all
      layouts = Dir.glob(File.join(LAYOUTS, '**.json'))

      layouts.map do |layout|
        File.open(layout, 'r') do |file|
          OpenStruct.new JSON.load(file.read)
        end
      end
    end

    def self.load(name)
      config = Layout.all.find { |l| l.name.eql? name }

      Layout.new(config.scale, config.frames)
    end

    def initialize(scale, frames)
      @scale  = Area(*scale.values.flatten)
      @frames = frames
    end

    def scale_to(desktop)
      scale = Scale.from_rect(@scale)

      @scale = desktop # assign the desktop rect as this layout's scale
      scale.scaler(desktop)

      @frames.map! do |frame|
        frame.map! { |layout| scale.convert(layout) }
      end
    end

    def apply
      zip(@frames[count - 1]) do |window, frame|
        # reposition and resize each window depending on its associated layout
        # frame's position/dimensions.
        window.position = frame.origin.to_a
        window.dimensions = frame.size.to_a
      end
    end

    def remove(window)
      reject! { |w| w.eql? window }
    end

    def main() first end

    def append(window)
      # Remove the window if it already exists, then add it to the end of the
      # layout and remove any extra windows from the beginning of the layout.
      remove window
      push window

      shift while count > @frames.count
    end

    def prepend(window)
      # Remove the window if it already exists, then add it to the beginning of
      # the layout and remove any extra windows from the end of the layout.
      remove window
      unshift window

      pop while count > @frames.count
    end

  end

end
