-- luacheck: globals vim

-- Mnemonic: dqp = debug quickly print
vim.keymap.set("n", "dqp", "<Plug>DumpDebugStringVar", { unique = true })
vim.keymap.set("n", "dqP", "k<Plug>DumpDebugStringVar", { unique = true })
vim.keymap.set("n", "dQp", "<Plug>DumpDebugStringExpr", { unique = true })
vim.keymap.set("n", "dQP", "k<Plug>DumpDebugStringExpr", { unique = true })
