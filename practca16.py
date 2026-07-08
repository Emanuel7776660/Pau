import tkinter as tk
from tkinter import messagebox
import mysql.connector
#conexion a mysql
conexion=mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="FORMULARIO"
)
cursor = conexion.cursor()

#funcion para guardar datos
def guardar():
    sql = "INSERT INTO casos (nombre,edad,descripcion,peso,enfermedades_cronicas) VALUES (%s,%s,%s,%s,CURDATE(),%s)"

    valores =(
        nombre.get(),
        edad.get(),
        descripcion.get(),
        peso.get(),
        enfermedades_cronicas.get()
        )
    
    cursor.execute(sql,valores)
    conexion.commit()
    messagebox.showinfo("exito","caso registrado correctamente")

ventana=tk.Tk()
ventana.title("FORMULARIO")
ventana.geometry("400x400")
ventana.config(bg="#E02AD1")

titulo = tk.Label(
    ventana,
    text="FORMULARIO!",
    font=("Arial",20,"bold"),
    fg="black",
    bg="#0CF8D9"
)
titulo.pack(pady=10)
formulario= tk.StringVar()
tk.Label(ventana,text="ingresa los siguientes datos").pack()

tk.Radiobutton(ventana,text="nombre",
   variable=formulario,
   value="nombre").pack()
tk.Radiobutton(ventana,text="edad",
   variable=formulario,
   value="edad").pack()
tk.Radiobutton(ventana,text="descripcion",
   variable=formulario,
   value="descripcion").pack()
tk.Radiobutton(ventana,text="peso",
   variable=formulario,
   value="peso").pack()
tk.Radiobutton(ventana,text="enfermedades_cronicas",
   variable=formulario,
   value="enfermedades_cronicas").pack()

  
ventana.config(bg="yellow")
titulo.config(bg="yellow")
ventana.mainloop()