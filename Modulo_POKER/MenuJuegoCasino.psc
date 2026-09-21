Algoritmo Menu_Casino_Prueba
	Definir opcion, saldo Como Entero;
	Definir continuar Como Logico;
	
	// El usuario empieza con saldo 0 hasta que cargue en la opción 5
	saldo <- 0;
	continuar <- Verdadero;
	
	Mientras continuar Hacer
		// Mostrar el cartel de opciones
		Limpiar Pantalla;
		Escribir "=========================================";
		Escribir "          BIENVENIDO AL CASINO           ";
		Escribir "=========================================";
		Escribir "=== MENU GENERAL DEL CASINO ===";
		Escribir " Saldo actual: $", saldo;
		Escribir " 1. Jugar a la Ruleta";
		Escribir " 2. Jugar al Blackjack";
		Escribir " 3. Jugar a las Tragamonedas";
		Escribir " 4. Jugar al Poker";
		Escribir " 5. Ver Saldo / Cargar Credito";
		Escribir " 6. Salir del Casino";
		Escribir "=========================================";
		Escribir "Seleccione una opcion (1-6): " Sin Saltar;
		Leer opcion;
		
		// Evaluar la opción seleccionada
		Segun opcion Hacer
			1:
				Escribir "Entrando a la Ruleta... ¡Hagan sus apuestas!";
				Esperar Tecla;
			2:
				Escribir "Entrando al Blackjack... ¿Carta o te plantas?";
				Esperar Tecla;
			3:
				Escribir "Entrando a las Tragamonedas... ¡Suerte con el Jackpot!";
				Esperar Tecla;
			4:
				// Validación de saldo mínimo antes de entrar
				Si saldo >= 100 Entonces
					AnimacionBienvenida;
					MenuJuego(saldo); // Pasamos el saldo global
				SiNo
					Escribir "Saldo insuficiente. Tenes $", saldo, ". Necesitas al menos $100 para jugar al Poker.";
					Escribir "Por favor, carga credito en la opcion 5.";
					Esperar Tecla;
				FinSi
				
			5:
				GestionarSaldo(saldo);
				
			6:
				Escribir "Gracias por visitarnos. Te retiras con: $", saldo;
				Escribir "¡Vuelve pronto!";
				continuar <- Falso;
				
			De Otro Modo:
				Escribir "Opcion no valida. Intente de nuevo.";
				Esperar Tecla;
		FinSegun
	FinMientras
FinAlgoritmo

// SubProceso para consultar y recargar fichas/crédito
SubProceso GestionarSaldo(saldo Por Referencia)
	Definir opSaldo, recarga Como Entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir "=============================================";
		Escribir "         GESTION DE SALDO Y CREDITO          ";
		Escribir "=============================================";
		Escribir "Tu saldo disponible es: $", saldo;
		Escribir "";
		Escribir "1. Cargar Credito";
		Escribir "2. Volver al Menu Principal";
		Escribir "=============================================";
		Escribir "Seleccione una opcion: " Sin Saltar;
		Leer opSaldo;
		
		Segun opSaldo Hacer
			1:
				Repetir 
					Escribir "Ingresa el monto a cargar (Minimo $100): " Sin Saltar;
					Leer recarga;
					Si recarga < 100 Entonces
						Escribir "La carga minima debe ser de al menos $100.";
					FinSi
				Mientras Que recarga < 100;
				
				saldo <- saldo + recarga;
				Escribir "";
				Escribir "¡Carga exitosa! Tu nuevo saldo es: $", saldo;
				Escribir "Presiona ENTER para continuar...";
				Esperar Tecla;
				
			2:
				Escribir "Volviendo... Presiona ENTER";
				Esperar Tecla;
				
			De Otro Modo:
				Escribir "Por favor ingrese una opcion valida. Presiona ENTER";
				Esperar Tecla;
		FinSegun
	Mientras Que opSaldo <> 2;
FinSubProceso

