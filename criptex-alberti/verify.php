<?php
header('Content-Type: application/json');
require_once 'db.php';

// Recibir la combinación del frontend
$input = json_decode(file_get_contents('php://input'), true);
$userKey = $input['key'] ?? '';
$userIp = $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1';

if (empty($userKey)) {
    echo json_encode(['success' => false, 'message' => 'Combinación no proporcionada']);
    exit;
}

// 1. Calcular el Hash SHA-256 de la combinación introducida
$userKeyHash = hash('sha256', $userKey);

// 2. Buscar el secreto correspondiente en la BD mediante consultas preparadas (Protección Anti SQL Injection)
$stmt = $pdo->prepare("SELECT * FROM secrets WHERE key_hash = :key_hash LIMIT 1");
$stmt->execute(['key_hash' => $userKeyHash]);
$secretRecord = $stmt->fetch();

$isSuccess = false;
$decryptedMessage = '';

if ($secretRecord) {
    // 3. Si el hash coincide, intentamos la desencriptación criptográfica con AES-256
    $cipherMethod = "AES-256-CBC";
    $encryptionKey = hash('sha256', $userKey); // Clave simétrica derivada
    $iv = $secretRecord['iv'];

    $decryptedAttempt = openssl_decrypt($secretRecord['encrypted_content'], $cipherMethod, $encryptionKey, 0, $iv);

    if ($decryptedAttempt !== false) {
        $isSuccess = true;
        $decryptedMessage = $decryptedAttempt;
    }
}

// 4. Registrar la auditoría del intento en la BD
$logStmt = $pdo->prepare("INSERT INTO access_logs (attempted_key, is_success, ip_address) VALUES (:key, :success, :ip)");
$logStmt->execute([
    'key' => $userKey,
    'success' => $isSuccess ? 1 : 0,
    'ip' => $userIp
]);

// 5. Responder al cliente en el frontend
if ($isSuccess) {
    echo json_encode([
        'success' => true,
        'message' => $decryptedMessage
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Combinación o secuencia de descifrado fallida.'
    ]);
}
?>