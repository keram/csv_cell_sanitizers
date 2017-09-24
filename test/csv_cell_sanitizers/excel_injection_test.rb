# frozen_string_literal: true

require 'test_helper'
require 'csv'

module CsvCellSanitizers
  module SomeOtherMod
    def <<(arg)
      super(arg)
    end
  end

  module SecondOtherMod
    def <<(arg)
      super(arg)
    end
  end

  class SafeCSV < CSV
    include(ExcelInjection)
  end

  class ExcelInjectionTest < Minitest::Test
    def test_that_it_sanitize_dangerous_string
      result = CSV.generate do |csv|
        csv.extend(ExcelInjection)

        csv << [1, '=3+4']
      end

      assert_equal "1,'=3+4\n", result
    end

    def test_that_it_does_not_sanitize_safe_string
      result = CSV.generate do |csv|
        csv.extend(ExcelInjection)

        csv << [1, '3+4']
      end

      assert_equal "1,3+4\n", result
    end

    def test_that_it_does_not_affect_non_extended_csv
      result = CSV.generate do |csv|
        csv << [1, '=3+4']
      end

      assert_equal "1,=3+4\n", result
    end

    def test_it_works_with_other_mixins
      result = CSV.generate do |csv|
        csv.extend(SomeOtherMod)
        csv.extend(ExcelInjection)
        csv.extend(SecondOtherMod)

        csv << [2, '=2+2']
      end

      assert_equal "2,'=2+2\n", result
    end

    def test_safe_csv
      result = SafeCSV.generate_line(['=lorem', 'sec'])

      assert_equal("'=lorem,sec\n", result)
      result = SafeCSV.generate { |csv| csv << ['=x'] }

      assert_equal("'=x\n", result)
    end

    def test_not_sanitize_one_char_str
      result = SafeCSV.generate_line(['='])

      assert_equal("=\n", result)
    end

    def test_not_sanitize_two_or_more_equal_signs_in_row
      result = SafeCSV.generate_line(['==xx'])

      assert_equal("==xx\n", result)
    end
  end
end
