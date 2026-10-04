-- Various shorthands for common actions
-- Each function value in table m is triggered by :Notes Shortcut <key>

local ytdlp = require("modules.pkm.util.ytdlp")
local template_actions = require("modules.pkm.features.template_actions")
local dirs = require("modules.pkm.data.paths")
local helper = require("utils.helper") --TODO: get rid of helper

local m = {}

m["YTNote"] = function()
	local url = vim.fn.getreg("+")

	if not ytdlp.is_ytdlp_available() then
		vim.notify("yt-dlp not found", vim.log.levels.WARN)
		return
	end

	if not ytdlp.is_youtube_url(url) then
		vim.notify("Clipboard content is not a yt URL (" .. url .. ")")
		return
	end

	local video_title = ytdlp.ytdlp_get_property_synchr(url, "title")
	local video_uploader = ytdlp.ytdlp_get_property_synchr(url, "uploader")
	local file_base_name = "yt "
		.. helper.sanitize_str(video_uploader)
		.. " "
		.. helper.sanitize_str(video_title)
		.. ".md"

	vim.cmd("edit " .. vim.fs.joinpath(dirs.vault_root, file_base_name))

	--HACK: putting the url in the clipboard again, just in case. May be redundant
	vim.fn.setreg("+", url)

	template_actions.apply_template_with_key("yt")
end

m["Preview"] = function()
	local curr_buf = vim.bo[vim.api.nvim_get_current_buf()]
	--TODO: find a better location for this
	local css_path = vim.fn.expand("~/Downloads/github-markdown.css")
	--WARN: *nix only
	local temp_path = "/tmp/nwu-notes-autogen.html"

	if not curr_buf or curr_buf.filetype ~= "markdown" then
		vim.notify("Current buffer is not a markdown buffer", vim.log.levels.ERROR)
		return
	end

	if not vim.fn.filereadable(css_path) then
		local source_ulr =
			"https://raw.githubusercontent.com/sindresorhus/github-markdown-css/refs/heads/main/github-markdown.css"
		local result = vim.system({ "curl", source_ulr }):wait()
		vim.fn.writefile(result.stdout, css_path)
	end

	-- generate file
	--WARN: not making any checks
	vim.system({
		"pandoc",
		"--from",
		"markdown",
		vim.fn.expand("%:p"),
		"--to",
		"html",
		"--standalone",
		"--css=" .. css_path,
		"--output",
		temp_path,
	}):wait()

	-- open it
	vim.system({ "xdg-open", vim.fn.expand(temp_path) }, { detach = true })
end

return m
