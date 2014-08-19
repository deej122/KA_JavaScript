# app/routes.js
module.exports = (app) ->
  
  # server routes ===========================================================
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

  
  # route to handle creating (app.post)
  # route to handle delete (app.delete)
  
  # frontend routes =========================================================
  # route to handle all angular requests
  app.get "*", (req, res) ->
    res.sendfile "./app/views/index.html"
    return

  return