-- plugins/hello-world/schema.lua
local typedefs = require "kong.db.schema.typedefs"

return {
  name = "hello-world",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { message = { type = "string", default = "Hello World!" } },
          { enabled = { type = "boolean", default = true } }
        }
      }
    }
  }
}