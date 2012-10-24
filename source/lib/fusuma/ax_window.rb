module Fusuma

  module AX

    module Window

      include Properties

      def activate
        set(MAIN, true)

        @application.activate
      end

      def position
        copy(POS) do |pointer|
          get(:point, pointer.value)
        end
      end

      def position=(position)
        create(:point, position) do |pointer|
          set(POS, pointer)
        end
      end

      def dimensions
        copy(DIM) do |pointer|
          get(:size, pointer.value)
        end
      end

      def dimensions=(dimensions)
        create(:size, dimensions) do |pointer|
          set(DIM, pointer)
        end
      end

    end

  end

end

