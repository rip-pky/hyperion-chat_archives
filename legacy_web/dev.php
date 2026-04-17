<?php
session_start();
if (!isset($_SESSION['chat'])) {
    $_SESSION['chat'] = array();
}

if (isset($_POST['debug_clear'])) {
    $_SESSION['chat'] = array();
}

if (isset($_POST['send']) && strlen($_POST['message'])) {
    $message = strip_tags(trim($_POST['message']));
    if ($message !== '') {
        $_SESSION['chat'][] = array(
            'user' => 'Dev',
            'text' => $message,
            'time' => date('H:i:s')
        );
    }
}

function renderMessage($message) {
    return '<div class="message"><strong>' . htmlspecialchars($message['user']) . '</strong>: ' . htmlspecialchars($message['text']) . ' <span>(' . $message['time'] . ')</span></div>';
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="pt-BR">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Project Hyperion Dev</title>
    <link rel="stylesheet" type="text/css" href="css/dev.css">
</head>
<body>
    <div class="page">
        <h1>Project Hyperion Dev</h1>
        <p>Ambiente de desenvolvimento. Use esta versão para testes, personalização de mods e debugging.</p>
        <div class="toolbar">
            <a href="index.php">Modo Legacy</a> | <a href="download_css.php?dev=1">Baixar CSS de dev</a>
        </div>
        <div class="chat-box">
            <h2>Chat de desenvolvimento</h2>
            <?php if (count($_SESSION['chat']) === 0): ?>
                <p class="info">Nenhuma mensagem ainda. Use o formulário para enviar texto.</p>
            <?php else: ?>
                <?php foreach ($_SESSION['chat'] as $msg): ?>
                    <?php echo renderMessage($msg); ?>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
        <form method="post" action="dev.php" class="chat-form">
            <label for="message">Mensagem:</label>
            <input type="text" name="message" id="message" maxlength="240" value="" />
            <input type="submit" name="send" value="Enviar" />
            <input type="submit" name="debug_clear" value="Limpar chat" />
        </form>
        <div class="debug-panel">
            <h3>Debug</h3>
            <p>Versão: <strong>DEV</strong></p>
            <p>Sessão ID: <?php echo htmlspecialchars(session_id()); ?></p>
            <p>Mensagens armazenadas: <?php echo count($_SESSION['chat']); ?></p>
        </div>
    </div>
</body>
</html>
