<?php
$communityName = 'Hyperion Nexus';
$communityDescription = 'Rede self-hosted para conversas privadas e moderadas.';
$channels = ['# geral', '# anúncios', '# ajuda'];
$members = ['Neo', 'Trinity', 'Morpheus'];
$messages = [
    ['user' => 'Hyperion', 'text' => 'Bem-vindo à sua comunidade self-hosted.'],
];
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?= htmlspecialchars($communityName) ?></title>
    <link rel="stylesheet" href="community_template.css" />
</head>
<body>
    <div class="app-shell">
        <header class="community-header">
            <div class="community-meta">
                <div class="community-avatar"></div>
                <div>
                    <h1><?= htmlspecialchars($communityName) ?></h1>
                    <p><?= htmlspecialchars($communityDescription) ?></p>
                </div>
            </div>
            <div class="community-banner">BANNER DA COMUNIDADE</div>
        </header>

        <aside class="sidebar">
            <section class="section">
                <h2>Canais</h2>
                <ul class="channel-list">
                    <?php foreach ($channels as $channel): ?>
                        <li><?= htmlspecialchars($channel) ?></li>
                    <?php endforeach; ?>
                </ul>
            </section>
            <section class="section">
                <h2>Membros</h2>
                <ul class="member-list">
                    <?php foreach ($members as $member): ?>
                        <li><?= htmlspecialchars($member) ?></li>
                    <?php endforeach; ?>
                </ul>
            </section>
        </aside>

        <main class="chat-area">
            <section class="chat-topbar">
                <div>
                    <h2># geral</h2>
                    <p>Chat central da comunidade</p>
                </div>
            </section>
            <section class="chat-log">
                <?php foreach ($messages as $message): ?>
                    <div class="chat-message">
                        <strong><?= htmlspecialchars($message['user']) ?></strong>
                        <span><?= htmlspecialchars($message['text']) ?></span>
                    </div>
                <?php endforeach; ?>
            </section>
            <form class="chat-form" method="post">
                <input name="message" type="text" placeholder="Digite sua mensagem..." autocomplete="off" />
                <button type="submit">Enviar</button>
            </form>
        </main>
    </div>
</body>
</html>
