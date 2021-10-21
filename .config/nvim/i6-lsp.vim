"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gI          <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR          <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> gi          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> g<cr>       <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> gX          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> gx          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

nnoremap <silent> g=          <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gs          <cmd>lua vim.lsp.buf.document_symbol()<CR>

" Needed for luasnip if I dont' use supertab
inoremap <expr> <Down> pumvisible() ? "\<c-n>" : "\<cmd>lua require'luasnip'.jump(1)<Cr>"
inoremap <expr> <Up> pumvisible() ? "\<c-p>" : "\<cmd>lua require'luasnip'.jump(-1)<Cr>"

"-----------------------------------------------------------------------------
" nvim-metals setup
"-----------------------------------------------------------------------------
:lua << EOF
metals_config = require'metals'.bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
   showImplicitArguments = true,
   excludedPackages = {
     "akka.actor.typed.javadsl",
     "com.github.swagger.akka.javadsl"
   }
}

local fn = vim.fn
local luasnip = require "luasnip"

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- problematic, as I can't reproduce (easily) in intellij
local function tab(fallback)
    if fn.pumvisible() == 1 then
        fn.feedkeys(t "<C-n>", "n")
    elseif luasnip.expand_or_jumpable() then
        fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
    else
        fallback()
    end
end
local function shift_tab(fallback)
    if fn.pumvisible() == 1 then
        fn.feedkeys(t "<C-p>", "n")
    elseif luasnip.jumpable(-1) then
        fn.feedkeys(t "<Plug>luasnip-jump-prev", "")
    else
        fallback()
    end
end

  -- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
   end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] =  cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    -- supertab and Right mapping problematic. I can't reproduce (easily) in intellij!
    -- ['<Right>'] = cmp.mapping.confirm({ select = true }),
    -- ["<Tab>"] = cmp.mapping(tab, { "i", "s" }),
    -- ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }
})

luasnip.snippets = {
 all = require('snippets/all')
}
EOF

augroup lsp
  au!
  au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
augroup end

" Needed for completions _only_ if you aren't using completion-nvim
autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F

