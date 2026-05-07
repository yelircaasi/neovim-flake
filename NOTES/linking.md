Here's a Lua script that will create symbolic links from plugin repositories to your plugin directory:

```lua
#!/usr/bin/env lua

local plugins = {
    ["user/repo-name"] = { path = "source_path/repo1" },
    ["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
    ["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
}

local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
-- Or use a custom path:
-- local PLUGIN_DIR = "/path/to/your/plugin/dir"

-- Expand tilde in paths
local function expand_path(path)
    if path:sub(1, 1) == "~" then
        return os.getenv("HOME") .. path:sub(2)
    end
    return path
end

-- Extract repo name from "user/repo-name" format
local function get_repo_name(plugin_id)
    return plugin_id:match("([^/]+)$")
end

-- Create symbolic links
for plugin_id, config in pairs(plugins) do
    local repo_name = get_repo_name(plugin_id)
    local source_path = expand_path(config.path)
    local target_path = PLUGIN_DIR .. "/" .. repo_name
    
    -- Check if source exists
    local source_exists = os.rename(source_path, source_path) and true or false
    
    if not source_exists then
        print(string.format("Warning: Source path does not exist: %s", source_path))
    else
        -- Remove existing link/directory if it exists
        os.execute(string.format("rm -rf '%s'", target_path))
        
        -- Create symbolic link
        local cmd = string.format("ln -s '%s' '%s'", source_path, target_path)
        local success = os.execute(cmd)
        
        if success then
            print(string.format("✓ Linked: %s -> %s", repo_name, source_path))
        else
            print(string.format("✗ Failed to link: %s", plugin_id))
        end
    end
end

print("\nDone!")
```

If you're using this within Neovim (as a `.lua` file in your config), here's a version that uses Neovim's functions:

```lua
local plugins = {
    ["user/repo-name"] = { path = "source_path/repo1" },
    ["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
    ["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
}

local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

-- Extract repo name from "user/repo-name" format
local function get_repo_name(plugin_id)
    return plugin_id:match("([^/]+)$")
end

-- Create symbolic links
for plugin_id, config in pairs(plugins) do
    local repo_name = get_repo_name(plugin_id)
    local source_path = vim.fn.expand(config.path)
    local target_path = PLUGIN_DIR .. "/" .. repo_name
    
    -- Check if source exists
    if vim.fn.isdirectory(source_path) == 0 then
        vim.notify(string.format("Warning: Source path does not exist: %s", source_path), vim.log.levels.WARN)
    else
        -- Remove existing link/directory if it exists
        vim.fn.delete(target_path, "rf")
        
        -- Create symbolic link
        local success = vim.loop.fs_symlink(source_path, target_path)
        
        if success then
            vim.notify(string.format("✓ Linked: %s -> %s", repo_name, source_path), vim.log.levels.INFO)
        else
            vim.notify(string.format("✗ Failed to link: %s", plugin_id), vim.log.levels.ERROR)
        end
    end
end

print("Symbolic links created!")
```

The script:
1. Extracts the repo name from the `"user/repo-name"` format
2. Expands paths (handles `~` for home directory)
3. Creates symbolic links at `PLUGIN_DIR/repo-name` pointing to the source paths
4. Handles errors and provides feedback

You can run it with `:luafile path/to/script.lua` in Neovim or just require it in your config.