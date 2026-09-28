// ==============================================================================
// BLOQUE A: PROGRAMA PRINCIPAL (PANTALLA Y MENÚ)
// -> Esto va adentro de tu "Algoritmo principal".
// -> Controla qué opción elige el usuario y conecta con las funciones de abajo.
// ==============================================================================
Algoritmo blackjack_proyecto
	
	// --- [A.1] VARIABLES DE CONTROL DEL SISTEMA ---
	Definir op Como Entero;        // Guarda la opción elegida del menú
	Definir saldo Como Real;       // Guarda la plata total acumulada del usuario
	
	saldo <- 0; // Regla: arranca en 0 para obligar a ingresar dinero antes de jugar
	
	Repetir
		Limpiar Pantalla;
		Escribir "+-----------------------------------------+";
		Escribir "|      * * *  !!BIENVENIDO!!  * * *       |";
		Escribir "|    -------------BLACKJACK------------    |";
		Escribir "+-----------------------------------------+";
		Escribir " Saldo en cuenta: $", saldo;
		Escribir "-------------------------------------------";
		Escribir " Elija una opcion:";
		Escribir "  1. Cargar saldo / Ingresar dinero";
		Escribir "  2. Reglas del juego";
		Escribir "  3. Jugar ronda";
		Escribir "  4. Salir";
		Escribir "===========================================";
		Leer op;
		
		Segun op Hacer
				// --- [CONEXIÓN 1]: LLAMA AL MÓDULO DE RECARGA ---
			1:
				CargarSaldo(saldo); // Pasa la variable saldo para aumentarla
				
				// --- [CONEXIÓN 2]: LLAMA AL TEXTO DE REGLAS ---
			2:
				MostrarReglas();
				
				// --- [CONEXIÓN 3]: VERIFICACIÓN DE FONDOS Y ARRANQUE DE RONDA ---
			3:
				// Validación obligatoria: sin dinero no se puede jugar
				Si saldo <= 0 Entonces
					Escribir "";
					Escribir " [!] Saldo insuficiente ($0). Primero ingresa dinero con la opcion 1.";
					Esperar Tecla;
				SiNo
					JugarRonda(saldo); // Si tiene fondos, arranca la partida
				FinSi;
				
				// --- [CONEXIÓN 4]: SALIDA Y CIERRE ---
			4:
				Escribir "";
				Escribir "Te retiras con un saldo final de: $", saldo;
				Escribir "Gracias por jugar. Hasta luego!";
				
			De Otro Modo:
				Escribir "Opcion incorrecta. Presiona cualquier tecla para reintentar...";
				Esperar Tecla;
		FinSegun;
		
	Hasta Que op = 4;
FinAlgoritmo


// ==============================================================================
// BLOQUE B: GESTIÓN DE DINERO (RECARGA Y APUESTAS)
// -> Si tus compañeros te piden "el módulo de dinero", les das estas dos funciones.
// ==============================================================================

// [B.1] Permite sumar dinero a la cuenta asegurando que no metan números negativos
SubProceso CargarSaldo(saldo Por Referencia)
	Definir ingreso Como Real;
	Escribir "";
	Escribir "--- PANEL DE DEPOSITOS ---";
	Repetir
		Escribir "Ingrese el monto a depositar: $";
		Leer ingreso;
		Si ingreso <= 0 Entonces
			Escribir " [!] Error: Debe ingresar una cifra mayor a 0.";
		FinSi;
	Hasta Que ingreso > 0;
	
	saldo <- saldo + ingreso; // 'Por Referencia' actualiza la variable del menú principal
	Escribir " [OK] Deposito exitoso. Saldo disponible: $", saldo;
	Esperar Tecla;
FinSubProceso

// [B.2] Solicita cuánto apostar y frena si quieren apostar más de lo que tienen
Funcion monto <- PedirMontoApuesta(saldo)
	Definir monto Como Real;
	Repetir
		Escribir "Saldo disponible para apostar: $", saldo;
		Escribir "¿Cuanto deseas apostar en esta mano?: $";
		Leer monto;
		
		Si monto <= 0 Entonces
			Escribir " [!] La apuesta minima debe ser mayor a 0.";
		SiNo
			Si monto > saldo Entonces
				Escribir " [!] Fondos insuficientes. No puedes apostar mas de lo que posees.";
			FinSi;
		FinSi;
	Hasta Que monto > 0 Y monto <= saldo; // Bucle hasta que el monto sea válido
