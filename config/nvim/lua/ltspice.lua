local M = {}

M.config = {
    ltspice = "ltspice",
    python = "python",
    lt2ti = vim.fn.expand("~/src/sources/lt2circuitikz/lt2ti.py"),
    directory = "ltspice",
    latex_ext = vim.fn.expand("~/src/sources/lt2circuitikz/sym32a/latex_ext.tex"),
    preamble = vim.fs.joinpath(vim.fn.stdpath("config"), "templates", "preamble.tex")
}

-- Send a mesasge to the user.
local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "LTspice" })
end

-- Validate specified name.
local function name_valid(name)
    if name == "" or name == "." or name == ".." then 
        return false 
    end
    return name:match("^[%w%.%-_]+$") ~= nil
end

-- Function to return the paths to the schematic files by name.
local function schematic_paths(name)
    local root = vim.fn.expand('%:p:h')
    local directory = vim.fs.joinpath(root, M.config.directory, name)

    return {
        root = root,
        directory = directory,
        asc = vim.fs.joinpath(directory, "schematic.asc"),
        generated = vim.fs.joinpath(directory, "schematic.asc.tex"),
        schematic = vim.fs.joinpath(directory, "schematic.tex"),
        latex_ext = vim.fs.joinpath(root, M.config.directory, "latex_ext.tex"),
        preamble = vim.fs.joinpath(root, M.config.directory, "preamble.tex"),
    }
end

-- Convert the modified .asc file to a .asc.tex file.
local function convert_schematic(paths, callback)
    if vim.fn.filereadable(M.config.lt2ti) ~= 1 then
        notify("lt2ti.py not found: " .. M.config.lt2ti, vim.log.levels.ERROR)
        return
    end

    vim.fn.jobstart({M.config.python, M.config.lt2ti, paths.asc}, {
        cwd = paths.directory,

        stdout_buffered = true,
        stderr_buffered = true,

        on_exit = function(_, exit_code)
            vim.schedule(function()
                if exit_code ~= 0 then
                    notify("lt2ti.py failed with exit code " .. exit_code, vim.log.levels.ERROR)
                    return
                end

                if vim.fn.filereadable(paths.generated) ~= 1 then
                    notify("lt2ti.py did not create " .. paths.generated, vim.log.levels.ERROR)
                    return
                end

                callback()
            end)
        end,
    })
end

-- Extract the tikzpicture section from the generated .asc.tex file.
local function extract_tikz(paths)
    local lines = vim.fn.readfile(paths.generated)
    local start_line
    local end_line

    -- Get the start and end of the slice containing the tikzpicture
    for i, line in ipairs(lines) do
        if line:find("^%s*\\begin{tikzpicture}") then
            start_line = i
        elseif line:find("^%s*\\end{tikzpicture}") then
            end_line = i
        end
    end
    if not start_line or not end_line then
        notify("Malformed .asc.tex file detected", vim.log.levels.ERROR)
        return false
    end

    -- Write the slice of the tikzpicture to the schematic file.
    lines = vim.list_slice(lines, start_line, end_line)
    if not vim.fn.writefile(lines, paths.schematic) then
        notify("Failed to write tikzfigure slice to " .. paths.schematic)
        return false
    end

    return true
end

-- Handle :LTspice open <NAME>
function M.open(name)
    if not name_valid(name) then
        notify("Usage: :LTspice open <NAME>", vim.log.levels.ERROR)
        return
    end
end

-- Handle :LTspice open <NAME>
function M.open(name)
    if not name_valid(name) then
        notify("Usage: :LTspice open <name>", vim.log.levels.ERROR)
        return
    end

    local paths = schematic_paths(name)
    if not vim.fn.mkdir(paths.directory, "p") then
        notify("Could not create " .. paths.directory, vim.log.levels.ERROR)
        return
    end

    if vim.uv.fs_stat(paths.asc) then
        notify(paths.asc .. " already exists", vim.log.levels.ERROR)
        return
    end

    vim.fn.jobstart({M.config.ltspice, paths.asc}, {detach = true})
end

-- Handle :LTspice edit <NAME>
function M.edit(name)
    if not name_valid(name) then
        notify("Usage: :LTspice edit <name>", vim.log.levels.ERROR)
        return
    end

    local paths = schematic_paths(name)
    if not vim.fn.filereadable(paths.asc) then
        notify(paths.asc .. " does not exist", vim.log.levels.ERROR)
        return
    end

    vim.fn.jobstart({M.config.ltspice, paths.asc}, {detach = true})
end

-- Handle :LTspice insert <NAME>
function M.insert(name)
    if not name_valid(name) then
        notify("Usage: :LTspice insert <name>", vim.log.levels.ERROR)
        return
    end

    local paths = schematic_paths(name)
    if not vim.fn.filereadable(paths.asc) then
        notify(paths.asc .. " does not exist", vim.log.levels.ERROR)
        return
    end

    notify("Converting " .. name .. " with lt2circuitikz...")
    convert_schematic(paths, function()
        if not extract_tikz(paths) then
            return
        end

        local include = vim.fs.relpath(paths.root, paths.schematic)
        local lines = {"% @ltspice " .. name, "\\input{" .. include:gsub("\\", "/") .. "}"}
        local row = vim.api.nvim_win_get_cursor(0)[1] - 1
        vim.api.nvim_buf_set_lines(0, row, row, false, lines)
        notify("Inserted LTspice schematic: " .. name)
    end)
end

-- Handle :LTspice preamble
function M.preamble()
    local paths = schematic_paths("unused")

    if not vim.uv.fs_copyfile(M.config.preamble, paths.preamble) then
        notify("Failed to copy " .. M.config.preamble, vim.log.levels.ERROR)
        return
    end

    if not vim.uv.fs_copyfile(M.config.latex_ext, paths.latex_ext) then
        notify("Failed to copy " .. M.config.latex_ext, vim.log.levels.ERROR)
        return
    end
end

-- Setup the plugin.
function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    vim.api.nvim_create_user_command("LTspice", function(opts)
        local args = opts.fargs
        if args[1] == "open" then
            M.open(args[2])
        elseif args[1] == "edit" then
            M.edit(args[2])
        elseif args[1] == "insert" then
            M.insert(args[2])
        elseif args[1] == "preamble" then
            M.preamble()
        else
            notify("Usage: :LTspice open|edit|insert|preamble <name>", vim.log.levels.ERROR)
        end
    end, {
    nargs = "+",
    complete = function(_, line)
        local args = vim.split(line, "%s+", {trimempty = true})
        if #args <= 2 then return { "open", "edit", "insert", "preamble" } end
        return {}
    end})
end

return M
