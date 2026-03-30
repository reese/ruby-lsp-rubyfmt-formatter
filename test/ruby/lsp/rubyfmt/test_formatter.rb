# frozen_string_literal: true

require "test_helper"
require "uri"

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

        command = formatter.send(:build_command, nil)

        assert_equal(["rubyfmt"], command)
      end

      def test_custom_rubyfmt_path
        global_state = create_global_state(
          {"rubyfmtPath" => "/custom/path/to/rubyfmt"}
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command, nil)

        assert_equal(["/custom/path/to/rubyfmt"], command)
      end

      def test_additional_args_as_string
        global_state = create_global_state(
          {"rubyfmtArgs" => "--check --some-flag"}
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command, nil)

        assert_equal(["rubyfmt", "--check", "--some-flag"], command)
      end

      def test_custom_path_with_args
        global_state = create_global_state(
          "rubyfmtPath" => "/usr/local/bin/rubyfmt",
          "rubyfmtArgs" => "--check"
        )
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command, nil)

        assert_equal(["/usr/local/bin/rubyfmt", "--check"], command)
      end

      def test_stdin_filepath_added_when_version_supported
        global_state = create_global_state("rubyfmtPath" => fixture("rubyfmt_0_13_0"))
        formatter = Formatter.new(global_state)
        uri = URI("file:///path/to/file.rb")

        command = formatter.send(:build_command, uri)

        assert_equal([fixture("rubyfmt_0_13_0"), "--stdin-filepath", "/path/to/file.rb"], command)
      end

      def test_stdin_filepath_not_added_when_version_unsupported
        global_state = create_global_state("rubyfmtPath" => fixture("rubyfmt_0_12_0"))
        formatter = Formatter.new(global_state)
        uri = URI("file:///path/to/file.rb")

        command = formatter.send(:build_command, uri)

        assert_equal([fixture("rubyfmt_0_12_0")], command)
      end

      def test_stdin_filepath_not_added_without_uri
        global_state = create_global_state("rubyfmtPath" => fixture("rubyfmt_0_13_0"))
        formatter = Formatter.new(global_state)

        command = formatter.send(:build_command, nil)

        assert_equal([fixture("rubyfmt_0_13_0")], command)
      end

      def test_stdin_filepath_with_custom_args
        global_state = create_global_state(
          "rubyfmtPath" => fixture("rubyfmt_0_13_0"),
          "rubyfmtArgs" => "--check"
        )
        formatter = Formatter.new(global_state)
        uri = URI("file:///app/lib/foo.rb")

        command = formatter.send(:build_command, uri)

        assert_equal([fixture("rubyfmt_0_13_0"), "--check", "--stdin-filepath", "/app/lib/foo.rb"], command)
      end

      def test_rubyfmt_version_parsed_from_output
        global_state = create_global_state("rubyfmtPath" => fixture("rubyfmt_0_13_0"))
        formatter = Formatter.new(global_state)

        assert_equal("0.13.0", formatter.send(:rubyfmt_version))
      end

      def test_rubyfmt_version_falls_back_to_zero_on_failure
        global_state = create_global_state("rubyfmtPath" => fixture("rubyfmt_version_check_fails"))
        formatter = Formatter.new(global_state)

        assert_equal("0.0.0", formatter.send(:rubyfmt_version))
      end

      private def fixture(name)
        File.expand_path("../../../support/#{name}", __dir__)
      end

      private def create_global_state(addon_settings = {})
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