SubProceso MenuJuego(saldo Por Referencia)
	Definir opcionSubMenu Como Entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir "===============================================";
		Escribir "             OPCIONES DE POKER                 ";
		Escribir "===============================================";
		Escribir "Saldo disponible: $", saldo;
		Escribir "1. Iniciar Juego";
		Escribir "2. Leer reglas y combinaciones";
		Escribir "3. Volver al menu principal";
		Escribir "===============================================";
		Escribir "Seleccione una opcion:";
		Leer opcionSubMenu;
		
		Segun opcionSubMenu Hacer
			1:
				Si saldo >= 100 Entonces
					JugarPoker(saldo);
				SiNo
					Escribir "No tenes saldo suficiente para la apuesta minima ($100).";
					Esperar Tecla;
				FinSi
			2:
				MostrarReglas;
			3:
				Escribir "Volviendo al menu del casino...";
			De Otro Modo:
				Escribir "Opcion no valida. Presiona ENTER";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionSubMenu <> 3 Y saldo >= 100;
FinSubProceso

SubProceso RealizarApuesta(saldo Por Referencia, pozo Por Referencia)
	Definir apuesta Como Entero;
	
	Escribir "===========================================";
	Escribir "Tus fichas disponibles: $", saldo;
	Escribir "===========================================";
	
	Repetir
		Escribir "Ingresa el monto a apostar para esta mano:";
		Leer apuesta;
		
		Si apuesta <= 0 Entonces
			Escribir "La apuesta debe ser mayor a $0.";
		SiNo
			Si apuesta > saldo Entonces
				Escribir "No podes apostar $", apuesta, " porque solo tenes $", saldo, ".";
			FinSi
		FinSi
	Mientras Que apuesta <= 0 O apuesta > saldo;
	
	saldo <- saldo - apuesta;
	pozo <- apuesta * 2; // La Casa iguala tu apuesta
	
	Escribir "";
	Escribir "¡Apuesta aceptada!";
	Escribir "Apostaste: $", apuesta;
	Escribir "La Casa igualo tu apuesta con: $", apuesta;
	Escribir "Pozo total acumulado en la mesa: $", pozo;
	Escribir "===========================================";
	Escribir "";
FinSubProceso

