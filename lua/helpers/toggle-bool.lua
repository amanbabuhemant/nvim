-- [[ Toggle Bool ]] --

local M = {}

function M.toggle_bool_value(bool)
    if bool == "true" then return "false" end
    if bool == "false" then return "true" end
    if bool == "True" then return "False" end
    if bool == "False" then return "True" end
    if bool == "1" then return "0" end
    if bool == "0" then return "1" end
end

function M.toggle_bool()
    vim.cmd(":normal! yiw")
    print("copiing the value")
    local bool_value = vim.fn.getreg("")
    print("bool_value:", bool_value)
    local toggled_value = M.toggle_bool_value(bool_value)
    print("toggled_value:", toggled_value)
    vim.fn.setreg("", toggled_value)
    vim.cmd(":normal! viw")
    vim.cmd(":normal! p")
end

vim.keymap.set("n", "g!", M.toggle_bool)

return M
