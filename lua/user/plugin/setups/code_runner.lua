local ok, cr = pcall(require, "code_runner")

if not ok then
  return
end

cr.setup {
  focus = false,
  filetype = {
    javascript = "npm run start",
  },
  project = {
    ["~/Codes/scrap-kanopi"] = {
      name = "Scrap kanopi",
      file_name = "index.js",
      command = "node ."
    }
  }
}

require("user.utils.keymaps").nmap {
  ["<leader>r"] = {
    ["r"] = { "<cmd>RunCode<cr>", "Run code" },
    ["f"] = { "<cmd>RunFile<CR>", "Run file" },
    ["b"] = { "<cmd>RunFile buf<CR>", "Run file buffer" },
    ["p"] = { "<cmd>RunProject<CR>", "Run project" },
    ["c"] = { "<cmd>RunClose<CR>", "Run close" },

    ["Cf"] = { "<cmd>CRFiletype<CR>", "Open json filetype" },
    ["Cp"] = { "<cmd>CRProjects<CR>", "Open json project" },
  },
}