SubProceso JugarPoker(saldo Por Referencia)
	Definir j1_valores, j1_palo Como Entero;
	Dimension j1_valores[5], j1_palo[5];
	
	Definir maq_valores, maq_palo Como Entero;
	Dimension maq_valores[5], maq_palo[5];
	
	Definir puntaje_j1, puntaje_maq, i, cambiar, pos, seguir, j, cand_val, cand_palo Como Entero;
	Definir es_repetido, pos_valida Como Logico;
	Definir pos_elegidas, pozo Como Entero;
	Dimension pos_elegidas[5];
	
	Repetir
		Limpiar Pantalla;
		
		// 1. Apuesta inicial de la mano
		RealizarApuesta(saldo, pozo);
		
		// 2. Reparto de cartas
		RepartirMano(j1_valores, j1_palo);
		OrdenarMano(j1_valores, j1_palo);
		RepartirMano(maq_valores, maq_palo);
		OrdenarMano(maq_valores, maq_palo);
		
		// Mostrar la mano del jugador
		Escribir "TU MANO INICIAL:";
		Para i=0 Hasta 4 Con Paso 1 Hacer
			Escribir "Carta ",i+1,": " Sin Saltar;
			MostrarCarta(j1_palo[i],j1_valores[i]);
			Escribir "";
		Fin Para
		Escribir "";
		
		puntaje_j1 <- EvaluarMano(j1_valores, j1_palo);
		Escribir "Tienes: " Sin Saltar;
		MostrarNombreJugada(puntaje_j1);
		Escribir "";
		Escribir "";
		
		// 3. Descarte del jugador
		Para i = 0 Hasta 4 Con Paso 1 Hacer
			pos_elegidas[i] <- 0;
		FinPara
		
		Escribir "¿Cuantas cartas quiere cambiar? (0 a 5)";
		Leer cambiar;
		
		Si cambiar > 0 Entonces
			Para i=0 Hasta cambiar-1 Con Paso 1 Hacer
				Repetir
					Escribir "Ingresa la posicion que quiere cambiar (1 a 5)";
					Leer pos;
					pos_valida <- Verdadero;
					
					Si pos < 1 O pos > 5 Entonces
						Escribir "Posicion invalida. Debe ser entre 1 y 5.";
						pos_valida <- Falso;
					SiNo
						Para j=0 Hasta i Con Paso 1 Hacer 
							Si pos_elegidas[j] = pos Entonces
								Escribir "Ya elegiste la posicion ",pos,". Eligi una posicion distinta.";
								pos_valida <- Falso;
							FinSi
						FinPara
					FinSi
				Mientras Que pos_valida = Falso;
				
				pos_elegidas[i] <- pos;
				
				Repetir
					cand_val <- Aleatorio(2,14);
					cand_palo <- Aleatorio(1,4);
					es_repetido <- Falso;
					
					Para j=0 Hasta 4 Con Paso 1 Hacer
						Si j <> (pos-1) Entonces
							Si j1_valores[j] = cand_val Y j1_palo[j] = cand_palo Entonces
								es_repetido <- Verdadero;
							FinSi
						FinSi
					FinPara
				Mientras Que es_repetido = Verdadero;
				
				j1_valores[pos-1] <- cand_val;
				j1_palo[pos-1] <- cand_palo;
			Fin Para
			
			OrdenarMano(j1_valores, j1_palo);
			Escribir "";
			Escribir "TU MANO: ";
			Para i=0 Hasta 4 Con Paso 1 Hacer
				Escribir "Carta ",i+1,": " Sin Saltar;
				MostrarCarta(j1_palo[i],j1_valores[i]);
				Escribir "";
			Fin Para
			puntaje_j1 <- EvaluarMano(j1_valores, j1_palo);
			Escribir "Tu mano final es: " Sin Saltar;
			MostrarNombreJugada(puntaje_j1);
			Escribir "";
		SiNo
			Escribir "Decidiste conservar tu mano inicial";
		FinSi
		
		// 4. Descarte de la máquina
		Escribir "";
		Escribir "===========================================";
		Escribir "Turno de la maquina para cambiar de cartas...";
		Escribir "";
		DescarteMaquina(maq_valores, maq_palo);
		Escribir "===========================================";
		Escribir "";
		
		Escribir "Presione ENTER para revelar las manos y ver los resultados...";
		Esperar Tecla;
		
		// 5. Revelación y determinación de ganador
		Escribir "";
		Escribir "MANO DE LA MAQUINA:";
		Para i=0 Hasta 4 Con Paso 1 Hacer
			Escribir "Carta ",i+1,": " Sin Saltar;
			MostrarCarta(maq_palo[i],maq_valores[i]);
			Escribir "";
		Fin Para
		
		puntaje_maq <- EvaluarMano(maq_valores, maq_palo);
		Escribir "La maquina tiene: " Sin Saltar;
		MostrarNombreJugada(puntaje_maq);
		Escribir "";
		Escribir "";
		Escribir "=======================================";
		
		DeterminarGanador(j1_valores, j1_palo, maq_valores, maq_palo, saldo, pozo);
		
		// 6. Pregunta para volver a jugar
		Si saldo > 0 Entonces
			Repetir
				Escribir "";
				Escribir "¿Quieres jugar otra mano?";
				Escribir "1. Si";
				Escribir "0. No";
				Leer seguir;
				
				Si seguir <> 1 Y seguir <> 0 Entonces
					Escribir "Opcion no valida. Por favor, ingresa 1 o 0";
				FinSi
			Mientras Que seguir <> 1 Y seguir <> 0;
		SiNo
			Escribir "Te quedaste sin saldo. Volviendo al menu del casino...";
			seguir <- 0;
			Esperar Tecla;
		FinSi
		
	Mientras Que seguir = 1 Y saldo > 0;
FinSubProceso

