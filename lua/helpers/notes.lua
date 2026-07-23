-- [[ notes ]] --


local notes_dir = vim.fn.stdpath("data") .. "/notes/"
vim.fn.mkdir(notes_dir, "p")

local is_fullscreen = false;
local fullscreen_width = vim.api.nvim_win_get_width(0)

local Notes = {};

function Notes.open(notefile)
    local note_file = notes_dir .. vim.fn.sha256(notefile) .. ".md"
    local w_width = math.max(math.floor(vim.api.nvim_win_get_width(0) / 3), 30)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        width = w_width,
        height = vim.api.nvim_win_get_height(0) - 2,
        row = 0,
        col = vim.api.nvim_win_get_width(0) - w_width,
        relative = "win",
        style = "minimal",
        border = "single",
    })

    local f = io.open(note_file, "r")
    if not f then
        f = io.open(note_file, "w")
        if not f then
            print("Unable to open note file")
            return
        end
        f:write("")
    end
    f:close()

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(note_file))
    vim.bo[buf].filetype = "markdown"

    -- mappings
    local sae = function() Notes.save_and_exit(buf, note_file) end
    local fft = function() Notes.full_screen_toggle(win) end
    vim.keymap.set("i", "<Esc><Esc>", sae, { buffer = buf })
    vim.keymap.set("n", "<Esc><Esc>", sae, { buffer = buf })
    vim.keymap.set("n", "q", sae, { buffer = buf })
    vim.keymap.set("n", "gf", fft, { buffer = buf })
end

function Notes.save_and_exit(buf, note_file)
    -- getting the content
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = ""
    for _, line in pairs(lines) do
        content = content .. line .. "\n"
    end

    -- writing the content
    local nf = io.open(note_file, "w")
    if not nf then
        print("Unable to open note file")
        return
    end
    nf:write(content)
    nf:close()

    -- deleting the buffer
    vim.api.nvim_buf_delete(buf, { force = true })

    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(
            "<Esc>", true, false, true
        ),
        "n", false
    )
end

function Notes.full_screen_toggle(win)
    if is_fullscreen then
        vim.api.nvim_win_set_width(win, math.max(math.floor(fullscreen_width / 3), 30))
        is_fullscreen = false
    else
        vim.api.nvim_win_set_width(win, fullscreen_width)
        is_fullscreen = true
    end
end

function Notes.cmd(opts)
    local args = opts.args
    local file_path = vim.fn.expand("%:p")
    local pwd = os.getenv("PWD")

    if args == "" then
        if file_path ~= "" then
            Notes.open(file_path)
        else
            Notes.open(pwd)
        end
    elseif args == "-f" then
        if file_path == "" then
            print("no file opened")
            return
        end
        Notes.open(file_path)
    elseif args == "-d" then
        Notes.open(pwd)
    elseif args == "-p" then
        local project_root_dir
        if vim.fn.isdirectory(pwd .. "/.git") == 1 then
            project_root_dir = pwd
            return Notes.open(project_root_dir)
        end
        local start = vim.api.nvim_buf_get_name(0)
        if string.len(start) == 0 and pwd then
            start = pwd
        end
        if string.len(start) == 0 then
            print("unable to get current directory")
            return
        end
        for dir in vim.fs.parents(start) do
            if vim.fn.isdirectory(dir .. '/.git') == 1 then
                project_root_dir = dir
                break
            end
        end
        if not project_root_dir then
            print("no project directory found")
            return
        end
        Notes.open(project_root_dir)
    else
        Notes.open(args)
    end
end

vim.api.nvim_create_user_command("Notes", Notes.cmd, {
    nargs = "?",
    complete = "file"
})

return Notes
