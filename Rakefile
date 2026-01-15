# frozen_string_literal: true

require "rubocop/rake_task"
require "minitest/test_task"

Minitest::TestTask.create
RuboCop::RakeTask.new

task(default: %i[test rubocop])
