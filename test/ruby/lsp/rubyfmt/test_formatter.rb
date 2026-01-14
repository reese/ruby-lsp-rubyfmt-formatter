# frozen_string_literal: true

require "test_helper"

module RubyLsp
  module RubyfmtFormatter
    class TestFormatter < Minitest::Test
      ADDON_NAME = "rubyfmt Formatter"

      def test_that_it_has_a_version_number
        refute_nil(::RubyLsp::RubyfmtFormatter::VERSION)
      end

      def test_addon_name
        global_state = create_global_state
        addon = Addon.new
        addon.activate(global_state, [])

        assert_equal(ADDON_NAME, addon.name)
      end

      def test_default_rubyfmt_path
        global_state = create_global_state
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command)

        assert_equal(["rubyfmt"], command)
      end

      def test_custom_rubyfmt_path
        global_state = create_global_state(
          {"rubyfmtPath" => "/custom/path/to/rubyfmt"}
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command)

        assert_equal(["/custom/path/to/rubyfmt"], command)
      end

      def test_additional_args_as_string
        global_state = create_global_state(
          {"rubyfmtArgs" => "--check --some-flag"}
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command)

        assert_equal(["rubyfmt", "--check", "--some-flag"], command)
      end

      def test_custom_path_with_args
        global_state = create_global_state(
          "rubyfmtPath" => "/usr/local/bin/rubyfmt",
          "rubyfmtArgs" => "--check"
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command)

        assert_equal(["/usr/local/bin/rubyfmt", "--check"], command)
      end

      private

      def create_global_state(addon_settings = {})
        global_state = RubyLsp::GlobalState.new
        global_state.apply_options(
          {
            initializationOptions: {
              addonSettings: {"rubyfmt" => addon_settings}
            }
          }
        )

        global_state
      end
    end
  end
end
