-- [[ notes ]] --


local notes_dir = vim.fn.stdpath("data") .. "/notes/"
vim.fn.mkdir(notes_dir, "p")


local Notes = {};

function Notes.open(notefile)
    local note_file = notes_dir .. vim.fn.sha256(notefile) .. ".txt"
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
        f:write("")
    end
    f:close()

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(note_file))

    -- mappings
    local sae = function() Notes.save_and_exit(buf, note_file) end
    vim.keymap.set("i", "<Esc><Esc>", sae, { buffer = buf })
    vim.keymap.set("n", "<Esc>", sae, { buffer = buf })
    vim.keymap.set("n", "q", sae, { buffer = buf })
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
    else
        Notes.open(args)
    end
end

vim.api.nvim_create_user_command("Notes", Notes.cmd, {
    nargs = "?",
    complete = "file"
})

return Notes
