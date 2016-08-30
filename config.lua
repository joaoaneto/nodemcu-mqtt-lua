-- file : config.lua
local module = {}

module.SSID = {}  
module.SSID["Gandalf"] = "997718709"

module.HOST = "iot.eclipse.org"
--module.HOST = "mq.thingmq.com"   
module.PORT = 1883  
module.ID = node.chipid()

module.ENDPOINT = "nodemcu/"  
return module