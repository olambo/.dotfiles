"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR          <cmd>lua vim.lsp.buf.rename()<CR>

nnoremap <silent> gh          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> g<cr>       <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> gE          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ge          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

nnoremap <silent> g=          <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gs          <cmd>lua vim.lsp.buf.document_symbol()<CR>

"-----------------------------------------------------------------------------
" nvim-metals setup
"-----------------------------------------------------------------------------
:lua << EOF
metals_config = require'metals'.bare_config
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

local function tab(fallback)
    if fn.pumvisible() == 1 then
        fn.feedkeys(t "<C-n>", "n")
    elseif luasnip.expand_or_jumpable() then
        fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
    elseif check_back_space() then
        fn.feedkeys(t "<tab>", "n")
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
    ["<Tab>"] = cmp.mapping(tab, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(shift_tab, { "i", "s" }),
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

" inoremap <expr> <Down> pumvisible() ? "\<c-n>" : "\<cmd>lua require'luasnip'.jump(1)<Cr>"
" inoremap <expr> <Up> pumvisible() ? "\<c-p>" : "\<cmd>lua require'luasnip'.jump(-1)<Cr>"

" Needed for completions _only_ if you aren't using completion-nvim
autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F

