require("conform").setup({
    formatters_by_ft = {
        rust = { "rustfmt", lsp_format = "fallback" },
    },
})

vim.keymap.set({ "n", "v" }, "<leader>=", function()
    require("conform").format({
        async = false
    })
end, { desc = "Format" })

