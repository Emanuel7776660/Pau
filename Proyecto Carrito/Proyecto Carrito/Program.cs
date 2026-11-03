using Carrito;
using System.Data.SqlClient;
using Microsoft.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

// Configurar CORS para permitir peticiones desde cualquier origen
builder.Services.AddCors(options =>
{
    options.AddPolicy("PermitirTodo", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// Habilitar archivos estáticos para que cargue wwwroot/index.html, login.html, etc.
app.UseStaticFiles();

app.UseCors("PermitirTodo");

// Ruta raíz que redirige automáticamente al Home (index.html)
app.MapGet("/", async context =>
{
    context.Response.Redirect("/index.html");
    await Task.CompletedTask;
});

// Endpoint para listar usuarios (GET)
app.MapGet("/api/usuarios", async (IConfiguration configuration) =>
{
    string connectionString = configuration.GetConnectionString("CadenaSql")
                              ?? throw new InvalidOperationException("No se encontró la cadena de conexión.");

    var listaUsuarios = new List<Usuario>();

    try
    {
        using var connection = new SqlConnection(connectionString);
        await connection.OpenAsync();

        string query = "SELECT IdUsuarios, NickUsuario, NombreUsuario, PasswordUsuario FROM Usuarios";
        using var command = new SqlCommand(query, connection);

        using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            listaUsuarios.Add(new Usuario
            {
                IdUsuarios = reader.GetString(0),
                NickUsuario = reader.GetString(1),
                NombreUsuario = reader.GetString(2),
                PasswordUsuario = reader.GetString(3)
            });
        }

        return Results.Ok(listaUsuarios);
    }
    catch (Exception ex)
    {
        return Results.Problem($"Error al consultar la tabla Usuarios: {ex.Message}");
    }
});

// Endpoint para Registrar un nuevo usuario (POST)
app.MapPost("/api/usuarios", async (Usuario usuario, IConfiguration configuration) =>
{
    string connectionString = configuration.GetConnectionString("CadenaSql")
                              ?? throw new InvalidOperationException("No se encontró la cadena de conexión.");

    try
    {
        using var connection = new SqlConnection(connectionString);
        await connection.OpenAsync();

        string query = "INSERT INTO Usuarios (IdUsuarios, NickUsuario, NombreUsuario, PasswordUsuario) VALUES (@Id, @Nick, @Nombre, @Password)";

        using var command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@Id", usuario.IdUsuarios);
        command.Parameters.AddWithValue("@Nick", usuario.NickUsuario);
        command.Parameters.AddWithValue("@Nombre", usuario.NombreUsuario);
        command.Parameters.AddWithValue("@Password", usuario.PasswordUsuario);

        await command.ExecuteNonQueryAsync();

        return Results.Ok(new { Mensaje = "¡Usuario registrado con éxito!" });
    }
    catch (Exception ex)
    {
        return Results.Problem($"Error al registrar el usuario: {ex.Message}");
    }
});

// Endpoint para Iniciar Sesión (POST)
app.MapPost("/api/login", async (Usuario credenciales, IConfiguration configuration) =>
{
    string connectionString = configuration.GetConnectionString("CadenaSql")
                              ?? throw new InvalidOperationException("No se encontró la cadena de conexión.");

    try
    {
        using var connection = new SqlConnection(connectionString);
        await connection.OpenAsync();

        string query = "SELECT IdUsuarios, NickUsuario, NombreUsuario, PasswordUsuario FROM Usuarios WHERE (NickUsuario = @Nick OR NombreUsuario = @Nick) AND PasswordUsuario = @Password";

        using var command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@Nick", credenciales.NickUsuario ?? "");
        command.Parameters.AddWithValue("@Password", credenciales.PasswordUsuario ?? "");

        using var reader = await command.ExecuteReaderAsync();
        if (await reader.ReadAsync())
        {
            var usuarioEncontrado = new Usuario
            {
                IdUsuarios = reader.GetString(0),
                NickUsuario = reader.GetString(1),
                NombreUsuario = reader.GetString(2),
                PasswordUsuario = "" // Por seguridad
            };

            return Results.Ok(new { Mensaje = "¡Acceso concedido!", Usuario = usuarioEncontrado });
        }
        else
        {
            return Results.BadRequest(new { detail = "Credenciales incorrectas. Verifique su Nick y Contraseña." });
        }
    }
    catch (Exception ex)
    {
        return Results.Problem($"Error al iniciar sesión: {ex.Message}");
    }
});

app.Run();