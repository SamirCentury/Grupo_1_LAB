Algoritmo tragamonedas_02
	Definir opcion,seguir Como Entero;
    Definir continuar Como Logico;
	Definir textoSimbolos Como Caracter;
    continuar <- Verdadero;
	saldo<- 1000;
	TRAGAMONEDAS(saldo, continuar);
FinAlgoritmo

SubProceso TRAGAMONEDAS(saldo, continuar)
	Definir apuesta Como Entero;
	Definir rueda1, rueda2, rueda3, i, s Como Entero; //S para los ritmos.
	//Seis variables.
	
	Mientras saldo>0 y continuar hacer
		Limpiar Pantalla;
		//Letrero gigante de entrada.
		CARTEL_TRAGAMONEDAS;
		//Escribir el saldo actual y leer la apuesta del juador.
		Escribir " Saldo Actual: [$", saldo, "]";
		Escribir " Ingresa tu apuesta (Mínimo $10): ";
		Leer apuesta;
		Si apuesta>saldo o apuesta<10 Entonces
			//Preguntar si la apuesta ingresada es mayor que el saldo. 
			//O menor al monto minimo de apuesta.
			APUESTA_INVALIDA;
			Leer continuar;
			continuar <- Verdadero;
		SiNo
			// COBRO INMEDIATO: Se descuenta la apuesta aquí, antes de ver la animación
			saldo <- saldo - apuesta;
			//Animación gigante de giro.
			Para i<-1 Hasta 5 Hacer
				//Repite el proceso en un total de cinco veces.
				Limpiar Pantalla;
				SLOTS_FORTUNE;
				//Cambia el estado de la palanca de la maquina segun el numero.
				//Simulando el movimiento.
				Si i MOD 2=0 Entonces
					PALANCA_01;
					//Si i es par (vueltas 2 y 4).
				SiNo
					PALANCA_02;
					//Si i es impar (vueltas 1,3 y 5).
				FinSi
				GIRANDO;
				//(Simula el mecanismo mecánico de giro).
				Esperar 200 Milisegundos;
			FinPara
		FinSi
		//Genera un numero entero aleatorio que empieza desde 0 hasta 3.
		//Se suma 1 para desplazar el rango y no comenzar en 0.
		rueda1 <- azar(4) + 1;
		rueda2 <- azar(4) + 1;
		rueda3 <- azar(4) + 1;
		//Cada una de las tres ruedas de la maquina obtiene un simbolo o numero al azar.
		//Independiente a cada bucle.
		Limpiar Pantalla;
		SLOTS_FORTUNE;
		INICIANDO(rueda1, rueda2, rueda3);
		// Mostrar nombres de símbolos
		//Su funcion es crear una linea de texto dinamica y autoajustable.
		// ==================== SECCIÓN DE SÍMBOLOS ENCAJADOS ====================
		textoSimbolos <- "  Símbolos: ";
		//La variable mide 12 caracteres de largo.
		// Concatenar el primer símbolo
		Segun rueda1 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown] ";
			2: textoSimbolos <- textoSimbolos + "[Diamante] ";
			3: textoSimbolos <- textoSimbolos + "[Moneda] ";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada] ";
		FinSegun
		
		// Concatenar el segundo símbolo
		Segun rueda2 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown] ";
			2: textoSimbolos <- textoSimbolos + "[Diamante] ";
			3: textoSimbolos <- textoSimbolos + "[Moneda] ";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada] ";
		FinSegun
		
		// Concatenar el tercer símbolo
		Segun rueda3 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown]";
			2: textoSimbolos <- textoSimbolos + "[Diamante]";
			3: textoSimbolos <- textoSimbolos + "[Moneda]";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada]";
		FinSegun
		
		// Relleno matemático automático para cerrar la caja a la perfección (67 caracteres de ancho interno).
		Mientras Longitud(textoSimbolos) < 67 Hacer //cuenta cuántas letras y espacios tiene la frase en ese instante.
			textoSimbolos <- textoSimbolos + " ";
			//El bucle dice: "Si la frase mide menos de 67 caracteres, agrégale un espacio en blanco al final y vuelve a revisar".
		FinMientras
		//El resultado: Si la combinación de símbolos fue corta, el bucle agregará muchos espacios.
		//Si fue larga, agregará pocos. Al final, no importa qué símbolos salga, la frase siempre medirá exactamente 67 caracteres.
		
		// Imprime la fila completamente alineada
		Escribir "      |", textoSimbolos, "|";
		
		// Línea final que cierra la estructura de la máquina
		Escribir "      |___________________________________________________________________|";
		Escribir "";
		// ========================================================================

		// LÓGICA DE PREMIOS Y RITMOS DE SONIDO
		Si rueda1 = rueda2 Y rueda2 = rueda3 Entonces
			Si rueda1 = 1 Entonces
				JACKPOT;
				saldo <- saldo + (apuesta * 15);
				Para s <- 1 Hasta 12 Hacer
					Escribir Sin Saltar ""; 
					Esperar 80 Milisegundos;
				FinPara
			SiNo
				Escribir "  ¡Felicidades! Consiguiste 3 símbolos iguales. ¡Gran Premio!";
				saldo <- saldo + (apuesta * 5);
				Para s <- 1 Hasta 5 Hacer
					Esperar 150 Milisegundos;
				FinPara
			FinSi
		SiNo
			Si rueda1 = rueda2 O rueda2 = rueda3 O rueda1 = rueda3 Entonces
				Escribir "  ¡Bien! 2 símbolos iguales. Duplicas tu apuesta.";
				saldo <- saldo + (apuesta * 2);
				
				Esperar 100 Milisegundos;
				Esperar 100 Milisegundos;
			SiNo
				Escribir "  No tuviste suerte esta vez. Los rodillos no coinciden.";
				// Ya no se resta saldo aquí porque se cobró al inicio del tiro
				Esperar 500 Milisegundos;
			FinSi
		FinSi
		//Si ganas el Jackpot, el programa hace pausas muy rápidas consecutivas para simula una sirena festiva.
		//Si pierdes, hace una pausa larga de medio segundo (500 Milisegundos) en silencio, simula el momento de decepción antes de continuar.
		//Es para agregar dramatismo y emoción al juego.
		Escribir "==========================================================================";
		Escribir " Nuevo saldo disponible: $", saldo;
		Escribir "==========================================================================";
		Si saldo >= 10 Entonces
			Escribir " 1. Seguir jugando.";
			Escribir " 2. Volver al menú principal.";
			Escribir " Seleccione una opción: ";
			Leer opcion;
			
			Segun opcion Hacer
				1:
					continuar <- Verdadero;
				2:
					continuar <- Falso;
					Escribir " ¡Gracias por jugar! Te retiras con: $", saldo;
					Esperar Tecla;
				De Otro Modo:
					Escribir " Opción inválida, continuando juego por defecto...";
					Esperar 1 Segundos;
			FinSegun
		SiNo
			SIN_FICHAS;
			Escribir "Te has quedado sin saldo suficiente para la apuesta mínima ($10).";
			Escribir "Vuelve al menú de inicio para recargar.";
			continuar <- Falso;
			Esperar Tecla;
		FinSi
	FinMientras
