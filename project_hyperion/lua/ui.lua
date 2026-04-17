-- Lua port da interface de comunidades e canais do Project Hyperion
local Ui = {
    currentCommunityId = 'community-1',
    currentChannelId = 'channel-general',
    logs = {}
}

Ui.communityData = {
    ['community-1'] = {
        name = 'Hyperion Hub',
        description = 'Comunidade self-hosted principal',
        channels = {
            { id = 'channel-general', name = '# geral' },
            { id = 'channel-announcements', name = '# anúncios' },
            { id = 'channel-help', name = '# ajuda' }
        }
    },
    ['community-2'] = {
        name = 'Canal DevOps',
        description = 'Servidor para devs e deploys',
        channels = {
            { id = 'channel-builds', name = '# builds' },
            { id = 'channel-tools', name = '# ferramentas' }
        }
    }
}

local function findChannel(communityId, channelId)
    local community = Ui.communityData[communityId]
    if not community then
        return nil
    end
    for _, channel in ipairs(community.channels) do
        if channel.id == channelId then
            return channel
        end
    end
    return nil
end

function Ui:appendLog(message)
    local timestamp = os.date('%H:%M:%S')
    table.insert(self.logs, ('[%s] %s'):format(timestamp, message))
end

function Ui:renderServers()
    for id, community in pairs(self.communityData) do
        local active = (id == self.currentCommunityId) and ' *' or ''
        print(('  %s%s - %s'):format(community.name, active, community.description))
    end
end

function Ui:renderChannels()
    local community = self.communityData[self.currentCommunityId]
    if not community then
        return
    end
    for _, channel in ipairs(community.channels) do
        local active = (channel.id == self.currentChannelId) and ' *' or ''
        print(('  %s%s'):format(channel.name, active))
    end
end

function Ui:updateWorkspaceHeader()
    local community = self.communityData[self.currentCommunityId]
    if not community then
        return
    end
    local channel = findChannel(self.currentCommunityId, self.currentChannelId)
    print(('Comunidade: %s'):format(community.name))
    print(('Descrição: %s'):format(community.description))
    print(('Canal ativo: %s'):format(channel and channel.name or '# geral'))
end

function Ui:selectCommunity(id)
    local community = self.communityData[id]
    if not community then
        self:appendLog(('Falha ao selecionar comunidade %s'):format(id))
        return
    end
    self.currentCommunityId = id
    self.currentChannelId = community.channels[1] and community.channels[1].id or nil
    self:appendLog(('Entrou na comunidade %s.'):format(community.name))
end

function Ui:selectChannel(id)
    local channel = findChannel(self.currentCommunityId, id)
    if not channel then
        self:appendLog(('Canal %s não encontrado.'):format(id))
        return
    end
    self.currentChannelId = id
    self:appendLog(('Canal alterado para %s.'):format(channel.name))
end

function Ui:createCommunity(name)
    if not name or name == '' then
        return
    end
    local id = ('community-%d'):format(os.time())
    self.communityData[id] = {
        name = name,
        description = 'Comunidade self-hosted criada pelo usuário',
        channels = { { id = id .. '-general', name = '# geral' } }
    }
    self:selectCommunity(id)
    self:appendLog(('Comunidade %q criada.'):format(name))
end

function Ui:createChannel(name)
    if not name or name == '' then
        return
    end
    local community = self.communityData[self.currentCommunityId]
    if not community then
        return
    end
    local channelId = self.currentCommunityId .. '-' .. tostring(os.time())
    table.insert(community.channels, { id = channelId, name = '# ' .. name })
    self.currentChannelId = channelId
    self:appendLog(('Canal # %s criado na comunidade %s.'):format(name, community.name))
end

function Ui:sendMessage(message)
    if not message or message == '' then
        return
    end
    self:appendLog(('Você: %s'):format(message))
end

function Ui:printState()
    print('=== Estado da interface Lua ===')
    self:updateWorkspaceHeader()
    print('Comunidades:')
    self:renderServers()
    print('Canais no servidor atual:')
    self:renderChannels()
    print('Logs recentes:')
    for _, line in ipairs(self.logs) do
        print('  ' .. line)
    end
    print('================================')
end

return Ui
