Algoritmo Casino_Virtual_Optimizado
	//========================================================
	//1. CONFIGURACION E INICIALIZACION DE DATOS
	//========================================================
	
	//Definimos la cantidad maxima de usuarios que soporta el sistema (2 precargados + 1 nuevo)
	definir MAX_USUARIOS Como Entero;
	MAX_USUARIOS <- 3;
	
	//Arreglos paralelos: la posicion [i] de cada vector corresponde al mismo usuario
	Dimension listaUsuarios[MAX_USUARIOS];
	Dimension listaClaves[MAX_USUARIOS];
	Dimension listaSaldos[MAX_USUARIOS];
	
	definir listaUsuarios, listaClaves como cadena;
	definir listaSaldos como real;
	
	//Variables de control para la navegacion del menu principal
	definir opcion, idSesion como entero;
	
	//Precarga del Usuario 1(Administrador)
	listaUsuarios[0] <- "admin";
	listaClaves[0] <- "1234";
	listaSaldos[0] <- 5000;
	
	//Precarga del Usuario 2 (Jugador de prueba)
	listaUsuarios[1] <- "jugador1";
	listaClaves[1] <- "0000";
	listaSaldos[1] <- 1000;
	
	//Reserva de la posicion 3 (Vacia, lista para cuando se registre alguien)
	listaUsuarios[2] <- "";
	listaClaves[2] <- "";
	listaSaldos[2] <- 0;
	
	//===================================================================
	//2- BUCLE DEL MENU PRINCIPAL DEL SISTEMA
	//===================================================================
	
	Repetir
		Limpiar Pantalla;
		Escribir "=============================================";
		Escribir "      BIENVENIDO AL CASINO - ELTIMBO         ";
		Escribir "=============================================";
		Escribir "1. Iniciar Sesion.";
		Escribir "2. Registrarse.";
		Escribir "3. Salir del Casino.";
		Escribir "=============================================";
		Escribir "Seleccione una opcion:";
		leer opcion;
		
		Segun opcion hacer
			1:
				//Llamamos a la funcion de autenticacion y guardamos la posicion del usuario devuelta 
				idSesion <- IniciarSesion(listaUsuarios, listaClaves, MAX_USUARIOS);
				
				//Si idSesion es distinto de -1, siginifica que el login es exitoso/correcto
				si idSesion <> -1 Entonces
					//Validacion  de rol: si el usuaio es "admin", va al panel  de control
					si listaUsuarios[idSesion] = "admin" Entonces
						MenuAdmin(listaUsuarios, listaClaves, listaSaldos, MAX_USUARIOS);
					SiNo
						// Si es jugador comun, va a la sala de juegos
						MenuCasino(listaUsuarios[idSesion], listaSaldos[idSesion]);
					FinSi
				FinSi
			2:
				//Pasamos los arreglos por referencia para guardar al usuario en la posicion libre
				RegistrarUsuario(listaUsuarios, listaClaves, listaSaldos, MAX_USUARIOS);
			3:
				Escribir "Gracias por visitar el casino. ¡Hasta luego!";
			De Otro Modo:
				Escribir "Opcion no valida. Intente nuevamente";
				Esperar Tecla;
		FinSegun
		
	//El programa sigue corriendo hasta que el usuario elija la opcion 3 (Salir)	
	Mientras Que opcion <> 3 
FinAlgoritmo

//=========================================================================
// INICIO DE SESION
//Devuelve un numero entero: el numero de indice (1, 2 o 3) si coincide, o 0 si falla
//=========================================================================

Funcion idEncontrado <-  IniciarSesion(listaUsuarios, listaClaves, max)
	
	definir usuario, contrasena como cadena;
	definir i, idEncontrado Como Entero;
	
	Limpiar Pantalla;
	Escribir "=== INICIO DE SESION ===";
	Escribir "Usuario:";
	leer usuario;
	Escribir "Clave:";
	leer contrasena;
	
	//Inicializamos en -1 (asumiendo que por defecto NO se encontro coincidencia) (significa no encontrado)
	idEncontrado <- -1;
	
	//Recorremos el vector desde la posicion 1 hasta MAX_USUARIOS
	Para i=0 hasta max-1 Hacer
		//Si coinciden el usuario y la clave, y el casillero NO esta vacio
		si listaUsuarios[i] = usuario y listaClaves[i] = contrasena y usuario <> "" Entonces
			idEncontrado <- i; //Guardamos el numero de posicion donde se encontro al usuario
		FinSi
	FinPara
	
	//Si tras recorrer todo el arreglo sigue en -1, las credenciales eran falsas
	si idEncontrado = -1 Entonces
		Escribir "Usuario o clave incorrectos.";
		Esperar Tecla;
	FinSi
FinFuncion