FinSubProceso

//Carteles.
SubProceso CARTEL_TRAGAMONEDAS
	Escribir "  _______ _____           _____          __  __  ____  _   _ ______ _____           _____";
	Escribir " |__   __|  __ \    /\   / ____|   /\   |  \/  |/ __ \| \ | |  ____|  __ \   /\    / ____|";
	Escribir "    | |  | |__) |  /  \ | |  __   /  \  | \  / | |  | |  \| | |__  | |  | | /  \  | (___  ";
	Escribir "    | |  |  _  /  / /\ \| | |_ | / /\ \ | |\/| | |  | | . ` |  __| | |  | |/ /\ \  \___ \ ";
	Escribir "    | |  | | \ \ / ____ \ |__| |/ ____ \| |  | | |__| | |\  | |____| |__| / ____ \ ____) |";
	Escribir "    |_|  |_|  \_\/_/    \_\_____/_/    \_\_|  |_|\____/|_| \_|______|_____/_/    \_\_____/ ";
	Escribir "";
	Escribir " ==========================================================================================";
	Escribir "     TABLA DE PAGOS:   [ Crown ] [ Crown ] [ Crown ] -> JACKPOT GIGANTE (x15)";
	Escribir "                       3 Símbolos Iguales          -> Gran Premio (x5)";
	Escribir "                       2 Símbolos Iguales          -> Recompensa (x2)";
	Escribir " ==========================================================================================";
	Escribir "";
FinSubProceso

SubProceso APUESTA_INVALIDA
	Escribir " .-------------------------------------------------------.";
	Escribir " |¡Apuesta inválida! ¡Presiona <<Enter>> para reintentar!|";
	Escribir " .-------------------------------------------------------.";
FinSubProceso

SubProceso SLOTS_FORTUNE
	Escribir "      .___________________________________________________________________.";
	Escribir "      |                    ===  SLOTS FORTUNE  ===                        |";
	Escribir "      |___________________________________________________________________|";
	Escribir "      |                 |                 |                 |             |";
FinSubProceso

SubProceso PALANCA_01
	Escribir "      |     / \_/ \     |       / \       |      _/\_       |     ==O     |";
	Escribir "      |    |       |    |      /   \      |     >    <      |       |     |";
	Escribir "      |     \     /     |      \   /      |       \/        |    ___|     |";
	Escribir "      |       \_/       |       \ /       |                 |   /         |";
FinSubProceso

