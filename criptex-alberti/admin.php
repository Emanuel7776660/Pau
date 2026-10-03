<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
require_once 'db.php';

$mensajeEstado = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $c1 = trim($_POST['c1'] ?? 'A');
    $c2 = trim($_POST['c2'] ?? '1');
    $c3 = trim($_POST['c3'] ?? 'α');
    $mensaje = trim($_POST['mensaje'] ?? '');

    $claveFormada = "$c1-$c2-$c3";

    if (!empty($mensaje)) {
        // Cifrado criptográfico con la combinación elegida
        $keyHash = hash('sha256', $claveFormada);
        $cipherMethod = "AES-256-CBC";
        $encryptionKey = hash('sha256', $claveFormada);
        $iv = substr(hash('sha256', 'VectorInizializacionUnico123'), 0, 16);

        $mensajeCifrado = openssl_encrypt($mensaje, $cipherMethod, $encryptionKey, 0, $iv);

        // Actualizar en MySQL
        $pdo->query("TRUNCATE TABLE secrets");
        $stmt = $pdo->prepare("INSERT INTO secrets (key_hash, encrypted_content, iv) VALUES (:hash, :content, :iv)");
        $stmt->execute([
            'hash' => $keyHash,
            'content' => $mensajeCifrado,
            'iv' => $iv
        ]);

        $mensajeEstado = " ¡Nuevo mensaje cifrado guardado con éxito! Clave requerida: <strong>$claveFormada</strong>";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Cifrado - Criptex Enigma</title>
    <style>
        body { background: #0b0907; color: #f0e6d2; font-family: sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .box { background: #17120b; border: 1px solid #e5b842; padding: 25px; border-radius: 10px; width: 100%; max-width: 400px; text-align: center; }
        select, textarea, button { width: 100%; margin-top: 10px; padding: 10px; border-radius: 5px; border: 1px solid #e5b842; background: #0b0907; color: #fff; }
        button { background: #e5b842; color: #000; font-weight: bold; cursor: pointer; }
        .status { margin-bottom: 15px; color: #4CAF50; font-size: 0.9rem; }
    </style>
</head>
<body>
    <div class="box">
        <h2>🔒 Cifrar Nuevo Mensaje</h2>
        <?php if ($mensajeEstado): ?>
            <div class="status"><?= $mensajeEstado ?></div>
        <?php endif; ?>
        <form method="POST">
            <label>Selecciona la clave de 3 anillos:</label>
            <div style="display: flex; gap: 5px;">
                <select name="c1">
                    <?php foreach(["A","B","C","D","E","F","G","H","I","J","K","L"] as $c): ?>
                        <option value="<?= $c ?>"><?= $c ?></option>
                    <?php endforeach; ?>
                </select>
                <select name="c2">
                    <?php foreach(["1","2","3","4","5","6","7","8","9","0","#","*"] as $c): ?>
                        <option value="<?= $c ?>"><?= $c ?></option>
                    <?php endforeach; ?>
                </select>
                <select name="c3">
                    <?php foreach(["α","β","γ","δ","Ω","Ψ","Σ","Δ","π","λ","θ","∞"] as $c): ?>
                        <option value="<?= $c ?>"><?= $c ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            
            <textarea name="mensaje" placeholder="Escribe el mensaje cifrado aquí..." rows="4" required></textarea>
            <button type="submit">Guardar y Cifrar en BD</button>
        </form>
        <br>
        <a href="index.php" style="color: #e5b842; text-decoration: none; font-size: 0.85rem;">← Volver al Criptex</a>
    </div>
</body>
</html>