SubProceso MostrarCarta(num_palo,num_valor)
	Definir nombre_valor, nombre_palo Como Cadena;
	
	Segun num_valor Hacer
		11: nombre_valor <- "J";
		12: nombre_valor <- "Q";
		13: nombre_valor <- "K";
		14: nombre_valor <- "As";
		De Otro Modo:
			nombre_valor <- ConvertirATexto(num_valor);
	Fin Segun
	
	Segun num_palo Hacer
		1: nombre_palo <- "Corazones";
		2: nombre_palo <- "Diamantes";
		3: nombre_palo <- "Treboles";
		4: nombre_palo <- "Picas";
	Fin Segun
	
	Escribir Sin Saltar nombre_valor, " de ", nombre_palo;
FinSubProceso

SubProceso RepartirMano(mano_valores Por Referencia, mano_palo Por Referencia)
	Definir i, j Como Entero;
	Definir candidato_valor, candidato_palo Como Entero;
	Definir es_repetido Como Logico;
	
	Para i=0 Hasta 4 Con Paso 1 Hacer
		Repetir
			candidato_valor <- Aleatorio(2,14);
			candidato_palo <- Aleatorio(1,4);
			es_repetido <- Falso;
			
			Para j=0 Hasta i-1 Con Paso 1 Hacer
				Si mano_valores[j] = candidato_valor Y mano_palo[j] = candidato_palo Entonces
					es_repetido <- Verdadero;
				Fin Si
			Fin Para
		Mientras Que es_repetido = Verdadero;
		
		mano_valores[i] <- candidato_valor;
		mano_palo[i] <- candidato_palo;
	Fin Para
FinSubProceso

SubProceso OrdenarMano(mano_valores, mano_palo)
	Definir i, j, AuxValor, AuxPalo Como Entero;
	
	Para i=0 Hasta 3 Con Paso 1 Hacer
		Para j=0 Hasta 3-i Con Paso 1 Hacer
			Si mano_valores[j] > mano_valores[j+1] Entonces
				AuxValor <- mano_valores[j];
				mano_valores[j] <- mano_valores[j+1];
				mano_valores[j+1] <- AuxValor;
				
				AuxPalo <- mano_palo[j];
				mano_palo[j] <- mano_palo[j+1];
				mano_palo[j+1] <- AuxPalo;
			Fin Si
		Fin Para
	Fin Para
FinSubProceso

Funcion puntaje <- EvaluarMano(mano_valores, mano_palo)
	Definir puntaje Como Entero;
	Definir esColor, esEscalera, esEscaleraReal Como Logico;
	Definir i, pares, trios, poker Como Entero;
	
	esColor <- Verdadero;
	Para i=0 Hasta 3 Con Paso 1 Hacer
		Si mano_palo[i] <> mano_palo[i+1] Entonces
			esColor <- Falso;
		FinSi
	Fin Para
	
	esEscalera <- Verdadero;
	Para i=0 Hasta 3 Con Paso 1 Hacer
		Si mano_valores[i+1] <> mano_valores[i] + 1 Entonces
			esEscalera <- Falso;
		FinSi
	Fin Para
	
	esEscaleraReal <- Falso;
	Si esEscalera Y mano_valores[1]=10 Y mano_valores[4]=14 Entonces
		esEscaleraReal <- Verdadero;
	FinSi
	
	Si (mano_valores[0] = mano_valores[3]) O (mano_valores[1] = mano_valores[4]) Entonces
		poker <- 1;
	FinSi
	
	Si (mano_valores[0] = mano_valores[2]) O (mano_valores[1] = mano_valores[3]) O (mano_valores[2] = mano_valores[4]) Entonces
		trios <- 1;
	FinSi
	
	Para i=0 Hasta 3 Con Paso 1 Hacer
		Si mano_valores[i] = mano_valores[i+1] Entonces
			pares <- pares + 1;
		FinSi
	Fin Para
	
	Si poker = 1 Entonces
		pares <- 0;
		trios <- 0;
	SiNo 
		Si trios = 1 Entonces
			pares <- pares - 2;
		FinSi
	FinSi
	
	Si esEscaleraReal Entonces
		puntaje <- 10;
	SiNo
		Si esEscalera Y esColor Entonces
			puntaje <- 9;
		SiNo
			Si poker = 1 Entonces
				puntaje <- 8;
			SiNo
				Si trios = 1 Y pares = 1 Entonces
					puntaje <- 7;
				SiNo
					Si esColor Entonces
						puntaje <- 6;
					SiNo
						Si esEscalera Entonces
							puntaje <- 5;
						SiNo 
							Si trios = 1 Entonces
								puntaje <- 4;
							SiNo
								Si pares = 2 Entonces
									puntaje <- 3;
								SiNo
									Si pares = 1 Entonces 
										puntaje <- 2;
									SiNo 
										puntaje <- 1;
									FinSi
								FinSi
							FinSi
						FinSi
					FinSi
				FinSi
			FinSi
		FinSi
	FinSi