SubProceso PALANCA_02
	Escribir "      |       / \       |      _/\_       |     / \_/ \     |       |     |";
	Escribir "      |      /   \      |     >    <      |    |       |    |       |     |";
	Escribir "      |      \   /      |       \/        |     \     /     |    ___|     |";
	Escribir "      |       \ /       |                 |       \_/       |   /         |";
FinSubProceso

SubProceso GIRANDO
	Escribir "      |_________________|_________________|_________________|             |";
	Escribir "      |                    [   G I R A N D O   ]            |             |";
	Escribir "      |_____________________________________________________|_____________|";
FinSubProceso

SubProceso INICIANDO(rueda1, rueda2, rueda3)
	Definir f1, f2, f3, f4 Como Caracter;
	
	Escribir "      |                 |                 |                 |             |";
	
	// ==================== FILA 1 DE LOS RODILLOS ====================
	Segun rueda1 Hacer
		1: f1 <- "   _/\_   ";
		2: f1 <- "   / \    ";
		3: f1 <- "  / \_/ \ ";
		De Otro Modo: f1 <- "   / \    ";
	FinSegun
	Segun rueda2 Hacer
		1: f2 <- "   _/\_   ";
		2: f2 <- "   / \    ";
		3: f2 <- "  / \_/ \ ";
		De Otro Modo: f2 <- "   / \    ";
	FinSegun
	Segun rueda3 Hacer
		1: f3 <- "   _/\_   ";
		2: f3 <- "   / \    ";
		3: f3 <- "  / \_/ \ ";
		De Otro Modo: f3 <- "   / \    ";
	FinSegun
	Escribir "      |    ", f1, "   |    ", f2, "   |    ", f3, "   |      O      |";
	
	// ==================== FILA 2 DE LOS RODILLOS ====================
	Segun rueda1 Hacer
		1: f1 <- "  >    <  ";
		2: f1 <- "  /   \   ";
		3: f1 <- " |       |";
		De Otro Modo: f1 <- "  /   \   ";
	FinSegun
	Segun rueda2 Hacer
		1: f2 <- "  >    <  ";
		2: f2 <- "  /   \   ";
		3: f2 <- " |       |";
		De Otro Modo: f2 <- "  /   \   ";
	FinSegun
	Segun rueda3 Hacer
		1: f3 <- "  >    <  ";
		2: f3 <- "  /   \   ";
		3: f3 <- " |       |";
		De Otro Modo: f3 <- "  /   \   ";
	FinSegun
	Escribir "      |    ", f1, "   |    ", f2, "   |    ", f3, "   |     /       |";
	
	// ==================== FILA 3 DE LOS RODILLOS ====================
	Segun rueda1 Hacer
		1: f1 <- "    \/    ";
		2: f1 <- "  \   /   ";
		3: f1 <- "  \     / ";
		De Otro Modo: f1 <- "  \___/   ";
	FinSegun
	Segun rueda2 Hacer
		1: f2 <- "    \/    ";
		2: f2 <- "  \   /   ";
		3: f2 <- "  \     / ";
		De Otro Modo: f2 <- "  \___/   ";
	FinSegun
	Segun rueda3 Hacer
		1: f3 <- "    \/    ";
		2: f3 <- "  \   /   ";
		3: f3 <- "  \     / ";
		De Otro Modo: f3 <- "  \___/   ";
	FinSegun
	Escribir "      |    ", f1, "   |    ", f2, "   |    ", f3, "   |    ||       |";
	
	// ==================== FILA 4 DE LOS RODILLOS ====================
	Segun rueda1 Hacer
		1: f1 <- "          ";
		2: f1 <- "   \ /    ";
		3: f1 <- "    \_/   ";
		De Otro Modo: f1 <- "          ";
	FinSegun
	Segun rueda2 Hacer
		1: f2 <- "          ";
		2: f2 <- "   \ /    ";
		3: f2 <- "    \_/   ";
		De Otro Modo: f2 <- "          ";
	FinSegun
	Segun rueda3 Hacer
		1: f3 <- "          ";
		2: f3 <- "   \ /    ";
		3: f3 <- "    \_/   ";
		De Otro Modo: f3 <- "          ";
	FinSegun
	Escribir "      |    ", f1, "   |    ", f2, "   |    ", f3, "   |    ||       |";
	
	Escribir "      |_________________|_________________|_________________|             |";
FinSubProceso

SubProceso JACKPOT
	Escribir "  ***********************************************************";
	Escribir "  ¡¡¡ JACKPOT GIGANTE !!! ¡REVENTASTE LA BANCA CON 3 CORONAS!";
	Escribir "  ***********************************************************";
FinSubProceso

SubProceso SIN_FICHAS
	Escribir "  ___________________________________________________________";
	Escribir " |                                                           |";
	Escribir " |   Te has quedado sin fichas. ¡Mejor suerte la próxima!    |";
	Escribir " |___________________________________________________________|";
	Esperar 3 Segundos;
FinSubProceso
	