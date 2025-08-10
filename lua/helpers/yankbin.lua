-- [ Yank Bin ] --

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local t_config = require("telescope.config").values

local M = {};

local yank_selected = false
local lines_to_paste = ""

local yanks_dir = vim.fn.stdpath("data") .. "/yankbin/"

vim.fn.mkdir(yanks_dir, "p")

function M.save()
    local buf, s_line , _ = unpack(vim.fn.getpos("v"))
    local _, e_line, _ = unpack(vim.fn.getpos("."))
    local lines = vim.api.nvim_buf_get_lines(buf, s_line-1, e_line, false)
    local concated_liens = ""
    for _, line in pairs(lines) do
        concated_liens = concated_liens .. line .. "\n"
    end
    lines_to_paste = concated_liens
    M.new_yank()
end

function M.write_to_yankfile(filename, content)
    local file = io.open(yanks_dir .. filename, "w")
    file:write(content)
    file:close()
    lines_to_paste = ""
end

function M.new_yank()
    local buf = vim.api.nvim_create_buf(false, true)
    local w_width = vim.api.nvim_win_get_width(0)
    local w_height = vim.api.nvim_win_get_height(0)
    local win = vim.api.nvim_open_win(buf, true, {
        width = math.floor((w_width * 80) / 100),
        height = 1,
        relative = "editor",
        row = math.floor(w_height / 2) - 1,
        col = math.floor(w_width / 10),
        style = "minimal",
        border = "rounded",
    })

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)

    local on_enter = function()
        vim.cmd(":normal! yy")
        local fn, filename = vim.fn.getreg(""), ""
        for c in fn:gmatch(".") do
            if c ~= "\r" and c ~= "\n" and c ~= "\t" then
                filename = filename .. c
            end
        end
        M.write_to_yankfile(filename, lines_to_paste)
        vim.cmd(":q!")
    end

    local on_esc = function()
        vim.cmd(":q!")
    end

    vim.keymap.set({ "i", "n" }, "<CR>", on_enter, { buffer = buf, silent = true })
    vim.keymap.set({ "i", "n" }, "<ESC>", on_esc, { buffer = buf, silent = true })
end

function M.yank_pick(callback_no_selection)
    local files = {}
    for filename in io.popen("ls -a " .. yanks_dir):lines() do
        if filename == "." or filename == ".." then goto continue end
        table.insert(files, { filename, yanks_dir .. filename })
        ::continue::
    end
    vim.inspect(files)
    pickers.new({}, {
        prompt_title = "Yanks",
        finder = finders.new_table({
            results = files,
            entry_maker = function (entry)
                return {
                    value = entry[2],
                    display = entry[1],
                    ordinal = entry[1],
                    path = entry[2],
                }
            end,
        }),
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry, status)
                local filepath = entry.path
                vim.schedule(function()
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.readfile(filepath))
                end)
            end,
        }),
        sorter = t_config.generic_sorter({}),
        attach_mappings = function(pbn, _)

            actions.select_default:replace(function()
                actions.close(pbn)
                local selection = action_state.get_selected_entry()
                local lines = vim.fn.readfile(selection.path)
                local concated_liens = ""
                for _, line in pairs(lines) do
                    concated_liens = concated_liens .. line .. "\n"
                end
                vim.fn.setreg("", concated_liens)
                yank_selected = true
                if callback_no_selection then
                    callback_no_selection()
                end
            end)

            return true
        end,
    }):find()
end

function M.paste()
    if not yank_selected then
        M.yank_pick(M.paste)
        return
    end
    vim.cmd(":normal! p")
    yank_selected = false
end

function M.Paste()
    if not yank_selected then
        M.yank_pick(M.Paste)
        return
    end
    vim.cmd(":normal! P")
    yank_selected = false
end

function M.cmd(args)
    local scmd = args.args
    if scmd == "save" then
        M.save()
    elseif scmd == "paste" then
        M.paste()
    elseif scmd == "Paste" then
        M.Paste()
    end
end

function M.cmd_complete(_, _, _)
    return {
        "Paste", "paste", "save",
    }
end

vim.keymap.set("v", "<leader>yy", M.save, {})
vim.keymap.set("v", "<leader>yp", M.paste, {})
vim.keymap.set("n", "<leader>yp", M.paste, {})
vim.keymap.set("v", "<leader>yP", M.Paste, {})
vim.keymap.set("n", "<leader>yP", M.Paste, {})

vim.api.nvim_create_user_command("YankBin",M.cmd, {
    nargs = 1,
    complete = M.cmd_complete
})

return M
