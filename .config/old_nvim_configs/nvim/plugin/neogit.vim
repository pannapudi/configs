lua << EOF
local neogit = require('neogit')

neogit.setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  signs = {
    section = { ">", "v" },
    item = { ">", "v" },
    hunk = { "", "" },
  },
  mappings = {
    status = {
      ["B"] = "BranchPopup",
    }
  }
}
EOF