FinFuncion


// ==============================================================================
// BLOQUE C: MOTOR DE LA RONDA DE JUEGO
// -> Este bloque contiene la mesa: cartas, decisiones y turnos.
// ==============================================================================
SubProceso JugarRonda(saldo Por Referencia)
	// --- VARIABLES DE LA PARTIDA ---
	Definir monto Como Real;
	Definir jugador, crupier Como Entero;
	Definir jugadorMano2 Como Entero;
	Definir jugoMano2, continuar Como Logico;
	Definir opc Como Entero;
	Definir resultado Como Entero; 
	
	// [C.1] Descuenta y valida la apuesta inicial de esta ronda
	monto <- PedirMontoApuesta(saldo);
	
	// [C.2] Puesta a cero de la mesa
	jugador <- 0;
	crupier <- 0;
	jugadorMano2 <- 0;
	jugoMano2 <- Falso;
	continuar <- Verdadero;
	
	// [C.3] Reparto inicial de cartas
	jugador <- jugador + SacarCarta();
	jugador <- jugador + SacarCarta();
	crupier <- crupier + SacarCarta();
	crupier <- crupier + SacarCarta();
	
	Escribir "";
	Escribir "======================================================";
	Escribir "                   MESA DE JUEGO                      ";
	Escribir "======================================================";
	Escribir " -> Tus cartas suman: ", jugador;
	DibujarManoGrafica();
	Escribir " -> Cartas del crupier: ", crupier;
	DibujarManoGrafica();
	
	// [C.4] Decisiones del jugador
	Mientras jugador < 21 Y continuar = Verdadero Hacer
		Escribir "";
		Escribir "+--------------------------------+";
		Escribir "|  1. Pedir carta (Hit)          |";
		Escribir "|  2. Plantarse (Stand)          |";
		Escribir "|  3. Doblar apuesta (Double)    |";
		Escribir "|  4. Comprar seguro (Insurance) |";
		Escribir "|  5. Dividir juego (Split)      |";
		Escribir "+--------------------------------+";
		Leer opc;
		
		Segun opc Hacer
			1:
				// Pide una carta más
				jugador <- jugador + SacarCarta();
				Escribir " (Carta) Nueva puntuacion: ", jugador;
				DibujarManoGrafica();
			2:
				// Finaliza el turno voluntariamente
				continuar <- Falso;
			3:
				// Doblar: verifica si tiene suficiente saldo para respaldar el doble
				Si saldo >= (monto * 2) Entonces
					monto <- monto * 2;
					Escribir " [x2] Apuesta duplicada a: $", monto;
					jugador <- jugador + SacarCarta();
					Escribir " (Carta) Puntuacion definitiva: ", jugador;
					DibujarManoGrafica();
					continuar <- Falso;
				SiNo
					Escribir " [!] No tienes saldo para duplicar la apuesta.";
				FinSi;
			4:
				Escribir " [!] Seguro contratado contra Blackjack del crupier.";
			5:
				// Dividir mano
				Escribir " [/] Mano dividida en dos jugadas.";
				jugoMano2 <- Verdadero;
				jugadorMano2 <- TRUNC(jugador / 2);
				jugador <- TRUNC(jugador / 2);
				jugador <- jugador + SacarCarta();
				jugadorMano2 <- jugadorMano2 + SacarCarta();
				Escribir " -> Mano 1: ", jugador, " puntos";
				Escribir " -> Mano 2: ", jugadorMano2, " puntos";
				DibujarManoGrafica();
			De Otro Modo:
				Escribir "Opcion no valida.";
		FinSegun;
	FinMientras;
	
	// [C.5] Turno automático de la banca (si el jugador sigue en carrera)
	Si jugador <= 21 O (jugoMano2 = Verdadero Y jugadorMano2 <= 21) Entonces
		Mientras crupier < 17 Hacer
			crupier <- crupier + SacarCarta();
		FinMientras;
	FinSi;
	
	// [C.6] Cierre de mano y cálculo económico
	Escribir "";
	Escribir "======================================================";
	Escribir "  Total Mano 1: ", jugador;
	Si jugoMano2 = Verdadero Entonces
		Escribir "  Total Mano 2: ", jugadorMano2;
	FinSi;
	Escribir "  Total Crupier: ", crupier;
	Escribir "======================================================";
	
	// Paga o cobra Mano 1
	Escribir "";
	Escribir "--- RESOLUCION MANO 1 ---";
	resultado <- EvaluarGanador(jugador, crupier);
	AplicarPago(resultado, monto, saldo);
	
	// Paga o cobra Mano 2 (si dividió)
	Si jugoMano2 = Verdadero Entonces
		Escribir "";
		Escribir "--- RESOLUCION MANO 2 ---";
		resultado <- EvaluarGanador(jugadorMano2, crupier);
		AplicarPago(resultado, monto, saldo);
	FinSi;
	
	Escribir "";
	Escribir "Saldo actualizado: $", saldo;
	Esperar Tecla;
