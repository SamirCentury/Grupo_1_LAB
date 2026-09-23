Algoritmo Menu_Casino_Prueba
	//Variables para las credenciales en la memoria RAM
	definir usuarioRegistro Como Caracter;
	definir contrasenaRegistro Como Caracter;
	definir estaRegistrado como logico;
	definir opcionBienvenida Como Entero;
	
	definir esAdmin Como Logico;
	definir loginExitoso como logico;
	definir usuarioLogueado Como Caracter;
	definir saldo Como Entero;
	
	definir listaUsuarios, listaClaves como cadena;
	
	//definimos el tamaño del arreglo con Dimensionar 
	Dimensionar listaUsuarios[2], listaClaves[2];
	
	//arreglo para que  cada usuario tenga su dinerp
	definir listaSaldos,saldoActual Como Entero;
	Dimensionar listaSaldos[2];
	
	//Definimos e inicializamos cantidadUsuarios
	definir cantidadUsuarios Como Entero;
	cantidadUsuarios <- 0;
	
	//Inicializamos variables base
	usuarioRegistro <- "";
	contrasenaRegistro <- "";
	estaRegistrado <- falso;
	opcionBienvenida <- 0;
	saldo <- 0;
	
	Repetir
		Escribir "================================================";
		Escribir "            BIENVENIDO AL CASINO                ";
		Escribir "================================================";
		Escribir "1. Registrarse como nuevo jugador.";
		Escribir "2. Iniciar Sesion (Jugadores/Administrador)";
		Escribir "3. Salir del programa";
		Escribir "================================================";
		Escribir "Seleccione una opcion (1-3)";
		leer opcionBienvenida;
		
		Segun opcionBienvenida Hacer
			1:
				RegistrarJugador(listaUsuarios, listaClaves, listaSaldos, cantidadUsuarios);
				Esperar Tecla;
			2:
				esAdmin <- falso;
				loginExitoso <- falso;
				usuarioLogueado <- "";
				
				//Llamamos a la funcion que procesa el ingreso
				IniciarSesion(listaUsuarios, listaClaves, cantidadUsuarios, esAdmin, usuarioLogueado, loginExitoso);
				
				//Si el login fue correcto, derivamos al menu correspondiente
				si loginExitoso = Verdadero Entonces
					si esAdmin = Verdadero Entonces
						MenuAdministrador();
					SiNo
						MenuCasino(usuarioLogueado,saldo);
					FinSi
				FinSi
				Esperar Tecla;
			3:
				Escribir "Gracias por usar el sistema del Casino. ¡Hasta luego!";
				Esperar Tecla;
			De otro modo:
				Escribir "Opcion no valida. Intente de nuevo.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionBienvenida <> 3;
FinAlgoritmo


//Funcion del Menu del Casino
SubProceso MenuCasino(usuario Por Referencia,saldo Por Referencia)
	Definir opcionCasino Como Entero;
	Definir continuar Como Lógico;
	continuar <- Verdadero;
	// Funcion para la interfaz del usuario
	
	Mientras continuar Hacer
		// Mostrar el cartel de opciones
		Limpiar Pantalla;
		Escribir "=========================================";
		Escribir "          BIENVENIDO AL CASINO: ",usuario;
		Escribir "=========================================";
		Escribir "=== MENU GENERAL DEL CASINO ===";
		Escribir " 1. Jugar a la Ruleta";
		Escribir " 2. Jugar al Blackjack";
		Escribir " 3. Jugar a las Tragamonedas";
		Escribir " 4. Jugar al Poker";
		Escribir " 5. Ver Saldo / Cargar Credito";
		Escribir " 6. Salir del Casino";
		Escribir "=========================================";
		Escribir "Seleccione una opcion (1-6): "Sin Saltar;
		Leer opcionCasino;
		// Evaluar la opción seleccionada
		Según opcionCasino Hacer
			1:
				Escribir "Entrando a la Ruleta... ¡Hagan sus apuestas!";
				Esperar Tecla;
			2:
				Escribir "Entrando al Blackjack... ¿Carta o te plantas?";
				Esperar Tecla;
	        3:
				Si saldo>=100 Entonces
					TRAGAMONEDAS(saldo, continuar);
				SiNo
					Escribir "Saldo insuficiente. Tenes $", saldo, ". Necesitas al menos $100 para jugar al Poker.";
					Escribir "Por favor, carga credito en la opcion 5.";
				FinSi
				Esperar Tecla;
			4:
				// Validación de saldo mínimo antes de entrar
				Si saldo>=100 Entonces
					AnimacionBienvenida();
					MenuJuego(saldo);
				SiNo // Pasamos el saldo global
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
		FinSegún
	FinMientras
FinSubProceso
//Fin Funcion del Menu del Casino

