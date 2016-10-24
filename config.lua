-- file : config.lua
local module = {}

module.SSID = {}  
module.SSID["N-TEKNET - JOAONETO"] = "97718709"

module.HOST = "iot.eclipse.org"
--module.HOST = "mq.thingmq.com"   
module.PORT = 1883
module.ID = node.chipid()

dofile("dht_11.lua")

module.LUZ = getTemp()

module.ENDPOINT = "nodemcu/"  
return module