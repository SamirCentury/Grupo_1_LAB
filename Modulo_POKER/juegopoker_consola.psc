Algoritmo juegopoker_consola
	
	definir op como entero
	
	Repetir
		Escribir "=== MENU DE JUEGOS ==="
		Escribir "1. Jugar al Poker."
		Escribir "2. Salir."
		Escribir "Selecciona una opción."
		Leer op
		
		Segun op Hacer
			1: 
				AnimacionBienvenida
				MenuJuego
				
			2: 
			    Escribir "¡Gracias por jugar!"
				
			De otro modo: 
				Escribir "Opción no valida."
		FinSegun
	Mientras Que  op <> 2
	
FinAlgoritmo

SubProceso JugarPoker
	
	
	//Arreglo para Jugador 1
	Definir j1_valores, j1_palo Como Entero
	Dimension j1_valores[5], j1_palo[5]

	//Arreglos de la maquina
	Definir maq_valores, maq_palo Como Entero
	Dimension maq_valores[5], maq_palo[5]

	Definir puntaje_j1, puntaje_maq, i, cambiar, pos, seguir como Entero
	
	Repetir
		
		//Usamos las funciones creadas
		RepartirMano(j1_valores, j1_palo)
		OrdenarMano(j1_valores, j1_palo)
		
		RepartirMano(maq_valores, maq_palo)
		OrdenarMano(maq_valores, maq_palo)
	
		//Mostrar la mano del jugador
		Escribir "TU MANO INICIAL:"
		Para i=0 Hasta 4 Con Paso 1 Hacer
			Escribir "Carta ",i+1,": " Sin Saltar
			MostrarCarta(j1_palo[i],j1_valores[i])
			Escribir ""
		Fin Para
		Escribir ""
		
		puntaje_j1 <- EvaluarMano(j1_valores, j1_palo)
		Escribir "Tienes: " Sin Saltar
		MostrarNombreJugada(puntaje_j1)
		Escribir ""
		Escribir ""
		//Posibilidad de cambiar de cartas para el jugador
		Escribir "¿Cuantas cartas quiere cambiar? (0 a 5)"
		leer cambiar
		si cambiar>0 Entonces
			Para i=0 Hasta cambiar-1 Con Paso 1 Hacer
				Escribir "Ingresá la posición que quiere cambiar (1 a 5)"
				leer pos
				j1_valores[pos-1] <- Aleatorio(2,14)
				j1_palo[pos-1] <- Aleatorio(1,4)
			Fin Para
			//Reordenamos la mano tras el cambio
			OrdenarMano(j1_valores, j1_palo)
			Escribir ""
		Escribir "TU MANO: "
		Para i=0 Hasta 4 Con Paso 1 Hacer
			Escribir "Carta ",i+1,": " Sin Saltar
			MostrarCarta(j1_palo[i],j1_valores[i])
			Escribir ""
		Fin Para
			puntaje_j1 <- EvaluarMano(j1_valores, j1_palo)
			Escribir "Tu mano final es: " sin saltar
			MostrarNombreJugada(puntaje_j1)
			Escribir ""
		SiNo
			Escribir "Decidiste conservar tu mano inicial"
		FinSi
		//Fase de descarte de la maquina
		Escribir ""
		Escribir "==========================================="
		Escribir "Turno de la maquina para cambiar de cartas..."
		Escribir ""
		DescarteMaquina(maq_valores, maq_palo)
		Escribir "==========================================="
		Escribir ""
		
		Escribir "Presione ENTER para revelar las manos y  ver los resultados..."
		esperar tecla
		//Revelacion y evaluacion final
		Escribir ""
		Escribir "MANO DE LA MAQUINA:"
		Para i=0 Hasta 4 Con Paso 1 Hacer
			Escribir "Carta ",i+1,": " Sin Saltar
			MostrarCarta(maq_palo[i],maq_valores[i])
			Escribir ""
		Fin Para
		puntaje_maq <- EvaluarMano(maq_valores, maq_palo)
		Escribir "La maquina tiene: " sin saltar
		MostrarNombreJugada(puntaje_maq)
		Escribir ""
		Escribir ""
		Escribir "======================================="
		
		//Definicion del Ganador 
		Si  puntaje_j1 > puntaje_maq Entonces
			Escribir "¡FELICITACIONES! Ganaste la partida."
		SiNo
			Si puntaje_maq > puntaje_j1 Entonces
				Escribir "Gana la Máquina. ¡Suerte para la próxima!"
			Sino 
				Escribir "¡Empate técnico en la partida!"
			FinSi
		FinSi
		
	//Preguntar al usuario si quiere seguir jugando
		Repetir
			Escribir ""
			Escribir "¿Quieres jugar otra mano?"
			Escribir "1. Si"
			Escribir "0. No"
			leer seguir
		
			si seguir <> 1 y seguir <> 0 Entonces
				Escribir "Opción no valida. Por favor, ingresá 1 o 0"
			FinSi
		Mientras Que seguir <> 1 y seguir <> 0
	Mientras Que seguir = 1


