import tkinter as tk
from tkinter import messagebox
from tkinter import ttk

# --- Funciones de Lógica ---

def actualizar_costo_aproximado(*args):
    """Actualiza el texto en pantalla con el costo de la membresía seleccionada."""
    membresia_seleccionada = combo_membresia.get()
    costo_base = precios_membresias.get(membresia_seleccionada, 0)
    lbl_costo_base.config(text=f"Costo aproximado base: ${costo_base}.00")

def calcular_total():
    """Valida los datos, calcula el total y muestra el mensaje final."""
    nombre = entry_nombre.get().strip()
    edad = entry_edad.get().strip()
    membresia = combo_membresia.get()
    
    # 1. Validación: que el nombre no esté vacío
    if not nombre:
        messagebox.showerror("Error de Validación", "El nombre no puede estar vacío. Por favor, ingréselo.")
        entry_nombre.focus()
        return

    # 2. Calcular costo de membresía
    total = precios_membresias.get(membresia, 0)
    servicios_seleccionados = []

    # 3. Calcular costos de servicios adicionales
    if var_casillero.get():
        total += 5
        servicios_seleccionados.append("Casillero (+$5)")
    if var_toalla.get():
        total += 3
        servicios_seleccionados.append("Servicio de Toalla (+$3)")
    if var_entrenador.get():
        total += 20
        servicios_seleccionados.append("Entrenador Personal (+$20)")

    # Preparar el texto de servicios para el mensaje
    texto_servicios = ", ".join(servicios_seleccionados) if servicios_seleccionados else "Ninguno"
    texto_edad = f"\nEdad: {edad} años" if edad else ""

    # 4. Mostrar el total en un mensaje final
    resumen = (
        f"¡Registro Exitoso!\n\n"
        f"Socio: {nombre}{texto_edad}\n"
        f"Membresía: {membresia} (${precios_membresias[membresia]}.00)\n"
        f"Servicios Adicionales: {texto_servicios}\n"
        f"-----------------------------------------\n"
        f"TOTAL A PAGAR: ${total}.00"
    )
    
    messagebox.showinfo("Resumen de Pago", resumen)


# --- Configuración de la Ventana Principal ---
ventana = tk.Tk()
ventana.title("Gimnasio - Registro de Socios")
ventana.geometry("400x550")
ventana.configure(bg="#f1f5f9")

# Diccionario de precios
precios_membresias = {
    "Básica": 30,
    "Estándar": 45,
    "Premium": 60
}

# --- Componentes de la Interfaz ---

# 1. Logotipo del Gimnasio (Simulado con un diseño de texto destacado)
lbl_logo = tk.Label(
    ventana, 
    text="🏋️‍♂️ POWER GYM 🏋️‍♀️", 
    font=("Arial", 18, "bold"), 
    bg="#1e293b", 
    fg="#f8fafc", 
    pady=15
)
lbl_logo.pack(fill=tk.X, padx=0, pady=(0, 20))

# Contenedor con márgenes internos
frame_cuerpo = tk.Frame(ventana, bg="#f1f5f9")
frame_cuerpo.pack(padx=20, fill=tk.BOTH)

# 2. Campo: Nombre
lbl_nombre = tk.Label(frame_cuerpo, text="Nombre Completo *:", font=("Arial", 10, "bold"), bg="#f1f5f9")
lbl_nombre.pack(anchor=tk.W, pady=(5, 2))
entry_nombre = tk.Entry(frame_cuerpo, font=("Arial", 11))
entry_nombre.pack(fill=tk.X, pady=5)

# 3. Campo: Edad
lbl_edad = tk.Label(frame_cuerpo, text="Edad (Opcional):", font=("Arial", 10, "bold"), bg="#f1f5f9")
lbl_edad.pack(anchor=tk.W, pady=(5, 2))
entry_edad = tk.Entry(frame_cuerpo, font=("Arial", 11))
entry_edad.pack(fill=tk.X, pady=5)

# 4. Campo: Tipo de Membresía
lbl_membresia = tk.Label(frame_cuerpo, text="Tipo de Membresía:", font=("Arial", 10, "bold"), bg="#f1f5f9")
lbl_membresia.pack(anchor=tk.W, pady=(5, 2))

combo_membresia = ttk.Combobox(frame_cuerpo, values=list(precios_membresias.keys()), state="readonly", font=("Arial", 10))
combo_membresia.set("Básica") # Opción por defecto
combo_membresia.pack(fill=tk.X, pady=5)
combo_membresia.bind("<<ComboboxSelected>>", actualizar_costo_aproximado)

# Subtítulo de costo aproximado (Muestra costos dinámicamente)
lbl_costo_base = tk.Label(frame_cuerpo, text="Costo aproximado base: $30.00", font=("Arial", 9, "italic"), fg="#64748b", bg="#f1f5f9")
lbl_costo_base.pack(anchor=tk.W, pady=(0, 10))

# 5. Campo: Servicios Adicionales
lbl_servicios = tk.Label(frame_cuerpo, text="Servicios Adicionales:", font=("Arial", 10, "bold"), bg="#f1f5f9")
lbl_servicios.pack(anchor=tk.W, pady=(10, 5))

frame_servicios = tk.LabelFrame(frame_cuerpo, bg="#ffffff", bd=1, relief=tk.SOLID, padx=10, pady=10)
frame_servicios.pack(fill=tk.X, pady=5)

var_casillero = tk.BooleanVar()
chk_casillero = tk.Checkbutton(frame_servicios, text="Casillero (+$5.00)", variable=var_casillero, bg="#ffffff", activebackground="#ffffff")
chk_casillero.pack(anchor=tk.W, pady=2)

var_toalla = tk.BooleanVar()
chk_toalla = tk.Checkbutton(frame_servicios, text="Servicio de Toalla (+$3.00)", variable=var_toalla, bg="#ffffff", activebackground="#ffffff")
chk_toalla.pack(anchor=tk.W, pady=2)

var_entrenador = tk.BooleanVar()
chk_entrenador = tk.Checkbutton(frame_servicios, text="Entrenador Personal (+$20.00)", variable=var_entrenador, bg="#ffffff", activebackground="#ffffff")
chk_entrenador.pack(anchor=tk.W, pady=2)

# 6. Botón de Enviar / Calcular
btn_calcular = tk.Button(
    frame_cuerpo, 
    text="Calcular y Registrar", 
    font=("Arial", 12, "bold"), 
    bg="#2563eb", 
    fg="white", 
    activebackground="#1d4ed8", 
    activeforeground="white",
    command=calcular_total,
    cursor="hand2"
)
btn_calcular.pack(fill=tk.X, pady=25)

# Iniciar la aplicación
ventana.mainloop()