FinSubProceso


// ==============================================================================
// BLOQUE D: LÓGICA DE GANADOR Y PAGOS
// -> Aquí se decide quién gana y se suma o resta plata del saldo.
// ==============================================================================

// [D.1] Compara los puntos y devuelve: 1 (Gana jugador), -1 (Gana crupier), 0 (Empate)
Funcion res <- EvaluarGanador(puntosJugador, puntosCrupier)
	Definir res Como Entero;
	Si puntosJugador > 21 Entonces
		Escribir " [X] Te pasaste de 21. Gana la casa.";
		res <- -1;
	SiNo
		Si puntosCrupier > 21 Entonces
			Escribir " [*] El crupier se paso de 21. ¡Ganaste!";
			res <- 1;
		SiNo
			Si puntosJugador > puntosCrupier Entonces
				Escribir " [!] Superaste a la banca. ¡Ganaste!";
				res <- 1;
			SiNo
				Si puntosCrupier > puntosJugador Entonces
					Escribir " [X] La banca obtuvo mejor mano. Pierdes.";
					res <- -1;
				SiNo
					Escribir " [-] Empate exacto.";
					res <- 0;
				FinSi;
			FinSi;
		FinSi;
	FinSi;
FinFuncion

// [D.2] Modifica el saldo real según el resultado del juego
SubProceso AplicarPago(resultado, monto, saldo Por Referencia)
	Si resultado = 1 Entonces
		saldo <- saldo + monto;
		Escribir " [+] Ganancia acreditada: +$", monto;
	SiNo
		Si resultado = -1 Entonces
			saldo <- saldo - monto;
			Escribir " [-] Apuesta perdida: -$", monto;
		SiNo
			Escribir " [=] Mano empatada: conservas tus $", monto;
		FinSi;
	FinSi;
FinSubProceso


// ==============================================================================
// BLOQUE E: HERRAMIENTAS AUXILIARES
// -> Cartas al azar, dibujos e impresiones de reglas.
// ==============================================================================

// [E.1] Generador de cartas aleatorias (1 al 11)
Funcion carta <- SacarCarta
	Definir carta Como Entero;
	carta <- Aleatorio(1,11);
FinFuncion

// [E.2] Gráfico decorativo de cartas
SubProceso DibujarManoGrafica
	Escribir "   +---------+";
	Escribir "   |  A *    |";
	Escribir "   |    * J  |";
	Escribir "   +---------+";
FinSubProceso

// [E.3] Texto con las reglas oficiales
SubProceso MostrarReglas
	Limpiar Pantalla;
