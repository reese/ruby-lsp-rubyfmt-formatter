# `ruby-lsp-rubyfmt-formatter`

A [Ruby LSP](https://github.com/Shopify/ruby-lsp) add-on that provides formatting support using [rubyfmt](https://github.com/fables-tales/rubyfmt).

## Installation

Add this gem to your application's Gemfile:

```bash
bundle add ruby-lsp-rubyfmt-formatter
```

Or install it directly:

```bash
gem install ruby-lsp-rubyfmt-formatter
```

## Usage

Once installed, configure your VSCode settings to use rubyfmt as the formatter:

```json
{
  "[ruby]": {
    "editor.defaultFormatter": "Shopify.ruby-lsp",
    "editor.formatOnSave": true
  },
  "rubyLsp.formatter": "rubyfmt"
}
```

By default, the extension uses the `rubyfmt` in your PATH, or see the configuration options below for passing a specific path.

For instructions on installing `rubyfmt` itself, see [the docs](https://github.com/fables-tales/rubyfmt?tab=readme-ov-file#how-do-i-use-it).

### Configuration Options

You can customize the rubyfmt behavior via `rubyLsp.addonSettings` in your VSCode settings:

```json
{
  "rubyLsp.formatter": "rubyfmt",
  "rubyLsp.addonSettings": {
    "rubyfmt": {
      "rubyfmtPath": "/custom/path/to/rubyfmt",
      "rubyfmtArgs": "--include-gitignored"
    }
  }
}
```

#### Available Options

| Option        | Type   | Default     | Description                                           |
| ------------- | ------ | ----------- | ----------------------------------------------------- |
| `rubyfmtPath` | String | `"rubyfmt"` | Path to the rubyfmt executable. Uses PATH by default. |
| `rubyfmtArgs` | String | `""`        | Additional arguments to pass to rubyfmt.              |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/reese/ruby-lsp-rubyfmt-formatter.
