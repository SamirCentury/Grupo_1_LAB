Algoritmo MenuRegistroYAcceso
    // Declarar variables de registro
    Definir edad Como Entero;
    Definir usuarioRegistro, contrasenaRegistro Como Caracter;
    
    // Declarar variables de inicio de sesión
    Definir usuarioIngreso, contrasenaIngreso Como Caracter;
    Definir intentoExitoso Como Logico;
    
    // ==========================================
    //           REGISTRO DE USUARIO
    // ==========================================
    Escribir "=== REGISTRO DE NUEVO USUARIO ===";
    
    Escribir "Ingrese su edad:";
    Leer edad;
    
    // Validar que sea mayor de 18 años
    Mientras edad < 18 Hacer
        Limpiar Pantalla;
        Escribir "Error: Debe ser mayor de 18 años para registrarse.";
        Escribir "Ingrese su edad nuevamente:";
        Leer edad;
    FinMientras
    
    // Crear las credenciales
    Escribir "Cree un nombre de usuario:";
    Leer usuarioRegistro;
    
    Escribir "Cree una contraseña:";
    Leer contrasenaRegistro;
    
    Limpiar Pantalla;
    Escribir "¡Registro completado con éxito!";
    Escribir "Presione una tecla para ir al inicio de sesión...";
    Esperar Tecla;
    
    // ==========================================
    //          MENÚ DE INGRESO (LOGIN)
    // ==========================================
    intentoExitoso <- Falso;
    
    Repetir
        Limpiar Pantalla;
        Escribir "=== INGRESO AL SISTEMA ===";
        
        Escribir "Usuario:";
        Leer usuarioIngreso;
        
        Escribir "Contraseña:";
        Leer contrasenaIngreso;
        
        // Verificar si las credenciales coinciden con las registradas
        Si usuarioIngreso = usuarioRegistro Y contrasenaIngreso = contrasenaRegistro Entonces
            intentoExitoso <- Verdadero;
        Sino
            Escribir "";
            Escribir "Usuario o contraseña incorrectos. Intente de nuevo.";
            Escribir "Presione Enter para continuar...";
            Esperar Tecla;
        FinSi
        
    Hasta Que intentoExitoso = Verdadero
    
    // ==========================================
    //           BIENVENIDA AL SISTEMA
    // ==========================================
    Limpiar Pantalla;
    Escribir "=========================================";
    Escribir "       ¡BIENVENIDO AL SISTEMA!           ";
    Escribir "=========================================";
    Escribir "Has ingresado correctamente como: ", usuarioRegistro;
    Escribir "=========================================";
    
FinAlgoritmo
