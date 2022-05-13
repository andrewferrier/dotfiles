-- luacheck: globals vim

local M = {}

local css_settings = {
    validate = true,
    lint = {
        compatibleVendorPrefixes = "error",
        vendorPrefix = "error",
        duplicateProperties = "error",
        emptyRules = "error",
        importStatement = "error",
        boxModel = "error",
        universalSelector = "error",
        zeroUnits = "error",
        fontFaceProperties = "error",
        hexColorLength = "error",
        argumentsInColorFunction = "error",
        unknownProperties = "error",
        ieHack = "error",
        unknownVendorSpecificProperties = "error",
        propertyIgnoredDueToDisplay = "error",
        important = "error",
        float = "error",
        idSelector = "error",
    },
}

local parsedcss_settings = vim.deepcopy(css_settings)

parsedcss_settings.lint.importStatement = "warning"
parsedcss_settings.lint.float = "warning"

M.settings = {
    settings = {
        css = css_settings,
        scss = parsedcss_settings,
        less = parsedcss_settings,
    },
    filetypes = { "css", "scss", "sass", "less" },
}

return M
