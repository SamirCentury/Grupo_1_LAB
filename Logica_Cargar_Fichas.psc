Algoritmo Logica_Cargar_Fichas
	
	definir saldo Como Entero;
	
	GestionarSaldo(saldo);
	RealizarApuesta(saldo,pozo);
	
FinAlgoritmo
//Inicio de la logica de Cargar fichas

SubProceso RealizarApuesta(saldo por referencia, pozo Por Referencia)
	definir apuesta como entero;
	Escribir "======================================";
	Escribir "Tus fichas: ",saldo;
	Escribir "======================================";
	
	//Bucle de validacion
	repetir
		Escribir "Ingresa el monto a apostar para esta mano: ";
		leer apuesta;
		
		Si apuesta <= 0 Entonces
			Escribir "La apuesta debe ser mayor a 0";
		FinSi
		
		si apuesta > saldo Entonces
			Escribir "No podes apostar mas fichas de las que tenes.";
		FinSi
	Mientras Que apuesta <= 0 o apuesta > saldo;
	
	//El jugador pone su apuesta y la casa pone el mismo monto en el pozo
	saldo <- saldo - apuesta;
	pozo <- apuesta*2;
	
	Escribir "";
	Escribir "¡Apuesta aceptada!";
	Escribir "Apostaste: $",apuesta;
	EScribir "La casa igualo tu apuesta con: $",apuesta;
	Escribir "Pozo total en la mesa: $",pozo;
	Escribir "=========================================================";
	EScribir "";
	
FinSubProceso

//SubProceso para consultar y recargar fichas/credito
SubProceso GestionarSaldo(saldo Por Referencia)
	definir opSaldo, recarga Como Entero;
	
	Limpiar Pantalla;
	Repetir
		Escribir "=============================================";
		Escribir "         GESTION DE SALDO Y CREDITO          ";
		Escribir "=============================================";
		Escribir "Tu saldo disponible es: $", saldo;
		Escribir "";
		Escribir "1. Cargar Credito";
		Escribir "2. Volver al Menu Principal";
		Escribir "=============================================";
		Escribir "Seleccione una opcion: " Sin Saltar;
		leer opSaldo;
		
		Segun opSaldo hacer
			1:
				Repetir 
					Escribir "Ingresa el monto a cargar (Minimo $100): " sin saltar;
					leer recarga;
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
				Escribir "Volviendo al menu principal...";
			De Otro Modo:
				Escribir "Por favor ingrese una opcion valida. Presiona ENTER";
				Esperar Tecla;
		FinSegun
	Mientras Que opSaldo <> 2;
FinSubProceso

//Fin de la logica de Cargar fichas