//Inicio de la funcion para registrar al usuario
SubProceso RegistrarJugador(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia, cantidadUsuarios Por Referencia)
	definir edad, i Como Entero;
	definir nuevoUsuario, nuevaClave como cadena;
	definir existe como logico;
	
	
	Limpiar Pantalla;
	
	//REGISTRO DE USUARIO
	Escribir "=== REGISTRO DE NUEVO USUARIO ===";
	Escribir "Ingrese su edad: " Sin Saltar;
	leer edad;
	
	//Validamos que sea mayor de edad
	Mientras (edad<18 o edad>120)
		Escribir "Error. Debe ser mayor de 17 años para registrarse.";
		Escribir "Ingrese su edad nuevamente.";
		leer edad;
	FinMientras
	
	//Verificamos si hay espacio en el sistema (maximo 10 usuarios por ejemplo)
	si cantidadUsuarios < 2 Entonces
		Escribir "Cree un nombre de usuario: "sin saltar;
		leer nuevoUsuario;
		
		//Validamos que el usuario no exista en la lista
		existe <- falso;
		para i=0 hasta cantidadUsuarios-1 con paso 1 Hacer
			si listaUsuarios[i] = nuevoUsuario Entonces
				existe <- Verdadero;
			FinSi
		FinPara
		
		si existe=Verdadero Entonces
			Escribir "El nombre de usuario ya esta registrado. Intente con otro";
		SiNo
			Escribir "Cree una contraseña: " sin saltar;
			leer nuevaClave;
			
			//Guardamos en la posicion del vector segun el contador
			listaUsuarios[cantidadUsuarios] <- nuevoUsuario;
			listaClaves[cantidadUsuarios] <- nuevaClave;
			listaSaldos[cantidadUsuarios] <- 0; //Saldo por defecto
			
			//Incrementamos el contador para que el siguiente usuario no sobrescriba a este
			cantidadUsuarios <- cantidadUsuarios + 1;
			
			Escribir "¡Registro completado con exito!";
		FinSi
	SiNo
		Escribir "Limite de usuarios alcanzado en el sistema";
	FinSi
FinSubProceso
//Fin de la funcion para registrar al usuario

//Login Universal
SubProceso IniciarSesion(listaUsuarios Por Referencia, listaClaves Por Referencia, cantidadUsuarios Por Referencia, esAdmin Por Referencia, usuarioLogueado Por Referencia, loginExitoso Por Referencia)
	definir u,c como cadena;
	
	Limpiar Pantalla;
	Escribir "================================================";
	Escribir "             INICIAR SESION                     ";
	Escribir "================================================";
	Escribir "Usuario: " sin saltar;
	leer u;
	Escribir "Contraseña: " sin saltar;
	leer c;
	
	loginExitoso <- falso;
	esAdmin <- falso;
    posicionUsuario <- -1;
	
	//1. Administrador
	si u = "admin" y c = "1234" Entonces
		loginExitoso <- Verdadero;
		esAdmin <- Verdadero;
		usuarioLogueado <- "Admin";
		Escribir "";
		Escribir "¡Bienvenido Administrador!";
	SiNo
		//2. Buscar dentro del arreglo de usuarios
		para i=0 hasta cantidadUsuarios-1 con paso 1 Hacer
			//si el usuario y la contraseña coinciden con el indice "i"
			si listaUsuarios[i] = u y listaClaves[i] = c Entonces
				loginExitoso <- Verdadero;
				usuarioLogueado <- u;
				posicionUsuario <- i; //Guardamos la posicion del usuario
			FinSi
		FinPara
		
		Escribir "";
		si loginExitoso Entonces
			Escribir "¡Bienvenido, ",usuarioLogueado, "!";
		Sino
			Escribir "Usuario o contraseña incorrectos.";
		FinSi
	FinSi
FinSubProceso

//Interfaz para el administrador
SubProceso MenuAdministrador
	definir opcionAdmin Como Entero;
	
	Repetir
		Escribir "===================================================";
		Escribir "        PANEL DE CONTROL - ADMINISTRADOR           ";
		Escribir "===================================================";
		Escribir "1. Ver caja total del casino.";
		Escribir "2. Modificar porcentaje de ganar de la Ruleta/Tragamonedas";
		Escribir "3. Expulsar a un jugador.";
		Escribir "4. Cerrar sesion de administrador.";
		Escribir "===================================================";
		Escribir "Seleccione una opcion (1-4)";
		Leer opcionAdmin;
		
		Segun opcionAdmin Hacer
			1:
				Escribir "[ADMIN] La caja actual tiene: $1.500.000 ARS.";
				Esperar Tecla;
			2:
				Escribir "[ADMIN] Modificando probabilidades... Configurado.";
				Esperar Tecla;
			3:
				Escribir "[ADMIN] Ingrese el nombre del usuario a banear.";
				Esperar Tecla;
			4:
				Escribir "Cerrando el panel de administracion...";
				Esperar Tecla;
			De  otro modo:
				Escribir "Opcion no valida.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionAdmin <> 4;

FinSubProceso
//Fin logica de Administrador

// SubProceso para consultar y recargar fichas/crédito
Función GestionarSaldo(saldo Por Referencia)
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
		Escribir "Seleccione una opcion: "Sin Saltar;
		Leer opSaldo;
		Según opSaldo Hacer
			1:
				Repetir
					Escribir "Ingresa el monto a cargar (Minimo $100): "Sin Saltar;
					Leer recarga;
					Si recarga<100 Entonces
						Escribir "La carga minima debe ser de al menos $100.";
					FinSi
				Mientras Que recarga<100
				saldo <- saldo+recarga;
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
		FinSegún
	Mientras Que opSaldo<>2;
