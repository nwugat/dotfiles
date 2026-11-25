-- vim.api.nvim_create_user_command("GDSelect", function(opts)
-- 	local fzf_lua = require("fzf-lua")
-- 	local opts = {
-- 		prompt = "Godot Projectz>",
-- 		actions = {
-- 			['default'] = function(selected)
-- 				vim.cmd("cmd " .. selected[1])
-- 			end
-- 		}
-- 	}
-- 	fzf_lua.fzf_exec()
-- end, {
-- })

local function fzf_files_gd()
	require("fzf-lua").files({
		fd_opts = [[ --type f --hidden --exclude '.git/*' --exclude .git --exclude .godot --exclude .editorconfig --exclude .cache --exclude '*.import' --exclude '*.translation' --exclude '*.uid' --exclude '*/android/*' --exclude '*.tres' --exclude '*.tscn' --exclude '*.svg' --exclude '*.png' --exclude '*.jpg' --exclude '*.jpeg' --exclude '*.ogg' --exclude '*.mp3' ]],
	})
end

local function on_detect_gd_proj()
	local cwd = vim.fn.getcwd()
	local root_marker_path = vim.fs.joinpath(cwd, "/project.godot")
	local pipe_path = vim.fs.joinpath(cwd, "/server.pipe")

	if vim.uv.fs_stat(root_marker_path) then
		vim.notify("project.godot detected", vim.log.levels.INFO)
		if not vim.uv.fs_stat(pipe_path) then
			-- Start listening remote control pipe file in gd project
			vim.fn.serverstart(pipe_path)
			-- Use custom file picker (ignores non-important files)
			vim.keymap.set("n", "<leader>sf", fzf_files_gd) -- TODO: revert it?
		end
	end
end

--detect godot project root marker
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
	callback = on_detect_gd_proj,
})
