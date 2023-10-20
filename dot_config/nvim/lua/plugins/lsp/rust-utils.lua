local function make_attach_things(rust_tools)
  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserRustLspConfig', {}),
    pattern = "*.rs",
    callback = function(ev)
      require("which-key").register({
        K = { rust_tools.hover_actions.hover_actions, "Rust: hover actions", buffer = ev.buf },
        gJ = { "<cmd>RustJoinLines<CR>", "Rust: join lines", buffer = ev.buf },
        ['<leader>cg'] = {
          rust_tools.code_action_group.code_action_group,
          "Rust: code-action group",
          buffer = ev.buf,
        },
        ['<leader>ff'] = { "<cmd>RustFmt<CR>", "Rust: rustfmt", buffer = ev.buf },
      })
    end,
  })
end

local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

-- https://github.com/simrat39/rust-tools.nvim#configuration
local function rust_tools_opts()
  return {
    tools = {
      crate_graph = {
        full = false,
        backend = "png",
        output = "./crate-graph.png",
      },
      inlay_hints = {
        only_current_line = true,
      },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
      capabilities = require("plugins.lsp.utils").make_capabilities({}),
      flags = {
        debounce_text_changes = 350
      },
      settings = {
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
          assist = {
            emitMustUse = true,
            importPrefix = "by_self",
          },
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          inlayHints = {
            closureCaptureHints = {
              enable = true
            }
          },
          lens = {
            references = {
              adt = {
                enable = true
              },
              enumVariant = {
                enable = true
              },
              method = {
                enable = true
              },
              trait = {
                enable = true
              },
            },
          },
          procMacro = {
            enable = true
          },
          typing = {
            autoClosingAngleBrackets = {
              enable = true
            }
          }
        },
      },
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    }
  }
end

return {
  rust_tools_opts = rust_tools_opts,
  make_attach_things = make_attach_things
}
