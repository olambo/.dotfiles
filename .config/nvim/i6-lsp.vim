"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" These are example settings to use with nvim-metals and the nvim built in
" LSP.  Be sure to thoroughly read the the help docs to get an idea of what
" everything does.
"
" The below configuration also makes use of the following plugins besides
" nvim-metals
" - https://github.com/nvim-lua/completion-nvim
"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

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

" what are these?
nnoremap <silent> gs          <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap  gws                 <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap  gww                 <cmd>lua require'metals'.open_all_diagnostics()<CR>
" nnoremap  gwl                 <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>


"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------
" If you just use the latest stable version, then setting this isn't necessary
" let g:metals_server_version = '0.9.8+10-334e402e-SNAPSHOT'

"-----------------------------------------------------------------------------
" nvim-metals setup with a few additions such as nvim-completions
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

  metals_config.on_attach = function()
    require'completion'.on_attach();
  end

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '',
      }
    }
  )
EOF

  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end

"-----------------------------------------------------------------------------
" completion-nvim settings - https://github.com/nvim-lua/completion-nvim#changing-completion-confirm-key
"-----------------------------------------------------------------------------
let g:completion_confirm_key = ""
inoremap <expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-n>\<c-y>" : "\<cr>"
inoremap <expr> <Tab> pumvisible() ? complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-n><C-y>" : "\<Tab>"

"-----------------------------------------------------------------------------
" Helpful general settings
"-----------------------------------------------------------------------------
" Needed for completions _only_ if you aren't using completion-nvim
autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F