FinFunción

Función MenuJuego(saldo Por Referencia)
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
		Según opcionSubMenu Hacer
			1:
				Si saldo>=100 Entonces
					JugarPoker(saldo);
				SiNo
					Escribir "No tenes saldo suficiente para la apuesta minima ($100).";
					Esperar Tecla;
				FinSi
			2:
				MostrarReglas();
			3:
				Escribir "Volviendo al menu del casino...";
			De Otro Modo:
				Escribir "Opcion no valida. Presiona ENTER";
				Esperar Tecla;
		FinSegún
	Mientras Que opcionSubMenu<>3 Y saldo>=100;
FinFunción

Función RealizarApuesta(saldo Por Referencia,pozo Por Referencia)
	Definir apuesta Como Entero;
	Escribir "===========================================";
	Escribir "Tus fichas disponibles: $", saldo;
	Escribir "===========================================";
	Repetir
		Escribir "Ingresa el monto a apostar para esta mano:";
		Leer apuesta;
		Si apuesta<=0 Entonces
			Escribir "La apuesta debe ser mayor a $0.";
		SiNo
			Si apuesta>saldo Entonces
				Escribir "No podes apostar $", apuesta, " porque solo tenes $", saldo, ".";
			FinSi
		FinSi
	Mientras Que apuesta<=0 O apuesta>saldo
	saldo <- saldo-apuesta;
	pozo <- apuesta*2;
	Escribir ""; // La Casa iguala tu apuesta
	Escribir "¡Apuesta aceptada!";
	Escribir "Apostaste: $', apuesta;
	Escribir "La Casa igualo tu apuesta con: $", apuesta;
	Escribir "Pozo total acumulado en la mesa: $", pozo;
	Escribir "===========================================";
	Escribir "";
FinFunción

// Inicio de la logica del Poker
Función JugarPoker(saldo Por Referencia)
	Definir j1_valores, j1_palo Como Entero;
	Dimensionar j1_valores[5], j1_palo[5];
	Definir maq_valores, maq_palo Como Entero;
	Dimensionar maq_valores[5], maq_palo[5];
	Definir puntaje_j1, puntaje_maq, i, cambiar, pos, seguir, j, cand_val, cand_palo Como Entero;
	Definir es_repetido, pos_valida Como Lógico;
	Definir pos_elegidas, pozo Como Entero;
	Dimensionar pos_elegidas[5];
	Repetir
		Limpiar Pantalla;
		// 1. Apuesta inicial de la mano
		RealizarApuesta(saldo,pozo);
		// 2. Reparto de cartas
		RepartirMano(j1_valores,j1_palo);
		OrdenarMano(j1_valores,j1_palo);
		RepartirMano(maq_valores,maq_palo);
		OrdenarMano(maq_valores,maq_palo);
		// Mostrar la mano del jugador
		Escribir 'TU MANO INICIAL:';
		Para i<-0 Hasta 4 Con Paso 1 Hacer
			Escribir 'Carta ', i+1, ': 'Sin Saltar;
			MostrarCarta(j1_palo[i],j1_valores[i]);
			Escribir '';
		FinPara
		Escribir '';
		puntaje_j1 <- EvaluarMano(j1_valores,j1_palo);
		Escribir 'Tienes: 'Sin Saltar;
		MostrarNombreJugada(puntaje_j1);
		Escribir '';
		Escribir '';
		// 3. Descarte del jugador
		Para i<-0 Hasta 4 Con Paso 1 Hacer
			pos_elegidas[i] <- 0;
		FinPara
		Escribir "¿Cuantas cartas quiere cambiar? (0 a 5)";
		Leer cambiar;
		Si cambiar>0 Entonces
			Para i<-0 Hasta cambiar-1 Con Paso 1 Hacer
				Repetir
					Escribir "Ingresa la carta que quiere cambiar (1 a 5)";
					Leer pos;
					pos_valida <- Verdadero;
					Si pos<1 O pos>5 Entonces
						Escribir 'Carta invalida. Debe ser entre 1 y 5.';
						pos_valida <- Falso;
					SiNo
						Para j<-0 Hasta i Con Paso 1 Hacer
							Si pos_elegidas[j]=pos Entonces
								Escribir 'Ya elegiste la carta ', pos, '. Elige una carta distinta.';
								pos_valida <- Falso;
							FinSi
						FinPara
					FinSi
				Mientras Que pos_valida=Falso;
				pos_elegidas[i] <- pos;
				Repetir
					cand_val <- Aleatorio(2,14);
					cand_palo <- Aleatorio(1,4);
					es_repetido <- Falso;
					Para j<-0 Hasta 4 Con Paso 1 Hacer
						Si j<>(pos-1) Entonces
							Si j1_valores[j]=cand_val Y j1_palo[j]=cand_palo Entonces
								es_repetido <- Verdadero;
							FinSi
						FinSi
					FinPara
				Mientras Que es_repetido=Verdadero;
				j1_valores[pos-1]<-cand_val;
				j1_palo[pos-1]<-cand_palo;
			FinPara
			OrdenarMano(j1_valores,j1_palo);
			Escribir '';
			Escribir 'TU MANO: ';
			Para i<-0 Hasta 4 Con Paso 1 Hacer
				Escribir 'Carta ', i+1, ': 'Sin Saltar;
				MostrarCarta(j1_palo[i],j1_valores[i]);
				Escribir '';
			FinPara
			puntaje_j1 <- EvaluarMano(j1_valores,j1_palo);
			Escribir 'Tu mano final es: 'Sin Saltar;
			MostrarNombreJugada(puntaje_j1);
			Escribir '';
		SiNo
			Escribir 'Decidiste conservar tu mano inicial';
		FinSi
		// 4. Descarte de la máquina
		Escribir '';
		Escribir '===========================================';
		Escribir 'Turno de la maquina para cambiar de cartas...';
		Escribir '';
		DescarteMaquina(maq_valores,maq_palo);
		Escribir '===========================================';
		Escribir '';
		Escribir 'Presione ENTER para revelar las manos y ver los resultados...';
		Esperar Tecla;
		// 5. Revelación y determinación de ganador
		Escribir '';
		Escribir 'MANO DE LA MAQUINA:';
		Para i<-0 Hasta 4 Con Paso 1 Hacer
			Escribir 'Carta ', i+1, ': 'Sin Saltar;
			MostrarCarta(maq_palo[i],maq_valores[i]);
			Escribir '';
		FinPara
		puntaje_maq <- EvaluarMano(maq_valores,maq_palo);
		Escribir 'La maquina tiene: 'Sin Saltar;
		MostrarNombreJugada(puntaje_maq);
		Escribir '';
		Escribir '';
		Escribir '=======================================';
		DeterminarGanador(j1_valores,j1_palo,maq_valores,maq_palo,saldo,pozo);
		
		// 6. Pregunta para volver a jugar
		Si saldo>0 Entonces
			Repetir
				Escribir '';
				Escribir '¿Quieres jugar otra mano?';
				Escribir '1. Si';
				Escribir '0. No';
				Leer seguir;
				
				Si seguir<>1 Y seguir<>0 Entonces
					Escribir 'Opcion no valida. Por favor, ingresa 1 o 0';
				FinSi
			Mientras Que seguir<>1 Y seguir<>0;
		SiNo
			Escribir 'Te quedaste sin saldo. Volviendo al menu del casino...';
			seguir <- 0;
			Esperar Tecla;
		FinSi
		
		Escribir "¡Gracias por jugar! Vuelve pronto.";
	Mientras Que seguir=1 Y saldo>0;