FinFuncion

SubProceso MostrarNombreJugada(puntaje)
	Segun puntaje Hacer
		1: Escribir "Carta Alta";
		2: Escribir "Un Par";
		3: Escribir "Doble Par";
		4: Escribir "Trio";
		5: Escribir "Escalera";
		6: Escribir "Color";
		7: Escribir "Full House";
		8: Escribir "Poker";
		9: Escribir "Escalera de Color";
		10: Escribir "Escalera Real";
	FinSegun
FinSubProceso

SubProceso DescarteMaquina(maq_valores, maq_palo)
	Definir i, puntaje, pospar, cand_val, cand_palo, j Como Entero;
	Definir es_repetido Como Logico;
	
	puntaje <- EvaluarMano(maq_valores, maq_palo);
	
	Si puntaje = 1 Entonces
		Para i=0 Hasta 2 Con Paso 1 Hacer
			Repetir 
				cand_val <- Aleatorio(2,14);
				cand_palo <- Aleatorio(1,4);
				es_repetido <- Falso;
				
				Para j=0 Hasta 4 Con Paso 1 Hacer
					Si j <> i Entonces
						Si maq_valores[j] = cand_val Y maq_palo[j] = cand_palo Entonces
							es_repetido <- Verdadero;
						FinSi
					FinSi
				FinPara
			Mientras Que es_repetido = Verdadero;
			
			maq_valores[i] <- cand_val;
			maq_palo[i] <- cand_palo;
		FinPara
		OrdenarMano(maq_valores,maq_palo);
		Escribir "La maquina decidio cambiar 3 cartas.";
	SiNo
		Si puntaje = 2 Entonces
			pospar <- 0;
			Para i=0 Hasta 3 Con Paso 1 Hacer
				Si maq_valores[i] = maq_valores[i+1] Entonces
					pospar <- i;
				FinSi
			FinPara
			
			Para i=0 Hasta 4 Con Paso 1 Hacer
				Si i <> pospar Y i <> (pospar+1) Entonces
					maq_valores[i] <- Aleatorio(2,14);
					maq_palo[i] <- Aleatorio(1,4);
				FinSi
			FinPara
			
			OrdenarMano(maq_valores, maq_palo);
			Escribir "La maquina decidio cambiar algunas cartas.";
		SiNo
			Escribir "La maquina decidio conservar sus cartas.";
		FinSi
	FinSi
FinSubProceso

SubProceso MostrarReglas
	Limpiar Pantalla;
	Escribir "===============================================";
	Escribir "               REGLAS DEL POKER                ";
	Escribir "===============================================";
	Escribir "1. Cada jugador recibe 5 cartas.";
	Escribir "2. Podes cambiar de 0 a 5 cartas en el descarte.";
	Escribir "3. Gana la mano con la combinacion mas alta:";
	Escribir "   -Escalera Real > Escalera de Color > Poker > Full House >";
	Escribir "     Color > Escalera > Trio > Doble Par > Par > Carta Alta";
	Escribir "===============================================";
	Escribir "Presiona cualquier tecla para volver...";
	Esperar Tecla;
FinSubProceso

