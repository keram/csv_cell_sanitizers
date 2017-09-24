# frozen_string_literal: true

require 'test_helper'
require 'benchmark'
require 'csv'

module CsvCellSanitizers
  class ExcelInjectionBenchmark < Minitest::Benchmark
    def bench_performance_against_non_sanitized_csv
      Benchmark.bm(10) do |reporter|
        generate_standard(reporter, rows)
        generate_extended(reporter, rows)
      end
    end

    def generate_standard(reporter, rows)
      CSV.generate do |csv|
        reporter.report('standard') do
          rows.each do |item|
            csv << item
          end
        end
      end
    end

    def generate_extended(reporter, rows)
      CSV.generate do |csv|
        csv.extend(ExcelInjection)

        reporter.report('extended') do
          rows.each do |item|
            csv << item
          end
        end
      end
    end

    def rows
      Array.new(10_024, [
                  [:safe, 'safe string'],
                  [:evil, '=3+3']
                ])
    end
  end
end
