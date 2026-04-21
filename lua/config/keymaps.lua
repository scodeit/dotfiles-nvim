-- VSCode-like keybindings layered on top of LazyVim defaults.
-- Run `:checkhealth which-key` to see every binding grouped by prefix.
local map = vim.keymap.set

-- Ctrl+S: save (works in normal, insert, visual)
map({ "n", "i", "v", "x" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Ctrl+P: file picker (Quick Open)
map({ "n", "i" }, "<C-p>", function()
  if _G.LazyVim and LazyVim.pick then
    LazyVim.pick("files")()
  else
    vim.cmd("Telescope find_files")
  end
end, { desc = "Find file" })

-- Ctrl+Shift+P: command palette (Ghostty passes this through; some terminals don't)
map("n", "<C-S-p>", function()
  if _G.LazyVim and LazyVim.pick then
    LazyVim.pick("commands")()
  else
    vim.cmd("Telescope commands")
  end
end, { desc = "Command palette" })

-- Ctrl+/ : toggle line comment (many terminals send <C-_>, so map both)
for _, k in ipairs({ "<C-/>", "<C-_>" }) do
  map({ "n" }, k, "gcc", { remap = true, desc = "Toggle comment" })
  map({ "v", "x" }, k, "gc", { remap = true, desc = "Toggle comment" })
  map("i", k, "<esc>gccA", { remap = true, desc = "Toggle comment" })
end

-- Ctrl+B: toggle file tree sidebar
map("n", "<C-b>", function() Snacks.explorer() end, { desc = "Toggle sidebar" })

-- Ctrl+` : toggle integrated terminal (snacks)
-- Terminals differ: some send <C-`>, some swallow it. Map both <C-`> and <C-\> as fallback.
local function toggle_term()
  if _G.Snacks and Snacks.terminal then
    Snacks.terminal()
  else
    vim.cmd("terminal")
  end
end
map({ "n", "t" }, "<C-`>",  toggle_term, { desc = "Toggle terminal" })
map({ "n", "t" }, "<C-\\>", toggle_term, { desc = "Toggle terminal (fallback)" })

-- Alt+Up/Down: move line(s) like VSCode
map("n", "<A-Up>",   "<cmd>m .-2<cr>==",  { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==",  { desc = "Move line down" })
map("v", "<A-Up>",   ":m '<-2<cr>gv=gv",  { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv",  { desc = "Move selection down" })
map("i", "<A-Up>",   "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })

-- Shift+Alt+Down: duplicate line
map("n", "<S-A-Down>", "<cmd>t.<cr>",     { desc = "Duplicate line down" })
map("n", "<S-A-Up>",   "<cmd>t.-1<cr>",   { desc = "Duplicate line up" })

-- F2: rename symbol (LSP), like VSCode
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Ctrl+. : code actions
map({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action, { desc = "Code action" })

-- gd / gr / gi are already LazyVim defaults (go to def / refs / implementation)
-- <leader>ca = code action, <leader>cr = rename, etc. This adds VSCode-shaped shortcuts on top.

-- Cmd+Shift+F on macOS in Ghostty maps to <D-F>-ish; instead use the leader.
-- <leader>sg for project search is LazyVim default.

-- Clear default Ctrl+/ fallback in terminal mode so it doesn't swallow input
map("t", "<C-/>", [[<C-\><C-n>]], { desc = "Normal mode in terminal" })