SubProceso DeterminarGanador (jug_valor, jug_palo, maq_valor, maq_palo, saldo Por Referencia, pozo Por Referencia)
	Definir punt_jug, punt_maq, i Como Entero;
	Definir ganador Como Entero; // 1. Jugador, 2. Maquina, 0. Empate
	Definir par_j1, par_j2, par_m1, par_m2 Como Entero;
	Definir trio_j, trio_m, poker_j, poker_m Como Entero;
	
	punt_jug <- EvaluarMano(jug_valor, jug_palo);
	punt_maq <- EvaluarMano(maq_valor, maq_palo);
	ganador <- 0;
	
	Escribir "";
	Escribir "=== RESULTADO FINAL DE LA MANO ===";
	
	Si punt_jug > punt_maq Entonces
		ganador <- 1;
	SiNo
		Si punt_maq > punt_jug Entonces
			ganador <- 2;
		SiNo
			Segun punt_jug Hacer
				1, 5, 6, 8, 9:
					Para i=4 Hasta 0 Con Paso -1 Hacer
						Si ganador = 0 Y jug_valor[i] <> maq_valor[i] Entonces
							Si jug_valor[i] > maq_valor[i] Entonces
								ganador <- 1;
							SiNo
								ganador <- 2;
							FinSi
						FinSi
					FinPara
				2:
					par_j1 <- 0;
					par_m1 <- 0;
					Para i=0 Hasta 3 Con Paso 1 Hacer 
						Si jug_valor[i] = jug_valor[i+1] Entonces
							par_j1 <- jug_valor[i];
						FinSi
						Si maq_valor[i] = maq_valor[i+1] Entonces
							par_m1 <- maq_valor[i];
						FinSi
					FinPara
					
					Si par_j1 > par_m1 Entonces
						ganador <- 1;
					SiNo
						Si par_m1 > par_j1 Entonces
							ganador <- 2;
						SiNo
							Para i = 4 Hasta 0 Con Paso -1 Hacer
								Si ganador = 0 Y jug_valor[i] <> maq_valor[i] Entonces
									Si jug_valor[i] > maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
					
				3:
					par_j1 <- 0; par_j2 <- 0; par_m1 <- 0; par_m2 <- 0;
					Para i=0 Hasta 3 Con Paso 1 Hacer 
						Si jug_valor[i] = jug_valor[i+1] Entonces
							Si par_j1 = 0 Entonces
								par_j1 <- jug_valor[i];
							SiNo
								par_j2 <- jug_valor[i];
							FinSi
						FinSi
						
						Si maq_valor[i] = maq_valor[i+1] Entonces
							Si par_m1 = 0 Entonces
								par_m1 <- maq_valor[i];
							SiNo
								par_m2 <- maq_valor[i];
							FinSi
						FinSi
					FinPara
					
					Si par_j2 > par_m2 Entonces
						ganador <- 1;
					SiNo
						Si par_m2 > par_j2 Entonces
							ganador <- 2;
						SiNo
							Si par_j1 > par_m1 Entonces
								ganador <- 1;
							SiNo
								Si par_m1 > par_j1 Entonces
									ganador <- 2;
								SiNo
									Para i = 4 Hasta 0 Con Paso -1 Hacer
										Si ganador = 0 Y jug_valor[i] <> maq_valor[i] Entonces
											Si jug_valor[i] > maq_valor[i] Entonces
												ganador <- 1;
											SiNo
												ganador <- 2;
											FinSi
										FinSi
									FinPara
								FinSi
							FinSi
						FinSi
					FinSi
					
				4:
					Para i=0 Hasta 2 Con Paso 1 Hacer
						Si jug_valor[i] = jug_valor[i+1] Y jug_valor[i+1] = jug_valor[i+2] Entonces
							trio_j <- jug_valor[i];
						FinSi
						
						Si maq_valor[i] = maq_valor[i+1] Y maq_valor[i+1] = maq_valor[i+2] Entonces 
							trio_m <- maq_valor[i];
						FinSi
					FinPara
					
					Si trio_j > trio_m Entonces
						ganador <- 1;
					SiNo
						Si trio_m > trio_j Entonces
							ganador <- 2;
						FinSi
					FinSi
					
				7:
					Para i = 0 Hasta 2 Con Paso 1 Hacer
						Si jug_valor[i] = jug_valor[i+1] Y jug_valor[i+1] = jug_valor[i+2] Entonces
							trio_j <- jug_valor[i];
						FinSi
						
						Si maq_valor[i] = maq_valor[i+1] Y maq_valor[i+1] = maq_valor[i+2] Entonces
							trio_m <- maq_valor[i];
						FinSi
					FinPara
					
					Si trio_j > trio_m Entonces
						ganador <- 1;
					SiNo
						Si trio_m > trio_j Entonces
							ganador <- 2;
						SiNo
							Para i = 4 Hasta 0 Con Paso -1 Hacer
								Si ganador = 0 Y jug_valor[i] <> maq_valor[i] Entonces
									Si jug_valor[i] > maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
				10:
					Para i=0 Hasta 1 Con Paso 1 Hacer
						Si jug_valor[i] = jug_valor[i+1] Y jug_valor[i+1] = jug_valor[i+2] Y jug_valor[i+2] = jug_valor[i+3] Entonces
							poker_j <- jug_valor[i];
						FinSi
						
						Si maq_valor[i] = maq_valor[i+1] Y maq_valor[i+1] = maq_valor[i+2] Y maq_valor[i+2] = maq_valor[i+3] Entonces
							poker_m <- maq_valor[i];
						FinSi
					FinPara
					
					Si poker_j > poker_m Entonces
						ganador <- 1;
					SiNo
						Si poker_m > poker_j Entonces
							ganador <- 2;
						SiNo
							Para i=4 Hasta 0 Con Paso -1 Hacer
								Si ganador = 0 Y jug_valor[i] <> maq_valor[i] Entonces
									Si jug_valor[i] > maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
			FinSegun
		FinSi
	FinSi
	
	// Pago y cobro del dinero según el resultado
	Si ganador = 1 Entonces
		Escribir "¡EL JUGADOR GANA LA MANO!";
		saldo <- saldo + pozo;
		Escribir "¡Ganaste $", pozo, "! Tu nuevo saldo es: $", saldo;
	SiNo
		Si ganador = 2 Entonces
			Escribir "¡LA MAQUINA GANA LA MANO!";
			Escribir "Perdiste la apuesta. Te quedan: $", saldo;
		SiNo
			Escribir "¡EMPATE ABSOLUTO!";
			saldo <- saldo + (pozo / 2);
			Escribir "Se te devuelve tu apuesta. Saldo actual: $", saldo;
		FinSi
	FinSi