FinSubProceso


//Este subproceso recibe el número de valor y palo, y se encarga
//de escribir en pantalla el nombre real de la carta
SubProceso MostrarCarta(num_palo,num_valor)
	
	definir nombre_valor, nombre_palo como cadena
	
	//1. mostramos el número de num_valor a texto
	Segun num_valor Hacer
		11: nombre_valor <- "J"
		12: nombre_valor <- "Q"
		13: nombre_valor <- "K"
		14: nombre_valor <- "As"
		De Otro Modo:
			nombre_valor <- ConvertirATexto(num_valor) //convierte números del 2 al 10
	Fin Segun
	
	//2. Mostramos el número de num_palo a texto
	Segun num_palo Hacer
		1: nombre_palo <- "Corazones"
		2: nombre_palo <- "Diamantes"
		3: nombre_palo <- "Treboles"
		4: nombre_palo <- "Picas"
	Fin Segun
	
	Escribir sin saltar nombre_valor " de ",nombre_palo
	
FinSubProceso

//Este subproceso reparte 5 cartas unicas sin repetir 
SubProceso RepartirMano(Mano_valores, mano_palo)
	definir i,j como entero
	definir candidato_valor, candidato_palo Como Entero
	definir es_repetido Como Logico
	
	Para i=0 Hasta 4 Con Paso 1 Hacer
		Repetir
			candidato_valor <- Aleatorio(2,14)
			candidato_palo <- Aleatorio(1,4)
			
			//revisamos si hay duplicados con las cartas anteriores
			Para j=0 Hasta i-1 Con Paso 1 Hacer
				Si mano_valores[j] = candidato_valor y mano_palo[j] = candidato_palo Entonces
					es_repetido <- verdadero
				Fin Si
			Fin Para
		Mientras Que es_repetido = verdadero
		
		//Al salir del bucle guardamos en la posicion i
		mano_valores[i] <- candidato_valor
		mano_palo[i] <- candidato_palo
	Fin Para
	
FinSubProceso



SubProceso OrdenarMano(mano_valores,mano_palo)
	
	definir i,j,AuxValor,AuxPalo Como Entero
	
	Para i=0 Hasta 3 Con Paso 1 Hacer
		Para j=0 Hasta 3-i Con Paso 1 Hacer
			//Si la carta actual es mayor que la siguiente, las intercambiamos 
			Si mano_valores[j] > mano_valores[j+1] Entonces
				//Intercambio de valores
				AuxValor <- mano_valores[j]
				mano_valores[j] <- mano_valores[j+1]
				mano_valores[j+1] <- AuxValor
				
				//Intercambio de palos (para mantener la carta unida)
				AuxPalo <- mano_palo[j]
				mano_palo[j] <- mano_palo[j+1]
				mano_palo[j+1] <- AuxPalo
			Fin Si
		Fin Para
	Fin Para
FinSubProceso

