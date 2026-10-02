Algoritmo Casino_Virtual_Optimizado
	//========================================================
	//1. CONFIGURACION E INICIALIZACION DE DATOS
	//========================================================
	
	//Variables de control para la navegacion del menu principal.
	Definir listaUsuarios, listaClaves, PalabraAdmin como cadena;
	Definir listaSaldos como real;
	Definir opcion, idSesion, i como entero; 
	//opcion: Variable entera para capturar la selección del usuario en el menú principal
	//idSesion: Variable entera utilizada para identificar al usuario que ha iniciado sesión
	Definir posicionLibre Como Entero;
	Definir cupoLibre como logico;
	
	
	//Definimos la cantidad maxima de usuarios que soporta el sistema (2 precargados + 1 nuevo).
	Definir MAX_USUARIOS Como Entero;
	MAX_USUARIOS <- 3;
	
	//Definimos la Edad minima y Edad maxima para el ingreso al casino
	definir EDAD_MIN, EDAD_MAX Como Entero;
	EDAD_MIN <- 18;
	EDAD_MAX <- 120;
	
	
	//Tamaño de palabras no permitidas para usuario "admin"
	NO_ADMIN <- 2;
	
	//Definimos la dimension para que no se puedan registrar con nombre de usuarios parecidos a "admin"
	dimension PalabraAdmin[NO_ADMIN];
	
	//Guardamos las usaurios no permitidos para el registro
	PalabraAdmin[0] <- "admin";
	PalabraAdmin[1] <- "administrador";
	
	
	//Arreglos paralelos: la posicion [i] de cada vector corresponde al mismo usuario
	Dimension listaUsuarios[MAX_USUARIOS]; //Arreglo de tipo cadena para almacenar los nombres de usuario.
	Dimension listaClaves[MAX_USUARIOS]; //Arreglo de tipo cadena para guardar las contraseñas de acceso.
	Dimension listaSaldos[MAX_USUARIOS]; //Arreglo de tipo real para registrar el dinero disponible de cada jugador.
	Dimension listaEdades[MAX_USUARIOS]; //Arreglo de tipo entero para registrar las edades de usuario.
	
	
	// Precarga del Usuario 1 (Administrador)
	listaUsuarios[0] <- "admin";
	listaClaves[0] <- "1234";
	listaSaldos[0] <- 5000;
	listaEdades[0] <- 30;
	
	// Precarga del Usuario 2 (Jugador de prueba)
	listaUsuarios[1] <- "jugador1";
	listaClaves[1] <- "0000";
	listaSaldos[1] <- 1000;
	listaEdades[1] <- 27;
	
	// Reserva de la posicion 3 (Vacia)
	listaUsuarios[2] <- "";
	listaClaves[2] <- "";
	listaSaldos[2] <- 0;
	listaEdades[2] <- 0;
	
	
	//===================================================================
	//2- BUCLE DEL MENU PRINCIPAL DEL SISTEMA
	//===================================================================
	Repetir
		Limpiar Pantalla;
		Escribir "=============================================";
		Escribir "      BIENVENIDO AL CASINO - CasiNOgano         ";
		Escribir "=============================================";
		Escribir "1. Iniciar Sesion.";
		Escribir "2. Registrarse.";
		Escribir "3. Salir del Casino.";
		Escribir "=============================================";
		Escribir "Seleccione una opcion:";
		leer opcion;
		
		Segun opcion hacer
			1:
				idSesion <- IniciarSesion(listaUsuarios, listaClaves, MAX_USUARIOS); //Llamamos a la funcion de autenticacion y guardamos la posicion del usuario devuelta. 
				
				si idSesion <> -1 Entonces //Si idSesion es distinto de -1, significa que el login es exitoso/correcto.
					si listaUsuarios[idSesion] = "admin" Entonces //Validacion  de rol: si el usuaio es "admin", va al panel  de control.
						MenuAdmin(listaUsuarios, listaClaves, listaSaldos, listaEdades, MAX_USUARIOS);
					SiNo
						MenuCasino(listaUsuarios, listaSaldos, idSesion, MAX_USUARIOS); //Si es jugador comun: va a la sala de juegos.
					FinSi
				FinSi
			2:
				// VERIFICACIÓN DE CUPO DISPONIBLE.
                posicionLibre <- -1; //Usamos -1 como una señal de alerta que significa "todavía no encontré ningún lugar vacío".
                i <- 0; //CONTADOR: empieza a revisar desde la posición "0".
                
                // El ciclo se detiene en cuanto encuentra el primer "".
				//OBLIGATORIO: Que todavía no hayamos llegado al final de la lista y que aún no hayamos encontrado un cupo libre.
                Mientras (i < MAX_USUARIOS) Y (posicionLibre = -1) Hacer 
					//Cuando encontremos un lugar: posicionLibre va a cambiar de valor, se volverá falsa y el bucle se detendrá inmediatamente.
					
                    Si listaUsuarios[i] = "" Entonces //Pregunta si la posición actual está vacía.
                        posicionLibre <- i; //Guardamos el índice exacto.
						//Si está vacía, guardamos el número de esa posición (i) dentro de posicionLibre. 
						//Y en la siguiente vuelta del bucle, la condición posicionLibre = -1 ya no se cumplirá y el ciclo terminará.
                    FinSi
                    i <- i + 1; //Si la posición no estaba vacía, pasamos al siguiente casillero
                FinMientras
                
                Si posicionLibre <> -1 Entonces // Si el valor ya no es -1, significa que el bucle encontró un espacio vacío con éxito.
                    RegistrarUsuario(listaUsuarios, listaClaves, listaSaldos,listaEdades, MAX_USUARIOS,PalabraAdmin, NO_ADMIN, EDAD_MIN, EDAD_MAX); 
					//Llama a la función y le manda una posción exacta de la fila que está vacia.
					//La funcion va directo a esa casilla a escribir un nuevo nombre y clave.
                SiNo
                    Escribir "Lo sentimos, el casino no acepta mas usuarios (Cupos llenos).";
					//Si la variable se quedó en -1 después de revisar toda la lista, significa que el casino está completamente lleno.
                    Esperar Tecla;
                FinSi
			3:
				Escribir "Gracias por visitar el casino. ¡Hasta luego!";
			De Otro Modo:
				Escribir "Opcion no valida. Intente nuevamente";
				Esperar Tecla;
		FinSegun
	Mientras Que opcion <> 3 //El programa sigue corriendo hasta que el usuario elija la opcion 3 (Salir).
