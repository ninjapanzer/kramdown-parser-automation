# frozen_string_literal: true

require_relative 'kramdown/parser/automation_version'

autoload Kramdown::Parser::Automation, 'kramdown/parser/automation'

Kramdown::Parser::Automation.load_extension(:codeblock_automation)
Kramdown::Parser::Automation.mixin_registry(Kramdown::Parser::Kramdown)
