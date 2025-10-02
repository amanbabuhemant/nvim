-- [[ Shifter ]] --

M = {}

function M.shift_up()
    local l, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd("norm k")
    vim.cmd("norm o")
    vim.cmd("norm j")
    vim.api.nvim_win_set_cursor(0, { l + 1, c })
    local view = vim.fn.winsaveview()
    view.topline = view.topline + 1
    vim.fn.winrestview(view)
end

function M.shift_down()
    local l, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.cmd("norm o")
    vim.cmd("norm k")
    vim.api.nvim_win_set_cursor(0, { l, c })
end

vim.keymap.set("n", "<leader>k", M.shift_up)
vim.keymap.set("n", "<leader>j", M.shift_down)

return M
