--[[ color scheme switcher ]]--

local set_colorscheme_file_path = os.getenv("HOME") .. "/.local/share/nvim/.set_colorscheme"

local M = {};

function M.get_current_colorscheme()
    local file = io.open(set_colorscheme_file_path, "r")
    if not file then
        M.save_current_colorscheem("default")
    else
        local ccs = file:read("*l")
        file:close()
        return ccs
    end
    return M.get_current_colorscheme()
end

function M.save_current_colorscheem(colorscheme)
    local file = io.open(set_colorscheme_file_path, "w")
    file:write(colorscheme)
    file:close()
end

function M.get_colorschemes()
    return vim.fn.getcompletion("", "color")
end

function M.set_colorscheme(colorscheme)
    vim.cmd.colorscheme(colorscheme)
end

function M.colorscheme_menu()
    local schemes = M.get_colorschemes()
    local current_scheme = M.get_current_colorscheme()
    local buf = vim.api.nvim_create_buf(false, true)
    local win_w, win_h = vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)
    local pane_w, pane_h = 30, win_h - 2
    if win_w < pane_w then
        pane_w = win_w
    end

    local metalines = {
        "Available colorschemes",
        "Press enter to set",
        "current colorscheme:",
        current_scheme,
        "",
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, metalines)
    for i, s in pairs(schemes) do
        vim.api.nvim_buf_set_lines(buf, #metalines + i, -1, false, { s })
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative="editor",
        row=0,
        col=win_w-pane_w,
        width=pane_w,
        height=pane_h,
        border="double",
    })

    vim.bo[buf].modifiable = false
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].cursorline = true

    local function on_enter()
        local scheme_index, _ = unpack(vim.api.nvim_win_get_cursor(win))
        scheme_index = scheme_index - #metalines
        if scheme_index < 1 then
            print("invalid scheme selection")
            return
        end
        M.set_colorscheme(schemes[scheme_index])
        M.save_current_colorscheem(schemes[scheme_index])
        print("colorscheme set: ", schemes[scheme_index])
    end

    local function on_line_change()
        local scheme_index, _ = unpack(vim.api.nvim_win_get_cursor(win))
        scheme_index = scheme_index - #metalines
        if scheme_index >= 1 then
            M.set_colorscheme(schemes[scheme_index])
        end
    end

    local function on_esc()
        vim.api.nvim_buf_delete(buf, { force = true })

        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(
                "<Esc>", true, false, true
            ),
            "n", false
        )
    end

    vim.api.nvim_create_autocmd("CursorMoved", { buffer=buf, callback=on_line_change })

    vim.keymap.set("n", "<CR>", on_enter, { buffer=buf })
    vim.keymap.set("n", "<Esc>", on_esc, { buffer=buf })
    vim.keymap.set("n", "q", on_esc, { buffer=buf })
end


vim.api.nvim_create_user_command("SwitchColorScheme", M.colorscheme_menu, {})
vim.api.nvim_create_user_command("SwitchColor", M.colorscheme_menu, {})

return M;
