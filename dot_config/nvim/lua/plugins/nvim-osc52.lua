return {
  "ojroques/nvim-osc52",
  -- Il provider clipboard va impostato prima del primo yank -> niente lazy.
  lazy = false,
  config = function()
    require("osc52").setup({
      max_length = 0,
      silent = true, -- niente "[osc52] N characters copied"
      trim = false,
      tmux_passthrough = true, -- richiede tmux: `set -g allow-passthrough on`
    })

    -- copy: spedisce il testo via OSC52 (arriva alla clipboard del client)
    local function copy(lines, _)
      require("osc52").copy(table.concat(lines, "\n"))
    end

    -- paste: legge il registro interno e NON interroga il terminale,
    -- quindi non compare "Waiting for OSC 52 response".
    local function paste()
      return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste, ["*"] = paste },
    }
  end,
}
