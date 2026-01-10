-- [[ Toggle Bool ]] --

local M = {}

M.map = {

    -- true/false
    ["true"]  = "false",
    ["false"] = "true",

    -- True/False
    ["True"]  = "False",
    ["False"] = "True",

    -- TRUE/FALSE
    ["TRUE"]  = "FALSE",
    ["FALSE"] = "TRUE",

    -- yes/no
    ["yes"]   = "no",
    ["no"]    = "yes",

    -- Yes/No
    ["Yes"]   = "No",
    ["No"]    = "Yes",

    -- YES/NO
    ["YES"]   = "NO",
    ["NO"]    = "YES",

    -- y/n
    ["y"]     = "n",
    ["n"]     = "y",

    -- Y/N
    ["Y"]     = "N",
    ["N"]     = "Y",

    -- on/off
    ["on"]    = "off",
    ["off"]   = "on",

    -- On/Off
    ["On"]    = "Off",
    ["Off"]   = "On",

    -- ON/OFF
    ["ON"]    = "OFF",
    ["OFF"]   = "ON",

    -- 1/0
    ["1"]     = "0",
    ["0"]     = "1",
}

function M.toggle_bool_value(bool)
    return M.map[bool]
end

function M.toggle_bool()
    local cursor_start_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd(":normal! yiw")
    local bool_value = vim.fn.getreg("")
    local toggled_value = M.toggle_bool_value(bool_value)
    if not toggled_value then
        vim.api.nvim_win_set_cursor(0, cursor_start_pos)
        return
    end
    vim.fn.setreg("", toggled_value)
    vim.cmd(":normal! viw")
    vim.cmd(":normal! p")
    local cursor_current_pos = vim.api.nvim_win_get_cursor(0)
    if cursor_start_pos[2] < cursor_current_pos[2] then
        vim.api.nvim_win_set_cursor(0, cursor_start_pos)
    else
        vim.api.nvim_win_set_cursor(0, cursor_current_pos)
    end
end

vim.keymap.set("n", "g!", M.toggle_bool)

return M