FinFunción

// Funcion para mostrar el valor y palo de las cartas
Función MostrarCarta(num_palo,num_valor)
	Definir nombre_valor, nombre_palo Como Cadena;
	Según num_valor Hacer
		11:
			nombre_valor <- 'J';
		12:
			nombre_valor <- 'Q';
		13:
			nombre_valor <- 'K';
		14:
			nombre_valor <- 'As';
		De Otro Modo:
			nombre_valor <- ConvertirATexto(num_valor);
	FinSegún
	Según num_palo Hacer
		1:
			nombre_palo <- 'Corazones';
		2:
			nombre_palo <- 'Diamantes';
		3:
			nombre_palo <- 'Treboles';
		4:
			nombre_palo <- 'Picas';
	FinSegún
	Escribir nombre_valor, ' de ', nombre_palo Sin Saltar;
FinFunción

// Repartimos y a la vez mezclamos las cartas y controlamos que no se repita
Función RepartirMano(mano_valores Por Referencia,mano_palo Por Referencia)
	Definir i, j Como Entero;
	Definir candidato_valor, candidato_palo Como Entero;
	Definir es_repetido Como Lógico;
	Para i<-0 Hasta 4 Con Paso 1 Hacer;
		Repetir
			candidato_valor <- Aleatorio(2,14);
			candidato_palo <- Aleatorio(1,4);
			es_repetido <- Falso;
			Para j<-0 Hasta i-1 Con Paso 1 Hacer
				Si mano_valores[j]=candidato_valor Y mano_palo[j]=candidato_palo Entonces
					es_repetido <- Verdadero;
				FinSi
			FinPara
		Mientras Que es_repetido=Verdadero;
		mano_valores[i] <- candidato_valor;
		mano_palo[i] <- candidato_palo;
	FinPara
FinFunción

Función OrdenarMano(mano_valores,mano_palo)
	Definir i, j, AuxValor, AuxPalo Como Entero;
	Para i<-0 Hasta 3 Con Paso 1 Hacer
		Para j<-0 Hasta 3-i Con Paso 1 Hacer
			Si mano_valores[j]>mano_valores[j+1] Entonces
				AuxValor <- mano_valores[j];
				mano_valores[j] <- mano_valores[j+1];
				mano_valores[j+1]<-AuxValor;
				AuxPalo <- mano_palo[j];
				mano_palo[j] <- mano_palo[j+1];
				mano_palo[j+1]<-AuxPalo;
			FinSi
		FinPara
	FinPara
FinFunción

