Algoritmo blackjack_proyecto
	// Variables del men
	Definir op, opc Como Entero;
	// Variables de los puntos
	Definir jugador, crupier, apuesta Como Entero;
	Definir continuar Como Logico; // Controla el turno del jugador
	
	// NUEVAS VARIABLES PARA SEGUNDA MANO (DIVIDIR)
	Definir jugadorMano2 Como Entero;
	Definir jugoMano2 Como Logico;
	
	// ---------- MEN PRINCIPAL (Envuelve todo el programa) ----------
	Repetir
		Escribir "+-----------------------------------------+";
		Escribir "|      * * *  !!BIENVENIDO!!  * * *       |";
		Escribir "|   -------------BLACKJACK------------    |";
		Escribir "+-----------------------------------------+";
		Escribir " Elija una opcion:";
		Escribir "  1. Mostrar Menu";
		Escribir "  2. Reglas del juego";
		Escribir "  3. Jugar";
		Escribir "  4. Salir";
		Escribir "===========================================";
		Leer op;
		
		Segun op Hacer
			1:
				// Solo limpia pantalla para volver a mostrar el men limpio
				Limpiar Pantalla;
				Esperar Tecla;
			2:
				// Mostrar las reglas
				Escribir "===================================================== REGLAS ==========================================================================================";
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
			3:
				//APUESTA
				
				// Reiniciar puntos y estados de la mano dividida
				jugador <- 0;
				crupier <- 0;
				jugadorMano2 <- 0;
				jugoMano2 <- Falso; // Arranca en falso porque todavía no dividió
				
				// Reparto inicial de cartas
				jugador <- jugador + SacarCarta();
				jugador <- jugador + SacarCarta();
				crupier <- crupier + SacarCarta();
				crupier <- crupier + SacarCarta();
				
				Escribir "======================================================";
				Escribir "                     BLACKJACK                        ";
				Escribir "======================================================";
				Escribir "";
				Escribir " -> Tus puntos iniciales: ", jugador;
				DibujarManoGrafica();
				Escribir " -> Puntos del crupier: ", crupier;
				DibujarManoGrafica();
				
				// ---------- TURNO DEL JUGADOR ----------
				continuar <- Verdadero; // Variable de control para evitar bucle infinito
				
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
							// Pedir carta común
							jugador <- jugador + SacarCarta();
							Escribir " (Carta) Ahora tienes ", jugador, " puntos";
							DibujarManoGrafica();
						2:
							continuar <- Falso; // El jugador se planta, salemos del Mientras
						3:
							// REGLA DOBLAR: El jugador pide una sola carta y termina su turno automáticamente
							Escribir " [x2] ¡Decidiste doblar! Recibes una ultima carta.";
							jugador <- jugador + SacarCarta();
							Escribir " (Carta) Tu puntuacion final al doblar es: ", jugador, " puntos";
							DibujarManoGrafica();
							continuar <- Falso; 
						4:
							// REGLA SEGURO: Muestra el mensaje informativo en pantalla
							Escribir " [!] Compraste un seguro en caso de que el crupier tenga Blackjack.";
							Escribir "     Se simula la proteccion de tu apuesta para esta ronda.";
						5:
							// REGLA DIVIDIR: El puntaje actual se separa en dos manos idénticas
							Escribir " [/] ¡Dividiste tu juego en dos manos independientes!";
							jugoMano2 <- Verdadero; // Activamos la bandera para saber que hay dos manos al final
							
							// Simulamos que dividimos los puntos actuales a la mitad
							jugadorMano2 <- jugador / 2;
							jugador <- jugador / 2;
							
							// Le damos una nueva carta a cada mano para completarlas
							jugador <- jugador + SacarCarta();
							jugadorMano2 <- jugadorMano2 + SacarCarta();
							
							Escribir " -> Mano 1 ahora tiene: ", jugador, " puntos";
							Escribir " -> Mano 2 ahora tiene: ", jugadorMano2, " puntos";
							DibujarManoGrafica();
						De Otro Modo:
							Escribir "Opcion invalida.";
					FinSegun
				FinMientras;
				
				// ---------- TURNO DEL CRUPIER ----------
				// El crupier solo juega si la mano 1 o la mano 2 no se pasaron de 21
				Si jugador <= 21 O (jugoMano2 = Verdadero Y jugadorMano2 <= 21) Entonces
					Mientras crupier < 17 Hacer
						crupier <- crupier + SacarCarta();
					FinMientras;
				FinSi;
				
				// Mostrar resultado final en pantalla
				Escribir "";
				Escribir "======================================================";
				Escribir "  Puntos finales jugador (Mano 1): ", jugador;
				Si jugoMano2 = Verdadero Entonces
					Escribir "  Puntos finales jugador (Mano 2): ", jugadorMano2;
				FinSi;
				Escribir "  Puntos finales crupier: ", crupier;
				Escribir "======================================================";
				Escribir "";
				
				// Evaluar ganador para la Mano 1
				Escribir "--- EVALUACION MANO 1 ---";
				MostrarGanador(jugador, crupier);
				
				// Si el jugador decidió dividir, evaluamos también su Mano 2
				Si jugoMano2 = Verdadero Entonces
					Escribir "";
					Escribir "--- EVALUACION MANO 2 ---";
					MostrarGanador(jugadorMano2, crupier);
				FinSi;
				
				Escribir "";
				Esperar Tecla;
			4:
				Escribir "Gracias por jugar. Hasta luego!";
			De Otro Modo:
				Escribir "El numero ingresado es invalido";
				Esperar Tecla;
		FinSegun;
		
	Hasta Que op = 4; // El juego se repite hasta que el usuario decida salir
FinProceso

// =======================================
// FUNCION PARA GENERAR UNA CARTA
// =======================================
Funcion carta <- SacarCarta
	Definir carta Como Entero;
	// Genera un numero entre 1 y 11
	carta <- Aleatorio(1,11);
FinFuncion

// =======================================
// SUBPROCESO PARA DECIDIR EL GANADOR
// =======================================
SubProceso MostrarGanador(jugador, crupier)
	Si jugador > 21 Entonces
		Escribir " [X] GANA EL CRUPIER! (Te pasaste de 21)";
	SiNo
		Si crupier > 21 Entonces
			Escribir " [*] GANA EL JUGADOR! (El crupier se paso de 21)";
		SiNo
			Si jugador > crupier Entonces
				Escribir " [!] GANA EL JUGADOR!";
			SiNo
				Si crupier > jugador Entonces
					Escribir " [!] GANA EL CRUPIER!";
				SiNo
					Escribir " [-] EMPATE!";
				FinSi;
			FinSi;
		FinSi;
	FinSi;
FinSubProceso

// =======================================
// SUBPROCESO AUXILIAR PARA DISEÑO ASCII
// =======================================
SubProceso DibujarManoGrafica
	Escribir "   +---------+";
	Escribir "   |  A *    |";
	Escribir "   |    * J  |";
	Escribir "   +---------+";
FinSubProceso