Funcion puntaje <- EvaluarMano(mano_valores, mano_palo)
	Definir puntaje como entero
	Definir esColor, esEscalera como logico
	Definir i, pares, trios, poker Como Entero
	
	//1. Verificación de Color (todos los palos iguales)
	esColor <- Verdadero
	Para i=0 Hasta 3 Con Paso 1 Hacer
		si mano_palo[i]<>mano_palo[i+1] Entonces
			esColor <- falso
		FinSi
	Fin Para
	
	//2. Verificación de Escalera (valores correlativos)
	esEscalera <- Verdadero
	Para i=0 Hasta 3 Con Paso 1 Hacer
		si mano_valores[i+1]<>mano_valores[i] + 1 Entonces
			esEscalera <- falso
		FinSi
	Fin Para
	
	//3. Conteo de repeticiones de valores
	pares <- 0
	trios <- 0
	poker <- 0
	
	//Evaluamos las cartas iguales agrupadas
	Si (mano_valores[0] = mano_valores[3]) o (mano_valores[1] = mano_valores[4]) Entonces
		poker <- 1
	Sino 
		//Verificamos trios posibles en un vector ordenado de 5 elementos 
		Si (mano_valores[0] = mano_valores[2]) o (mano_valores[1] = mano_valores[3]) o (mano_valores[2] = mano_valores[4]) Entonces
			trios <- 1
		FinSi
		
		//Verificamos cantidad de pares
		Para i=0 Hasta 3 Con Paso 1 Hacer
			Si mano_valores[i] = mano_valores[i+1] Entonces
				pares <- pares + 1
			FinSi
		Fin Para
		
		//Ajuste: si hay un trio, el bucle anterior cuenta 2 pares consecutivos 
		Si trios = 1 Entonces
			pares <- pares - 2
		FinSi
	FinSi
	
	//4. Determinación del puntaje final
	Si esEscalera y esColor Entonces
		puntaje <- 9 //Escalera de color
	SiNo
		Si poker = 1 Entonces
			puntaje <- 8 //Poker (4 cartas iguales)
		SiNo
			Si trios = 1 y pares = 1 Entonces
				puntaje <- 7 //Full House (trio + par)
			SiNo
				Si esColor Entonces
					puntaje <- 6 //Color
				SiNo
					Si esEscalera Entonces
						puntaje <- 5 //Escalera
					Sino 
						Si trios = 1 Entonces
							puntaje <- 4 //trios
						SiNo
							Si pares = 2 Entonces
								puntaje <- 3 //doble par
							SiNo
								Si pares = 1 Entonces 
									puntaje <- 2 //par
								Sino 
									puntaje <- 1 //Carta Alta
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
		1: Escribir "Carta Alta"
		2: Escribir "Un Par"
		3: Escribir "Doble Par"
		4: Escribir "Trio"
		5: Escribir "Escalera"
		6: Escribir "Color"
		7: Escribir "Full House"
		8: Escribir "Poker"
		9: Escribir "Escalera de Color"
	FinSegun
FinSubProceso

SubProceso DescarteMaquina(maq_valores, maq_palo)
	definir i, puntaje,pospar como entero
	
	//Evaluamos la mano inicial de la maquina
	puntaje <- EvaluarMano(maq_valores, maq_palo)
	
	//Estrategia segun su puntaje actual
	Si puntaje = 1 Entonces //carta alta
		//Si tiene carta alta, cambia las 3 cartas mas bajas
		Para i=0 hasta 2 con paso 1 Hacer
			maq_valores[i] <- Aleatorio(2,14)
			maq_palo[i] <- Aleatorio(1,4)
		FinPara
		OrdenarMano(maq_valores,maq_palo)
		Escribir "La máquina decidió cambiar 3 cartas."
	SiNo
		si puntaje = 2 Entonces //un par
			
			pospar <- 0
			//Buscamos en que posición estan las 2 cartas iguales
			para i=0 hasta 3 con paso 1 Hacer
				si maq_valores[i] = maq_valores[i+1] Entonces
					pospar <- i //Guardamos donde empieza el par
				FinSi
			FinPara
			
			//Cambiamos todas las cartas que no sean las del Par
			para i=0 hasta 4 con paso 1 Hacer
				si i <> pospar y i <> (pospar+1) Entonces
					maq_valores[i] <-  Aleatorio(2,14)
					maq_palo[i] <- Aleatorio(1,4)
				FinSi
			FinPara
			
			OrdenarMano(maq_valores, maq_palo)
			Escribir "La máquina decidió conservar su par y cambiar 3 cartas."
		SiNo
			//Si tiene doble par, trio o superior, prefiere conservar su mano
			Escribir "La máquina decidió conservar sus cartas."
		FinSi
	FinSi