//	Escribir "===================================================== REGLAS =====================================================";
//	Escribir " 1. OBJETIVO: Sumar 21 o lo mas cercano posible sin pasarte. Si sumas 22 o mas, pierdes.";
//	Escribir " 2. CARTAS: Numeros valen su valor facial, figuras valen 10, y el As vale 1 u 11.";
//	Escribir " 3. CRUPIER: Esta obligado a pedir carta con 16 o menos, y se planta con 17 o mas.";
//	Escribir " 4. FONDOS: Debes contar con saldo disponible para apostar o doblar.";
//	Escribir "==================================================================================================================";
//	Escribir "";
	Esperar Tecla;
	Escribir " 1. OBJETIVO BLACK JACK 21 ";
	Escribir " 	El objetivo principal es ganarle al crupier (la banca). "; 
	Escribir " 	para lograrlo, debs obtener una mano que sume lo ms cerca posible a 21 puntos, "; 
	Escribir " 	pero con una condicin estricta: si sums 22 o ms puntos, perds automticamente. ";
	Escribir " 	En este juego compets nicamente contra la banca, no contra los dems jugadores. ";
	Escribir ""; Esperar Tecla;
	Escribir " 2. EL VALOR DE LAS CARTAS ";
	Escribir "		Cartas del 2 al 10: Tienen el mismo valor que el nmero ";
	Escribir " 	impreso en ellas (un 5 vale 5 puntos, un 9 vale 9 puntos, etc.). ";
	Escribir " 	Figuras (J, Q, K): Valen 10 puntos cada una. ";
	Escribir " 	El As (A): Es la carta ms flexible. Vale 1 u 11 puntos, applying de ";
	Escribir " 	forma automtica el valor que ms te favorezca para no pasarte de 21. ";
	Escribir ""; Esperar Tecla;
	Escribir " 3. DINAMICA DE UNA PARTIDA PASO A PASO";
	Escribir " 	Fase de apuestas: Cada jugador coloca sus fichas en la mesa antes de recibir cualquier carta. ";
	Escribir " 	El reparto inicial: El crupier reparte dos cartas boca arriba a cada jugador, "; 
	Escribir "		y se reparte a s mismo una carta boca arriba y otra boca abajo (oculta). ";
	Escribir " 	El Blackjack Natural: Si tus dos primeras cartas son un As y una ";
	Escribir "		carta de valor 10 (10, J, Q o K), tens BLACKJACK "; 
	Escribir "		Si el crupier no tiene lo mismo, gans la mano inmediatamente con un ";
	Escribir "		pago de 3 a 2 (recibs 1.5 veces el valor de tu apuesta original). ";
	Escribir ""; Esperar Tecla;
	Escribir "4. OPCIONES DEL JUGADOR DURANTE SU TURNO ";
	Escribir "		Cuando sea tu turno, debs elegir una de las siguientes acciones segn tus cartas: ";
	Escribir " Pedir carta (Hit): Solicits una carta ms para aumentar tu puntaje. Pods pedir todas las que quieras, ";
	Escribir "		pero si la suma pasa de 21, te pass (*Bust*) y perds tu apuesta al instante. ";
	Escribir " Plantarse (Stand): Si ests conforme con tu puntaje actual, decids no recibir ms cartas y finalizs tu turno. ";
	Escribir " Doblar apuesta (Double Down): Pods duplicar tu apuesta inicial. Al hacer esto, recibs obligatoriamente una sola carta ms y tu turno termina. ";
	Escribir " 	Se usa habitualmente cuando tus dos primeras cartas suman 9, 10 u 11. ";
	Escribir " Dividir (Split): Si tus dos primeras cartas son del mismo valor (por ejemplo, dos 8), pods separarlas para jugar dos manos ";
	Escribir " 	independientes. Debs colocar una apuesta idntica para la segunda mano y cada una se juega por separado. ";
	Escribir "	Seguro (Insurance): Si la carta visible del crupier es un As, pods hacer una apuesta secundaria ";
	Escribir " 	(de hasta la mitad de tu apuesta original) apostando a que el crupier tiene un 10 oculto. ";
	Escribir " 	Si el crupier tiene Blackjack, esta apuesta te paga 2 a 1. ";
	Escribir ""; Esperar Tecla;
	Escribir "5. REGLAS ESTRICTAS PARA EL CRUPIER ";
	Escribir " 	El crupier no decide cmo jugar; debe seguir estas reglas fijas de forma obligatoria: ";
	Escribir "		Si suma 16 puntos o menos: Est obligado a pedir cartas hasta alcanzar o superar los 17 puntos. ";
	Escribir "		Si suma 17 puntos o ms: Est obligado a plantarse de inmediato y no puede pedir ms cartas. ";
	Escribir ""; Esperar Tecla;
	Escribir "6. COMO SE DEFINEN LOS RESULTADOS Y PAGOS ";
	Escribir "		Victoria Estndar (Pago 1 a 1): Tu puntuacin final es ms alta que la del crupier sin pasarte de 21, ";
	Escribir " 		o el crupier se pasa de 21 y vos te mantuviste en juego. Recibs de ganancia lo mismo que apostaste. ";
	Escribir " 	Victoria por Blackjack (Pago 3 a 2): Gans con un As y un 10 en tus dos primeras cartas. ";
	Escribir "		Empate (Push): Vos y el crupier terminan con el mismo puntaje. No gana nadie y recupers tu apuesta intacta. ";
	Escribir "		Derrota: Te pass de 21 puntos, o el crupier logra una puntuacin ms alta que la tuya sin pasarse. Perds el dinero apostado. ";
	Escribir "=======================================================================================================================================================";
	Escribir "";
	Esperar Tecla;
FinSubProceso