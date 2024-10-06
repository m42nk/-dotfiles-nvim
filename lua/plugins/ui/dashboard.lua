return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      local load_session = function()
        vim.defer_fn(function()
          require("persistence").load()
        end, 0)
      end

      opts.config.center = vim.tbl_extend("keep", {
        -- stylua: ignore
        { action = "Neotree position=current", desc = " Explore", icon = "󰉋 ", key = "e", },
        -- stylua: ignore
        -- { action = load_session, desc = " Restore Session", icon = " ", key = "s", },
      }, opts.config.center)

      return opts
    end,
  },
}