FinAlgoritmo


//=========================================================================
// 3. INICIO DE SESION
//=========================================================================

Funcion idEncontrado <- IniciarSesion(listaUsuarios, listaClaves, max)
	definir usuario, contrasena como cadena;
	definir i, idEncontrado Como Entero;
	
	Limpiar Pantalla;
	Escribir "=== INICIO DE SESION ===";
	Escribir "Usuario:";
	leer usuario;
	Escribir "Clave:";
	leer contrasena;
	
	idEncontrado <- -1; //Inicializamos en -1 (asumiendo que por defecto NO se encontro coincidencia) (significa no encontrado)
	
	Para i=0 hasta max-1 Hacer //Recorremos el vector desde la posicion 0 hasta MAX_USUARIOS.
		//Si coinciden el usuario y la clave, y el casillero NO esta vacio.
		si listaUsuarios[i] = usuario y listaClaves[i] = contrasena y usuario <> "" Entonces
			idEncontrado <- i; //Guardamos el numero de posicion donde se encontro al usuario.
		FinSi
	FinPara
	
	si idEncontrado = -1 Entonces //Si tras recorrer todo el arreglo sigue en -1, las credenciales eran falsas.
		Escribir "Usuario o clave incorrectos.";
		Esperar Tecla;
	FinSi
FinFuncion


SubProceso MenuAdmin(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia,listaEdades Por Referencia, max)
    Definir opcionAdmin, i, usuarioModificar, tipoAjuste Como Entero;
    Definir nuevoSaldo, montoAjuste Como Real;
    Definir usuarioBuscar Como Cadena;
    
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
        Leer opcionAdmin;
        
        Segun opcionAdmin Hacer
            1:
                Limpiar Pantalla;
                Escribir "=== REPORTES DEL SISTEMA ===";
                Escribir "POS| USUARIO |  EDAD          | SALDO";
                Escribir "----------------------------------";
                Para i <- 0 Hasta max-1 Hacer //Revisar todos los casilleros del arreglo uno por uno.
                    Si listaUsuarios[i] <> "" Entonces //Si el casillero no está vacío, muestra en pantalla el número de posición, el nombre del jugador y la plata.
                        Escribir "[", i, "] ", listaUsuarios[i],"        ", listaEdades[i], " años         $", listaSaldos[i];
                    SiNo
                        Escribir "[", i, "] (Espacio Libre)"; //Si el casillero está vacío. Esto le sirve al administrador para saber cuántos cupos quedan libres en el sistema.
                    FinSi
                FinPara
                Escribir "-------------------------------------------";
                Esperar Tecla;
            2:
                Limpiar Pantalla;
                Escribir "=== MODIFICAR SALDO DE USUARIO ===";
                Escribir "Ingrese el NOMBRE de usuario a modificar:";
                Leer usuarioBuscar;
                
                // BÚSQUEDA CON MIENTRAS
                usuarioModificar <- -1;
                i <- 0;
                
                Mientras (i < max) Y (usuarioModificar = -1) Hacer
                    // Agregamos la condición de que no sea "admin" para proteger la cuenta del administrador
                    Si listaUsuarios[i] = usuarioBuscar Y usuarioBuscar <> "" Y usuarioBuscar <> "admin" Entonces
                        usuarioModificar <- i; // Guardamos la posición exacta y rompe el ciclo
                    FinSi
                    i <- i + 1;
                FinMientras
                
				//Si el usuario existe: muestra el saldo actual del jugador y despliega un menú interno con 3 opciones de transacciones financieras:
                Si usuarioModificar <> -1 Entonces
                    Escribir "Usuario seleccionado: ", listaUsuarios[usuarioModificar];
                    Escribir "Saldo actual: $", listaSaldos[usuarioModificar];
                    Escribir "----------------------------------------------";
                    Escribir "1. Sumar saldo."; 
                    Escribir "2. Restar saldo."; 
                    Escribir "3. Fijar saldo (sobreescribir)"; 
                    Escribir "Seleccione el tipo de operacion:";
                    Leer tipoAjuste;
                    
                    Segun tipoAjuste Hacer
                        1: 
                            Escribir "Ingrese el monto a sumar: "; //Le pide un monto al admin y se lo suma al saldo actual (+ montoAjuste). 
							//Tiene una validación que exige que el monto sea un número positivo.
                            Leer montoAjuste;
                            Si montoAjuste > 0 Entonces
                                listaSaldos[usuarioModificar] <- listaSaldos[usuarioModificar] + montoAjuste;
                                Escribir "¡Monto acreditado! Nuevo saldo: $", listaSaldos[usuarioModificar];
                            SiNo
                                Escribir "Error: El monto a sumar debe ser positivo.";
                            FinSi
                        2:
                            Escribir "Ingrese el monto a Restar:"; //Le resta dinero al jugador (- montoAjuste). 
							//Cuenta con una doble validación de seguridad: el monto debe ser positivo...
							//...y el usuario debe tener dinero suficiente en su cuenta para que su saldo no quede en negativo (deuda).
                            Leer montoAjuste;
                            Si montoAjuste > 0 Entonces
                                Si listaSaldos[usuarioModificar] >= montoAjuste Entonces
                                    listaSaldos[usuarioModificar] <- listaSaldos[usuarioModificar] - montoAjuste;
                                    Escribir "¡Monto debitado! Nuevo saldo: $", listaSaldos[usuarioModificar];
                                SiNo
                                    Escribir "Error: El usuario no tiene suficiente saldo para debitar ese monto.";
                                FinSi
                            SiNo
                                Escribir "Error: El monto a restar debe ser positivo.";
                            FinSi
                        3:
                            Escribir "Ingrese el nuevo saldo total a fijar:"; //Borra el saldo anterior y establece un valor exacto directo (listaSaldos[...] <- nuevoSaldo). 
							//Valida que el número no sea menor a 0.
                            Leer nuevoSaldo;
                            Si nuevoSaldo >= 0 Entonces
                                listaSaldos[usuarioModificar] <- nuevoSaldo;
                                Escribir "¡Saldo fijado correctamente! Nuevo saldo: $", listaSaldos[usuarioModificar];
                            SiNo
                                Escribir "Error: El saldo no puede ser negativo.";
                            FinSi
                        De Otro Modo:
                            Escribir "Opcion de ajuste no valida.";
                    FinSegun
                SiNo
                    // Mensaje personalizado por si intentó modificarse a sí mismo o no existe
                    Si usuarioBuscar = "admin" Entonces
                        Escribir "Error: No está permitido modificar el saldo de la cuenta de administrador.";
						//Si el administrador intentó buscar la palabra "admin".
                    SiNo
                        Escribir "Error: El usuario no existe en el sistema.";
						//Si puso cualquier otro nombre que no existe.
                    FinSi
                FinSi
                Esperar Tecla;
            3: 
                Escribir "Cerrando panel de administracion...";
                Esperar Tecla;
            De Otro Modo:
                Escribir "Opcion no valida.";
                Esperar Tecla;
        FinSegun
    Mientras Que opcionAdmin <> 3
