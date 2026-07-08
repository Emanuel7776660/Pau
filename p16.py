import tkinter as tk
from tkinter import messagebox

def enviar_datos():
    # Obtener los datos de los campos
    nombre = entrada_nombre.get()
    edad = entrada_edad.get()
    sexo = entrada_sexo.get()
    
    # Validar que no estén vacíos
    if nombre and edad:
        messagebox.showinfo("Formulario Recibido", f"¡Gracias {nombre}!\nTus Datos Son: {edad},{sexo} ha sido guardado.")
        # Aquí puedes guardar los datos en un archivo o base de datos
        entrada_nombre.delete(0, tk.END)
        entrada_edad.delete(0, tk.END)
    else:
        messagebox.showwarning("Error", "Por favor, llena todos los campos.")

# Configuración de la ventana principal
ventana = tk.Tk()
ventana.title("Formulario de Registro")
ventana.geometry("300x200")
ventana.config(bg="#E02AD1")

# Etiquetas y campos de entrada
tk.Label(ventana, text="Nombre:").pack(pady=5)
entrada_nombre = tk.Entry(ventana, width=30)
entrada_nombre.pack(pady=5)

tk.Label(ventana, text="Edad:").pack(pady=5)
entrada_edad= tk.Entry(ventana, width=30)
entrada_edad.pack(pady=5)

tk.Label(ventana, text="Sexo:").pack(pady=5)
entrada_sexo= tk.Entry(ventana, width=30)
entrada_sexo.pack(pady=5)

# Botón de envío
boton_enviar = tk.Button(ventana, text="Enviar", command=enviar_datos)
boton_enviar.pack(pady=15)

# Iniciar la aplicación
ventana.mainloop()