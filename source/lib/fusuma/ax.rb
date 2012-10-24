module Fusuma

  module AX

    def title
      copy(TITLE, &:value)
    end

    def create(type, values)
      value = create_pointer(type, values)

      yield AXValueCreate(*value)
    end

    def copy(attribute)
      pointer = Pointer.new(:id)

      AXUIElementCopyAttributeValue(container, attribute, pointer)
      yield pointer
    end

    def set(attribute, value)
      AXUIElementSetAttributeValue(container, attribute, value)
    end

    def create_pointer(type, values = nil)
      type = type.to_s.capitalize
      pointer = Pointer.new("{CG#{type}=dd}")

      unless values.nil?
        point = Kernel.const_get("NS#{type}")
        pointer.assign point.new(*values)
      end

      Array[Properties.const_get("CG#{type.upcase}"), pointer]
    end

    def get(type, source)
      type, pointer = create_pointer(type)

      AXValueGetValue(source, type, pointer)
      pointer.value
    end

  end

end

