<?php
$cssFile = __DIR__ . '/css/style.css';
if (isset($_GET['dev'])) {
    $cssFile = __DIR__ . '/css/dev.css';
}

if (!file_exists($cssFile)) {
    header('HTTP/1.1 404 Not Found');
    echo 'Arquivo CSS não encontrado.';
    exit;
}

$downloadName = basename($cssFile);
header('Content-Type: text/css');
header('Content-Disposition: attachment; filename="' . $downloadName . '"');
header('Content-Length: ' . filesize($cssFile));
readfile($cssFile);
exit;
