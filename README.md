# OpenPilot

OpenPilot is a FOSS, LLM-based coding assistant designed for the Neovim text editor as a source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp). OpenPilot aims to change the way you code by providing real-time, context aware suggestions, completions, and documentation lookup. Unlike cloud-based solutions, OpenPilot runs locally on your machine, ensuring privacy and security, as well as offline access.

## Features:
- Real-time code completion: Get smart code suggestions as you type, tailored to your current context and coding style.
- Documentaion on demand: Instantly access documentation for libraries, functions, and API calls.
- Seamless integration: designed to be a natural extension to neovim, fits into existing workflows smoothly.
- Privacy as a default: Your code stays with you. OpenPilot runs offline and will never share data.
- Free and Open Source: Built by a passionate community. Contributions are welcome.

## Installation:

A few prerequisites are needed. Firstly, the LLM component of this project comes from [ollama](https://github.com/ollama/ollama) and we will use their API as the backend. Next, this plugin is a source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), and as such that will be requiired as well.

### Linux ollama install
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### cmp / openpilot download (Lazy package manager)
```lua
require('lazy').setup({

    -- Other plugins ...
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'NoahSchiro/openpilot'
        }
    },
    -- Other plugins ...
}, {})

-- Other configurations...

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

cmp.setup {
 sources = {
   { name = 'path' },
   { name = 'buffer' },
  },
}

```

TODO: Add other package managers

## Configuration
TODO

## Usage
TODO

## Contributing

OpenPilot is an open-source project, and we welcome all contributions. See the CONTRIBUTING.md for more information on how to get started. (TODO, make contributing.md)

## License
OpenPilot is released under the MIT License.

## Acknowledgements
A special thanks must be extended to the neovim community, the team behind ollama, and all of the people developing open source LLMs. This project would not be possible without their support
