if exists("b:current_syntax")
    finish
endif

syntax keyword schemaType Array Object Image Number
syntax keyword schemaType String Boolean URL Text
syntax keyword schemaType RichText Color Enum File
syntax keyword schemaType Date Box
highlight link schemaType Type

syn keyword schemaCommentTodo TODO FIXME XXX TBD contained
syn match schemaLineComment "\/\/.*" contains=@Spell,schemaCommentTodo,schemaRef
syn match schemaRefComment /\/\/\/<\(reference\|amd-\(dependency\|module\)\)\s\+.*\/>$/ contains=schemaRefD,schemaRefS
syn region schemaRefD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region schemaRefS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+

syn match schemaCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn region schemaComment start="/\*" end="\*/" contains=@Spell,schemaCommentTodo extend

highlight link schemaComment Comment


" string
syn match typescriptSpecial "\\\d\d\d\|\\."
syn region typescriptStringR start=+"+ skip=+\\\\\|\\"+ end=+"\|$+  contains=typescriptSpecial,@htmlPreproc extend
syn region typescriptString start=+(+ skip=+\\\\\|\\'+ end=+)\|$+  contains=typescriptSpecial,@htmlPreproc extend
highlight link typescriptStringR String

syntax match schemaOperator "\v,"
syntax match schemaOperator "\v\{"
syntax match schemaOperator "\v\}"
syntax match schemaOperator "\v\["
syntax match schemaOperator "\v\]"
syntax match schemaOperator "\v\:"
syntax match schemaOperator "\v\("
syntax match schemaOperator "\v\)"
highlight link schemaOperator Operator

let b:current_syntax = "schema"

