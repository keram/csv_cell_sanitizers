# frozen_string_literal: true

module CsvCellSanitizers
  module ExcelInjectionRefinements
    refine String do
      def sanitize_excel_injection(object)
        object.sanitize_string_excel_injection(self)
      end
    end

    refine Enumerable do
      def sanitize_excel_injection(object)
        map do |item|
          item.sanitize_excel_injection(object)
        end
      end
    end

    refine Object do
      def sanitize_excel_injection(_)
        self
      end
    end
  end

  module ExcelInjection
    using ExcelInjectionRefinements

    def <<(arg)
      super(arg.sanitize_excel_injection(self))
    end

    def sanitize_string_excel_injection(str)
      str.gsub(/(\A=)(?=[^=]+)/, "'=")
    end
  end
end
