const SERVER_ENDPOINT: string = 'http://127.0.0.1:8080';

type Message = {
    user: string;
    text: string;
};

const state: {
    activeChannel: string;
    channels: string[];
    members: string[];
    messages: Message[];
} = {
    activeChannel: '# geral',
    channels: ['# geral', '# anúncios', '# ajuda'],
    members: ['Neo', 'Trinity', 'Morpheus'],
    messages: [
        { user: 'Hyperion', text: 'Bem-vindo à sua comunidade self-hosted.' }
    ]
};

function renderChannelList(): void {
    const channelList = document.getElementById('channel-list');
    if (!channelList) return;
    channelList.innerHTML = '';
    state.channels.forEach((channel) => {
        const item = document.createElement('li');
        item.textContent = channel;
        item.className = channel === state.activeChannel ? 'active' : '';
        item.addEventListener('click', () => selectChannel(channel));
        channelList.appendChild(item);
    });
}

function renderMemberList(): void {
    const memberList = document.getElementById('member-list');
    if (!memberList) return;
    memberList.innerHTML = '';
    state.members.forEach((member) => {
        const item = document.createElement('li');
        item.textContent = member;
        memberList.appendChild(item);
    });
}

function renderMessages(): void {
    const chatLog = document.getElementById('chat-log');
    if (!chatLog) return;
    chatLog.innerHTML = '';
    state.messages.forEach((message) => {
        const bubble = document.createElement('div');
        bubble.className = 'chat-message';
        bubble.innerHTML = `<strong>${message.user}</strong><span>${message.text}</span>`;
        chatLog.appendChild(bubble);
    });
}

function selectChannel(channel: string): void {
    state.activeChannel = channel;
    const activeChannel = document.getElementById('active-channel');
    if (activeChannel) {
        activeChannel.textContent = channel;
    }
    renderChannelList();
}

function sendMessage(text: string): void {
    if (!text.trim()) return;
    state.messages.push({ user: 'Você', text });
    renderMessages();
}

function setupEvents(): void {
    const chatForm = document.getElementById('chat-form');
    if (chatForm) {
        chatForm.addEventListener('submit', (event: Event) => {
            event.preventDefault();
            const input = document.getElementById('chat-input') as HTMLInputElement | null;
            if (!input) return;
            sendMessage(input.value);
            input.value = '';
        });
    }

    const refreshButton = document.getElementById('refresh-chat');
    if (refreshButton) {
        refreshButton.addEventListener('click', () => {
            console.log('Refresh chat requested');
        });
    }

    const createChannelButton = document.getElementById('create-channel');
    if (createChannelButton) {
        createChannelButton.addEventListener('click', () => {
            const name = prompt('Nome do novo canal:');
            if (!name) return;
            state.channels.push(`# ${name}`);
            renderChannelList();
        });
    }
}

window.addEventListener('DOMContentLoaded', () => {
    renderChannelList();
    renderMemberList();
    renderMessages();
    setupEvents();
});