FinSubProceso


SubProceso RegistrarUsuario(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia, listaEdades Por Referencia, max,PalabraAdmin Por Referencia, cantNoAdmin, EDAD_MIN, EDAD_MAX)
	definir i, posLibre,nuevaEdad Como Entero;
	definir nuevoUsuario, nuevaClave,usuarioMinuscula como cadena;
	definir existe, esAdminProhibido como logico;
	
	posLibre <- -1; //Asume al principio que no hay espacio.
	Para i = 0 hasta max-1 Hacer
		si listaUsuarios[i] = "" y posLibre = -1 Entonces 
			//Si encuentra una posición vacía ("") y todavía no había guardado ninguna otra (posLibre = -1), anota ese número de índice en posLibre.
			posLibre <- i; 
		FinSi
	FinPara
	
	Limpiar Pantalla;
	Escribir "=== REGISTRO DE USUARIO ===";
	
	//Pedimos la edad para validar que sea mayor de edad para jugar
	repetir 
		Escribir "Ingrese su edad (permitido de ", EDAD_MIN, " a " ,EDAD_MAX, " años):";
		leer nuevaEdad;
		si nuevaEdad < EDAD_MIN O nuevaEdad > EDAD_MAX Entonces
			Escribir "Error: edad no permitida.";
		FinSi
	Mientras Que nuevaEdad < EDAD_MIN O nuevaEdad > EDAD_MAX
	
	Escribir "Ingrese nombre de usuario:";
	leer nuevoUsuario;
	
	si nuevoUsuario = "" Entonces
		Escribir "Error: El nombre de usuario no puede estar vacio.";
		//Comprueba si el usuario apretó "Enter" sin escribir nada. Si es así, muestra un error y detiene el proceso.
		Esperar Tecla;
	SiNo
		
		//Convertimos el textp ingresado a minusculas para comparar facilmente
		usuarioMinuscula <- Minusculas(nuevoUsuario);
		
		//RECORRIDO DEL ARREGLO PALABRAADMIN
		//Validacion de palabras prohibidas (Recorrido del arreglo PalabraAdmin)
		esAdminProhibido <- falso;
		para i=0 hasta cantNoAdmin-1 Con Paso 1 Hacer
			//Compara ignorando mayusculas/minusculas gracias a Minusculas()
			si usuarioMinuscula = Minusculas(PalabraAdmin[i]) Entonces
				esAdminProhibido <- Verdadero; //Marca como prohibido si detecta coincidencia
			FinSi
		FinPara
		
		si esAdminProhibido Entonces
			Escribir "Error: Este nombre de usuario no esta permitido";
			Esperar Tecla;
		SiNo
			//validacion de usuario existente
			existe <- falso; //Si superó los filtros anteriores, el programa asume que el usuario no existe.
			para i = 0 hasta max-1 Hacer
				si listaUsuarios[i] = nuevoUsuario Entonces
					existe <- Verdadero; 
					//Si encuentra que el nombre ingresado coincide con un usuario que ya estaba registrado, cambia la variable existe a Verdadero.
				FinSi
			FinPara
			
			si existe = Verdadero Entonces
				Escribir "Ese nombre de usuario ya esta en uso. Intente con otro.";
				//Si existe es verdadero, rebota el registro con un mensaje de advertencia
				Esperar Tecla;
			SiNo
				//Si el nombre está libre, pasa al SiNo y le pide una contraseña (nuevaClave). También valida que la contraseña no este en blanco.
				Escribir "Ingrese clave:";
				leer nuevaClave;
				
				si nuevaClave = "" Entonces
					Escribir "Error: La clave no puede estar vacia.";
					Esperar Tecla;
				SiNo
					//Guardamos los nuevos datos en la posicion libre encontrada.
					listaUsuarios[posLibre] <- nuevoUsuario;
					listaClaves[posLibre] <- nuevaClave;
					listaSaldos[posLibre] <- 1000; //Le damos un saldo inicial de bienvenida.
					listaEdades[posLibre] <- nuevaEdad; 
					
					Escribir "¡Usuario registrado con exito! Saldo inicial de obsequio: $1000";
					Esperar Tecla;
				FinSi
			FinSi
		FinSi
	FinSi
