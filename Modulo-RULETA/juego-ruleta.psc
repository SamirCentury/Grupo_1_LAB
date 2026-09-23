SubProceso CargarColores(colores)
    Definir i Como Entero;
    
    Para i <- 0 Hasta 36 Con Paso 1 Hacer
        colores[i] = "N";
    FinPara
    
    colores[0] = "V";
    
    colores[1]  = "R"; colores[3]  = "R"; colores[5]  = "R"; colores[7]  = "R";
    colores[9]  = "R"; colores[12] = "R"; colores[14] = "R"; colores[16] = "R";
    colores[18] = "R"; colores[19] = "R"; colores[21] = "R"; colores[23] = "R";
    colores[25] = "R"; colores[27] = "R"; colores[30] = "R"; colores[32] = "R";
    colores[34] = "R"; colores[36] = "R";
FinSubProceso

SubProceso MostrarBienvenida()
    Escribir "==========================================";
    Escribir "            BIENVENIDOS AL                ";
    Escribir "         JUEGO DE LA RULETA               ";
    Escribir "==========================================";
FinSubProceso

Funcion monto = SolicitarApuesta(saldoActual)
    Definir monto Como Real;
    Repetir
        Escribir "Saldo disponible: $", saldoActual;
        Escribir "Ingrese monto a apostar:";
        Leer monto;
        Si monto <= 0 Entonces
            Escribir "Error: El monto debe ser mayor a 0.";
        FinSi
        Si monto > saldoActual Entonces
            Escribir "Error: Saldo insuficiente.";
        FinSi
    Hasta Que monto > 0 Y monto <= saldoActual
FinFuncion

Funcion tipo = MenuApuestas()
    Definir tipo Como Entero;
    Repetir
        Escribir "";
        Escribir "=== TIPOS DE APUESTA DE LA RULETA ===";
        Escribir "1. Pleno (0 al 36)    [Paga 35:1]";
        Escribir "2. Color (Rojo/Negro) [Paga 1:1]";
        Escribir "3. Par o Impar        [Paga 1:1]";
        Escribir "Seleccione una opcion (1-3):";
        Leer tipo;
        Si tipo < 1 O tipo > 3 Entonces
            Escribir "Opcion invalida... Reintente";
        FinSi
    Hasta Que tipo >= 1 Y tipo <= 3
FinFuncion

Funcion num = PedirNumeroPleno()
    Definir num Como Entero;
    Repetir
        Escribir "Elija un numero (0 al 36):";
        Leer num;
        Si num < 0 O num > 36 Entonces
            Escribir "Error: Numero fuera de rango.";
        FinSi
    Hasta Que num >= 0 Y num <= 36
FinFuncion

Funcion col = PedirColor()
    Definir col Como Caracter;
    Repetir
        Escribir "Elija color (R: Rojo / N: Negro):";
        Leer col;
        col = Mayusculas(col);
        Si col <> "R" Y col <> "N" Entonces
            Escribir "Error: Ingrese solo R o N.";
        FinSi
    Hasta Que col = "R" O col = "N"
FinFuncion

Funcion paridad = PedirParidad()
    Definir paridad Como Entero;
    Repetir
        Escribir "Elija paridad (1: Par / 2: Impar):";
        Leer paridad;
        Si paridad <> 1 Y paridad <> 2 Entonces
            Escribir "Error: Ingrese 1 para Par o 2 para Impar.";
        FinSi
    Hasta Que paridad = 1 O paridad = 2
FinFuncion

Funcion num = TirarRuleta()
    Definir num Como Entero;
    Escribir "";
    Escribir "Girando la bola...";
    num = Azar(37);
FinFuncion

SubProceso ResolverRonda(tipo, monto, colores, saldo Por Referencia)
    Definir numElegido, numeroSalio, paridadElegida Como Entero;
    Definir colElegido, colSalio Como Caracter;
    
    Segun tipo Hacer
        1:
            numElegido = PedirNumeroPleno();
        2:
            colElegido = PedirColor();
        3:
            paridadElegida = PedirParidad();
    FinSegun
    
    numeroSalio = TirarRuleta();
    colSalio = colores[numeroSalio];
    Escribir "-> Salio el: ", numeroSalio, " (Color: ", colSalio, ")";
    
    Segun tipo Hacer
        1:
            Si numElegido = numeroSalio Entonces
                Escribir "¡Acertaste el pleno! Ganaste $", (monto * 35);
                saldo = saldo + (monto * 35);
            Sino
                Escribir "Perdiste :( $", monto;
                saldo = saldo - monto;
            FinSi
            
        2:
            // Si sale 0 (Verde), la casa gana frente a Rojo/Negro
            Si (colElegido = colSalio) Y (numeroSalio <> 0) Entonces
                Escribir "¡Acertaste el color! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Color incorrecto (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi
            
        3:
            // El 0 no es par ni impar; la casa gana
            Si (numeroSalio <> 0) Y (((paridadElegida = 1) Y (numeroSalio MOD 2 = 0)) O ((paridadElegida = 2) Y (numeroSalio MOD 2 <> 0))) Entonces
                Escribir "¡Acertaste la paridad! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Paridad incorrecta (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi
    FinSegun
FinSubProceso

Funcion continua = DeseaContinuar(saldoActual)
    Definir continua Como Caracter;
    Si saldoActual > 0 Entonces
        Escribir "";
        Escribir "¿Desea jugar otra ronda en la Ruleta? (S/N):";
        Leer continua;
    Sino
        Escribir "Te has quedado sin saldo.";
        continua = "N";
    FinSi
FinFuncion

Algoritmo Ruleta_Laboratorio
    Dimension colores[37];
    Definir colores Como Caracter;
    Definir saldo, monto Como Real;
    Definir tipo Como Entero;
    Definir seguir Como Caracter;
    
    CargarColores(colores);
    MostrarBienvenida();
    
    saldo = 1000; //saldo de prueba
    seguir = "S";
    
    Mientras (saldo > 0) Y (seguir = "S" O seguir = "s") Hacer
        Escribir "";
        monto = SolicitarApuesta(saldo);
        tipo = MenuApuestas();
        
        ResolverRonda(tipo, monto, colores, saldo);
        
        seguir = DeseaContinuar(saldo);
    FinMientras
    
    Escribir "";
    Escribir "Fin de la partida. Te retiras con un saldo final de: $", saldo;
FinAlgoritmo