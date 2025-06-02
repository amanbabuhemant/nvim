--[[ ReWrite ]]--


local M = {}

M.write_string = ""
M.write_mode = ""
M.last_writes = {}

function M.load()
    M.write_string = vim.fn.getreg("") or ""
end

function M.write(mode)
    -- modes:
    -- l : line
    -- w : word
    -- c : cahrracter

    if not mode or #mode == 0 then
        mode = "l"
    end
    M.write_string = vim.fn.getreg("") or ""
    M.write_mode = mode
    M.set_mappings()
end

function M.write_next()
    local mode = M.write_mode

    if #M.write_string == 0 then
        M.remove_mappings()
    end

    local text_to_write

    if mode == "c" then
        text_to_write = M.write_string:sub(1, 1)
        M.write_string = M.write_string:sub(2)
    end

    if mode == "w" then
        local sp = M.write_string:find(" ") or #M.write_string
        local nlp = M.write_string:find("\n")
        local bp = sp
        if nlp and nlp < sp then
            bp = nlp
        end
        if bp then
            text_to_write = M.write_string:sub(1, bp)
            M.write_string = M.write_string:sub(bp+1)
        end
    end

    if mode == "l" then
        local nlp = M.write_string:find("\n")
        if nlp then
            text_to_write = M.write_string:sub(1, nlp)
            M.write_string = M.write_string:sub(nlp+1)
        end
    end

    if #M.write_string == 0 then
        M.remove_mappings()
        print("ReWrite Complete")
    end

    M.paste(text_to_write)
end

function M.delete_last()
    local lw = table.remove(M.last_writes, #M.last_writes)
    if lw then
        vim.cmd(":normal! u")
        M.write_string = lw .. M.write_string
    end
end

function M.set_mappings()
    vim.keymap.set("n", "<CR>", M.write_next)
    vim.keymap.set("n", "<BS>", M.delete_last)
end

function M.remove_mappings()
    vim.keymap.del("n", "<CR>")
    vim.keymap.del("n", "<BS>")
end

function M.paste(text)
    if not text then return end
    for c in text:gmatch(".") do
        vim.fn.setreg("", c)
        vim.cmd(":normal! p")
    end
    table.insert(M.last_writes, text)
end

function M.cmd(opts)
    local args = opts.args
    if args then
        M.write(args)
    else
        M.write()
    end
end

function M.complete(_, _, _) return { "c", "w", "l" } end

vim.api.nvim_create_user_command("ReWrite", M.cmd, { nargs = "?", complete = M.complete })

return M
