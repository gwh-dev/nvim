local M = {}

-- * Give all the registered providers
---@return table
local list_registered_providers_names = function(filetype)
    local s = require "null-ls.sources"
    local available_sources = s.get_available(filetype)
    local registered = {}
    for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
            registered[method] = registered[method] or {}
            table.insert(registered[method], source.name)
        end
    end
    return registered
end

-- * check if the filetype have a null_ls provider/s
---@return table
function M.list_registered(filetype, method)
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

M.root_patterns = { ".git", "/lua" }

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

-- this will return a function that calls telescope.
-- cwd will defautlt to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

local line_targets = function(winid, comp)
    local wininfo = vim.fn.getwininfo(winid)[1]
    local cur_line = vim.fn.line "."

    -- Get targets.
    local targets = {}
    local state = { lnum = -1 }

    while comp(state, wininfo, cur_line) do
        -- Skip folded ranges.
        local fold_end = vim.fn.foldclosedend(state.lnum)
        if fold_end ~= -1 then
            state.lnum = fold_end + 1
        else
            if state.lnum ~= cur_line then
                table.insert(targets, { pos = { state.lnum, 1 } })
            end
            state.lnum = state.lnum + 1
        end
    end

    if #targets == 0 then
        return
    end

    -- Sort them by vertical screen distance from cursor.
    local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]

    local screen_rows_from_cursor = function(t)
        local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
        return math.abs(cur_screen_row - t_screen_row)
    end

    table.sort(targets, function(t1, t2)
        return screen_rows_from_cursor(t1) < screen_rows_from_cursor(t2)
    end)

    return targets
end

function M.leap_line_backward()
    local winid = vim.api.nvim_get_current_win()
    local comp = function(state, wininfo, line)
        if state.lnum == -1 then
            state.lnum = wininfo.topline
        end

        return state.lnum <= line
    end
    require("leap").leap {
        targets = line_targets(winid, comp),
        target_windows = { winid },
    }
end

function M.leap_line_forward()
    local winid = vim.api.nvim_get_current_win()
    local comp = function(state, wininfo, line)
        if state.lnum == -1 then
            state.lnum = line
        end

        return state.lnum <= wininfo.botline
    end

    require("leap").leap {
        targets = line_targets(winid, comp),
        target_windows = { winid },
    }
end

function M.lsp_client(msg)
    msg = msg or ""

    local buf_clients = vim.lsp.buf_get_clients()
    local method = {
        "FORMATTING",
        "DIAGNOSTICS",
        "CODE_ACTION",
    }

    if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
            return ""
        end
        return msg
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    for value in pairs(method) do
        local utils = require "core.utils"
        local null_ls = require "null-ls"
        local supported = utils.list_registered(buf_ft, null_ls.methods[method[value]])
        vim.list_extend(buf_client_names, supported)
    end

    -- add client
    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

    return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

return M
