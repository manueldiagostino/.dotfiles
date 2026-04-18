return {
  {
    "nvim-neotest/neotest",

    keys = {
      { "<leader>t", group = "Test", mode = "n" },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        mode = "n",
        desc = "Run Test File (Neotest)",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        mode = "n",
        desc = "Run Nearest Test (Neotest)",
      },
      {
        "<leader>tD",
        function()
          require("neotest").run.run(vim.fn.expand("%"), { strategy = "dap" })
        end,
        mode = "n",
        desc = "Debug Test File (Neotest)",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        mode = "n",
        desc = "Debug Nearest Test (Neotest)",
      },

      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle()
        end,
        mode = "n",
        desc = "Toggle Watch Nearest (Neotest)",
      },
    },

    opts = {
      adapters = {
        ["neotest-java"] = {
          test_runner = "gradle",
        },
      },
    },
    ft = { "java" },
  },

  {
    "rcasia/neotest-java",
    dependencies = {},
    ft = { "java" },
  },
}