FinSubProceso


SubProceso MenuCasino(listaUsuarios Por Referencia, listaSaldos Por Referencia, idSesion, max)
	definir opcionJuego como entero;
	
	Repetir
		Limpiar Pantalla;
		Escribir "==================================================";
		Escribir "  USUARIO ACTIVO: ", listaUsuarios[idSesion];
		Escribir "  SALDO DISPONIBLE: $", listaSaldos[idSesion];
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
			1, 2, 4:
				Escribir "Juego en desarrollo...";
				Esperar Tecla;
			3:
				si listaSaldos[idSesion]>100 Entonces //si el usuario tiene menos de $100 se le pide cargar fichas
					AnimacionBienvenida;
					MenuJuegoPoker(listaSaldos[idSesion]); //Pasamos el saldo real del arreglo
				SiNo
					Escribir "Error: Saldo insuficiente ($",listaSaldos[idSesion],"). Requiere al menos $100.";
					Escribir "Por favor cargue saldo (opcion 5)";
				FinSi
				
			5:
				CargarSaldo(listaSaldos[idSesion]);
			6:
				Escribir "Cerrando sesion de ", listaUsuarios[idSesion], "...";
				Esperar Tecla;
			De Otro Modo:
				Escribir "Opcion no valida. Vuelva a intentar.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionJuego <> 6
FinSubProceso


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

//=================================================================================
//INICIO DE LA LOGICA DEL POKER
//=================================================================================
// Muestra el nombre legible de la carta (ej: "As de Corazones")
SubProceso MostrarCarta(num_palo, num_valor)
	definir nombre_valor, nombre_palo Como cadena;
	
	//Convertimos el valor numerico a representacion normal (11=J, 12=Q, 13=K, 14=As)
	Segun num_valor Hacer
		11: 
			nombre_valor <- "J";
		12: 
			nombre_valor <- "Q";
		13: 
			nombre_valor <- "K";
		14:
			nombre_valor <- "As";
		De Otro Modo:
			// ConvertirATexto(num_valor): Transforma el valor numerico (ej: 2 a 10)
			//en un dato de tipo cadena para poder asignarlo a nombre_valor sin error de tipos
			nombre_valor <- ConvertirATexto(num_valor);
	FinSegun
	
	// Mapeo del codigo numerico del palo a su nombre real
	Segun num_palo hacer
		1: nombre_palo <- "Corazones";
		2: nombre_palo <- "Diamantes";
		3: nombre_palo <- "Treboles";
		4: nombre_palo <- "Picas";
	FinSegun
	
	Escribir nombre_valor, " de ", nombre_palo Sin Saltar;
FinSubProceso

//Funcion logica que recorre las cartas servidas en ambas manos para verificar
// si una carta candidata (v,p) ya fue entregada previamente. Retorna verdadero falso
Funcion usada <- EsCartaUsada(v, p, j_val Por Referencia, j_palo Por Referencia, m_val Por Referencia, m_palo Por Referencia)
	definir usada como logico;
	definir k como entero;
	
	//Dimensionamos los parametros recibidos dentro de la Funcion
	usada <- falso; // Asumimos inicialmente que la carta esta disponible 
	
	//Recorrido: va desde el indice 0 hasta el 4 (las 5 posiciones de los arreglos)
	//Evalua simultaneamente si coincide en valor y palo con las cartas del jugador o de la maquina
	Para k = 0 hasta 4 con paso 1 Hacer
		Si (j_val[k] = v y j_palo[k] = p) o (m_val[k] = v y m_palo[k] = p) Entonces
			usada <- Verdadero; // se encontro coincidencia: la carta ya no se puede usar
		FinSi
	FinPara
FinFuncion

//SubProceso que reparte las manos iniciales. Usa por referencia en los arreglos
//para que las modificaciones de las cartas persistan fuera del subproceso en la memoria principal
SubProceso RepartirAmbasManos(j_val Por Referencia, j_palo Por Referencia, m_val Por Referencia, m_palo Por Referencia)
	definir i,v,p como entero;
	
	//Recorrido de blanqueo: Inicializa en 0 todos los casilleros de los arreglos 
	//Esto previene basuras de memoria antes de empezar la validacion de duplicados
	Para i=0 hasta 4 con paso 1 Hacer
		j_val[i] <- 0;
		j_palo[i] <- 0;
		m_val[i] <- 0;
		m_palo[i] <- 0;
	FinPara
	
	//Reparto para el Jugador 1
	para i = 0 hasta 4 con paso 1 Hacer
		Repetir
			v <- Aleatorio(2,14);
			p <- Aleatorio(1, 4);
		Mientras Que EsCartaUsada(v,p,j_val,j_palo,m_val,m_palo) = Verdadero;
		j_val[i] <- v;
		j_palo[i] <- p;
	FinPara
	
	//Reparto para la maquina
	//Misma logica, pero ahora la funcion EsCartaUsada tambien revisara las cartas que ya recibio el Jugador 1
	Para i = 0 hasta 4 con paso 1 hacer
		Repetir
			v <- Aleatorio(2,14);
			p <- Aleatorio(1,4);
		Mientras Que EsCartaUsada(v,p,j_val,j_palo,m_val,m_palo) = Verdadero;
		m_val[i] <- v;
		m_palo[i] <- p;
	FinPara
FinSubProceso

