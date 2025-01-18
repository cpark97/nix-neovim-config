-- Don't lazy load by keys
-- https://github.com/ggandor/leap.nvim?tab=readme-ov-file#installation
return {
  "leap.nvim",
  event = "DeferredUIEnter",
  after = function()
    require("leap").create_default_mappings()
  end,
}
