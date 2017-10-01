# frozen_string_literal: true

require 'test_helper'
require 'benchmark'
require 'csv'

module CsvCellSanitizers
  class SaveCSV < CSV
    include(ExcelInjection)
  end

  class ExcelInjectionBenchmark < Minitest::Benchmark
    def bench_performance_against_non_sanitized_csv
      Benchmark.bm(10) do |reporter|
        generate_standard(reporter, rows)
        generate_extended(reporter, rows)
        generate_if_else_everything(reporter, rows)
        generate_if_else_with_sub(reporter, rows)
        generate_safecsv(reporter, rows)
      end
    end

    def generate_standard(reporter, rows)
      CSV.generate do |csv|
        reporter.report('standard') do
          rows.each do |row|
            csv << row
          end
        end
      end
    end

    def generate_safecsv(reporter, rows)
      SaveCSV.generate do |csv|
        reporter.report('safecvs') do
          rows.each do |row|
            csv << row
          end
        end
      end
    end

    def generate_extended(reporter, rows)
      CSV.generate do |csv|
        csv.extend(ExcelInjection)
        reporter.report('extended') do
          rows.each do |row|
            csv << row
          end
        end
      end
    end

    def generate_if_else_everything(reporter, rows)
      sanitize = true
      CSV.generate do |csv|
        reporter.report('if_els_ev') do
          rows.each do |row|
            csv << if sanitize
                     row.map { |item| "'#{item}" }
                   else
                     row
                   end
          end
        end
      end
    end

    def generate_if_else_with_sub(reporter, rows)
      sanitize = true
      CSV.generate do |csv|
        reporter.report('if_els_s') do
          rows.each do |row|
            csv << if sanitize
                     row.map { |item| item.to_s.sub(/(\A=)(?=[^=]+)/, "'=") }
                   else
                     row
                   end
          end
        end
      end
    end

    def rows
      Array.new(100_024, [
                  'safe string',
                  '=3+3',
                  '=afdsa+3232',
                  1337,
                  :symbol
                ])
    end
  end
end