//Reordena las cartas de menor a mayor segun su valor numerico
//Es crucial ordenar la mano para simplificar la deteccion de escaleras y pares
SubProceso OrdenarMano(mano_valores Por Referencia, mano_palo Por Referencia)
	definir i,j,AuxValor,AuxPalo Como Entero;
	
	//Bucle externo: Controla la cantidad de pasadas necesarias sobre el arreglo
	Para i = 0 hasta 3 con paso 1 Hacer
		//BUcle interno: Compara pares adyacentes de elementos
		Para j=0 hasta 3-i con paso 1 Hacer
			//Si la carta actual es mayor que la siguiente, se inntercambian sus posiciones
			si mano_valores[j] > mano_valores[j+1] Entonces
				//Intercambio de valores usando variable auxiliar
				AuxValor <- mano_valores[j];
				mano_valores[j] <- mano_valores[j+1];
				mano_valores[j+1] <- AuxValor;
				
				//Intercambio de palos
				AuxPalo <- mano_palo[j];
				mano_palo[j] <- mano_palo[j+1];
				mano_palo[j+1] <- AuxPalo;
			FinSi
		FinPara
	FinPara
	
FinSubProceso

//====================================================================
// EVALUACION DE COMBINACIONES Y RESOLUCION DE GANADOR
//====================================================================

// Analiza una mano ordenada de 5 cartas y devuelve un entero del 1 al 10 segun su jerarquia
Funcion puntaje <- EvaluarMano(mano_valores Por Referencia, mano_palo Por Referencia)
	definir puntaje Como Entero;
	definir esColor, esEscalera, esEscaleraReal Como Logico;
	definir i, pares, trios, poker Como Entero;
	
	pares <- 0;
	trios <- 0;
	poker <- 0;
	
	//Recorrido de comprobacion de Color
	//Asume verdadero y compara cada carta con la siguiente. Si algun palo difiere, interrumpe la bandera
	esColor <- Verdadero;
	para i=0 hasta 3 con paso 1 Hacer
		si mano_palo[i] <> mano_palo[i+1] Entonces
			esColor <- falso;
		FinSi
	FinPara
	
	//Recorrido de comprobacion de Escalera
	//Como la mano ya esta ordenada de menor a mayor, valida si cada carta es exactamente +1 que la anterior
	esEscalera <- Verdadero;
	para i=0 hasta 3 con paso 1 Hacer
		si mano_valores[i+1] <> mano_valores[i] + 1 Entonces
			esEscalera <- falso;
		FinSi
	FinPara
	
	//Deteccion de escalera baja (As como 1: A-2-3-4-5)
	si mano_valores[0] = 2 y mano_valores[1] = 3 y mano_valores[2] = 4 y mano_valores[3] = 5 y mano_valores[4] = 14 Entonces
		esEscalera <- Verdadero;
	FinSi 
	

	
	//Validacion de Escalera Real
	//Requiere cumplir Escalera + color + tener como carta incial el 10 y como final el as (14)
	esEscaleraReal <- falso;
	si esEscalera y esColor y mano_valores[0] = 10 y mano_valores[4] = 14 Entonces
		esEscaleraReal <- Verdadero;
	FinSi
	
	//Deteccion de frecuencias agrupadas (poker  y trios) sobre mano ordenada
	//En mano ordenada, 4 cartas iguales ocupan indice [0..3] o [1..4]
	si (mano_valores[0] = mano_valores[3]) o (mano_valores[1] = mano_valores[4]) Entonces
		poker <- 1;
	FinSi
	
	//En mano ordenada, 3 cartas iguales ocupan indices [0..2], [1..3] o [2..4]
	si (mano_valores[0] = mano_valores[2]) o (mano_valores[1] = mano_valores[3]) o (mano_valores[2] = mano_valores[4]) Entonces
		trios <- 1;
	FinSi
	
	//Recorrido para conteo de pares
	//Cuenta cuantas veces se repiten dos valores contiguos en la mano ordenada
	para i=0 hasta 3 con paso 1 Hacer
		si mano_valores[i] = mano_valores[i+1] Entonces
			pares <- pares +1;
		FinSi
	FinPara
	
	//Un trio genera 2 pares contiguos falsos al contarlo secuencialmente. Se le resta el exceso
	Si poker = 1 Entonces
		pares <- 0;
		trios <- 0;
	SiNo
		si trios = 1 Entonces
			pares <- pares - 2;
		FinSi
	FinSi
	
	//Clasificacion en jerarquia escalar (Del 10 mas alto al 1 mas bajo)
	Si esEscaleraReal Entonces
		puntaje <- 10;
	SiNo
		si esEscalera y esColor Entonces
			puntaje <- 9;
		SiNo
			si poker = 1 Entonces
				puntaje <- 8;
			SiNo
				si trios = 1 y pares = 1 Entonces
					puntaje <- 7; //full house (trio + par)
				SiNo
					si esColor Entonces
						puntaje <- 6;
					SiNo
						Si esEscalera Entonces
							puntaje <- 5;
						SiNo
							si trios = 1 Entonces
								puntaje <- 4;
							SiNo
								si pares = 2 Entonces
									puntaje <- 3; //Doble Par
								SiNo
									si pares = 1 Entonces
										puntaje <- 2; //Un Par
									SiNo
										puntaje <- 1; //Carta Alta
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

