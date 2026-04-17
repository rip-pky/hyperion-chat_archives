local Ui = require('ui')

local ui = Ui
ui:appendLog('Interface Lua iniciada com sucesso.')
ui:printState()

print('\nCriando uma nova comunidade...')
ui:createCommunity('Comunidade Lua')
ui:printState()

print('\nCriando novo canal...')
ui:createChannel('dev-lua')
ui:printState()

print('\nEnviando mensagem de teste...')
ui:sendMessage('Olá do frontend Lua!')
ui:printState()
