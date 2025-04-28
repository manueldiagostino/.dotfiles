return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        "clangd",
        "jdtls",
        "texlab",
        "pyre",
        "marksman",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          on_new_config = function(new_config, root_dir)
            local util = require("lspconfig.util")
            local uv = vim.loop

            local function find_compile_commands_dir(startpath)
              local function scan_dir(path)
                local handle = uv.fs_scandir(path)
                if not handle then
                  return nil
                end

                while true do
                  local name, typ = uv.fs_scandir_next(handle)
                  if not name then
                    break
                  end
                  local fullpath = path .. "/" .. name
                  if name == "compile_commands.json" then
                    return path
                  elseif typ == "directory" and not name:match("^%.") then
                    local found = scan_dir(fullpath)
                    if found then
                      return found
                    end
                  end
                end
                return nil
              end
              return scan_dir(startpath)
            end

            local cc_dir = find_compile_commands_dir(root_dir)
            if cc_dir then
              new_config.cmd = { "clangd", "--compile-commands-dir=" .. cc_dir }
            end
          end,
        },
      },
    },
  },
}
