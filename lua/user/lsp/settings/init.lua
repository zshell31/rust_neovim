local M = {}

M["clangd"] = require("user.lsp.settings.clangd")
M["hls"] = require("user.lsp.settings.hls")
M["pylsp"] = require("user.lsp.settings.pylsp")
M["rnix"] = require("user.lsp.settings.rnix")
M["rust_analyzer"] = require("user.lsp.settings.rust")
M["sumneko_lua"] = require("user.lsp.settings.sumneko_lua")

return M
