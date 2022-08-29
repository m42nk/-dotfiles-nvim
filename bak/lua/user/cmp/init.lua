----------------------------------
-- Completion Configuration

-- lsp completion also need to be
-- set up in capabilities
----------------------------------

-- Completion engine
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

-- Snippet
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

require("luasnip/loaders/from_vscode").lazy_load()

local kind_icons = require "user.cmp.kind_icons"
local utils = require "user.cmp.utils"
local compare = require "cmp.config.compare"
local types = require "cmp.types"

local config = {
  source_names = {
    nvim_lsp = "[LSP]",
    neorg = "[Neorg]",
    emoji = "[Emoji]",
    path = "[Path]",
    calc = "[Calc]",
    cmp_tabnine = "[Tabnine]",
    luasnip = "[Snippet]",
    buffer = "[Buffer]",
    tmux = "[TMUX]",
  },
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
}

-- TODO: change 'enter' to something else when accepting completion
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    -- { name = "nvim_lsp", max_item_count = 1 },
    { name = "neorg" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
  }, {
    -- Don't show these sources if all source above
    -- still have items to complete
    { name = "path" },
    { name = "buffer" },
  }),
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),

    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    -- ["<C-x>"] = cmp.mapping(function(fallback)
    --   local selected = cmp.get_selected_entry()
    --   -- local f = assert(io.open("quicksave.txt", "a"))
    --   -- f:write(vim.inspect(entry.source:get_debug_name()), "\n")
    --   -- f:close()
    -- end),
    ["<Tab>"] = cmp.mapping(utils.handle_tab, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(utils.handle_s_tab, { "i", "s" }),
  },
  -- sorting = {
  --   comparators = {
  --     compare.offset,
  --     compare.exact,
  --     -- compare.scopes,
  --     compare.score,
  --     compare.recently_used,
  --     compare.locality,
  --     compare.kind,
  --     compare.sort_text,
  --     compare.length,
  --     compare.order,
  --     -- function(entry1, entry2)
  --     --   -- if entry1.kind
  --     --   if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
  --     --     return true
  --     --   end

  --     --   return false
  --     -- end,
  --   },
  -- },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- local f = assert(io.open("quicksave.txt", "a"))
      -- f:write(vim.inspect(entry.source:get_debug_name()), "\n")
      -- f:close()

      vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = config.source_names[entry.source.name]
      vim_item.dup = config.duplicates[entry.source.name]

      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = true,
  },
}

--[[ cmp.setup.cmdline(":", { ]]
--[[   mapping = cmp.mapping.preset.cmdline(), ]]
--[[   completion = { ]]
--[[     keyword_length = 3, ]]
--[[   }, ]]
--[[   sources = cmp.config.sources({ ]]
--[[     { name = "path" }, ]]
--[[   }, { ]]
--[[     { name = "cmdline" }, ]]
--[[   }), ]]
--[[ }) ]]

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  completion = {
    keyword_length = 3,
  },
  sources = {
    { name = "buffer" },
  },
})