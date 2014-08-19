"use strict"
_ = require("lodash")

###
Load environment configuration
###
module.exports = _.merge(require("./env/all.coffee") or {})
