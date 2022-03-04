# frozen_string_literal: true

require_relative 'lib/kramdown/parser/automation_version'

Gem::Specification.new do |s|
  s.name     = 'kramdown-parser-automation'
  s.version  = Kramdown::Parser::AUTOMATION_VERSION
  s.authors  = ['Paul SCarrone']
  s.email    = ['paul.scarrone@gmail.com']
  s.homepage = ''
  s.license  = 'MIT'
  s.summary  = 'A kramdown parser for the inline automation dialect within Markdown fenced codeblocks'

  #s.files = Dir.glob('{lib,test}/**/*').concat(%w[COPYING VERSION CONTRIBUTERS])
  s.require_path = 'lib'

  s.required_ruby_version = '>= 2.5.0'

  s.add_runtime_dependency 'kramdown', '~> 2.0'
end
