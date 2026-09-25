
local function s(mode, motion, action, desc, dict)
    dict = dict or {}
    dict["desc"] = desc
    vim.keymap.set(mode, motion, action, dict)
end

local function sn(motion, action, desc, dict)
    dict = dict or {}
    s('n', motion, action, desc, dict)
end

local function sv(motion, action, desc, dict)
    dict = dict or {}
    s('v', motion, action, desc, dict)
end

local function snv(motion, action, desc, dict)
    dict = dict or {}
    s({'n', 'v'}, motion, action, desc, dict)
end

----------------------------------------------------------------------
-- Generic
----------------------------------------------------------------------

-- Navigation
snv('ge', 'G', 'Goto end of file')
snv('gl', '$', 'Goto end of line')
snv('gh', '0', 'Goto beginning of line')

-- Comments
sn('<leader>c', 'gcc', 'Toggle comment', { remap = true })
sv('<leader>c', 'gc', 'Toggle comment selection', { remap = true })

-- Clipboard
sv('<leader>y', '"+y', 'Yank selection to clipboard', { remap = true })
snv('<leader>p', '"+p', 'Paste clipboard after selection', { remap = true })
snv('<leader>P', '"+P', 'Paste clipboard before selection', { remap = true })

-- These keybinds are nasty
vim.keymap.del('n', 'gO')
vim.keymap.del('n', 'gx')
vim.keymap.set('n', 'g%', '<Nop>')
vim.keymap.set('n', 'g;', '<Nop>')
vim.keymap.set('n', 'g,', '<Nop>')

----------------------------------------------------------------------
-- Pickers
----------------------------------------------------------------------

-- Top Pickers & Explorer
sn("<leader><space>", function() Snacks.picker.smart() end, "Smart Find Files")
sn("<leader>,", function() Snacks.picker.buffers() end, "Buffers")
sn("<leader>/", function() Snacks.picker.grep() end, "Grep")
sn("<leader>:", function() Snacks.picker.command_history() end, "Command History")
sn("<leader>n", function() Snacks.picker.notifications() end, "Notification History")
sn("<leader>e", ":Explore<CR>", "File Explorer")

-- find
sn("<leader>fb", function() Snacks.picker.buffers() end, "Buffers")
sn("<leader>ff", function() Snacks.picker.files() end, "Find Files")
sn("<leader>fg", function() Snacks.picker.git_files() end, "Find Git Files")
sn("<leader>fp", function() Snacks.picker.projects() end, "Projects")
sn("<leader>fr", function() Snacks.picker.recent() end, "Recent")

-- git
sn("<leader>gb", function() Snacks.picker.git_branches() end, "Git Branches")
sn("<leader>gl", function() Snacks.picker.git_log() end, "Git Log")
sn("<leader>gL", function() Snacks.picker.git_log_line() end, "Git Log Line")
sn("<leader>gs", function() Snacks.picker.git_status() end, "Git Status")
sn("<leader>gS", function() Snacks.picker.git_stash() end, "Git Stash")
sn("<leader>gd", function() Snacks.picker.git_diff() end, "Git Diff (Hunks)")
sn("<leader>gf", function() Snacks.picker.git_log_file() end, "Git Log File")

-- gh
sn("<leader>gi", function() Snacks.picker.gh_issue() end, "GitHub Issues (open)")
sn("<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, "GitHub Issues (all)")
sn("<leader>gp", function() Snacks.picker.gh_pr() end, "GitHub Pull Requests (open)")
sn("<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, "GitHub Pull Requests (all)")

-- Grep
sn("<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
sn("<leader>sB", function() Snacks.picker.grep_buffers() end, "Grep Open Buffers")
sn("<leader>sg", function() Snacks.picker.grep() end, "Grep")
s({'n', 'x'}, "<leader>sw", function() Snacks.picker.grep_word() end, "Visual selection or word")

-- search
sn('<leader>s"', function() Snacks.picker.registers() end, "Registers")
sn('<leader>s/', function() Snacks.picker.search_history() end, "Search History")
sn("<leader>sa", function() Snacks.picker.autocmds() end, "Autocmds")
sn("<leader>sb", function() Snacks.picker.lines() end, "Buffer Lines")
sn("<leader>sc", function() Snacks.picker.command_history() end, "Command History")
sn("<leader>sC", function() Snacks.picker.commands() end, "Commands")
sn("<leader>sd", function() Snacks.picker.diagnostics() end, "Diagnostics")
sn("<leader>sD", function() Snacks.picker.diagnostics_buffer() end, "Buffer Diagnostics")
sn("<leader>sh", function() Snacks.picker.help() end, "Help Pages")
sn("<leader>sH", function() Snacks.picker.highlights() end, "Highlights")
sn("<leader>si", function() Snacks.picker.icons() end, "Icons")
sn("<leader>sj", function() Snacks.picker.jumps() end, "Jumps")
sn("<leader>sk", function() Snacks.picker.keymaps() end, "Keymaps")
sn("<leader>sl", function() Snacks.picker.loclist() end, "Location List")
sn("<leader>sm", function() Snacks.picker.marks() end, "Marks")
sn("<leader>sM", function() Snacks.picker.man() end, "Man Pages")
sn("<leader>sp", function() Snacks.picker.lazy() end, "Search for Plugin Spec")
sn("<leader>sq", function() Snacks.picker.qflist() end, "Quickfix List")
sn("<leader>sR", function() Snacks.picker.resume() end, "Resume")
sn("<leader>su", function() Snacks.picker.undo() end, "Undo History")
sn("<leader>uC", function() Snacks.picker.colorschemes() end, "Colorschemes")

-- LSP
sn("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
sn("gD", function() Snacks.picker.lsp_declarations() end, "Goto Declaration")
sn("gr", function() Snacks.picker.lsp_references() end, "References", { nowait = true })
sn("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
sn("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto T[y]pe Definition")
sn("gai", function() Snacks.picker.lsp_incoming_calls() end, "C[a]lls Incoming")
sn("gao", function() Snacks.picker.lsp_outgoing_calls() end, "C[a]lls Outgoing")
sn("<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
sn("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")

-- Other
sn("<leader>z",     function() Snacks.zen() end, "Toggle Zen Mode")
sn("<leader>Z",     function() Snacks.zen.zoom() end, "Toggle Zoom")
sn("<leader>.",     function() Snacks.scratch() end, "Toggle Scratch Buffer")
sn("<leader>S",     function() Snacks.scratch.select() end, "Select Scratch Buffer")
sn("<leader>n",     function() Snacks.notifier.show_history() end, "Notification History")
sn("<leader>bd",    function() Snacks.bufdelete() end, "Delete Buffer")
sn("<leader>cR",    function() Snacks.rename.rename_file() end, "Rename File")
snv("<leader>gB",   function() Snacks.gitbrowse() end, "Git Browse")
sn("<leader>gg",    function() Snacks.lazygit() end, "Lazygit")
sn("<leader>un",    function() Snacks.notifier.hide() end, "Dismiss All Notifications")
sn("<c-/>",         function() Snacks.terminal() end, "Toggle Terminal")
sn("<c-_>",         function() Snacks.terminal() end, "which_key_ignore")
s({"n", "t"}, "]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
s({"n", "t"}, "[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")