Función puntaje <- EvaluarMano(mano_valores,mano_palo)
	Definir puntaje Como Entero;
	Definir esColor, esEscalera, esEscaleraReal Como Lógico;
	Definir i, pares, trios, poker Como Entero;
	esColor <- Verdadero;
	Para i<-0 Hasta 3 Con Paso 1 Hacer
		Si mano_palo[i]<>mano_palo[i+1] Entonces
			esColor <- Falso;
		FinSi
	FinPara
	esEscalera <- Verdadero;
	Para i<-0 Hasta 3 Con Paso 1 Hacer
		Si mano_valores[i+1]<>mano_valores[i]+1 Entonces
			esEscalera <- Falso;
		FinSi
	FinPara
	esEscaleraReal <- Falso;
	Si esEscalera Y mano_valores[1]=10 Y mano_valores[4]=14 Entonces
		esEscaleraReal <- Verdadero;
	FinSi
	Si (mano_valores[0]=mano_valores[3]) O (mano_valores[1]=mano_valores[4]) Entonces
		poker <- 1;
	FinSi
	Si (mano_valores[0]=mano_valores[2]) O (mano_valores[1]=mano_valores[3]) O (mano_valores[2]=mano_valores[4]) Entonces
		trios <- 1;
	FinSi
	Para i<-0 Hasta 3 Con Paso 1 Hacer
		Si mano_valores[i]=mano_valores[i+1] Entonces
			pares <- pares+1;
		FinSi
	FinPara
	Si poker=1 Entonces
		pares <- 0;
		trios <- 0;
	SiNo
		Si trios=1 Entonces
			pares <- pares-2; //Para controlar los falsos pares
		FinSi
	FinSi
	Si esEscaleraReal Entonces
		puntaje <- 10;
	SiNo
		Si esEscalera Y esColor Entonces
			puntaje <- 9;
		SiNo
			Si poker=1 Entonces
				puntaje <- 8;
			SiNo
				Si trios=1 Y pares=1 Entonces
					puntaje <- 7;
				SiNo
					Si esColor Entonces
						puntaje <- 6;
					SiNo
						Si esEscalera Entonces
							puntaje <- 5;
						SiNo
							Si trios=1 Entonces
								puntaje <- 4;
							SiNo
								Si pares=2 Entonces
									puntaje <- 3;
								SiNo
									Si pares=1 Entonces
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
FinFunción

Función MostrarNombreJugada(puntaje)
	Según puntaje Hacer
		1:
			Escribir 'Carta Alta';
		2:
			Escribir 'Un Par';
		3:
			Escribir 'Doble Par';
		4:
			Escribir 'Trio';
		5:
			Escribir 'Escalera';
		6:
			Escribir 'Color';
		7:
			Escribir 'Full House';
		8:
			Escribir 'Poker';
		9:
			Escribir 'Escalera de Color';
		10:
			Escribir 'Escalera Real';
	FinSegún
FinFunción

Función DescarteMaquina(maq_valores,maq_palo)
	Definir i, puntaje, pospar, cand_val, cand_palo, j Como Entero;
	Definir es_repetido Como Lógico;
	puntaje <- EvaluarMano(maq_valores,maq_palo);
	Si puntaje=1 Entonces
		Para i<-0 Hasta 2 Con Paso 1 Hacer
			Repetir
				cand_val <- Aleatorio(2,14);
				cand_palo <- Aleatorio(1,4);
				es_repetido <- Falso;
				Para j<-0 Hasta 4 Con Paso 1 Hacer
					Si j<>i Entonces
						Si maq_valores[j]=cand_val Y maq_palo[j]=cand_palo Entonces
							es_repetido <- Verdadero;
						FinSi
					FinSi
				FinPara
			Mientras Que es_repetido=Verdadero;
			maq_valores[i] <- cand_val;
			maq_palo[i] <- cand_palo;
		FinPara
		OrdenarMano(maq_valores,maq_palo);
		Escribir 'La maquina decidio cambiar 3 cartas.';
	SiNo
		Si puntaje=2 Entonces
			pospar <- 0;
			Para i<-0 Hasta 3 Con Paso 1 Hacer
				Si maq_valores[i]=maq_valores[i+1] Entonces
					pospar <- i;
				FinSi
			FinPara
			Para i<-0 Hasta 4 Con Paso 1 Hacer
				Si i<>pospar Y i<>(pospar+1) Entonces
					maq_valores[i] <- Aleatorio(2,14);
					maq_palo[i] <- Aleatorio(1,4);
				FinSi
			FinPara
			OrdenarMano(maq_valores,maq_palo);
			Escribir 'La maquina decidio cambiar algunas cartas.';
		SiNo
			Escribir 'La maquina decidio conservar sus cartas.';
		FinSi
	FinSi
FinFunción

Función MostrarReglas
	Limpiar Pantalla;
	Escribir '===============================================================';
	Escribir '                        REGLAS DEL POKER                       ';
	Escribir '===============================================================';
	Escribir '1. Cada jugador recibe 5 cartas.';
	Escribir '2. Podes cambiar de 0 a 5 cartas en el descarte.';
	Escribir '3. Gana la mano con la combinacion mas alta:';
	Escribir '   -Escalera Real > Escalera de Color > Poker > Full House >';
	Escribir '     Color > Escalera > Trio > Doble Par > Par > Carta Alta';
	Escribir '================================================================';
	Escribir 'Presiona cualquier tecla para volver...';
	Esperar Tecla;
