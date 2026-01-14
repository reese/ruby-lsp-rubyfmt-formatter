# Ruby LSP Rubyfmt Formatter

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

You'll also need `rubyfmt` installed and available on your PATH:

```bash
brew install rubyfmt
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

| Option        | Type            | Default     | Description                                                                                      |
| ------------- | --------------- | ----------- | ------------------------------------------------------------------------------------------------ |
| `rubyfmtPath` | String          | `"rubyfmt"` | Path to the rubyfmt executable. Uses PATH by default.                                            |
| `rubyfmtArgs` | String \| Array | `""`        | Additional arguments to pass to rubyfmt. Can be a space-separated string or an array of strings. |

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/reese/ruby-lsp-rubyfmt-formatter.
