-- plugins/hello-world/handler.lua
local HelloWorldHandler = {}

HelloWorldHandler.PRIORITY = 1000
HelloWorldHandler.VERSION = "1.0.0"

function HelloWorldHandler:access(conf)
  -- Add a custom header
  kong.response.set_header("X-Hello-World", "Hello from Kong Plugin!")
  
  -- Log a message
  kong.log.info("Hello World plugin executed for request: " .. kong.request.get_path())
  
  -- Optionally modify the request
  kong.service.request.set_header("X-Plugin-Processed", "true")
end

return HelloWorldHandler