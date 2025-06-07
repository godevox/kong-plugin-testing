-- plugins/request-logger/schema.lua
local typedefs = require "kong.db.schema.typedefs"

return {
  name = "request-logger",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { detailed_logging = { type = "boolean", default = false } },
          { log_request_body = { type = "boolean", default = false } },
          { enabled = { type = "boolean", default = true } }
        }
      }
    }
  }
}