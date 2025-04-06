-- [[ run-code.lua ]] --

local M = {}

function M.run_code()
    local filetype = vim.bo.filetype;
    if filetype == "text" then
        vim.cmd("terminal cat %")
    elseif filetype == "python" then
        vim.cmd("terminal python3 %")
    elseif filetype == "javascript" then
        vim.cmd("terminal node %")
    elseif filetype == "go" then
        vim.cmd("terminal go run %")
    elseif filetype == "lua" then
        vim.cmd("terminal lua %")
    elseif filetype == "dart" then
        vim.cmd("terminal dart run %")
    end
end


vim.keymap.set("n", "<F5>", M.run_code, { silent=true })

return M
