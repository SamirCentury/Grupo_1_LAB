SubProceso CargarColores(colores)
	Definir i Como Entero;
	
	Para i <- 1 Hasta 36 Con Paso 1 Hacer
		colores[i] = "N";
	FinPara
	
	// Casilla 0 especial, unico verde
	colores[0] = "V";

	colores[1] = "R"; colores[3] = "R"; colores[5] = "R"; colores[7] = "R";
	colores[9] = "R"; colores[12] = "R"; colores[14] = "R"; colores[16] = "R";
	colores[18] = "R"; colores[19] = "R"; colores[21] = "R"; colores[23] = "R";
	colores[25] = "R"; colores[27] = "R"; colores[30] = "R"; colores[32] = "R";
	colores[34] = "R"; colores[36] = "R";
FinSubProceso

Funcion monto = SolicitarApuesta(saldoActual)
	Definir monto Como Real;
	Repetir
		Escribir "Ingrese monto a apostar (Disponible: $", saldoActual, "):";
		Leer monto;
		Si monto <= 0 Entonces
			Escribir "Error: El monto debe ser mayor a 0.";
		FinSi
		Si monto > saldoActual Entonces
			Escribir "Error: Saldo insuficiente.";
		FinSi
	Hasta Que (monto > 0) Y (monto <= saldoActual)
FinFuncion

Funcion tipo = ElegirTipoApuesta()
	Definir tipo Como Entero;
	Repetir
		Escribir "";
		Escribir "=== TIPO DE APUESTA ===";
		Escribir "1. Pleno (Numero exacto 0-36) [Paga 35:1]";
		Escribir "2. Color (Rojo o Negro) [Paga 1:1]";
		Escribir "Seleccione una opcion (1-2):";
		Leer tipo;
		Si tipo <> 1 Y tipo <> 2 Entonces
			Escribir "Opcion invalida. Reintente.";
		FinSi
	Hasta Que tipo = 1 o tipo = 2
FinFuncion

Algoritmo Ruleta_Laboratorio
	Dimension colores[37];
	Definir colores Como Caracter;
	Definir saldo, apuesta Como Real;
	Definir tipoApuesta, numeroElegido, numeroSalio Como Entero;
	Definir colorElegido, colorSalio, seguir Como Caracter;
	
	CargarColores(colores);
	saldo = 1000;
	seguir = "S";
	
	Escribir "----------------------------------";
	Escribir " SISTEMA DE RULETA - LABORATORIO ";
	Escribir "----------------------------------";
	
	Mientras (saldo > 0) y (seguir = "S" o seguir = "s") Hacer
		Escribir "";
		Escribir ">>> Saldo actual: $", saldo;
		
		apuesta = SolicitarApuesta(saldo);
		tipoApuesta = ElegirTipoApuesta();
		
		Si tipoApuesta = 1 Entonces
			// Apuesta Pleno
			Repetir
				Escribir "Elija un numero (0 al 36):";
				Leer numeroElegido;
				Si numeroElegido < 0 o numeroElegido > 36 Entonces
					Escribir "Error: Numero fuera de rango.";
				FinSi
			Hasta Que numeroElegido >= 0 y numeroElegido <= 36
		Sino
			// Apuesta Color
			Repetir
				Escribir "Elija el color (R para Rojo / N para Negro):";
				Leer colorElegido;
				colorElegido = Mayusculas(colorElegido);
				Si colorElegido <> "R" y colorElegido <> "N" Entonces
					Escribir "Error: Debe ingresar R o N.";
				FinSi
			Hasta Que colorElegido = "R" o colorElegido = "N"
		FinSi
		
		Escribir "";
		Escribir "Girando la ruleta...";
		numeroSalio = Azar(37); // Genera 0 a 36
		colorSalio = colores[numeroSalio];
		
		Escribir "-> Bola cayó en: ", numeroSalio, " (Color: ", colorSalio, ")";
		
		// Liquidación de la apuesta
		Si tipoApuesta = 1 Entonces
			Si numeroElegido = numeroSalio Entonces
				Escribir "¡ACERTASTE EL PLENO! Ganaste $", (apuesta * 35);
				saldo = saldo + (apuesta * 35);
			Sino
				Escribir "No hubo suerte con el pleno. Perdiste $", apuesta;
				saldo = saldo - apuesta;
			FinSi
		Sino
			// Si sale el 0 (Verde), la casa siempre gana las apuestas simples
			Si colorElegido = colorSalio Y numeroSalio <> 0 Entonces
				Escribir "¡ACERTASTE EL COLOR! Ganaste $", apuesta;
				saldo = saldo + apuesta;
			Sino
				Escribir "Color incorrecto (o salio el 0). Perdiste $", apuesta;
				saldo = saldo - apuesta;
			FinSi
		FinSi
		
		Si saldo > 0 Entonces
			Escribir "";
			Escribir "¿Desea realizar otra tirada? (S/N):";
			Leer seguir;
		Sino
			Escribir "Te has quedado sin fichas.";
		FinSi
	FinMientras
	
	Escribir "";
	Escribir "Partida terminada. Te retiras con un saldo final de: $", saldo;
FinAlgoritmo