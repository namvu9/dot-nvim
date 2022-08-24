-- autocomplete config
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  }
}

-- omnisharp lsp config
require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "omnisharp_lsp_run", "-lsp" , "--hostPID", tostring(pid) },
}

--nnoremap('<leader>fu', 'Telescope lsp_references')
--nnoremap('<leader>gd', 'Telescope lsp_definitions')
--nnoremap('<leader>rn', 'lua vim.lsp.buf.rename()')
--nnoremap('<leader>dn', 'lua vim.lsp.diagnostic.goto_next()')
--nnoremap('<leader>dN', 'lua vim.lsp.diagnostic.goto_prev()')
--nnoremap('<leader>dd', 'Telescope lsp_document_diagnostics')
--nnoremap('<leader>dD', 'Telescope lsp_workspace_diagnostics')
--nnoremap('<leader>xx', 'Telescope lsp_code_actions')
--nnoremap('<leader>xd', '%Telescope lsp_range_code_actions')

return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- so packer can update itself
  use { -- nice interface for LSP functions (among other things)
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'neovim/nvim-lspconfig' -- native LSP support
  use 'hrsh7th/nvim-cmp' -- autocompletion framework
  use 'hrsh7th/cmp-nvim-lsp' -- LSP autocompletion provider
end)

