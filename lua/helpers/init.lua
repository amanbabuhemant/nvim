-- [[ helpers funcitons and functnalitis ]] --

local luarocks = require("luarocks")

local helpers = {
    { "run-code" },
    { "logger" },
    { "yankbin" },
    { "notes" },
    { "rewrite" },
    { "toggle-bool" },
};

for _, helper in pairs(helpers) do
    if helper.luarocks then
        for _, lr in pairs(helper.luarocks) do
            if not luarocks.is_installed(lr) then
                print("luarock '" .. lr .. "' not installed, required by " .. helper[1])
                print("installing " .. lr)
                luarocks.install(lr)
                local installed = luarocks.is_installed(luarocks)
                if not installed then
                    print("root privlages might needed")
                    vim.cmd("terminal sudo luarocks install " .. lr)
                    vim.cmd("startinsert")
                end
            end
        end
    end
    require("helpers." .. helper[1])
end
