--como um dicionario em python, apenas criado. Sera alimentado mais adiante
m_dist = {}

--variavel para o loop da conexao
local count = 0 

-- funcao para acender ou apagar o LED.
function manipulateLED(STATUS)
    m:publish("/mcu/LED_status/", "ON/OFF",0,0, function(m) print("ON/OFF") end)

    light(STATUS)

    if STATUS == OFF then
    -- confirma a recepcao de mensagem no topico /mcu/comando
        m:publish("/mcu/LED_status/","LED OFF",0,0, function(m) print("LED OFF") end)
    else
    -- confirma a recepcao de mensagem no topico /mcu/comando
        m:publish("/mcu/LED_status/","LED ON",0,0, function(m) print("LED ON") end)
    end
end

    -- Como dicionario em Python, um array que no momento esta armazenando apenas a funcao de LED
    m_dist["/mcu/comandos/LED_status"] = manipulateLED
    
    m = mqtt.Client("ESP_001", 60, "dobitaobyte", "naoContoAsenha")

    m:lwt("/lwt","online",0,0)

    m:on("connect",function(m) print("nClient: ",
                                    MQTT_CLIENTID, 
                                     "nBroker: ",
                                        MQTT_HOST,
                                     "nPorta : ",
                                        MQTT_PORT,
                                        "nn")
    -- Topico para receber os comandos remotos
    m:subscribe("/mcu/comandos/#",0, function(m) print("Topico COMANDOS alinhado") end)

    end)

    -- na desconexao...
    m:on("offline", function(m) print("Desconectado do Broker")
                              print("Heap: ", node.heap()) 
    end)

    -- dispatcher e interpreter
    m:on("message", function(m,t,pl) print("Payload: ", pl)
                                     print("Topic  : ", t)
                                     if pl~=nil and m_dist[t] then
                                         m_dist[t](pl)
                                     end
                                     
    end)

    -- conexao ao Broker
    m:connect(MQTT_HOST, MQTT_PORT, 0, 1)
