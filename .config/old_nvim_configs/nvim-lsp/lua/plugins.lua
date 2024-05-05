return require("packer").startup(function(use)
    use({ "wbthomason/packer.nvim" })

    -- Language servers insteller
    -- use({ "williamboman/nvim-lsp-installer" })
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })

    use("lewis6991/impatient.nvim")

    -- Collection of common configurations for the Nvim LSP client
    use({ "neovim/nvim-lspconfig" })

    -- use({
    -- 	"simrat39/inlay-hints.nvim",
    -- 	config = function()
    -- 		require("inlay-hints").setup()
    -- 	end,
    -- })

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    -- Completion framework
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
                requires = { "rafamadriz/friendly-snippets" },
            },
            "hrsh7th/cmp-calc",
            "saadparwaiz1/cmp_luasnip",
            -- "hrsh7th/cmp-latex-symbols",
        },
        config = function()
            require("core.cmp").setup()

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    })

    use({
        "rafamadriz/friendly-snippets",
    })

    -- To enable more of the features of rust-analyzer, such as inlay hints and more!
    use({
        "simrat39/rust-tools.nvim",
        requires = { "neovim/nvim-lspconfig" },
        config = function()
            require("core.rust-tools").setup()
        end,
        ft = { "rust", "rs" }, -- or you can not lazy load and remove this line
    })

    use({
        "folke/trouble.nvim",
        -- cmd = "TroubleToggle",
        config = function()
            local map = require("util").map
            map("n", "tr", "<cmd>Trouble lsp_references<cr>")
            map("n", "tf", "<cmd>Trouble lsp_definitions<cr>")
            map("n", "tq", "<cmd>Trouble quickfix<cr>")
            map("n", "tl", "<cmd>Trouble loclist<cr>")
            map("n", "tw", "<cmd>Trouble document_diagnostics<cr>")
            map("n", "tW", "<cmd>Trouble workspace_diagnostics<cr>")
        end,
    })

    -- Fuzzy finder
    use({ "nvim-lua/popup.nvim" })
    use({ "nvim-lua/plenary.nvim" })
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            local map = require("util").map
            map("n", "<C-p>", '<cmd>lua require("telescope.builtin").find_files()<CR>')
            map("n", "<leader>fg", '<cmd>lua require("telescope.builtin").grep_string()<CR>')
            map("n", "<leader>ff", '<cmd>lua require("telescope.builtin").live_grep()<CR>')
            require("core.telescope").setup()
        end,
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use({
        "nvim-telescope/telescope-frecency.nvim",
        requires = { "tami5/sql.nvim" },
        config = function()
            require("telescope").load_extension("frecency")
        end,
    })
    use({ "nvim-telescope/telescope-symbols.nvim" })
    use({ "nvim-telescope/telescope-github.nvim" })
    -- use {
    --     'nvim-telescope/telescope-arecibo.nvim',
    --     rocks = {"openssl", "lua-http-parser"}
    -- }
    use({ "nvim-telescope/telescope-media-files.nvim" })
    -- use { 'nvim-telescope/telescope-packer.nvim ' }
    use({
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            -- even more opts
                        }),
                    },
                },
            })
        end,
    })

    -- Color scheme used in the GIFs!
    use({ "arcticicestudio/nord-vim" })

    -- dev: Auto reload config
    use({ "famiu/nvim-reload" })

    -- Fetch versions from crates.io
    use({
        "saecki/crates.nvim",
        tag = "v0.1.0",
        event = { "BufRead Cargo.toml" },
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup()
        end,
    })

    -- Git
    use({
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Gdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
            "GBrowse",
            "GRemove",
            "GRename",
            "Glgrep",
            "Gedit",
        },
        config = function()
            local map = require("util").map
            map("n", "<leader>gh", "<cmd>diffget //3<CR>")
            map("n", "<leader>gf", "<cmd>diffget //2<CR>")
        end,
        ft = { "fugitive" },
    })

    -- Comments
    -- use({ "tpope/vim-commentary" })
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup()
        end,
    })

    -- Add git related info in the signs columns and popups
    use({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { hl = "GitGutterAdd", text = "+" },
                    change = { hl = "GitGutterChange", text = "~" },
                    delete = { hl = "GitGutterDelete", text = "_" },
                    topdelete = { hl = "GitGutterDelete", text = "‾" },
                    changedelete = { hl = "GitGutterChange", text = "~" },
                },
            })
        end,
    })

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use({
        "nvim-treesitter/nvim-treesitter",
        -- branch = "0.5-compat",
        -- run = ":TSUpdate",
        config = function()
            require("core.treesitter").setup()
        end,
    })
    use("nvim-treesitter/nvim-treesitter-context")
    -- Additional textobjects for treesitter
    -- use({ "nvim-treesitter/nvim-treesitter-textobjects" })

    -- File tree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("core.nvim-tree").setup()

            local map = require("util").map
            map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
        end,
    })

    use({
        "mhartington/formatter.nvim",
        config = function()
            require("core.formatter").setup()
            vim.api.nvim_exec(
                [[
                augroup FormatAutogroup
                  autocmd!
                  autocmd BufWritePost *.lua,*.cpp FormatWrite
                augroup END
                ]],
                true
            )
        end,
    })

    -- Terminal
    use({
        "akinsho/toggleterm.nvim",
        event = "BufWinEnter",
        config = function()
            require("core.terminal").setup()
        end,
    })

    use({
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("lsp_signature").setup()
        end,
    })

    use({
        "phaazon/hop.nvim",
        event = "BufRead",
        config = function()
            require("hop").setup()
            vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
            vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
        end,
    })

    use({
        "kevinhwang91/rnvimr",
        cmd = "RnvimrToggle",
        config = function()
            vim.g.rnvimr_draw_border = 1
            vim.g.rnvimr_pick_enable = 1
            vim.g.rnvimr_bw_enable = 1
        end,
    })

    use({
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    })

    use({
        "metakirby5/codi.vim",
        cmd = "Codi",
    })

    -- use({
    -- 	"monaqa/dial.nvim",
    -- 	event = "BufRead",
    -- 	config = function()
    -- 		local dial = require("dial")
    -- 		vim.cmd([[
    -- 	      nmap <C-a> <Plug>(dial-increment)
    -- 	      nmap <C-x> <Plug>(dial-decrement)
    -- 	      vmap <C-a> <Plug>(dial-increment)
    -- 	      vmap <C-x> <Plug>(dial-decrement)
    -- 	      vmap g<C-a> <Plug>(dial-increment-additional)
    -- 	      vmap g<C-x> <Plug>(dial-decrement-additional)
    -- 	    ]])

    -- 		dial.augends["custom#boolean"] = dial.common.enum_cyclic({
    -- 			name = "boolean",
    -- 			strlist = { "true", "false" },
    -- 		})
    -- 		table.insert(dial.config.searchlist.normal, "custom#boolean")

    -- 		-- For Languages which prefer True/False, e.g. python.
    -- 		dial.augends["custom#Boolean"] = dial.common.enum_cyclic({
    -- 			name = "Boolean",
    -- 			strlist = { "True", "False" },
    -- 		})
    -- 		table.insert(dial.config.searchlist.normal, "custom#Boolean")
    -- 	end,
    -- })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    use({ "oberblastmeister/neuron.nvim" })
    use({ "mattn/webapi-vim" })
    use({ "rhysd/clever-f.vim" })
    use({ "ron-rs/ron.vim" })
    use({ "DingDean/wgsl.vim" })
    -- use({ "tikhomirov/vim-glsl" })
    use({ "bronson/vim-trailing-whitespace" })

    use({
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit",
                    "gitrebase",
                    "svn",
                    "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    })

    use({
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = false, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>"),
                vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>"),
                vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>"),
            })
        end,
    })

    use({
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup({
                show_numbers = true, -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            })
        end,
    })

    use({
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
        end,
    })

    use({
        "kevinhwang91/nvim-bqf",
        event = { "BufRead", "BufNew" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        setup = function()
            -- require("indent_blankline").setup {
            --    -- for example, context is off by default, use this to turn it on
            --    show_current_context = true,
            --    show_current_context_start = true,
            -- }
            -- vim.g.indentLine_enabled = 1
            -- vim.g.indent_blankline_char = "▏"
            -- vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
            -- vim.g.indent_blankline_buftype_exclude = { "terminal" }
            -- vim.g.indent_blankline_show_trailing_blankline_indent = false
            -- vim.g.indent_blankline_show_first_indent_level = false
        end,
    })

    use({
        "simrat39/symbols-outline.nvim",
        config = function()
            vim.g.symbols_outline = { auto_preview = false, width = 15 }
            local map = require("util").map
            map("n", "<F8>", "<cmd>SymbolsOutline<CR>")
        end,
    })

    use({
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim",
        -- config = function()
        --     vim.cmd("colorscheme zenbones")
        --     vim.cmd("set background=dark")
        --     vim.g.zenflesh_darkness = "default"
        -- end,
    })

    -- use({
    -- 	"lewis6991/spellsitter.nvim",
    -- 	config = function()
    -- 		require("spellsitter").setup()
    -- 	end,
    -- })

    use({
        "luisiacc/gruvbox-baby",
    })

    use("arkav/lualine-lsp-progress")

    use("navarasu/onedark.nvim")

    use({
        "nvim-lualine/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "onedark",
                    section_separators = { "", "" },
                    component_separators = { "", "" },
                    disabled_filetypes = {},
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        "filename",
                        {
                            "lsp_progress",
                            display_components = { "lsp_client_name", { "title", "percentage", "message" } },
                        },
                        "fileformat",
                    },
                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_diagnostic" },
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        },
                        "encoding",
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = { "fugitive", "nvim-tree", "quickfix" },
            })
        end,
    })
end)
