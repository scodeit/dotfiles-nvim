-- Claude Code inside Neovim.
-- Requires the `claude` CLI on PATH (installed by the bootstrapper).
-- Open/close with <leader>ac, send visual selection with <leader>as.
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a",  nil,                                 desc = "AI / Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",               desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",          desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",      desc = "Resume Claude session" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",    desc = "Continue last Claude session" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",    desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",          desc = "Add current buffer to Claude" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",           mode = "v", desc = "Send selection to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file from tree",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",     desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",       desc = "Deny diff" },
      -- quick toggle like VSCode's Cmd+K Cmd+I — Ctrl+, opens Claude
      { "<C-,>",      "<cmd>ClaudeCode<cr>",               mode = { "n", "i", "t" }, desc = "Toggle Claude" },
    },
  },
}