FinSubProceso

SubProceso AnimacionBienvenida
	Definir i Como Entero;
	
	Para i <- 1 Hasta 3 Con Paso 1 Hacer
		Limpiar Pantalla;
		Escribir "==========================================================";
		Escribir "    ____    ____    _   __ _____ ____   ";
		Escribir "   / __ \ / __ \ | |/ /| ____|  _ \  ";
		Escribir "  / /_/ // /_/ / | ' "/ |  _| | |_) | ";
		Escribir " / ____// ____/  | . \ | |___|  _ <  ";
		Escribir " /_/    /_/      |_|\_\|_____|_| \_\ ";
		Escribir "                                                          ";
		Escribir "    [+]---------- CASINO NIGHT CLUB ----------[+]";
		Escribir "==========================================================";
		Escribir "";
		Escribir "          < < <  PRESIONA ENTER PARA JUGAR  > > >          ";
		Esperar 400 Milisegundos;
		
		Limpiar Pantalla;
		Escribir "==========================================================";
		Escribir "    ____    ____    _   __ _____ ____   ";
		Escribir "   / __ \ / __ \ | |/ /| ____|  _ \  ";
		Escribir "  / /_/ // /_/ / | ' "/ |  _| | |_) | ";
		Escribir " / ____// ____/  | . \ | |___|  _ <  ";
		Escribir " /_/    /_/      |_|\_\|_____|_| \_\ ";
		Escribir "                                                          ";
		Escribir "    [+]---------- CASINO NIGHT CLUB ----------[+]";
		Escribir "==========================================================";
		Escribir "";
		Escribir "          . . .                               . . .          ";
		Esperar 300 Milisegundos;
		Limpiar Pantalla;
	FinPara
	
	Escribir "";
	Escribir "  --> [ Presiona ENTER para repartir la primera mano ] ";
	Esperar Tecla;
	Limpiar Pantalla;
FinSubProceso