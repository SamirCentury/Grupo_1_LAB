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

SubProceso DibujarPanoRuleta()
    Escribir "==========================================================================";
    Escribir "                         PANEL DE LA RULETA EUROPEA                       ";
    Escribir "==========================================================================";
    Escribir "  +-----+---------------------------------------------------------------+";
    Escribir "  |     | [ 3R] [ 6N] [ 9R] [12R] [15N] [18R] [21R] [24N] [27R] [30R] [33N] [36R] |";
    Escribir "  |     |---------------------------------------------------------------|";
    Escribir "  | 0 V | [ 2N] [ 5R] [ 8N] [11N] [14R] [17N] [20N] [23R] [26N] [29N] [32R] [35N] |";
    Escribir "  |     |---------------------------------------------------------------|";
    Escribir "  |     | [ 1R] [ 4N] [ 7R] [10N] [13N] [16R] [19R] [22N] [25R] [28N] [31N] [34R] |";
    Escribir "  +-----+---------------------------------------------------------------+";
    Escribir "        |          1ra DOCENA           |          2da DOCENA           |          3ra DOCENA           |";
    Escribir "        |            (1 - 12)           |           (13 - 24)           |           (25 - 36)           |";
    Escribir "        +-------------------------------+-------------------------------+-------------------------------+";
    Escribir "        |    1 - 18     |      PAR      |     ROJO      |     NEGRO     |     IMPAR     |    19 - 36    |";
    Escribir "        +---------------+---------------+---------------+---------------+---------------+---------------+";
    Escribir "  Referencias: [R] = Rojo | [N] = Negro | [V] = Verde (0)";
    Escribir "==========================================================================";
FinSubProceso

// Simula visualmente el giro de la bola en la rueda
SubProceso AnimarGiroRuleta(numeroSalio, colorSalio)
    Escribir "";
    Escribir "           .---.          ";
    Escribir "        .-/     /-.       ";
    Escribir "       /   ( o )   /      Girando la rueda y lanzando la bola...";
    Escribir "      |   /     /   |     * clic * * clac * * clic *";
    Escribir "       /   ( o )   /      ";
    Escribir "        .-/     /-.       ";
    Escribir "           ---          ";
    Esperar 1 Segundos;
    
    Escribir "";
    Escribir "      +-------------------------------------------+";
    Escribir "      |           ¡LA BOLA SE HA DETENIDO!        |";
    Escribir "      |                                           |";
    Escribir "      |             NUMERO GANADOR: [ ", numeroSalio, " ]         |";
    Escribir "      |                COLOR: [ ", colorSalio, " ]                |";
    Escribir "      +-------------------------------------------+";
    Escribir "";
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
		Escribir "4. Falta (1-18) / Pasa (19-36) [Paga 1:1]";
		Escribir "5. Docenas (1-12, 13-24, 25-36) [Paga 2:1]";
        Escribir "Seleccione una opcion (1-5):";
        Leer tipo;
        Si tipo < 1 O tipo > 5 Entonces
            Escribir "Opcion invalida... Reintente";
        FinSi
    Mientras Que tipo < 1 O tipo > 5
FinFuncion

Funcion num = PedirNumeroPleno()
    Definir num Como Entero;
    Repetir
        Escribir "Elija un numero (0 al 36):";
        Leer num;
        Si num < 0 O num > 36 Entonces
            Escribir "Error: Numero fuera de rango";
        FinSi
    Mientras Que num < 0 O num > 36
FinFuncion

Funcion col = PedirColor()
    Definir col Como Caracter;
    Repetir
        Escribir "Elija color (R: Rojo / N: Negro):";
        Leer col;
        col = Mayusculas(col);
        Si col <> "R" Y col <> "N" Entonces
            Escribir "Error: Ingrese solo R o N";
        FinSi
    Mientras Que col <> "R" Y col <> "N"
FinFuncion

Funcion paridad = PedirParidad()
    Definir paridad Como Entero;
    Repetir
        Escribir "Elija paridad (1: Par / 2: Impar):";
        Leer paridad;
        Si paridad <> 1 Y paridad <> 2 Entonces
            Escribir "Error: Ingrese 1 para Par o 2 para Impar";
        FinSi
    Mientras Que paridad <> 1 Y paridad <> 2
FinFuncion

Funcion rango = PedirFaltaPasa()
    Definir rango Como Entero;
    Repetir
        Escribir "Elija rango (1: Falta [1-18] / 2: Pasa [19-36]):";
        Leer rango;
        Si rango <> 1 Y rango <> 2 Entonces
            Escribir "Error: Ingrese 1 para Falta o 2 para Pasa";
        FinSi
    Mientras Que rango <> 1 Y rango <> 2
FinFuncion

Funcion docena = PedirDocena() 
	Definir docena Como Entero;
	Repetir
		Escribir "Elija la docena:";
        Escribir "1. Primera docena (1 al 12)";
        Escribir "2. Segunda docena (13 al 24)";
        Escribir "3. Tercera docena (25 al 36)";
        Leer docena;
        Si docena < 1 O docena > 3 Entonces
            Escribir "Error: Ingrese una opcion valida (1, 2 o 3).";
        FinSi
	Mientras Que docena < 1 O docena > 3
FinFuncion

Funcion num = TirarRuleta()
    Definir num Como Entero;
    num = Azar(37);
FinFuncion

SubProceso ResolverRonda(tipo, monto, colores, saldo Por Referencia)
    Definir numElegido, numeroSalio, paridadElegida, rangoElegido, docenaElegida Como Entero;
    Definir colElegido, colSalio Como Caracter;
    
	// Entrada de datos segun el tipo de jugada
    Segun tipo Hacer
        1:
            numElegido = PedirNumeroPleno();
        2:
            colElegido = PedirColor();
        3:
            paridadElegida = PedirParidad();
		4: 
			rangoElegido = PedirFaltaPasa();
		5:
			docenaElegida = PedirDocena();
    FinSegun
    
	// Gira la bolaa
    numeroSalio = TirarRuleta();
    colSalio = colores[numeroSalio];
	AnimarGiroRuleta(numeroSalio, colSalio);
    
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
		4:
            // Si sale 0, la casa gana
            Si (numeroSalio <> 0) Y (((rangoElegido = 1) Y (numeroSalio >= 1 Y numeroSalio <= 18)) O ((rangoElegido = 2) Y (numeroSalio >= 19 Y numeroSalio <= 36))) Entonces
                Escribir "¡Acertaste el rango! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Rango incorrecto (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi		
		5:
            Si (numeroSalio <> 0) Y ( ((docenaElegida = 1) Y (numeroSalio >= 1 Y numeroSalio <= 12)) O ((docenaElegida = 2) Y (numeroSalio >= 13 Y numeroSalio <= 24)) O ((docenaElegida = 3) Y (numeroSalio >= 25 Y numeroSalio <= 36)) ) Entonces
                Escribir "¡Acertaste la docena! Ganaste $", (monto * 2);
                saldo = saldo + (monto * 2);
            Sino
                Escribir "Docena incorrecta (o salio el 0). Perdiste $", monto;
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
		DibujarPanoRuleta();
        tipo = MenuApuestas();
        
        ResolverRonda(tipo, monto, colores, saldo);
        
        seguir = DeseaContinuar(saldo);
    FinMientras
    
    Escribir "";
    Escribir "Fin de la partida... Te retiras con un saldo final de: $", saldo;
FinAlgoritmo