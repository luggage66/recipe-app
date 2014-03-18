recipe-app playground
---------------------

1. Clone repo
1. install grunt-cli if you don't already have it `npm install grunt-cli -g`
1. Run `npm install`
1. Start Mongo server (e.g. `mongod --dbpath \users\me\mongodata`)
1. Run `grunt dev`

That will compile coffeescript from `src/` into `lib/`, start the web server, and watch for changes (recompiling and restarting as needed).

Organization
------------

* `src/` - All coffeescript files
    * `src/startup.coffee` - starts up express web server
    * `src/controllers` - the url handler functions
* `views/` - The html (jade) templates
    * `views/layout.jade` - a shared layout template
    * `views/index.jade` - placeholder for content
    * `views/recipes/*` - recipe-specific pages
* `public/` - css, client-side script libraries, fonts, images, etc
