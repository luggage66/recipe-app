
###
Module dependencies.
###
express = require("express")
setupRoutes = require("./routes")
http = require("http")
path = require("path")
engines = require('consolidate')
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "../views")
app.set "view engine", "jade"
app.engine('html', engines.hogan)
app.engine('jade', engines.jade)
app.use express.favicon()
app.use express.logger("dev")
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser("your secret here")
app.use express.session()
app.use app.router
app.use require("less-middleware")(path.join(__dirname, "../public"))
app.use express.static(path.join(__dirname, "../public"))
app.use express.static(path.join(__dirname, "../lib/client"))

app.locals.slug = require 'slug'

# development only
app.use express.errorHandler()  if "development" is app.get("env")

#setup url -> function mappings
setupRoutes(app)

#start server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
  return