//=====================================================================
// PANEL DEL ADMINISTRADOR
// Permite auditar usuarios, ver saldos del sistema y modificar cuentas
//=====================================================================
SubProceso MenuAdmin(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia, max)
	
	definir opcionAdmin, i, usuarioModificar, tipoAjuste Como Entero;
	definir nuevoSaldo, montoAjuste como real;
	
	Repetir
		Limpiar Pantalla;
		Escribir "===================================================";
		Escribir "       PANEL DE CONTROL (ADMINISTRADOR)            ";
		Escribir "===================================================";
		Escribir "1. Listar todos los usuarios y saldos";
		Escribir "2. Modificar saldo a un usuario";
		Escribir "3. Cerrar Sesion de Administrador";
		Escribir "===================================================";
		Escribir "Seleccione una opcion:";
		leer opcionAdmin;
		
		Segun opcionAdmin Hacer
			1:
				Limpiar Pantalla;
				Escribir "=== REPORTES DEL SISTEMA ===";
				Escribir "POS| USUARIO           | SALDO";
				Escribir "----------------------------------";
				
				// Recorremos todo el arreglo desde la pos 0 hasta max-1
				Para i = 0 hasta max-1 con paso 1 Hacer
					//verificamos si la posicion actual contiene un usuario registrado
					//o si es una casilla vacia
					si listaUsuarios[i] <> "" Entonces
						Escribir "[", i, "] ", listaUsuarios[i], "                $",listaSaldos[i];
					SiNo
						//Notificamos el espacio libre para que el admin identifique
						//cuantos cupos quedan disponibles para nuevos registros
						Escribir "[", i, "] (Espacio Libre)";
					FinSi
				FinPara
				
				Escribir "-------------------------------------------";
				Esperar Tecla;
				
				//=================================================
				// Modificacion manual de saldos 
				// Permitir correcciones monetarias por errores del sistema,
				//carga directo en caja o penalizaciones
				//=================================================
				
			2:
				Limpiar Pantalla;
				Escribir "=== MODIFICAR SALDO DE USUARIO ===";
				Escribir "Ingrese la posicion del usuario a modificar (0 a ", max - 1, "):";
				leer usuarioModificar;
				
				// BARRERA DE SEGURIDAD
				// Previene colapsos del sistema al asegurar que el indice ingresado
				// exista realmente dentro del limite del arreglo
				
				si usuarioModificar >= 0 y usuarioModificar < max Entonces
					//Se verifica que la casilla seleccionada no este vacia antes de intentar
					//asignarle dinero
					si listaUsuarios[usuarioModificar] <> "" Entonces
						Escribir "Usuario seleccionado: ", listaUsuarios[usuarioModificar];
						Escribir "Saldo actual: $", listaSaldos[usuarioModificar];
						Escribir "Ingrese el nuevo saldo total:";
						Escribir "----------------------------------------------";
						Escribir "1. Sumar saldo.";
						Escribir "2. Restar saldo.";
						Escribir "3. Fijar saldo (sobreescribir)";
						Escribir "Seleccione el tipo de operacion";
						leer tipoAjuste;
						
						segun tipoAjuste Hacer
							1: 
								Escribir "Ingrese el monto a sumar: ";
								leer montoAjuste;
								si montoAjuste > 0 Entonces
									listaSaldos[usuarioModificar] <- listaSaldos[usuarioModificar] + montoAjuste;
									Escribir "¡Monto acreditado! Nuevo saldo: $", listaSaldos[usuarioModificar];
								SiNo
									Escribir "Error: El monto a sumar debe ser positivo.";
								FinSi
							2:
								Escribir "Ingrese el monto a Restar:";
								leer montoAjuste;
								si montoAjuste > 0 Entonces
									Si listaSaldos[usuarioModificar] >= montoAjuste Entonces
										listaSaldos[usuarioModificar] <- listaSaldos[usuarioModificar] - montoAjuste;
										Escribir "¡Monto debitado! Nuevo saldo: $", listaSaldos[usuarioModificar];
									SiNo
										Escribir "Error: El usuario no tiene suficiente saldo para debitar ese monto.";
									FinSi
								SiNo
									Escribir "Error: El monto a restar debe ser positivo";
								FinSi
							3:
								Escribir "Ingrese el nuevo saldo total a fijar:";
								leer nuevoSaldo;
								si nuevoSaldo >= 0 Entonces
									listaSaldos[usuarioModificar] <- nuevoSaldo;
									Escribir "¡Saldo fijado correctamente! Nuevo saldo: $", listaSaldos[usuarioModificar];
								SiNo
									Escribir "Error: El saldo no puede ser negativo.";
									
								FinSi
							De Otro Modo:
								Escribir "Opcionde ajuste no valida.";
						FinSegun
					SiNo
						Escribir "Error: La posicion seleccionada no contiene ningun usuario registrado.";
					FinSi
				SiNo
					Escribir "Error: Posicion fuera de rango. Ingrese un valor valido.";
				FinSi
				Esperar Tecla;
			3: 
				Escribir "Cerrando panel de administracion...";
				Esperar Tecla;
			De Otro Modo:
				Escribir "Opcion no valida. Seleccione un numero del 1 al 3.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionAdmin <> 3 // Condicion de salida 
	
