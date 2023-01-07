local M = {}

function M.ensure_tools_installed(tools)
    local mr = require "mason-registry"
    for _, tool in ipairs(tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end

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
function M.list_registered(filetype, method)
    local registered_providers = list_registered_providers_names(filetype)
    return registered_providers[method] or {}
end

function M.format()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

    vim.lsp.buf.format {
        bufnr = buf,
        filter = function(client)
            if have_nls then
                return client.name == "null-ls"
            end
            return client.name ~= "null-ls"
        end,
    }
end

function M.rename()
    if pcall(require, "inc_rename") then
        return ":IncRename " .. vim.fn.expand "<cword>"
    else
        vim.lsp.buf.rename()
    end
end

function M.autoformat(client, bufnr)
    if client.supports_method "textDocument/formatting" then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
            buffer = bufnr,
            callback = function()
                M.format()
            end,
        })
    end
end

---@param on_attach fun(client, bufnr)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            if vim.b.lsp_attached then
                return
            end
            vim.b.lsp_attached = true

            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

return M
