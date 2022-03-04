require 'kramdown/options'
require 'kramdown/parser/kramdown'

require_relative 'automation/options'
require_relative 'automation_version'

module Kramdown
  module Parser

    # This class provides a parser implementation for the GFM dialect of Markdown.
    class Automation < Kramdown::Parser::Kramdown

      VERSION = Parser::AUTOMATION_VERSION

      EXTENSIONS = {
        codeblock_automation: 'kramdown/parser/automation/automation_parser'
      }.freeze

      LOADED_EXTENSIONS = {}
      OPTIONS = {}

      REGISTRY = []

      private_constant :EXTENSIONS, :LOADED_EXTENSIONS

      def self.load_extension(id, options = {})
        return LOADED_EXTENSIONS[id] if LOADED_EXTENSIONS.key?(id)

        OPTIONS[id] ||= begin
          options
        rescue StandardError => e
          false
        end

        LOADED_EXTENSIONS[id] ||= begin
          require EXTENSIONS[id]
        rescue LoadError
          false
        end
      end

      def self.define_parser(name, start_re, span_start = nil, meth_name = "parse_#{name}")
        define_method("parse_#{name}".to_sym) do |src, tree|
          send("parse_#{parser}".to_sym, src, tree)
        end
        REGISTRY.push(name)
        super
      end

      def initialize(source, options)
        super
        @block_parsers.unshift(:codeblock_automation)
        self.class.load_extension(:automation)
      end

    end
  end
end
