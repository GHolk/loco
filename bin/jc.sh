#!/bin/sh
#
# usage:
# jc "type:1,shell:'$SHELL',n:null,t:true"
# jc "'m.room.join_rule':'public', 'white space':true, under_score:1"
# jc type:1 n:null t:true shell:\"$SHELL\"
# jc [ 1 2 \"string\" null "{type:'object'}" ]
# jc [ "{type:1,shell:'$SHELL'}" "{type:2, message: 'hello world'}" ]
# jc [ "{type:1,shell:'$SHELL'}, {type:2, message: 'hello world'}" ]

node -p '
    const argv = process.argv.slice(1)
    const result = (argv[0] == "[") ?
        eval(`[${argv.slice(1,-1).join(",")}]`) :
        eval(`({${argv.join(",")}})`)
    JSON.stringify(result, null, "  ")
' -- "$@"
