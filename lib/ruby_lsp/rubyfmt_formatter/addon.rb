# frozen_string_literal: true

require "ruby_lsp/internal"
require "open3"

module RubyLsp
  module RubyfmtFormatter
    class Addon < ::RubyLsp::Addon
      def activate(global_state, message_queue)
        @message_queue = message_queue
        global_state.register_formatter("rubyfmt", Formatter.new(global_state))
      end

      def deactivate
      end

      def name
        "rubyfmt Formatter"
      end
    end

    class Formatter
      include RubyLsp::Requests::Support::Formatter

      def initialize(global_state)
        @global_state = global_state
      end

      def run_formatting(uri, document)
        source = document.source
        command = build_command

        stdout, stderr, status = Open3.capture3(*command, stdin_data: source)

        unless status.success?
          raise StandardError, "`rubyfmt` failed: #{stderr}"
        end

        stdout
      end

      def run_range_formatting(_uri, _source, _base_indentation)
        # rubyfmt doesn't support range formatting
      end

      def run_diagnostic(_uri, _document)
        # rubyfmt doesn't emit diagnostics
      end

      private def build_command
        path = rubyfmt_executable
        args = additional_args

        [path] + args
      end

      private def rubyfmt_executable
        # Fall back to PATH if nothing is provided
        settings.fetch("rubyfmtPath", "rubyfmt")
      end

      private def additional_args
        args_string = settings.fetch("rubyfmtArgs", "")
        return [] if args_string.empty?

        args_string.split
      end

      private def settings
        addon_settings = @global_state.settings_for_addon("rubyfmt")
        addon_settings || {}
      end
    end
  end
end
