lvim.plugins = {
    { "Mofiqul/dracula.nvim" },
    { "Pocco81/auto-save.nvim" },
    { "anuvyklack/animation.nvim",
        dependencies = { "anuvyklack/middleclass" }
    },
    --{ "karb94/neoscroll.nvim" },
    { "echasnovski/mini.nvim" },
    { "lukas-reineke/indent-blankline.nvim" },
    -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow"},
    { "norcalli/nvim-colorizer.lua" },
    -- { "ellisonleao/carbon-now.nvim", opts = { }, cmd = "CarbonNow" },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install()",
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
	},
    { "iamcco/markdown-preview.nvim" }
}

require('colorizer').setup()