FinFunción

Función DeterminarGanador (jug_valor,jug_palo,maq_valor,maq_palo,saldo Por Referencia,pozo Por Referencia)
	Definir punt_jug, punt_maq, i Como Entero;
	Definir ganador Como Entero;
	Definir par_j1, par_j2, par_m1, par_m2 Como Entero; // 1. Jugador, 2. Maquina, 0. Empate
	Definir trio_j, trio_m, poker_j, poker_m Como Entero;
	punt_jug <- EvaluarMano(jug_valor,jug_palo);
	punt_maq <- EvaluarMano(maq_valor,maq_palo);
	ganador <- 0;
	Escribir '';
	Escribir '=== RESULTADO FINAL DE LA MANO ===';
	// Definimos ganador
	Si punt_jug>punt_maq Entonces
		ganador <- 1;
	SiNo
		Si punt_maq>punt_jug Entonces
			ganador <- 2;
		SiNo
			Según punt_jug Hacer
				1, 5, 6, 8, 9:
					Para i<-4 Hasta 0 Con Paso -1 Hacer
						Si ganador=0 Y jug_valor[i]<>maq_valor[i] Entonces
							Si jug_valor[i]>maq_valor[i] Entonces
								ganador <- 1;
							SiNo
								ganador <- 2;
							FinSi
						FinSi
					FinPara
				2:
					par_j1 <- 0;
					par_m1 <- 0;
					Para i<-0 Hasta 3 Con Paso 1 Hacer
						Si jug_valor[i]=jug_valor[i+1] Entonces
							par_j1 <- jug_valor[i];
						FinSi
						Si maq_valor[i]=maq_valor[i+1] Entonces
							par_m1 <- maq_valor[i];
						FinSi
					FinPara
					Si par_j1>par_m1 Entonces
						ganador <- 1;
					SiNo
						Si par_m1>par_j1 Entonces
							ganador <- 2;
						SiNo
							Para i<-4 Hasta 0 Con Paso -1 Hacer
								Si ganador=0 Y jug_valor[i]<>maq_valor[i] Entonces
									Si jug_valor[i]>maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
				3:
					par_j1 <- 0;
					par_j2 <- 0;
					par_m1 <- 0;
					par_m2 <- 0;
					Para i<-0 Hasta 3 Con Paso 1 Hacer
						Si jug_valor[i]=jug_valor[i+1] Entonces
							Si par_j1=0 Entonces
								par_j1 <- jug_valor[i];
							SiNo
								par_j2 <- jug_valor[i];
							FinSi
						FinSi
						Si maq_valor[i]=maq_valor[i+1] Entonces
							Si par_m1=0 Entonces
								par_m1 <- maq_valor[i];
							SiNo
								par_m2 <- maq_valor[i];
							FinSi
						FinSi
					FinPara
					Si par_j2>par_m2 Entonces
						ganador <- 1;
					SiNo
						Si par_m2>par_j2 Entonces
							ganador <- 2;
						SiNo
							Si par_j1>par_m1 Entonces
								ganador <- 1;
							SiNo
								Si par_m1>par_j1 Entonces
									ganador <- 2;
								SiNo
									Para i<-4 Hasta 0 Con Paso -1 Hacer
										Si ganador=0 Y jug_valor[i]<>maq_valor[i] Entonces
											Si jug_valor[i]>maq_valor[i] Entonces
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
					Para i<-0 Hasta 2 Con Paso 1 Hacer
						Si jug_valor[i]=jug_valor[i+1] Y jug_valor[i+1]=jug_valor[i+2] Entonces
							trio_j <- jug_valor[i];
						FinSi
						Si maq_valor[i]=maq_valor[i+1] Y maq_valor[i+1]=maq_valor[i+2] Entonces
							trio_m <- maq_valor[i];
						FinSi
					FinPara
					Si trio_j>trio_m Entonces
						ganador <- 1;
					SiNo
						Si trio_m>trio_j Entonces
							ganador <- 2;
						FinSi
					FinSi
				7:
					Para i<-0 Hasta 2 Con Paso 1 Hacer
						Si jug_valor[i]=jug_valor[i+1] Y jug_valor[i+1]=jug_valor[i+2] Entonces
							trio_j <- jug_valor[i];
						FinSi
						Si maq_valor[i]=maq_valor[i+1] Y maq_valor[i+1]=maq_valor[i+2] Entonces
							trio_m <- maq_valor[i];
						FinSi
					FinPara
					Si trio_j>trio_m Entonces
						ganador <- 1;
					SiNo
						Si trio_m>trio_j Entonces
							ganador <- 2;
						SiNo
							Para i<-4 Hasta 0 Con Paso -1 Hacer
								Si ganador=0 Y jug_valor[i]<>maq_valor[i] Entonces
									Si jug_valor[i]>maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
				10:
					Para i<-0 Hasta 1 Con Paso 1 Hacer
						Si jug_valor[i]=jug_valor[i+1] Y jug_valor[i+1]=jug_valor[i+2] Y jug_valor[i+2]=jug_valor[i+3] Entonces
							poker_j <- jug_valor[i];
						FinSi
						Si maq_valor[i]=maq_valor[i+1] Y maq_valor[i+1]=maq_valor[i+2] Y maq_valor[i+2]=maq_valor[i+3] Entonces
							poker_m <- maq_valor[i];
						FinSi
					FinPara
					Si poker_j>poker_m Entonces
						ganador <- 1;
					SiNo
						Si poker_m>poker_j Entonces
							ganador <- 2;
						SiNo
							Para i<-4 Hasta 0 Con Paso -1 Hacer
								Si ganador=0 Y jug_valor[i]<>maq_valor[i] Entonces
									Si jug_valor[i]>maq_valor[i] Entonces
										ganador <- 1;
									SiNo
										ganador <- 2;
									FinSi
								FinSi
							FinPara
						FinSi
					FinSi
			FinSegún
		FinSi
	FinSi
	// Pago y cobro del dinero según el resultado
	Si ganador=1 Entonces
		Escribir '¡EL JUGADOR GANA LA MANO!';
		saldo <- saldo+pozo;
		Escribir '¡Ganaste $', pozo, '! Tu nuevo saldo es: $', saldo;
	SiNo
		Si ganador=2 Entonces
			Escribir '¡LA MAQUINA GANA LA MANO!';
			Escribir 'Perdiste la apuesta. Te quedan: $', saldo;
		SiNo
			Escribir '¡EMPATE ABSOLUTO!';
			saldo <- saldo+(pozo/2);
			Escribir 'Se te devuelve tu apuesta. Saldo actual: $', saldo;
		FinSi
	FinSi
