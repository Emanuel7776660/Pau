document.addEventListener('DOMContentLoaded', () => {
    const outerChars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
    const middleChars = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "#", "*"];
    const innerChars = ["α", "β", "γ", "δ", "Ω", "Ψ", "Σ", "Δ", "π", "λ", "θ", "∞"];

    const state = { outer: 0, middle: 0, inner: 0 };
    const center = 250;

    function renderSVGText(containerId, chars, radius) {
        const container = document.getElementById(containerId);
        const total = chars.length;
        const angleStep = 360 / total;

        chars.forEach((char, index) => {
            const angleDeg = index * angleStep;
            const angleRad = (angleDeg - 90) * (Math.PI / 180);

            const x = center + radius * Math.cos(angleRad);
            const y = center + radius * Math.sin(angleRad);

            const textNode = document.createElementNS("http://www.w3.org/2000/svg", "text");
            textNode.setAttribute("x", x);
            textNode.setAttribute("y", y);
            textNode.setAttribute("class", "ring-text");
            textNode.setAttribute("transform", `rotate(${angleDeg}, ${x}, ${y})`);
            textNode.textContent = char;

            container.appendChild(textNode);
        });
    }

    renderSVGText('text-outer', outerChars, 195);
    renderSVGText('text-middle', middleChars, 132);
    renderSVGText('text-inner', innerChars, 75);

    function setupRingRotation(groupId, key) {
        const group = document.getElementById(groupId);
        group.addEventListener('click', () => {
            state[key] = (state[key] + 30) % 360;
            group.style.transform = `rotate(${state[key]}deg)`;
            updateComboDisplay();
        });
    }

    setupRingRotation('group-outer', 'outer');
    setupRingRotation('group-middle', 'middle');
    setupRingRotation('group-inner', 'inner');

    function getTopChar(chars, angle) {
        const total = chars.length;
        const step = 360 / total;
        let normalizedAngle = (360 - (angle % 360)) % 360;
        let index = Math.round(normalizedAngle / step) % total;
        return chars[index];
    }

    function updateComboDisplay() {
        const c1 = getTopChar(outerChars, state.outer);
        const c2 = getTopChar(middleChars, state.middle);
        const c3 = getTopChar(innerChars, state.inner);
        document.getElementById('live-combo').innerText = `${c1} - ${c2} - ${c3}`;
    }

    // MODAL ¿CÓMO FUNCIONA?
    const infoModal = document.getElementById('info-modal');
    document.getElementById('open-info-btn').onclick = () => infoModal.classList.remove('hidden');
    document.getElementById('close-modal-btn').onclick = () => infoModal.classList.add('hidden');
    document.getElementById('confirm-modal-btn').onclick = () => infoModal.classList.add('hidden');

    // MODAL CIFRAR SECRETO
    const encryptModal = document.getElementById('encrypt-modal');
    document.getElementById('open-encrypt-btn').onclick = () => {
        document.getElementById('generated-key-box').classList.add('hidden');
        encryptModal.classList.remove('hidden');
    };
    document.getElementById('close-encrypt-modal').onclick = () => encryptModal.classList.add('hidden');

    // MODAL DE EXPLICACIÓN PASO A PASO
    const explainModal = document.getElementById('explain-modal');
    document.getElementById('open-explain-btn').onclick = () => explainModal.classList.remove('hidden');
    document.getElementById('close-explain-modal').onclick = () => explainModal.classList.add('hidden');
    document.getElementById('confirm-explain-btn').onclick = () => explainModal.classList.add('hidden');
    
    // CIFRADO AUTOMÁTICO
    document.getElementById('encrypt-form').addEventListener('submit', async (e) => {
        e.preventDefault();
        
        const message = document.getElementById('secret-input').value;
        const keyBox = document.getElementById('generated-key-box');
        const keyText = document.getElementById('generated-key-text');

        try {
            const res = await fetch('save_secret.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message })
            });

            const data = await res.json();
            
            if (data.success) {
                keyText.innerText = data.key;
                keyBox.classList.remove('hidden');
                document.getElementById('secret-input').value = '';
            } else {
                alert(`❌ Error: ${data.message}`);
            }
        } catch (err) {
            console.error("Error al cifrar:", err);
        }
    });

    // VERIFICACIÓN CON CANDADO CENTRAL
    document.getElementById('unlock-btn').addEventListener('click', async () => {
        const c1 = getTopChar(outerChars, state.outer);
        const c2 = getTopChar(middleChars, state.middle);
        const c3 = getTopChar(innerChars, state.inner);
        const key = `${c1}-${c2}-${c3}`;

        try {
            const response = await fetch('verify.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ key })
            });

            const data = await response.json();
            const box = document.getElementById('result-box');
            const badge = document.getElementById('result-badge');
            const icon = document.getElementById('lock-icon');

            box.classList.remove('hidden');

            if (data.success) {
                icon.className = "fa-solid fa-lock-open";
                box.style.borderColor = "#4CAF50";
                badge.className = "badge badge-success";
                badge.innerText = "ACCESO PERMITIDO";
                document.getElementById('result-title').innerText = "Secreto Desbloqueado";
                document.getElementById('result-text').innerText = data.message;
            } else {
                icon.className = "fa-solid fa-lock";
                box.style.borderColor = "#f44336";
                badge.className = "badge";
                badge.style.background = "#f44336";
                badge.style.color = "#fff";
                badge.innerText = "BLOQUEADO";
                document.getElementById('result-title').innerText = "Combinación Incorrecta";
                document.getElementById('result-text').innerText = "La clave enviada no coincide con la base de datos.";
            }
        } catch (err) {
            console.error("Error al conectar con verify.php", err);
        }
    });
});