//SubProceso de resolucion de victoria y manejo de la banca (salddo/pozo)
SubProceso DeterminarGanador(jug_valor, jug_palo, maq_valor, maq_palo, saldo Por Referencia, pozo Por Referencia)
	definir punt_jug, punt_maq, i, ganador, par_jug, par_maq Como Entero;
	
	punt_jug <- EvaluarMano(jug_valor, jug_palo);
	punt_maq <- EvaluarMano(maq_valor, maq_palo);
	ganador <- 0; //	Estado neutro (0 = Empate, 1 = Jugador, 2 = Maquina)
	
	Escribir "=== RESULTADO FINAL DE LA MANO ===";
	
	//Evaluacion de jerarquia primaria
	Si punt_jug > punt_maq Entonces
		ganador <- 1;
	SiNo
		si punt_maq > punt_jug Entonces
			ganador <- 2;
		Sino
			//Recorrido inverso de desempate
			//Va desde la posicion 4 (la carta de mas alto valor, al estar ordenada)
			//bajando con "Con Paso -1" hasta la posicion 0
			//Si ambas manos tienen la misma jugada, ganan quien tenga la carta mas alta restante
			Si punt_jug = 2 Entonces
				// Buscar cuál es el valor del par de cada uno (en mano ordenada, el par son 2 contiguos)
				par_jug <- 0;
				par_maq <- 0;
				Para i = 0 hasta 3 con paso 1 Hacer
					si jug_valor[i] = jug_valor[i+1] Entonces
						par_jug <- jug_valor[i];
					FinSi
					si maq_valor[i] = maq_valor[i+1] Entonces
						par_maq <- maq_valor[i];
					FinSi
				FinPara
				
				//Compara directamente el valor del Para 
				si par_jug > par_maq Entonces
					ganador <- 1;
				SiNo
					si par_maq > par_jug Entonces
						ganador <- 2;
					FinSi
				FinSi
			FinSi
			
			// Desempate por carta alta (si siguen empatados o si tienen carta alta/ escalera/ etc)
			si ganador = 0 Entonces
				para i=4 hasta 0 con paso -1 Hacer
					si ganador =0 y jug_valor[i] <> maq_valor[i] Entonces
						si jug_valor[i] > maq_valor[i] Entonces
							ganador <- 1;
						SiNo
							ganador <- 2;
						FinSi
					FinSi
				FinPara
			FinSi
		FinSi
	FinSi
	
	//Resultado del premio segun el resultado asignado a la variable ganador 
	Si ganador = 1 Entonces
		Escribir "¡EL JUGADOR GANA LA MANO!";
		saldo <- saldo + pozo; //El saldo aumenta sumando la totalidad del pozo acumulado
		Escribir "¡Ganaste $", pozo,"! Tu nuevo saldo es: $",saldo;
	SiNo
		si ganador = 2 Entonces
			Escribir "¡LA MAQUINA GANA LA MANO!";
			//El saldo no se descuenta aca porque la apuesta ya se resto al inicio del juego
			Escribir "Perdiste la apuesta. Te quedan: $", saldo;
		SiNo
			Escribir "¡EMPATE ABSOLUTO!";
			saldo <- saldo + (pozo/2); //Devuelve al jugador su parte invertida del pozo
			Escribir "Se devuelve tu apuesta. Saldo actual: $", saldo;
		FinSi
	FinSi
FinSubProceso

//===================================================================================
// DESCARTE E INTEGRACION DEL BUCLE DEL JUEGO
//===================================================================================

//Logica de decision de la maquina para descartar cartas
SubProceso DescarteMaquina(j_val,j_palo,m_val Por Referencia,m_palo Por Referencia)
	definir i,puntaje,cand_val,cand_palo Como Entero;
	definir es_repetido Como Logico;
	
	puntaje <- EvaluarMano(m_val, m_palo);
	
	//Toma de decision: Si la maquina solo posee "Carta Alta" (puntaje = 1)
	//descarta sus 3 cartas mas bajas (indices 0, 1 y 2 al estar ordenada la mano) para intentar mejorar
	Si puntaje = 1 Entonces
		para i=0 hasta 2 con paso 1 Hacer
			//Genera un reemplazo asegurando con EsCartaUsada no repetir cartas servidas en mesa
			Repetir
				cand_val <- Aleatorio(2,14);
				cand_palo <- Aleatorio(1,4);
				es_repetido <- EsCartaUsada(cand_val,cand_palo,j_val,j_palo,m_val,m_palo);
			Mientras que es_repetido = Verdadero;
			
			m_val[i] <- cand_val;
			m_palo[i] <- cand_palo;
		FinPara
		//Re-ordena la mano de la maquina tras la modificacion de valores
		OrdenarMano(m_val, m_palo);
		Escribir "La maquina decidio cambiar algunas cartas.";
	SiNo
		//Si la Maquina tiene par o mejor, prefiere no arriesgar y conserva sus cartas
		Escribir "La maquina decidio conservar sus cartas.";
	FinSi
FinSubProceso

