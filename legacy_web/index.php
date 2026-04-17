<?php
session_start();
if (!isset($_SESSION['chat'])) {
    $_SESSION['chat'] = array();
}

if (isset($_POST['send']) && strlen($_POST['message'])) {
    $message = strip_tags(trim($_POST['message']));
    if ($message !== '') {
        $_SESSION['chat'][] = array(
            'user' => 'Você',
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
    <title>Project Hyperion Legacy</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="page">
        <h1>Project Hyperion Legacy</h1>
        <p>Versão antiga para navegadores legados. Funciona com HTML/PHP simples e com CSS básico.</p>
        <div class="toolbar">
            <a href="dev.php">Modo Dev</a> | <a href="download_css.php">Baixar CSS</a>
        </div>
        <div class="chat-box">
            <h2>Chat simples</h2>
            <?php if (count($_SESSION['chat']) === 0): ?>
                <p class="info">Nenhuma mensagem ainda. Digite abaixo para testar.</p>
            <?php else: ?>
                <?php foreach ($_SESSION['chat'] as $msg): ?>
                    <?php echo renderMessage($msg); ?>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
        <form method="post" action="index.php" class="chat-form">
            <label for="message">Mensagem:</label>
            <input type="text" name="message" id="message" maxlength="240" value="" />
            <input type="submit" name="send" value="Enviar" />
        </form>
        <p class="footer">Esta página é uma versão legada para teste local e modificação.</p>
    </div>
</body>
</html>
