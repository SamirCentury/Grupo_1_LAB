Algoritmo blackjack_proyecto
	
//	Proceso BlackJack
	
	// Variables del menú
	Definir op, opc Como Entero;
	
	// Variables de los puntos
	Definir jugador, crupier, aux_valor Como Entero;
	
	// ---------- MENU PRINCIPAL ----------
	Repetir
		
		Escribir "----------¡¡BIENVENIDO!!--------------";
		Escribir "-------------BLACKJACK----------------";
		Escribir "Elija una opcion";
		Escribir "1. menu";
		Escribir "2. reglas del juego";
		Escribir "3. jugar";
		Escribir "4. salir";
		
		Leer op;
		
		// Mostrar las reglas
		Si op = 2 Entonces
			
			Escribir "========== REGLAS ==========";
			Escribir "1. Debes acercarte a 21 puntos.";
			Escribir "2. Si superas 21 puntos pierdes.";
			Escribir "3. El crupier roba hasta llegar a 17.";
			Escribir "4. Gana quien tenga mas puntos sin pasarse.";
			
		FinSi;
		
	Mientras Que op = 1 O op = 2;
	
	// ---------- OPCIONES ----------
	Segun op Hacer
		
		3:
			
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
			Mientras jugador < 21 Hacer
				
				Escribir "";
				Escribir "1. Pedir carta";
				Escribir "2. Plantarse";
				Leer opc;
				
				Segun opc Hacer
					1:
						jugador <- jugador + SacarCarta();
						Escribir "Ahora tienes ", jugador, " puntos";
					2:
						aux_valor = jugador;
				FinSegun
				
			FinMientras;
			
			// ---------- TURNO DEL CRUPIER ----------
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
			
		4:
			
			Escribir "Gracias por jugar";
			
		De Otro Modo:
			
			Escribir "El numero ingresado es invalido";
			
	FinSegun;
	
FinProceso



// =======================================
// FUNCION PARA GENERAR UNA CARTA
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
		
		Escribir "GANA EL CRUPIER";
		
	SiNo
		
		Si crupier > 21 Entonces
			
			Escribir "GANA EL JUGADOR";
			
		SiNo
			
			Si jugador > crupier Entonces
				
				Escribir "GANA EL JUGADOR";
				
			SiNo
				
				Si crupier > jugador Entonces
					
					Escribir "GANA EL CRUPIER";
					
				SiNo
					
					Escribir "EMPATE";
					
				FinSi;
				
			FinSi;
			
		FinSi;
		
	FinSi;
	
FinSubProceso