//SubProceso principal que coordina el flujo completo del juego
SubProceso JugarPoker(saldo Por Referencia)
	//Declaracion de arreglos paralelos para jugador y maquina (valores y palos)
	definir j1_valores, j1_palo como entero;
	dimension j1_valores[5], j1_palo[5];
	definir maq_valores, maq_palo Como Entero;
	Dimension maq_valores[5], maq_palo[5];
	
	definir puntaje_j1, puntaje_maq, i, cambiar, pos, seguir, j, cand_val, cand_palo Como Entero;
	definir es_repetido, pos_valida Como Logico;
	definir pos_elegidas como entero;
	definir pozo como real;
	dimension pos_elegidas[5]; //Registra las posiciones ya cambiadas por el usuario
	
	repetir 
		Limpiar Pantalla;
		RealizarApuesta(saldo,pozo);
		
		//Reparto sin colisiones y ordenamiento inicial
		RepartirAmbasManos(j1_valores,j1_palo,maq_valores,maq_palo);
		OrdenarMano(j1_valores, j1_palo);
		OrdenarMano(maq_valores, maq_palo);
		
		//Animacion visual de mezcla de mazo (Solo se ejecuta una vez antes de mostrar)
		AnimacionMezclando;
		
		
		
		//Muestra la mano formateada al jugador mediante un recorrido
		Escribir "==================================================";
		Escribir "             REPARTIENDO TU MANO...               ";
		Escribir "==================================================";
		Para i=0 hasta 4 con paso 1 Hacer
			Escribir "Carta ", i+1, ": " Sin Saltar;
			MostrarCarta(j1_palo[i],j1_valores[i]);
			Escribir "";
			Esperar 300 Milisegundos;
		FinPara
		Escribir "";
		
		puntaje_j1 <- EvaluarMano(j1_valores, j1_palo);
		Escribir "Tienes: " Sin Saltar;
		MostrarNombreJugada(puntaje_j1);
		Escribir "";
		Escribir "";
		
		//Inicializacion del control de selecciones del descarte
		para i=0 hasta 4 con paso 1 Hacer
			pos_elegidas[i] <- 0;
		FinPara
		
		Escribir "¿Cuantas cartas quiere cambiar? (0 a 5)";
		leer cambiar;
		
		si cambiar > 0 Entonces
			//Bucle segun la cantidad de descart elegida
			para i=0 hasta cambiar-1 con paso 1 Hacer
				//Validacion de entrada para evitar selecciones duplicados o rangos invalidos
				Repetir
					Escribir "Ingresa la carta a cambiar (1 a 5):";
					leer pos;
					pos_valida <- Verdadero;
					
					//Control de limites de rango validos
					si pos < 1 o pos > 5 Entonces
						Escribir "Carta invalida. Debe ser entre 1 y 5.";
						pos_valida <- falso;
					SiNo
						//Recorrido de verificacion: Revisa si la posicion elegida ya fue ingresada en este turno
						para j=0 hasta i con paso 1 Hacer
							si pos_elegidas[j] = pos Entonces
								escribir "Ya elegiste la carta ", pos, ". Selecciona otra.";
								pos_valida <- falso;
							FinSi
						FinPara
					FinSi
				Mientras Que pos_valida = falso;
				
				//Guarda la posicion procesada para bloquearla en la siguiente iteracion
				pos_elegidas[i] <- pos;
				
				//Genera un reemplazo valido sin repetir la baraja
				Repetir
					cand_val <- Aleatorio(2,14);
					cand_palo <- Aleatorio(1,4);
					es_repetido <- EsCartaUsada(cand_val,cand_palo,j1_valores,j1_palo,maq_valores,maq_palo);
				Mientras Que es_repetido = Verdadero;
				
				//Ssustituye la carta en el arreglo ajustando el indice (pos-1 porque el usaurio ve 1 a 5)
				j1_valores[pos-1] <- cand_val;
				j1_palo[pos-1] <- cand_palo;
			FinPara
			
			
			//Re-ordena y muestra la mano definitiva del jugador
			OrdenarMano(j1_valores, j1_palo);
			Escribir "";
			Escribir "==================================================";
			Escribir "                TU MANO DEFINITIVA                ";
			Escribir "==================================================";
			Escribir "TU MANO INICIAL:";
			Para i=0 hasta 4 con paso 1 Hacer
				escribir "Carta ",i+1, ": " Sin Saltar;
				MostrarCarta(j1_palo[i], j1_valores[i]);
				Escribir "";
			FinPara
			Escribir "==================================================";
			
			puntaje_j1 <- EvaluarMano(j1_valores, j1_palo);
			Escribir "Tu mano final es: " Sin Saltar;
			MostrarNombreJugada(puntaje_j1);
			Escribir "";
		SiNo
			Escribir "Decidiste conservar tu mano inicial.";
		FinSi
		
		//Ejecucion del descarte de la Maquina
		Escribir "";
		Escribir "========================================================";
		Escribir "Turno de la maquina para cambiar cartas...";
		Escribir "";
		DescarteMaquina(j1_valores,j1_palo,maq_valores,maq_palo);
		Escribir "========================================================";
		Escribir "";
		Escribir "Presione ENTER para revelar las manos...";
		Esperar Tecla;
		
		//Revelacion de las cartas de la maquina
		Escribir "";
		Escribir "MANO DE LA MAQUINA:";
		Para i=0 hasta 4 con paso 1 Hacer
			Escribir "Carta ",i+1, ": " Sin Saltar;
			MostrarCarta(maq_palo[i], maq_valores[i]);
			Escribir "";
			Esperar 200 Milisegundos;
		FinPara
		
		puntaje_maq <- EvaluarMano(maq_valores, maq_palo);
		Escribir "La maquina tiene: " Sin Saltar;
		MostrarNombreJugada(puntaje_maq);
		Escribir "";
		Escribir "";
		
		//Evaluacion de ganador y actualizacion del saldo
		DeterminarGanador(j1_valores,j1_palo,maq_valores,maq_palo,saldo,pozo);
		
		//Bucle de control para reinterar mano o salir por falta de fondos
		si saldo > 0 Entonces
			Repetir
				Escribir "";
				Escribir "¿Quieres jugar otra mano? (1: Si / 0: No)";
				leer seguir;
			Mientras que seguir <> 1 y seguir <> 0;
		SiNo
			Escribir "Te quedaste sin saldo. Volviendo al menu del casino...";
			seguir <- 0;
			Esperar Tecla;
		FinSi
	Mientras Que seguir = 1 y saldo >= 100;
FinSubProceso

//=================================================================================
// ESTRUCTURA PRINCIPAL, MENU Y APUESTAS
//=================================================================================

//SubProceso de entrada al juego de Poker desde el casino general
//Recibe la variable saldo por referencia para que las ganancias o perdidas
//se reflejen en la cuenta global del jugador
SubProceso MenuJuegoPoker(saldo Por Referencia)
	definir opcionSubMenu Como Entero;
	
	repetir 
		Limpiar Pantalla;
		Escribir "==================================================================";
		Escribir "                     OPCIONES DE POKER                            ";
		Escribir "==================================================================";
		Escribir "Saldo disponible: $",saldo;
		Escribir "1. Iniciar Juego.";
		Escribir "2. Leer reglas y combinaciones.";
		Escribir "3. Volver al menu principal.";
		Escribir "==================================================================";
		Escribir "Seleccione una opcion:";
		leer opcionSubMenu;
		
		segun opcionSubMenu Hacer
			1:
				JugarPoker(saldo);
			2:
				MostrarReglas();
				Esperar Tecla;
			3:
				Escribir "Vollviendo al menu del casino...";
			De Otro Modo:
				Escribir "Opcion no valida. Presiona ENTER para intentar de nuevo.";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionSubmenu <> 3;
