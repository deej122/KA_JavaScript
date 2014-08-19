# app/routes.js
module.exports = (app) ->
  
  # server routes ===========================================================
  # controller = require './controllers/controller'
  # console.log controller
  # handle things like api calls
  # authentication routes
  
  # # sample api route
  # app.get "/api/nerds", (req, res) ->
    
  #   # use mongoose to get all nerds in the database
  #   Nerd.find (err, nerds) ->
      
  #     # if there is an error retrieving, send the error. nothing after res.send(err) will execute
  #     res.send err  if err
  #     res.json nerds # return all nerds in JSON format
  #     return

  #   return

  acorn = require("acorn")
  # route to handle creating (app.post)
  app.route('/api/controller/parse')
    .post (req, res) ->
      console.log "BEFORE FXN"
      # parseCode = (req, res) ->
      console.log "RUNNING"
      console.log req.body
      comments = []
      tokens = []
      ast = acorn.parse(req.body.jsCode,
       
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
      )
      console.log "AST: ---> "
      console.log ast
      res.json 200, ast: ast
  # route to handle delete (app.delete)
  
  # frontend routes =========================================================
  # route to handle all angular requests
  app.get "*", (req, res) ->
    res.sendfile "./app/views/index.html"
    return

  return