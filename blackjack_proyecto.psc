Algoritmo blackjack_proyecto
	// Variables del menú
	Definir op, opc Como Entero;
	// Variables de los puntos
	Definir jugador, crupier, apuesta Como Entero;
	Definir continuar Como Logico; // Controla el turno del jugador
	
	// ---------- MENÚ PRINCIPAL (Envuelve todo el programa) ----------
	Repetir
		Escribir "----------¡¡BIENVENIDO!!--------------";
		Escribir "-------------BLACKJACK----------------";
		Escribir "Elija una opcion:";
		Escribir "1. Mostrar Menu";
		Escribir "2. Reglas del juego";
		Escribir "3. Jugar";
		Escribir "4. Salir";
		Leer op;
		
		Segun op Hacer
			1:
				// Solo limpia pantalla para volver a mostrar el menú limpio
				Limpiar Pantalla;
				Esperar Tecla;
			2:
				// Mostrar las reglas
				Escribir "===================================================== REGLAS ==========================================================================================";
				Esperar Tecla;
				Escribir " 1. OBJETIVO BLACK JACK 21 ";
				Escribir " 	El objetivo principal es ganarle al crupier (la banca). "; 
				Escribir " 	para lograrlo, debés obtener una mano que sume lo más cerca posible a 21 puntos, "; 
				Escribir " 	pero con una condición estricta: si sumás 22 o más puntos, perdés automáticamente. ";
				Escribir " 	En este juego competís únicamente contra la banca, no contra los demás jugadores. ";
				Escribir ""; Esperar Tecla;
				Escribir " 2. EL VALOR DE LAS CARTAS ";
				Escribir "		Cartas del 2 al 10: Tienen el mismo valor que el número ";
				Escribir " 	impreso en ellas (un 5 vale 5 puntos, un 9 vale 9 puntos, etc.). ";
				Escribir " 	Figuras (J, Q, K): Valen 10 puntos cada una. ";
				Escribir " 	El As (A): Es la carta más flexible. Vale 1 u 11 puntos, aplicando de ";
				Escribir " 	forma automática el valor que más te favorezca para no pasarte de 21. ";
				Escribir ""; Esperar Tecla;
				Escribir " 3. DINAMICA DE UNA PARTIDA PASO A PASO";
				Escribir " 	Fase de apuestas: Cada jugador coloca sus fichas en la mesa antes de recibir cualquier carta. ";
				Escribir " 	El reparto inicial: El crupier reparte dos cartas boca arriba a cada jugador, "; 
				Escribir "		y se reparte a sí mismo una carta boca arriba y otra boca abajo (oculta). ";
				Escribir " 	El Blackjack Natural: Si tus dos primeras cartas son un As y una ";
				Escribir "		carta de valor 10 (10, J, Q o K), tenés BLACKJACK "; 
				Escribir "		Si el crupier no tiene lo mismo, ganás la mano inmediatamente con un ";
				Escribir "		pago de 3 a 2 (recibís 1.5 veces el valor de tu apuesta original). ";
				Escribir ""; Esperar Tecla;
				Escribir "4. OPCIONES DEL JUGADOR DURANTE SU TURNO ";
				Escribir "		Cuando sea tu turno, debés elegir una de las siguientes acciones según tus cartas: ";
				Escribir " Pedir carta (Hit): Solicitás una carta más para aumentar tu puntaje. Podés pedir todas las que quieras, ";
				Escribir "		pero si la suma pasa de 21, te pasás (*Bust*) y perdés tu apuesta al instante. ";
				Escribir " Plantarse (Stand): Si estás conforme con tu puntaje actual, decidís no recibir más cartas y finalizás tu turno. ";
				Escribir " Doblar apuesta (Double Down): Podés duplicar tu apuesta inicial. Al hacer esto, recibís obligatoriamente una sola carta más y tu turno termina. ";
				Escribir " 	Se usa habitualmente cuando tus dos primeras cartas suman 9, 10 u 11. ";
				Escribir " Dividir (Split): Si tus dos primeras cartas son del mismo valor (por ejemplo, dos 8), podés separarlas para jugar dos manos ";
				Escribir " 	independientes. Debés colocar una apuesta idéntica para la segunda mano y cada una se juega por separado. ";
				Escribir "	Seguro (Insurance): Si la carta visible del crupier es un As, podés hacer una apuesta secundaria ";
				Escribir " 	(de hasta la mitad de tu apuesta original) apostando a que el crupier tiene un 10 oculto. ";
				Escribir " 	Si el crupier tiene Blackjack, esta apuesta te paga 2 a 1. ";
				Escribir ""; Esperar Tecla;
				Escribir "5. REGLAS ESTRICTAS PARA EL CRUPIER ";
				Escribir " 	El crupier no decide cómo jugar; debe seguir estas reglas fijas de forma obligatoria: ";
				Escribir "		Si suma 16 puntos o menos: Está obligado a pedir cartas hasta alcanzar o superar los 17 puntos. ";
				Escribir "		Si suma 17 puntos o más: Está obligado a plantarse de inmediato y no puede pedir más cartas. ";
				Escribir ""; Esperar Tecla;
				Escribir "6. COMO SE DEFINEN LOS RESULTADOS Y PAGOS ";
				Escribir "		Victoria Estándar (Pago 1 a 1): Tu puntuación final es más alta que la del crupier sin pasarte de 21, ";
				Escribir " 		o el crupier se pasa de 21 y vos te mantuviste en juego. Recibís de ganancia lo mismo que apostaste. ";
				Escribir " 	Victoria por Blackjack (Pago 3 a 2): Ganás con un As y un 10 en tus dos primeras cartas. ";
				Escribir "		Empate (Push): Vos y el crupier terminan con el mismo puntaje. No gana nadie y recuperás tu apuesta intacta. ";
				Escribir "		Derrota: Te pasás de 21 puntos, o el crupier logra una puntuación más alta que la tuya sin pasarse. Perdés el dinero apostado. ";
				Escribir "=======================================================================================================================================================";
				Escribir "";
				Esperar Tecla;
			3:
				//APUESTA
				
				// Reiniciar puntos
				jugador <- 0;
				crupier <- 0;
				
				// Reparto inicial de cartas
				jugador <- jugador + SacarCarta();
				jugador <- jugador + SacarCarta();
				crupier <- crupier + SacarCarta();
				crupier <- crupier + SacarCarta();
				
				Escribir "======================================================";
				Escribir "---------------------BLACKJACK------------------------";
				Escribir "======================================================";
				Escribir "";
				Escribir "Tus puntos iniciales: ", jugador;
				Escribir "Puntos del crupier: ", crupier;
				
				// ---------- TURNO DEL JUGADOR ----------
				continuar <- Verdadero; // Variable de control para evitar bucle infinito
				
				Mientras jugador < 21 Y continuar = Verdadero Hacer
					Escribir "";
					Escribir "1. Pedir carta";
					Escribir "2. Plantarse";
					Leer opc;
					
					Segun opc Hacer
						1:
							jugador <- jugador + SacarCarta();
							Escribir "Ahora tienes ", jugador, " puntos";
						2:
							continuar <- Falso; // El jugador se planta, salimos del Mientras
						De Otro Modo:
							Escribir "Opcion invalida.";
					FinSegun
				FinMientras;
				
				// ---------- TURNO DEL CRUPIER ----------
				// El crupier solo juega si el jugador no se ha pasado de 21
				Si jugador <= 21 Entonces
					Mientras crupier < 17 Hacer
						crupier <- crupier + SacarCarta();
					FinMientras;
				FinSi;
				
				// Mostrar resultado final
				Escribir "";
				Escribir "Puntos finales jugador: ", jugador;
				Escribir "Puntos finales crupier: ", crupier;
				
				// Llamada al subproceso ganador
				MostrarGanador(jugador, crupier);
				Escribir "";
				Esperar Tecla;
			4:
				Escribir "Gracias por jugar. ¡Hasta luego!";
			De Otro Modo:
				Escribir "El numero ingresado es invalido";
				Esperar Tecla;
		FinSegun;
		
	Hasta Que op = 4; // El juego se repite hasta que el usuario decida salir
FinProceso

// =======================================
// FUNCIÓN PARA GENERAR UNA CARTA
// =======================================
Funcion carta <- SacarCarta
	Definir carta Como Entero;
	// Genera un número entre 1 y 11
	carta <- Aleatorio(1,11);
FinFuncion

// =======================================
// SUBPROCESO PARA DECIDIR EL GANADOR
// =======================================
SubProceso MostrarGanador(jugador, crupier)
	Si jugador > 21 Entonces
		Escribir "¡GANA EL CRUPIER! (Te pasaste de 21)";
	SiNo
		Si crupier > 21 Entonces
			Escribir "¡GANA EL JUGADOR! (El crupier se paso de 21)";
		SiNo
			Si jugador > crupier Entonces
				Escribir "¡GANA EL JUGADOR!";
			SiNo
				Si crupier > jugador Entonces
					Escribir "¡GANA EL CRUPIER!";
				SiNo
					Escribir "¡EMPATE!";
				FinSi;
			FinSi;
		FinSi;
	FinSi;
FinSubProceso