FinSubProceso

//SubProceso encargado de solicitar y validar el monto apostado por el usuario
//Modifica el saldo del jugador e iguala el pozo en la mesa por parte de la casa
SubProceso RealizarApuesta(saldo Por Referencia, pozo Por Referencia)
	definir apuesta Como real;
	escribir "================================================";
	escribir "Tus fichas disponibles: $",saldo;
	escribir "================================================";
	
	//Buvle de validacion de entrada financiera
	Repetir
		Escribir "Ingresa el monto a apostar para esta mano:";
		leer apuesta;
		
		si apuesta <= 0 Entonces
			Escribir "La apuesta debe ser un valor positivo mayor a $0.";
		SiNo
			Si apuesta > saldo Entonces
				Escribir "No podes apostar $", apuesta, "porque tu saldo actual es de $:",saldo;
			FinSi
		FinSi
		
		//Valida que la apuesta este dentro del rango legal (maayor a 0 y menor/igual al saldo real)
	Mientras Que apuesta <= 0 o apuesta > saldo;
	
	AnimacionApuesta(apuesta);
	
	//Transaccion: Descuenta la apuesta del jugador y duplica el pozo con el dinero de la casa
	saldo <- saldo - apuesta;
	pozo <- apuesta * 2;
	
	Escribir "";
	Escribir "¡Apuesta aceptada!";
	Escribir "Apostaste: $", apuesta;
	Escribir "La Casa igualo tu apuesta con: $", apuesta;
	Escribir "Pozo total acumulado en la mesa: $", pozo;
	Escribir "===========================================";
	Escribir "";
FinSubProceso

// Muestra en pantalla el cuadro informativo de reglas y jerarquías de jugadas
SubProceso MostrarReglas
	Limpiar Pantalla;
	Escribir "===============================================================";
	Escribir "                        REGLAS DEL POKER                       ";
	Escribir "===============================================================";
	Escribir "1. Cada jugador recibe 5 cartas de un mazo de 52.";
	Escribir "2. Podes cambiar de 0 a 5 cartas en la fase de descarte.";
	Escribir "3. Gana la mano quien forme la combinacion de mayor jerarquia:";
	Escribir "   - Escalera Real      (10, J, Q, K, As del mismo palo)";
	Escribir "   - Escalera de Color  (5 cartas consecutivas del mismo palo)";
	Escribir "   - Poker             (4 cartas con el mismo valor)";
	Escribir "   - Full House        (Un Trio + Un Par)";
	Escribir "   - Color             (5 cartas del mismo palo)";
	Escribir "   - Escalera          (5 cartas de valores consecutivos)";
	Escribir "   - Trio              (3 cartas con el mismo valor)";
	Escribir "   - Doble Par         (Dos pares de cartas iguales)";
	Escribir "   - Par               (Dos cartas con el mismo valor)";
	Escribir "   - Carta Alta        (Valor de la carta mas alta)";
	Escribir "===============================================================";
	Escribir "Presiona cualquier tecla para volver al menu...";
	Esperar Tecla;
FinSubProceso

// Graficos
SubProceso AnimacionBienvenida
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
		Escribir '    [+]---------- casiNOgano ----------[+]';
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
		Escribir '    [+]---------- casiNOgano ----------[+]';
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
FinSubProceso

SubProceso AnimacionMezclando
	Definir i Como Entero;
	Para i <- 1 Hasta 2 Con Paso 1 Hacer
		Limpiar Pantalla;
		Escribir "          Mezclando el mazo...             ";
		Escribir "";
		Escribir "     [C]     [D]     [T]     [P]           ";
		Escribir "   +-----+ +-----+ +-----+ +-----+         ";
		Escribir "   |=====| |=====| |=====| |=====|         ";
		Escribir "   +-----+ +-----+ +-----+ +-----+         ";
		Esperar 250 Milisegundos;
		
		Limpiar Pantalla;
		Escribir "          Mezclando el mazo...             ";
		Escribir "";
		Escribir "       [D]     [C]     [P]     [T]         ";
		Escribir "      +-----+ +-----+ +-----+ +-----+      ";
		Escribir "      |*****| |*****| |*****| |*****|      ";
		Escribir "      +-----+ +-----+ +-----+ +-----+      ";
		Esperar 250 Milisegundos;
	FinPara
	Limpiar Pantalla;
FinSubProceso


SubProceso AnimacionApuesta(monto)
	Limpiar Pantalla;
	Escribir "          Aceptando apuestas...            ";
	Escribir "               ( $ )                       ";
	Escribir "                 |                         ";
	Escribir "                 v                         ";
	Escribir "          [=== MESA ===]                   ";
	Esperar 800 Milisegundos;
	
	Limpiar Pantalla;
	Escribir "          Aceptando apuestas...            ";
	Escribir "                                           ";
	Escribir "               ( $ )                       ";
	Escribir "                 v                         ";
	Escribir "          [=== MESA ===]                   ";
	Esperar 800 Milisegundos;
	
	Limpiar Pantalla;
	Escribir "===========================================";
	Escribir "   ¡APUESTA ACEPTADA! POZO ACUMULADO       ";
	Escribir "            *** $", monto * 2, " ***       ";
	Escribir "===========================================";
	Esperar 1000 Milisegundos;
FinSubProceso
//=================================================================================
//FIN DE LA LOGICA DEL POKER
//=================================================================================