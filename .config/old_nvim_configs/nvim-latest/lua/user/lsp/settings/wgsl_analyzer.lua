return {
	settings = {
		wgsl = {
			inlayHints = {
				enabled = true,
				typeHints = true,
				parameterHints = true,
				structLayoutHints = true,
				typeVerbosity = "compact",
			},
			diagnostics = {
				typeErrors = true,
				nagaParsing = true,
				nagaValudation = true,
				nagaVersion = "main",
			},
		},
	},
}