FinSubProceso

SubProceso MenuJuego
	definir opcionSubMenu como entero
	
	Limpiar Pantalla
	Escribir "==============================================="
	Escribir "            OPCIONES DE JUEGO                  "
	Escribir "==============================================="
	Escribir "1. Iniciar Juego"
	Escribir "2. Leer reglas y combinaciones"
	Escribir "3. Volver al menú principal"
	Escribir "==============================================="
	Escribir "Selecciones una opción"
	Leer opcionSubMenu
	Segun opcionSubMenu Hacer
		1:JugarPoker
		2:MostrarReglas
		3:Escribir "" //regresa al menu principal
		de otro modo:
			Escribir "Opción no valida. Presiona ENTER"
			Esperar Tecla
	FinSegun
FinSubProceso

SubProceso MostrarReglas
	Limpiar Pantalla
	Escribir "==============================================="
	Escribir "              REGLAS DEL PÓKER                 "
	Escribir "==============================================="
	Escribir "1. Cada jugador recibe 5 cartas."
	Escribir "2. Podés cambiar de 0 a 5 cartas en el descarte."
	Escribir "3. Gana la mano con la combinación más alta:"
	Escribir "   - Escalera de Color > Poker > Full House >"
	Escribir "     Color > Escalera > Trio > Doble Par > Par"
	Escribir "==============================================="
	Escribir "Presioná cualquier tecla para volver..."
	Esperar Tecla
FinSubProceso



//GRAFICOS
SubProceso AnimacionBienvenida
    Definir i Como Entero
    
    Para i <- 1 Hasta 3 Con Paso 1 Hacer
        Limpiar Pantalla
        Escribir "=========================================================="
        Escribir "   ____   ____   _  __ _____ ____   "
        Escribir "  / __ \ / __ \ | |/ /| ____|  _ \  "
        Escribir " / /_/ // /_/ / | ' "/ |  _| | |_) | "
        Escribir "/ ____// ____/  | . \ | |___|  _ <  "
        Escribir "/_/    /_/      |_|\_\|_____|_| \_\ "
        Escribir "                                                          "
        Escribir "    [+]---------- CASINO NIGHT CLUB ----------[+]"
        Escribir "=========================================================="
        Escribir ""
        Escribir "         < < <  PRESIONA ENTER PARA JUGAR  > > >          "
        Esperar 400 Milisegundos
        
        Limpiar Pantalla
        Escribir "=========================================================="
        Escribir "   ____   ____   _  __ _____ ____   "
        Escribir "  / __ \ / __ \ | |/ /| ____|  _ \  "
        Escribir " / /_/ // /_/ / | ' "/ |  _| | |_) | "
        Escribir "/ ____// ____/  | . \ | |___|  _ <  "
        Escribir "/_/    /_/      |_|\_\|_____|_| \_\ "
        Escribir "                                                          "
        Escribir "    [+]---------- CASINO NIGHT CLUB ----------[+]"
        Escribir "=========================================================="
        Escribir ""
        Escribir "         . . .                             . . .          "
        Esperar 300 Milisegundos
    FinPara
	
    Escribir ""
    Escribir "  --> [ Presiona ENTER para repartir la primera mano ] "
    Esperar Tecla
    Limpiar Pantalla
FinSubProceso




	