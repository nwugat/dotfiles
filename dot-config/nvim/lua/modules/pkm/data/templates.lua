local tutil = require("modules.pkm.util.template")

local m = {
	generic = function()
		return tutil.table_concat(tutil.default_frontmatter, {
			"",
			"# " .. tutil.get_current_buf_filename(),
		})
	end,
	yt = function()
		local ytdlp = require("modules.pkm.util.ytdlp")
		local url = vim.fn.getreg("+")
		---@type string?
		local vid_author = "Unknown"
		---@type string?
		local vid_title = nil
		if not ytdlp.is_ytdlp_available() then
			vim.notify("yt-dlp not found", vim.log.levels.WARN)
		elseif ytdlp.is_youtube_url(url) then
			vid_author = ytdlp.ytdlp_get_property_synchr(url, "uploader")
			vid_title = ytdlp.ytdlp_get_property_synchr(url, "title")
		end
		return tutil.table_concat(tutil.default_frontmatter_open, {
			"author: " .. vid_author,
			"url: " .. url,
			"---",
			"",
			"# " .. vid_title or tutil.get_current_buf_filename(),
		})
	end,
	fleeting = function()
		return tutil.table_concat(tutil.default_frontmatter_open, {
			"---",
			"",
			"#fleeting",
			"",
			"# " .. tutil.get_current_buf_filename(),
		})
	end,
}
m[".default"] = m.generic

return m
