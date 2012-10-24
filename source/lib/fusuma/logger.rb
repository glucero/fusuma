module Fusuma

  module Logger

    def log
      @log ||= logger
    end

    private

    def log_formatter
      ->(severity, datetime, program, message) do
        datetime = datetime.strftime("%Y-%m-%dT%H:%M:%S")
        "[#{datetime}] - #{severity} - (#{component_name}) #{message}\n"
      end
    end

    def component_name
      self.class.name[/\w+::(.+)/, 1]
    end

    def logger
      logger = Kernel::Logger.new(File.join('log', 'fusuma.log'), 3, 5 * 1024 * 1024)
      logger.formatter = log_formatter
      logger
    end
  end

end

