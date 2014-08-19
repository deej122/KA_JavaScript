"use strict"
acorn = require("acorn")

parseCode = (req, res) ->
	ast = acorn.parse(req.params.jsCode,
	 
	 # collect ranges for each node
	 ranges: true
	 
	 # collect comments in Esprima's format
	 onComment: (block, text, start, end) ->
	   comments.push
	     type: (if block then "Block" else "Line")
	     value: text
	     range: [
	       start
	       end
	     ]

	   return

	 # collect token ranges
	 onToken: (token) ->
	   tokens.push range: [
	     token.start
	     token.end
	   ]
	   return
	res.json 200, ast: ast
	)