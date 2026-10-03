<?php
ini_set('display_errors', 0);
error_reporting(E_ALL);

header('Content-Type: application/json; charset=utf-8');

try {
    if (!file_exists('db.php')) {
        throw new Exception("El archivo db.php no existe.");
    }
    require_once 'db.php';

    $rawInput = file_get_contents('php://input');
    $input = json_decode($rawInput, true);

    $message = trim($input['message'] ?? '');

    if (empty($message)) {
        echo json_encode(['success' => false, 'message' => 'Debes escribir un mensaje para cifrar.']);
        exit;
    }

    // Caracteres por cada anillo
    $outerChars  = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
    $middleChars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "#", "*"];
    $innerChars  = ["α", "β", "γ", "δ", "Ω", "Ψ", "Σ", "Δ", "π", "λ", "θ", "∞"];

    // === LÓGICA DETERMINISTA MÁTEMÁTICA BASADA EN EL MENSAJE ===
    $length = mb_strlen($message, 'UTF-8');
    
    $asciiSum = 0;
    for ($i = 0; $i < $length; $i++) {
        $asciiSum += ord($message[$i]);
    }

    // Cálculo matemático de posición en los 3 anillos (Módulo 12)
    $idx1 = $asciiSum % 12;
    $idx2 = ($length * $asciiSum) % 12;
    
    $firstAscii = ord($message[0]);
    $lastAscii  = ord($message[$length - 1]);
    $idx3 = ($firstAscii + $lastAscii + $length) % 12;

    $c1 = $outerChars[$idx1];
    $c2 = $middleChars[$idx2];
    $c3 = $innerChars[$idx3];

    $derivedKey = "$c1-$c2-$c3";

    // === CIFRADO AES-256 ===
    $keyHash = hash('sha256', $derivedKey);
    $cipherMethod = "AES-256-CBC";
    $encryptionKey = hash('sha256', $derivedKey);
    $iv = substr(hash('sha256', 'VectorInicializacionUnico123'), 0, 16);

    $encryptedContent = openssl_encrypt($message, $cipherMethod, $encryptionKey, 0, $iv);

    if ($encryptedContent === false) {
        throw new Exception("Error al ejecutar OpenSSL.");
    }

    // Guardar en MySQL
    $pdo->exec("DELETE FROM secrets");

    $stmt = $pdo->prepare("INSERT INTO secrets (key_hash, encrypted_content, iv) VALUES (:hash, :content, :iv)");
    $stmt->execute([
        'hash' => $keyHash,
        'content' => $encryptedContent,
        'iv' => $iv
    ]);

    echo json_encode([
        'success' => true,
        'key' => $derivedKey,
        'message' => '¡Mensaje cifrado exitosamente!'
    ]);

} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>