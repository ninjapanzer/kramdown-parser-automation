module Kramdown
  module Parser
    class Automation
      
      FENCED_CODEBLOCK_AUTOMATION_START_PATTERN = /.(\w*)(?:.[{](\s*[a-zA-Z0-9]+=\".+\")+[}])?/m
      FENCED_CODEBLOCK_START = ::Kramdown::Parser::Kramdown::FENCED_CODEBLOCK_START
      FENCED_CODEBLOCK_START_PATTERN = -> {
        start_pattern = FENCED_CODEBLOCK_START
        start_pattern = OPTIONS[:codeblock_automation][:start] if OPTIONS[:codeblock_automation]&.has_key?(:start)

        Regexp.new(
          start_pattern.source + FENCED_CODEBLOCK_AUTOMATION_START_PATTERN.source,
          FENCED_CODEBLOCK_AUTOMATION_START_PATTERN.options
        )
      }

      FENCED_CODEBLOCK_MATCH = /^([ ]{0,3}[~`]{3,})\W*(\w*)(?:\W*[{](\s*[a-zA-Z0-9-]+=\".+\")+[}])\W*\n([\S\W\n]*)\n\1/m
      FENCED_CODEBLOCK_MATCH_PATTERN = -> {
        match_pattern = FENCED_CODEBLOCK_MATCH
        match_pattern = OPTIONS[:codeblock_automation][:match] if OPTIONS[:codeblock_automation]&.has_key?(:match)
        match_pattern
      }

      private_constant :FENCED_CODEBLOCK_MATCH_PATTERN

      def self.parse_codeblock_automation(base, src, tree)
        start_line_number = src.current_line_number
        if src.check(FENCED_CODEBLOCK_MATCH_PATTERN.())
          start_line_number = src.current_line_number
          src.pos += src.matched_size
          el = base.new_block_el(:codeblock, src[4], nil, location: start_line_number, fenced: true)
          lang = src[2].to_s.strip
          unless lang.empty?
            el.options[:lang] = lang
            el.attr['class'] = "language-#{src[2]}"
          end

          automation = src[3].to_s.strip
          unless automation.empty?
            el.options[:automation] = automation
          end

          puts "Automation Config: #{automation}"

          tree.children << el
          true
        else
          false
        end
      end
      define_parser(:codeblock_automation, FENCED_CODEBLOCK_START_PATTERN.(), nil)

    end
  end
end