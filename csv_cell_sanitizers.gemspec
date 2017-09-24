# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_cell_sanitizers/version'

Gem::Specification.new do |spec|
  spec.name          = 'csv_cell_sanitizers'
  spec.version       = CsvCellSanitizers::VERSION
  spec.authors       = ['Marek L']
  spec.email         = ['nospam.keram@gmail.com']

  spec.summary       = 'Sanitization modules for CSV.'
  spec.description   = 'Protect against excel injections and more'
  spec.homepage      = 'https://github.com/keram/csv_cell_sanitizers'
  spec.license       = 'MIT'
  spec.required_ruby_version = '~> 2.3'
  spec.metadata['allowed_push_host'] = 'https://github.com'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'overcommit', '~> 0.41'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-minitest', '~> 2.4'
end
