module Fusuma

  module Container

    attr_reader :container

    def ==(target)
      container.eql? target.container
    end

    def title
      container.name
    end

  end

end
