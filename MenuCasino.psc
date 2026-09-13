Algoritmo MenuCasino
    Definir opcion Como Entero;
    Definir continuar Como Logico;
    
    continuar <- Verdadero;
    
    Mientras continuar Hacer
        // Mostrar el cartel de opciones
        Limpiar Pantalla;
        Escribir "=========================================";
        Escribir "          BIENVENIDO AL CASINO           ";
        Escribir "=========================================";
        Escribir " 1. Jugar a la Ruleta";
        Escribir " 2. Jugar al Blackjack";
        Escribir " 3. Jugar a las Tragamonedas";
        Escribir " 4. Ver Saldo / Cargar Crédito";
        Escribir " 5. Salir del Casino";
        Escribir "=========================================";
        Escribir "Seleccione una opción (1-5): " Sin Saltar;
        Leer opcion;
        
        // Evaluar la opción seleccionada
        Segun opcion Hacer
            1:
                Escribir "Entrando a la Ruleta... ¡Hagan sus apuestas!";
                // Aquí va la lógica de la ruleta
                Esperar Tecla;
            2:
                Escribir "Entrando al Blackjack... ¿Carta o te plantas?";
                // Aquí va la lógica del blackjack
                Esperar Tecla;
            3:
                Escribir "Entrando a las Tragamonedas... ¡Suerte con el Jackpot!";
                // Aquí va la lógica de los slots
                Esperar Tecla;
            4:
                Escribir "Sección de Saldo y Créditos en mantenimiento.";
                Esperar Tecla;
            5:
                Escribir "Gracias por visitarnos. ¡Vuelve pronto!";
                continuar <- Falso;
            De Otro Modo:
                Escribir "Opción no válida. Intente de nuevo.";
                Esperar Tecla;
        FinSegun
    FinMientras
FinAlgoritmo
