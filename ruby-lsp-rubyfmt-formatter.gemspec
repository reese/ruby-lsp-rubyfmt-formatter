# frozen_string_literal: true

require_relative "lib/ruby_lsp/rubyfmt_formatter/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-lsp-rubyfmt-formatter"
  spec.version = RubyLsp::RubyfmtFormatter::VERSION
  spec.authors = ["Reese Williams"]
  spec.email = ["reese@reesew.com"]

  spec.summary = "A Ruby LSP add-on for formatting with `rubyfmt`."
  spec.homepage = "https://github.com/reese/ruby-lsp-rubyfmt-formatter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency("ruby-lsp", ">= 0.17.0")
end
