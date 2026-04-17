let bridge = null;
let currentCommunityId = 'community-1';
let currentChannelId = 'channel-general';

const communityData = {
    'community-1': {
        name: 'Hyperion Hub',
        description: 'Comunidade self-hosted principal',
        channels: [
            { id: 'channel-general', name: '# geral' },
            { id: 'channel-announcements', name: '# anúncios' },
            { id: 'channel-help', name: '# ajuda' }
        ]
    },
    'community-2': {
        name: 'Canal DevOps',
        description: 'Servidor para devs e deploys',
        channels: [
            { id: 'channel-builds', name: '# builds' },
            { id: 'channel-tools', name: '# ferramentas' }
        ]
    }
};

function appendLog(message) {
    const output = document.getElementById('chat-output');
    const entry = document.createElement('div');
    entry.className = 'chat-message';
    entry.innerHTML = `<strong>${new Date().toLocaleTimeString()}</strong><span>${message}</span>`;
    output.appendChild(entry);
    output.scrollTop = output.scrollHeight;
}

function renderServers() {
    const serverList = document.getElementById('server-list');
    serverList.innerHTML = '';
    Object.keys(communityData).forEach((id) => {
        const community = communityData[id];
        const card = document.createElement('button');
        card.className = `server-card ${currentCommunityId === id ? 'active' : ''}`;
        card.innerHTML = `<strong>${community.name}</strong><span>${community.description}</span>`;
        card.addEventListener('click', () => selectCommunity(id));
        serverList.appendChild(card);
    });
}

function renderChannels() {
    const channelList = document.getElementById('channel-list');
    const community = communityData[currentCommunityId];
    channelList.innerHTML = '';
    community.channels.forEach((channel) => {
        const item = document.createElement('button');
        item.className = `channel-card ${currentChannelId === channel.id ? 'active' : ''}`;
        item.innerHTML = `<strong>${channel.name}</strong>`;
        item.addEventListener('click', () => selectChannel(channel.id));
        channelList.appendChild(item);
    });
}

function updateWorkspaceHeader() {
    const community = communityData[currentCommunityId];
    const channel = community.channels.find((c) => c.id === currentChannelId) || community.channels[0];
    document.getElementById('community-name').textContent = community.name;
    document.getElementById('community-status').textContent = community.description;
    document.getElementById('channel-title').textContent = channel ? channel.name : '# geral';
    document.getElementById('chat-subtitle').textContent = channel ? `Canal ${channel.name} ativo` : 'Selecione um canal.';
}

function selectCommunity(id) {
    currentCommunityId = id;
    const community = communityData[id];
    currentChannelId = community.channels[0].id;
    renderServers();
    renderChannels();
    updateWorkspaceHeader();
    appendLog(`Entrou na comunidade ${community.name}.`);
}

function selectChannel(id) {
    currentChannelId = id;
    renderChannels();
    updateWorkspaceHeader();
    appendLog(`Canal alterado para ${document.getElementById('channel-title').textContent}.`);
}

function createCommunity() {
    const name = prompt('Nome da nova comunidade:');
    if (!name || !name.trim()) {
        return;
    }
    const id = `community-${Date.now()}`;
    communityData[id] = {
        name: name.trim(),
        description: 'Comunidade self-hosted criada pelo usuário',
        channels: [ { id: `${id}-general`, name: '# geral' } ]
    };
    selectCommunity(id);
    renderServers();
    appendLog(`Comunidade '${name.trim()}' criada. Configure seu backend self-hosted para hospedar essa comunidade.`);
    if (bridge && bridge.createCommunity) {
        bridge.createCommunity(name.trim());
    }
}

function createChannel() {
    const name = prompt('Nome do novo canal (sem #):');
    if (!name || !name.trim()) {
        return;
    }
    const community = communityData[currentCommunityId];
    const channelId = `${currentCommunityId}-${Date.now()}`;
    community.channels.push({ id: channelId, name: `# ${name.trim()}` });
    renderChannels();
    selectChannel(channelId);
    appendLog(`Canal '# ${name.trim()}' criado na comunidade ${community.name}.`);
    if (bridge && bridge.createChannel) {
        bridge.createChannel(name.trim(), currentCommunityId);
    }
}

function updateProfile(nickname, status, online) {
    const profileName = document.getElementById('profile-name');
    const profileStatus = document.getElementById('profile-status');
    const profileOnline = document.getElementById('profile-online');
    if (profileName) {
        profileName.textContent = nickname;
    }
    if (profileStatus) {
        profileStatus.textContent = status;
    }
    if (profileOnline) {
        profileOnline.textContent = online ? 'Online' : 'Offline';
    }
}

function showError(message) {
    alert(message);
}

function setButtons() {
    const sendButton = document.getElementById('chat-send');
    if (sendButton) {
        sendButton.addEventListener('click', () => {
            const input = document.getElementById('chat-input');
            if (!input.value.trim()) {
                return;
            }
            const message = input.value.trim();
            appendLog(`Você: ${message}`);
            if (bridge && bridge.sendMessage) {
                bridge.sendMessage(message);
            }
            input.value = '';
        });
    }

    const uploadButton = document.getElementById('upload-media');
    if (uploadButton) {
        uploadButton.addEventListener('click', () => {
            if (bridge && bridge.uploadMedia) {
                bridge.uploadMedia();
            } else {
                appendLog('Upload de mídia não disponível no momento.');
            }
        });
    }

    const profileEdit = document.getElementById('profile-edit');
    if (profileEdit) {
        profileEdit.addEventListener('click', () => {
            if (bridge && bridge.editProfile) {
                bridge.editProfile();
            }
        });
    }

    const themeSwitch = document.getElementById('theme-switch');
    if (themeSwitch) {
        themeSwitch.addEventListener('click', () => {
            const theme = prompt('Digite um tema (md3, stealth ou default):', 'md3');
            if (theme && bridge && bridge.setTheme) {
                bridge.setTheme(theme);
            }
        });
    }

    const createCommunityButton = document.getElementById('create-community');
    if (createCommunityButton) {
        createCommunityButton.addEventListener('click', createCommunity);
    }

    const createChannelButton = document.getElementById('create-channel');
    if (createChannelButton) {
        createChannelButton.addEventListener('click', createChannel);
    }
}

window.addEventListener('DOMContentLoaded', () => {
    renderServers();
    renderChannels();
    updateWorkspaceHeader();

    if (typeof QWebChannel === 'undefined') {
        appendLog('Erro: QWebChannel não pôde ser carregado. Funcionalidade local ativada.');
        setButtons();
        return;
    }

    new QWebChannel(qt.webChannelTransport, function (channel) {
        bridge = channel.objects.bridge;
        if (bridge.appendLog) {
            bridge.appendLog.connect(appendLog);
        }
        if (bridge.updateProfile) {
            bridge.updateProfile.connect(updateProfile);
        }
        if (bridge.showError) {
            bridge.showError.connect(showError);
        }
        if (bridge.initialState) {
            bridge.initialState.connect(updateProfile);
            bridge.requestInitialState();
        }
        setButtons();
    });
});
