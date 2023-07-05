--add zon as a zig file
vim.filetype.add({
    extension = {
        zon = "zig",
    },
    filename = {
        ["build.zig.zon"] = "zig",
    },
    pattern = {
        [".*%.zig.zon$"] = "zig",
    },
})
