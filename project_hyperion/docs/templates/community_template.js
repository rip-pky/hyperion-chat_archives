const SERVER_ENDPOINT = 'http://127.0.0.1:8080';

const state = {
    activeChannel: '# geral',
    channels: ['# geral', '# anúncios', '# ajuda'],
    members: ['Neo', 'Trinity', 'Morpheus'],
    messages: [
        { user: 'Hyperion', text: 'Bem-vindo à sua comunidade self-hosted.' }
    ]
};

function renderChannelList() {
    const channelList = document.getElementById('channel-list');
    channelList.innerHTML = '';
    state.channels.forEach((channel) => {
        const item = document.createElement('li');
        item.textContent = channel;
        item.className = channel === state.activeChannel ? 'active' : '';
        item.addEventListener('click', () => selectChannel(channel));
        channelList.appendChild(item);
    });
}

function renderMemberList() {
    const memberList = document.getElementById('member-list');
    memberList.innerHTML = '';
    state.members.forEach((member) => {
        const item = document.createElement('li');
        item.textContent = member;
        memberList.appendChild(item);
    });
}

function renderMessages() {
    const chatLog = document.getElementById('chat-log');
    chatLog.innerHTML = '';
    state.messages.forEach((message) => {
        const bubble = document.createElement('div');
        bubble.className = 'chat-message';
        bubble.innerHTML = `<strong>${message.user}</strong><span>${message.text}</span>`;
        chatLog.appendChild(bubble);
    });
}

function selectChannel(channel) {
    state.activeChannel = channel;
    document.getElementById('active-channel').textContent = channel;
    renderChannelList();
}

function sendMessage(text) {
    if (!text.trim()) return;
    state.messages.push({ user: 'Você', text });
    renderMessages();
}

function setupEvents() {
    document.getElementById('chat-form').addEventListener('submit', (event) => {
        event.preventDefault();
        const input = document.getElementById('chat-input');
        sendMessage(input.value);
        input.value = '';
    });

    document.getElementById('refresh-chat').addEventListener('click', () => {
        console.log('Refresh chat requested');
    });

    document.getElementById('create-channel').addEventListener('click', () => {
        const name = prompt('Nome do novo canal:');
        if (!name) return;
        state.channels.push(`# ${name}`);
        renderChannelList();
    });
}

window.addEventListener('DOMContentLoaded', () => {
    renderChannelList();
    renderMemberList();
    renderMessages();
    setupEvents();
});