FinFunción

// Graficos
Función AnimacionBienvenida
	Definir i Como Entero;
	Para i<-1 Hasta 3 Con Paso 1 Hacer;
		Limpiar Pantalla;
		Escribir '==========================================================';
		Escribir '    ____    ____    _   __ _____ ____   ';
		Escribir '   / __ \ / __ \ | |/ /| ____|  _ \  ';
		Escribir '  / /_/ // /_/ / | ', '/ |  _| | |_) | ';
		Escribir ' / ____// ____/  | . \ | |___|  _ <  ';
		Escribir ' /_/    /_/      |_|\_\|_____|_| \_\ ';
		Escribir '                                                          ';
		Escribir '    [+]---------- CASINO NIGHT CLUB ----------[+]';
		Escribir '==========================================================';
		Escribir '';
		Escribir '          < < <  PRESIONA ENTER PARA JUGAR  > > >          ';
		Esperar 400 Milisegundos;
		Limpiar Pantalla;
		Escribir '==========================================================';
		Escribir '    ____    ____    _   __ _____ ____   ';
		Escribir '   / __ \ / __ \ | |/ /| ____|  _ \  ';
		Escribir '  / /_/ // /_/ / | ', '/ |  _| | |_) | ';
		Escribir ' / ____// ____/  | . \ | |___|  _ <  ';
		Escribir ' /_/    /_/      |_|\_\|_____|_| \_\ ';
		Escribir '                                                          ';
		Escribir '    [+]---------- CASINO NIGHT CLUB ----------[+]';
		Escribir '==========================================================';
		Escribir '';
		Escribir '          . . .                               . . .          ';
		Esperar 300 Milisegundos;
		Limpiar Pantalla;
	FinPara
	Escribir '';
	Escribir '  --> [ Presiona ENTER para repartir la primera mano ] ';
	Esperar Tecla;
	Limpiar Pantalla;
FinFunción

