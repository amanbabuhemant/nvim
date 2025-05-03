-- [[ logger.lua ]] --

local M = {}

function M.log()
    local cr, cc = unpack(vim.api.nvim_win_get_cursor(0))

    vim.cmd(":normal! yy")
    local line = vim.fn.getreg("0")
    vim.cmd(":normal! yiw")
    local var = vim.fn.getreg("0")

    local filetype = vim.bo.filetype
    local ll = "";
    if filetype == "text" then
        ll = var
    elseif filetype == "python" then
        ll = "print(\"" .. var .. ":\", " .. var .. ")"
    elseif filetype == "javascript" then
        ll = "console.log(\"" .. var .. ":\", " .. var .. ");"
    elseif filetype == "go" then
        ll = "println(\"" .. var .. ":\", " .. var .. ")"
    elseif filetype == "lua" then
        ll = "print(\"" .. var .. ":\", " .. var .. ")"
    elseif filetype == "dart" then
        ll = "print(\"" .. var .. ":\", " .. var .. ");"
    end

    for c in line:gmatch(".") do
        if c ~= " " and c ~= "\t" then
            break
        end
        ll = c .. ll
    end

    vim.fn.setreg("0", ll, "c")
    vim.cmd(":normal! o")
    vim.cmd(":normal! p")
    vim.cmd(":normal! ==")

    vim.api.nvim_win_set_cursor(0, {cr, cc})
end

vim.keymap.set("n", "<C-l>", M.log, {})

return M