FinSubProceso

//=====================================================================
//REGISTRO DINAMICO DE USUARIOS
//Se usa por referencia para actualizar directamente los vectores del programa
//=====================================================================
SubProceso RegistrarUsuario(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia, max)
	
	definir i,  posLibre Como Entero;
	definir nuevoUsuario, nuevaClave como cadena;
	definir existe como logico;
	
	posLibre <- 0;
	
	//Buscamos el primer espacio vacio en el vector (donde listaUsuarios[i] sea igual a "")
	Para i = 0 hasta max-1 Hacer
		si listaUsuarios[i] = "" y posLibre = 0 Entonces
			posLibre <- i; //Guardamos el indice disponible
		FinSi
	FinPara
	
	//Verificamos si no se encontro ninguna posicion libre (posLibre sigue siendo 0)
	si posLibre = 0 Entonces
		Escribir "El sistema no acepta mas usuarios (cupo lleno)";
		Esperar Tecla;
	SiNo
		Limpiar Pantalla;
		Escribir "=== REGISTRO DE USUARIO ===";
		Escribir "Ingrese nombre de usuario:";
		leer nuevoUsuario;
		
		//Comprobamos que el usuario ingresado no exista previamente en el arreglo
		existe <- falso;
		para i = 0 hasta max-1 Hacer
			si listaUsuarios[i] = nuevoUsuario y nuevoUsuario <> "" Entonces
				existe <- Verdadero; //Si se encuentra un nombre identico, marcamos la bandera
			FinSi
		FinPara
		
		//Si el nombre ya esta registrado, rechazamos la operacion
		si existe = Verdadero Entonces
			Escribir "Ese nombre de usuario ya esta en uso. Intente con otro.";
			Esperar Tecla;
		SiNo
			Escribir "Ingrese clave:";
			leer nuevaClave;
			
			//Guardamos los nuevos datos en la posicion libre encontrada
			
			listaUsuarios[posLibre] <- nuevoUsuario;
			listaClaves[posLibre] <- nuevaClave;
			listaSaldos[posLibre] <- 1000; //Le damos un saldo inicial de bienvenida
			
			Escribir "¡Usuario registrado con exito!";
			Escribir "Saldo de bienvenida otorgado: $1000";
			Esperar Tecla;
		FinSi
	FinSi
FinSubProceso

//====================================================================
// MENU PRINCIPAL DEL CASINO (SALA DE JUEGOS)
//Recibe saldoUsuario por referencia para que las jugadas actualicen la cuenta
//====================================================================
SubProceso MenuCasino(nombreUsuario, saldoUsuario Por Referencia)
	
	definir opcionJuego como entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir "==================================================";
		Escribir "  USUARIO ACTIVO: ", nombreUsuario;
		Escribir "  SALDO DISPONIBLE: $", saldoUsuario;
		Escribir "==================================================";
		Escribir "1. Jugar Ruleta";
		Escribir "2. Jugar Tragamonedas (Slot)";
		Escribir "3. Jugar Poker";
		Escribir "4. Jugar BlackJack";
		Escribir "5. Cargar Saldo";
		Escribir "6. Cerrar Sesion.";
		Escribir "==================================================";
		Escribir "Seleccione una opcion:";
		leer opcionJuego;
		
		Segun opcionJuego Hacer
			1:
				//JugarRuleta
				//Maneja saldo por referencia
				Esperar Tecla;
			2:
				//JugarTragamonedas
				//Maneja saldo por referencia
			3:
				//JugarPoker
				//Maneja saldo por referencia
			4:
				//JugarBlacJack
				//Maneja saldo por referencia
			5:
				//llamada al SubProceso de carga de fondos
				CargarSaldo(saldousuario);
			6:
				Escribir "Cerrando sesion de ", nombreUsuario, "...";
				Esperar Tecla;
			De Otro Modo:
				Escribir "Opcion no valida. Vuelva a intentar.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionJuego <> 6 //Sale del submenu y regresa al menu de login incial
FinSubProceso

//==============================================================================
// GESTION Y DEPOSITO DE SALDO (SUBPROCESO)
// Valida el ingreso de numeros mayores a cero y acumula en saldoUsuario
//==============================================================================
SubProceso CargarSaldo(saldoUsuario Por Referencia)
	
	definir monto Como Real;
	
	Limpiar Pantalla;
	Escribir "=== CARGA DE SALDO ===";
	Escribir "Saldo actual: $", saldoUsuario;
	Escribir "Ingrese el monto a ingresar:";
	leer monto;
	
	//validaciones de seguridad para evitar numeros negativos o depositos en cero
	si monto > 0 Entonces
		saldoUsuario <- saldoUsuario + monto; //Suma directa al acumulador del usuario
		Escribir "¡Carga exitosa! Nuevo saldo: $", saldoUsuario;
	SiNo
		Escribir "Monto invalido. La carga debe ser mayor a $0.";
	FinSi
	Esperar Tecla;
FinSubProceso


