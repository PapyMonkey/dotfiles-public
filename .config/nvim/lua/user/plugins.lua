local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
	augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use "wbthomason/packer.nvim"	-- Have packer manage itself
	use "nvim-lua/popup.nvim"	-- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim"	-- Useful lua functions used ny lots of plugins
	-- use "vim-airline/vim-airline" -- Vim powerline
	-- use "vim-airline/vim-airline-themes" -- Airline themes
	use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	use "numToStr/Comment.nvim" -- Easily comment stuff
	use "akinsho/bufferline.nvim" -- Nice bufferline
	use "moll/vim-bbye"	-- Useful plugin preventig from quitting after closing last buffer
	use "andweeb/presence.nvim" -- Discord rich presence integration

	-- Themes
	--use 'overcache/NeoSolarized'
	use 'wojciechkepka/vim-github-dark'
	use "RRethy/nvim-base16"

	-- 42
	-- use 'vim-syntastic/syntastic' -- Norminette dependency
	-- use 'alexandregv/norminette-vim' -- 42 mandatory 'norminette'
	use "42Paris/42header"	-- 42 mandatory header

	-- cmp plugins
	use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-buffer" -- buffer completions
	use "hrsh7th/cmp-path" -- path completions
	use "hrsh7th/cmp-cmdline" -- cmdline completions
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"

	-- snippets
	use "L3MON4D3/LuaSnip" --snippet engine
	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- LSP
	use "neovim/nvim-lspconfig" -- enable LSP
	use "williamboman/nvim-lsp-installer" -- simple to use language server installer

	-- Telescope
	use "nvim-telescope/telescope.nvim"
	use 'nvim-telescope/telescope-media-files.nvim'

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "p00f/nvim-ts-rainbow"
	use "JoosepAlviste/nvim-ts-context-commentstring"

	-- NvimTree
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'

	-- Git
	use "lewis6991/gitsigns.nvim"

	-- Doge
	use "kkoomen/vim-doge"

	-- Markdown
	-- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'} -- Markdown preview
	use {"ellisonleao/glow.nvim", branch = 'main'} -- Markdown preview

	-- Powerline
	use {
	  "nvim-lualine/lualine.nvim",
	  requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
