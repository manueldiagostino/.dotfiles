-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local set = vim.opt

set.textwidth = 80
set.colorcolumn = "+1"
set.columns = 80
set.wrap = true

-- Set the behavior of tab
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = false

set.relativenumber = true

local function smart_format_with_wrap(start_line, end_line)
  local shiftwidth = vim.o.shiftwidth
  local expandtab = vim.o.expandtab
  local textwidth = vim.o.textwidth

  -- Iteriamo a ritroso per non "perdere" righe nel buffer
  for lnum = end_line, start_line, -1 do
    local line = vim.fn.getline(lnum)

    if line:match("^%s*$") then
      -- Righe vuote: non toccare
    else
      -- Costruisco indent
      local indent = vim.fn.indent(lnum)
      local indent_str
      if expandtab then
        indent_str = string.rep(" ", indent)
      else
        local tabs = math.floor(indent / shiftwidth)
        local spaces = indent % shiftwidth
        indent_str = string.rep("\t", tabs) .. string.rep(" ", spaces)
      end

      -- Splitto in parole e ricostruisco linee spezzate
      local words = vim.split(vim.fn.trim(line), "%s+")
      local wrapped_lines = {}
      local curr = indent_str
      for _, w in ipairs(words) do
        if #curr + #w + 1 > textwidth then
          table.insert(wrapped_lines, curr)
          curr = indent_str .. w
        else
          if #curr > #indent_str then
            curr = curr .. " " .. w
          else
            curr = curr .. w
          end
        end
      end
      table.insert(wrapped_lines, curr)

      -- Sovrascrivo la riga corrente e inserisco le restanti subito dopo
      vim.fn.setline(lnum, wrapped_lines[1])
      if #wrapped_lines > 1 then
        -- vim.fn.append accetta una lista di righe da inserire
        vim.fn.append(lnum, vim.list_slice(wrapped_lines, 2))
      end
    end
  end
end

vim.api.nvim_create_user_command("SmartFormat", function()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  smart_format_with_wrap(start_line, end_line)
end, { range = true })

vim.keymap.set("x", "gw", ":SmartFormat<CR>", { silent = true })

vim.filetype.add({
  extension = {
    mzn = "zinc",
    dzn = "zinc",
    fzn = "zinc",
  },
})
