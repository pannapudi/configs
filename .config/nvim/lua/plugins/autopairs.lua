-- return {
-- 	"altermo/ultimate-autopair.nvim",
-- 	event = { "InsertEnter", "CmdlineEnter" },
-- 	-- branch = "v0.6", --recommended as each new version will have breaking changes
-- 	opts = {
-- 		{
-- 			"'",
-- 			"'",
-- 			multiline = false,
-- 			surround = true,
-- 			cond = function(fn)
-- 				if fn.get_ft() ~= "rust" then
-- 					return true
-- 				end
-- 				return not fn.in_node({ "bounded_type", "reference_type", "type_arguments", "type_parameters" })
-- 			end,
-- 		},
-- 	},
--
-- }

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
	},
}
