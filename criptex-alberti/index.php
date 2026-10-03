<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criptex Enigma - Disco Criptográfico</title>
    <!-- Iconos vectoriales y Fuentes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;800;900&family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <!-- Fondo de Taller de Madera / Metal -->
    <div class="workshop-bg"></div>

    <div class="criptex-app">
        <!-- Encabezado con Botones Visibles -->
        <header class="top-bar">
            <div class="brand">
                <i class="fa-solid fa-shield-halved brand-icon"></i>
                <h2>CRIPTEX ENIGMA</h2>
            </div>
            <div class="header-actions">
                <button id="open-encrypt-btn" class="action-btn encrypt-btn">
                    <i class="fa-solid fa-key"></i> Cifrar Secreto
                </button>
                <button id="open-explain-btn" class="action-btn explain-btn">
                    <i class="fa-solid fa-book-open"></i> Explicación
                </button>
                <button id="open-info-btn" class="action-btn info-btn">
                    <i class="fa-solid fa-circle-question"></i> Uso
                </button>
            </div>
        </header>

        <!-- Indicador Superior -->
        <div class="pointer-wrapper">
            <div class="pointer"></div>
        </div>

        <!-- Tablero Criptex Vectorial SVG -->
        <div class="board-wrapper">
            <svg id="criptex-svg" viewBox="0 0 500 500" width="100%" height="100%">
                <defs>
                    <radialGradient id="grad-outer" cx="50%" cy="50%" r="50%">
                        <stop offset="60%" stop-color="#120e09"/>
                        <stop offset="65%" stop-color="#b88d3b"/>
                        <stop offset="85%" stop-color="#e8c26b"/>
                        <stop offset="98%" stop-color="#7a581e"/>
                        <stop offset="100%" stop-color="#120e09"/>
                    </radialGradient>

                    <radialGradient id="grad-mid" cx="50%" cy="50%" r="50%">
                        <stop offset="55%" stop-color="#120e09"/>
                        <stop offset="60%" stop-color="#99732b"/>
                        <stop offset="85%" stop-color="#d4aa4c"/>
                        <stop offset="98%" stop-color="#614413"/>
                        <stop offset="100%" stop-color="#120e09"/>
                    </radialGradient>

                    <radialGradient id="grad-inner" cx="50%" cy="50%" r="50%">
                        <stop offset="45%" stop-color="#120e09"/>
                        <stop offset="52%" stop-color="#805d1d"/>
                        <stop offset="85%" stop-color="#c4993d"/>
                        <stop offset="98%" stop-color="#4a330a"/>
                        <stop offset="100%" stop-color="#120e09"/>
                    </radialGradient>
                </defs>

                <!-- Anillo Exterior -->
                <g id="group-outer" class="ring-group">
                    <circle cx="250" cy="250" r="230" fill="url(#grad-outer)" stroke="#000" stroke-width="2"/>
                    <g id="text-outer"></g>
                </g>

                <!-- Anillo Medio -->
                <g id="group-middle" class="ring-group">
                    <circle cx="250" cy="250" r="165" fill="url(#grad-mid)" stroke="#000" stroke-width="2"/>
                    <g id="text-middle"></g>
                </g>

                <!-- Anillo Interior -->
                <g id="group-inner" class="ring-group">
                    <circle cx="250" cy="250" r="100" fill="url(#grad-inner)" stroke="#000" stroke-width="2"/>
                    <g id="text-inner"></g>
                </g>
            </svg>

            <!-- Candado Central -->
            <button id="unlock-btn" class="center-unlock-btn" title="Verificar combinación">
                <div class="inner-lock-circle">
                    <i id="lock-icon" class="fa-solid fa-lock"></i>
                </div>
            </button>
        </div>

        <!-- Lectura de combinación -->
        <div class="combo-display">
            Alineación actual: <strong id="live-combo">A - 1 - α</strong>
        </div>

        <!-- Tarjeta de Resultado -->
        <div id="result-box" class="result-card hidden">
            <span id="result-badge" class="badge">ESTADO</span>
            <h3 id="result-title">Título</h3>
            <p id="result-text">Mensaje del servidor</p>
        </div>
    </div>

    <!-- MODAL 1: CIFRAR NUEVO SECRETO -->
    <div id="encrypt-modal" class="modal-overlay hidden">
        <div class="modal-box">
            <button id="close-encrypt-modal" class="modal-close-btn">&times;</button>
            <div class="modal-header">
                <i class="fa-solid fa-wand-magic-sparkles"></i>
                <h3>Cifrar Nuevo Secreto</h3>
            </div>
            <form id="encrypt-form" class="modal-form">
                <div class="form-group">
                    <label>Escribe el mensaje que deseas ocultar:</label>
                    <textarea id="secret-input" placeholder="Ejemplo: El mapa del tesoro está escondido tras el cuadro..." rows="4" required></textarea>
                </div>

                <button type="submit" id="save-secret-btn" class="btn-primary">
                    <i class="fa-solid fa-gears"></i> Generar Combinación y Cifrar
                </button>
            </form>

            <div id="generated-key-box" class="generated-box hidden">
                <span class="badge badge-success">COMBINACIÓN MATEMÁTICA GENERADA</span>
                <h1 id="generated-key-text"></h1>
                <p>Usa la lógica de los tres anillos: alinea esta clave en la flecha superior para desbloquear el secreto.</p>
            </div>
        </div>
    </div>

    <!-- MODAL 2: EXPLICACIÓN PASO A PASO DEL CIFRADO -->
    <div id="explain-modal" class="modal-overlay hidden">
        <div class="modal-box modal-large">
            <button id="close-explain-modal" class="modal-close-btn">&times;</button>
            <div class="modal-header">
                <i class="fa-solid fa-graduation-cap"></i>
                <h3>¿Cómo Funciona el Cifrado? (Sencillo y Paso a Paso)</h3>
            </div>
            <div class="modal-content text-left">
                
                <div class="concept-card">
                    <h4>💡 La Idea Principal</h4>
                    <p>Imagina que tu mensaje es una carta secreta. Para que nadie pueda leerla si se la roban, la metemos en una <strong>caja fuerte</strong> que solo abre con una combinación de 3 símbolos.</p>
                </div>

                <h4 class="section-title">🔍 Ejemplo con el mensaje: "HOLA"</h4>

                <div class="step-box">
                    <div class="step-header">
                        <span class="step-badge">Paso 1</span>
                        <strong>Matemáticas del Mensaje</strong>
                    </div>
                    <p>Cuando escribes <code>"HOLA"</code>, el sistema calcula el "peso" numérico de cada letra. Con esa fórmula matemática única, determina qué símbolos de los discos se usarán. Para "HOLA", la clave resultante es <strong><code>D - 8 - Ω</code></strong>.</p>
                </div>

                <div class="step-box">
                    <div class="step-header">
                        <span class="step-badge">Paso 2</span>
                        <strong>Cifrado de Alta Seguridad (AES-256)</strong>
                    </div>
                    <p>En el servidor, PHP mezcla el mensaje <code>"HOLA"</code> con la clave <strong><code>D - 8 - Ω</code></strong> y lo transforma en un código indescifrable: <code>8vH2JpX1Z3e9...</code>. Nadie puede leerlo, ni siquiera revisando la base de datos.</p>
                </div>

                <div class="step-box">
                    <div class="step-header">
                        <span class="step-badge">Paso 3</span>
                        <strong>Alineación en los Discos</strong>
                    </div>
                    <p>Tú o la persona a quien le compartas el secreto giran los anillos en la pantalla hasta colocar <strong><code>D</code></strong> en la rueda exterior, <strong><code>8</code></strong> en la del medio y <strong><code>Ω</code></strong> en la del centro bajo la flecha roja.</p>
                </div>

                <div class="step-box">
                    <div class="step-header">
                        <span class="step-badge">Paso 4</span>
                        <strong>Desbloqueo</strong>
                    </div>
                    <p>Al presionar el candado central, el servidor verifica que los tres discos coincidan. Al ser correctos, deshace el cifrado y te entrega de vuelta la palabra original: <strong><code>"HOLA"</code></strong>.</p>
                </div>

            </div>
            <button id="confirm-explain-btn" class="btn-primary">¡Entendido, está clarísimo!</button>
        </div>
    </div>

    <!-- MODAL 3: USO RÁPIDO -->
    <div id="info-modal" class="modal-overlay hidden">
        <div class="modal-box">
            <button id="close-modal-btn" class="modal-close-btn">&times;</button>
            <div class="modal-header">
                <i class="fa-solid fa-gears"></i>
                <h3>Guía Rápida de Uso</h3>
            </div>
            <div class="modal-content">
                <div class="guide-step">
                    <i class="fa-solid fa-hand-pointer step-icon"></i>
                    <div>
                        <h4>1. Haz clic y Gira</h4>
                        <p>Presiona cualquiera de los tres anillos metálicos para rotar sus caracteres.</p>
                    </div>
                </div>
                <div class="guide-step">
                    <i class="fa-solid fa-arrows-to-dot step-icon"></i>
                    <div>
                        <h4>2. Guía Superior</h4>
                        <p>La clave activa es la que queda alineada bajo el triángulo rojo superior.</p>
                    </div>
                </div>
                <div class="guide-step">
                    <i class="fa-solid fa-lock step-icon"></i>
                    <div>
                        <h4>3. Desbloqueo Seguro</h4>
                        <p>Haz clic en el candado central para comprobar la clave contra MySQL.</p>
                    </div>
                </div>
            </div>
            <button id="confirm-modal-btn" class="btn-primary">¡Entendido!</button>
        </div>
    </div>

    <script src="app.js"></script>
</body>
</html>