// Fin de la logica del poker
//Inicio Logica Tragamonedas
SubProceso TRAGAMONEDAS(saldo Por Referencia, continuar)
	Definir apuesta Como Entero;
	Definir rueda1, rueda2, rueda3, i, s Como Entero; //S para los ritmos.
	//Seis variables.
	
	Mientras saldo>0 y continuar hacer
		Limpiar Pantalla;
		//Letrero gigante de entrada.
		CARTEL_TRAGAMONEDAS;
		//Escribir el saldo actual y leer la apuesta del juador.
		Escribir " Saldo Actual: [$", saldo, "]";
		Escribir " Ingresa tu apuesta (M?nimo $10): ";
		Leer apuesta;
		Si apuesta>saldo o apuesta<10 Entonces
			//Preguntar si la apuesta ingresada es mayor que el saldo. 
			//O menor al monto minimo de apuesta.
			APUESTA_INVALIDA;
			Leer continuar;
			continuar <- Verdadero;
		SiNo
			// COBRO INMEDIATO: Se descuenta la apuesta aqu?, antes de ver la animaci?n
			saldo <- saldo - apuesta;
			//Animaci?n gigante de giro.
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
				//(Simula el mecanismo mec?nico de giro).
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
		// Mostrar nombres de s?mbolos
		//Su funcion es crear una linea de texto dinamica y autoajustable.
		// ==================== SECCI?N DE S?MBOLOS ENCAJADOS ====================
		textoSimbolos <- "  S?mbolos: ";
		//La variable mide 12 caracteres de largo.
		// Concatenar el primer s?mbolo
		Segun rueda1 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown] ";
			2: textoSimbolos <- textoSimbolos + "[Diamante] ";
			3: textoSimbolos <- textoSimbolos + "[Moneda] ";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada] ";
		FinSegun
		
		// Concatenar el segundo s?mbolo
		Segun rueda2 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown] ";
			2: textoSimbolos <- textoSimbolos + "[Diamante] ";
			3: textoSimbolos <- textoSimbolos + "[Moneda] ";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada] ";
		FinSegun
		
		// Concatenar el tercer s?mbolo
		Segun rueda3 Hacer
			1: textoSimbolos <- textoSimbolos + "[Crown]";
			2: textoSimbolos <- textoSimbolos + "[Diamante]";
			3: textoSimbolos <- textoSimbolos + "[Moneda]";
			De Otro Modo: textoSimbolos <- textoSimbolos + "[Espada]";
		FinSegun
		
		// Relleno matem?tico autom?tico para cerrar la caja a la perfecci?n (67 caracteres de ancho interno).
		Mientras Longitud(textoSimbolos) < 67 Hacer //cuenta cu?ntas letras y espacios tiene la frase en ese instante.
			textoSimbolos <- textoSimbolos + " ";
			//El bucle dice: "Si la frase mide menos de 67 caracteres, agr?gale un espacio en blanco al final y vuelve a revisar".
		FinMientras
		//El resultado: Si la combinaci?n de s?mbolos fue corta, el bucle agregar? muchos espacios.
		//Si fue larga, agregar? pocos. Al final, no importa qu? s?mbolos salga, la frase siempre medir? exactamente 67 caracteres.
		
		// Imprime la fila completamente alineada
		Escribir "      |", textoSimbolos, "|";
		
		// L?nea final que cierra la estructura de la m?quina
		Escribir "      |___________________________________________________________________|";
		Escribir "";
		// ========================================================================
		
		// L?GICA DE PREMIOS Y RITMOS DE SONIDO
		Si rueda1 = rueda2 Y rueda2 = rueda3 Entonces
			Si rueda1 = 1 Entonces
				JACKPOT;
				saldo <- saldo + (apuesta * 15);
				Para s <- 1 Hasta 12 Hacer
					Escribir Sin Saltar ""; 
					Esperar 80 Milisegundos;
				FinPara
			SiNo
				Escribir "  ?Felicidades! Consiguiste 3 s?mbolos iguales. ?Gran Premio!";
				saldo <- saldo + (apuesta * 5);
				Para s <- 1 Hasta 5 Hacer
					Esperar 150 Milisegundos;
				FinPara
			FinSi
		SiNo
			Si rueda1 = rueda2 O rueda2 = rueda3 O rueda1 = rueda3 Entonces
				Escribir "  ?Bien! 2 s?mbolos iguales. Duplicas tu apuesta.";
				saldo <- saldo + (apuesta * 2);
				
				Esperar 100 Milisegundos;
				Esperar 100 Milisegundos;
			SiNo
				Escribir "  No tuviste suerte esta vez. Los rodillos no coinciden.";
				// Ya no se resta saldo aqu? porque se cobr? al inicio del tiro
				Esperar 500 Milisegundos;
			FinSi
		FinSi
		//Si ganas el Jackpot, el programa hace pausas muy r?pidas consecutivas para simula una sirena festiva.
		//Si pierdes, hace una pausa larga de medio segundo (500 Milisegundos) en silencio, simula el momento de decepci?n antes de continuar.
		//Es para agregar dramatismo y emoci?n al juego.
		Escribir "==========================================================================";
		Escribir " Nuevo saldo disponible: $", saldo;
		Escribir "==========================================================================";
		Si saldo >= 10 Entonces
			Escribir " 1. Seguir jugando.";
			Escribir " 2. Volver al menu principal.";
			Escribir " Seleccione una opci?n: ";
			Leer opcion;
			
			Segun opcion Hacer
				1:
					continuar <- Verdadero;
				2:
					continuar <- Falso;
					Escribir " ?Gracias por jugar! Te retiras con: $", saldo;
					Esperar Tecla;
				De Otro Modo:
					Escribir " Opci?n inv?lida, continuando juego por defecto...";
					Esperar 1 Segundos;
			FinSegun
		SiNo
			SIN_FICHAS;
			Escribir "Te has quedado sin saldo suficiente para la apuesta m?nima ($10).";
			Escribir "Vuelve al men? de inicio para recargar.";
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
	Escribir "                       3 S?mbolos Iguales          -> Gran Premio (x5)";
	Escribir "                       2 S?mbolos Iguales          -> Recompensa (x2)";
	Escribir " ==========================================================================================";
	Escribir "";
FinSubProceso

SubProceso APUESTA_INVALIDA
	Escribir " .-------------------------------------------------------.";
	Escribir " |?Apuesta inv?lida! ?Presiona <<Enter>> para reintentar!|";
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
	Escribir "  ??? JACKPOT GIGANTE !!! ?REVENTASTE LA BANCA CON 3 CORONAS!";
	Escribir "  ***********************************************************";
FinSubProceso

SubProceso SIN_FICHAS
	Escribir "  ___________________________________________________________";
	Escribir " |                                                           |";
	Escribir " |   Te has quedado sin fichas. ?Mejor suerte la pr?xima!    |";
	Escribir " |___________________________________________________________|";
	Esperar 3 Segundos;
FinSubProceso
//Fin Logica Tragamonedas