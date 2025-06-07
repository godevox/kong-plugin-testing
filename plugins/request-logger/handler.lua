-- plugins/request-logger/handler.lua
local RequestLoggerHandler = {}

RequestLoggerHandler.PRIORITY = 1001
RequestLoggerHandler.VERSION = "1.0.0"

function RequestLoggerHandler:access(conf)
  local request_data = {
    method = kong.request.get_method(),
    path = kong.request.get_path(),
    query = kong.request.get_query(),
    headers = kong.request.get_headers(),
    timestamp = os.time(),
    client_ip = kong.client.get_ip()
  }
  
  if conf.log_request_body and kong.request.get_method() ~= "GET" then
    request_data.body = kong.request.get_raw_body()
  end
  
  -- Log the request details
  kong.log.info("Request Logger - Method: " .. request_data.method .. 
                " Path: " .. request_data.path .. 
                " IP: " .. request_data.client_ip)
  
  if conf.detailed_logging then
    kong.log.info("Request Logger - Headers: " .. require("cjson").encode(request_data.headers))
    if request_data.query then
      kong.log.info("Request Logger - Query: " .. require("cjson").encode(request_data.query))
    end
  end
end

function RequestLoggerHandler:header_filter(conf)
  local response_data = {
    status = kong.response.get_status(),
    headers = kong.response.get_headers(),
    timestamp = os.time()
  }
  
  kong.log.info("Request Logger - Response Status: " .. response_data.status)
  
  if conf.detailed_logging then
    kong.log.info("Request Logger - Response Headers: " .. require("cjson").encode(response_data.headers))
  end
end

return RequestLoggerHandler