--                       ██╗  ██╗███████╗██╗   ██╗███████╗
--                       ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--                       █████╔╝ █████╗   ╚████╔╝ ███████╗
--                       ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--                       ██║  ██╗███████╗   ██║   ███████║
--                       ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝

-- Variable
local key = vim.keymap.set

-- Leader key
vim.g.mapleader = ' '

-- Jumps
key({'n', 'x', 'o'}, '<leader>h', '^', {desc = "Go to the start line"})
key({'n', 'x', 'o'}, '<leader>l', 'g_', {desc = "Go to the end line"})
key('n', '<leader>a', ':keepjumps normal! ggVG<cr>', {desc = "Select all"})

-- Basics
key('i', 'jj', '<ESC>',{remap = false, silent = false})
key('n', 'q', '<Nop>',{remap = false, silent = false, desc = "norecording"})
key('n', '<leader>z', 'z=', {remap = false, silent = false, desc = "spell suggestion"})

-- save file
key({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better up/down
key({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
key({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
key({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
key({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Delete single character without copying into register
key({'n', 'x'}, 'x', '"_x', {desc = "Dont register x delete"})
key({'n', 'x'}, 'c', '"_c', {desc = "Dont register change"})


-- Increment/decrement numbers
key("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
key("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement{desc = 'Nohls'})

-- Resize window using <ctrl> arrow keys
key("n", "<C-Up>", "<cmd>resize +5<cr>", { desc = "Increase window height" })
key("n", "<C-Down>", "<cmd>resize -5<cr>", { desc = "Decrease window height" })
key("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
key("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- Move Lines
key("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
key("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
key("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
key("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
key("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
key("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Move to window using the <ctrl> hjkl keys
key("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
key("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
key("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
key("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- windows
key("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
key("n", "<leader>wd", "<C-W>c", { desc = "Close window", remap = true })
key("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
key("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
key("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
key("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
key("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
key("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
key("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
key("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
key("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
key("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


-- buffers
key("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
key("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- key('n', '<leader>bd', '<cmd>bdelete<cr>', {desc = 'Deled curren buffer'})
key('n', '<leader>bb', '<cmd>buffer #<cr>', {desc = "Change of the last buffer"})

-- Clear search with <esc>
key({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
key(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

-- Add undo break-points
key("i", ",", ",<c-g>u")
key("i", ".", ".<c-g>u")
key("i", ";", ";<c-g>u")

--keywordprg
key("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
key("v", "<", "<gv")
key("v", ">", ">gv")


-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
key("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
key("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
key("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
key("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
key("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
key("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
key("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })


-- lazy
key("n", "<leader>cl", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
key("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

key("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
key("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

key("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
key("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- quit
key("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
key("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Terminal Mappings
key("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
key("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
key("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
key("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
key("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
key("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
key("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
