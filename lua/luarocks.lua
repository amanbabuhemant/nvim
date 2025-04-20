-- [ LuaRock Managment ] --

local M = {}

function M.list()
    local out = io.popen("luarocks list"):read("*a")
    local installed_rocks = {};
    local header_passed = false;
    for line in out:gmatch("[^\r\n]+") do
        if line:sub(1, 1) ~= " " and header_passed then
            table.insert(installed_rocks, line)
        end
        if line:sub(1, 1) == "-" then
            header_passed = true
        end
    end
    return installed_rocks
end

function M.is_installed(luarock)
    for _, v in pairs(M.list()) do
        if v == luarock then
            return true
        end
    end
    return false
end

function M.install(luarock)
    local install_command = "luarocks install " .. luarock
    local e = os.execute(install_command)
    if e then
        os.execute("sudo " .. install_command)
    end
end

function M.remove(luarock)
    local remove_command = "luarocks remove " .. luarock
    local e = os.execute(remove_command)
    if e then
        os.execute("sudo " .. remove_command)
    end
end

return M
