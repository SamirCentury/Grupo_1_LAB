Algoritmo Casino_Virtual_Optimizado
	//========================================================
	//1. CONFIGURACION E INICIALIZACION DE DATOS
	//========================================================
	
	//Variables de control para la navegacion del menu principal.
	Definir listaUsuarios, listaClaves, PalabraAdmin,opcionTexto como cadena;
	Definir listaSaldos como real;
	Definir listaEdades, opcionSeleccion, idSesion, i como entero; 
	//opcion: Variable entera para capturar la selección del usuario en el menú principal
	//idSesion: Variable entera utilizada para identificar al usuario que ha iniciado sesión
	Definir posicionLibre Como Entero;
	Definir cupoLibre como logico;
	
	//Monto minimo que pide el juego para ingresar a jugar
	MAX_SALDO_POKER <- 1500; 
	MAX_SALDO_TRAGAMONEDAS <- 500; 
	MAX_SALDO_RULETA <- 500; 
	MAX_SALDO_BLACKJACK <- 1500; 
	
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
		leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    opcionSeleccion <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para que opcionSeleccion reciba un valor entero
		SiNo
			opcionSeleccion <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
		Segun opcionSeleccion hacer
			1:
				idSesion <- IniciarSesion(listaUsuarios, listaClaves, MAX_USUARIOS); //Llamamos a la funcion de autenticacion y guardamos la posicion del usuario devuelta. 
				
				si idSesion <> -1 Entonces //Si idSesion es distinto de -1, significa que el login es exitoso/correcto.
					si listaUsuarios[idSesion] = "admin" Entonces //Validacion  de rol: si el usuaio es "admin", va al panel  de control.
						MenuAdmin(listaUsuarios, listaClaves, listaSaldos, listaEdades, MAX_USUARIOS);
					SiNo
						//MenuCasino(listaUsuarios, listaSaldos, idSesion, MAX_USUARIOS,MAX_SALDO_POKER); //Si es jugador comun: va a la sala de juegos.
						MenuCasino(listaUsuarios, listaSaldos, idSesion, max, MAX_SALDO_POKER, MAX_SALDO_BLACKJACK, MAX_SALDO_RULETA, MAX_SALDO_TRAGAMONEDAS);
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
	Mientras Que opcionSeleccion <> 3 //El programa sigue corriendo hasta que el usuario elija la opcion 3 (Salir).
FinAlgoritmo
//=========================================================================
//  FUNCION PARA VALIDAR NUMEROS ENTEROS/REALES (SEGUN, EDAD, ETC)
//=========================================================================
Funcion valido <- EsValido(textoIngresado)
    Definir valido Como Logico;
    Definir j, contadorPuntos Como Entero;
    Definir caracterActual Como Cadena;
    
	//Incializamos la bandera en verdadero y el contador de decimales en 0
    valido <- Verdadero;
	contadorPuntos <- 0;
    
    // Validamos que no hayan presionado ENTER dejando la entrada vacia
    Si Longitud(textoIngresado) = 0 Entonces
        valido <- Falso;
    SiNo
        // Recorremos la cadena caracter por caracter (desde 0 hasta n-1)
        Para j <- 0 Hasta Longitud(textoIngresado) - 1 Con Paso 1 Hacer
            caracterActual <- Subcadena(textoIngresado, j, j);
			
			//Verificamos si el caracter es un separador decimal (punto o coma)
            Si caracterActual = "." o caracterActual = "," Entonces
				contadorPuntos <- contadorPuntos + 1;
			SiNo
				//Si no es un separador, evaluamos si esta  fuera de rango de digitos (0 al 9)
				si caracterActual < "0" o caracterActual > "9" Entonces
					valido <- falso; // Invalida el resultado si detecta letras, espacios o simbolos
				FinSi
            FinSi
        FinPara
		
		//Un numero real valido no puede tener mas de un punto/coma decimal (ej: "10.50.2" es invalido)
		Si contadorPuntos > 1 Entonces
			valido <- falso;
		FinSi
    FinSi
FinFuncion
//=========================================================================
//  FIN DE FUNCION PARA VALIDAR NUMEROS ENTEROS/REALES (SEGUN, EDAD, ETC)
//=========================================================================
//-------------------------------------------------------------------------

//=========================================================================
// INICIO DE AUXILIAR PARA VALIDAR NUMEROS ENTEROS/REALES
// ReemplazarComaPunto
// Objetivo: Recorrer una cadena de texto y reemplazar cualquier coma (,)
//por un punto, para asegurar compatibilidad con CinvertirNumero
//=========================================================================
Funcion textoModificado <- ReemplazarComaPorPunto(textoOriginal)
	//Declaracion de variables locales para el recorrido de la cadena
	definir j como entero;
	definir caracterActual, textoModificado como cadena;
	
	//Inicializamos la variable de retorno como un texto vacio
	textoModificado <- "";
	
	//Recorremos la cadena caracter por caracter (desde la posicion 0 hasta n-1)
	para j <- 0 hasta longitud(textoOriginal)-1 con paso 1 Hacer
		//Extraemos el caracter de la posicion actual
		caracterActual <- Subcadena(textoOriginal,j,j);
		si caracterActual = "," Entonces
			caracterActual <- ".";
		FinSi
		//Si detectamos una coma, ponemos un punto en su lugar
		textoModificado <- Concatenar(textoModificado, caracterActual); //concatenar: unir o enlazar 2 o mas cosas
	FinPara
FinFuncion
//=========================================================================
//  FIN DE AUXILIAR PARA VALIDAR NUMEROS ENTEROS/REALES
//=========================================================================
	
	


//=========================================================================
//  INICIO DE SESION
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
    Definir usuarioBuscar,opcionTexto Como Cadena;
    
    Repetir
        Limpiar Pantalla;
        Escribir "===================================================";
        Escribir "       PANEL DE CONTROL (ADMINISTRADOR)            ";
        Escribir "===================================================";
        Escribir "1. Listar todos los usuarios y saldos";
        Escribir "2. Modificar saldo a un usuario";
		Escribir "3. Banear / Eliminar usuario"; 
        Escribir "4. Cerrar Sesion de Administrador";
        Escribir "===================================================";
        Escribir "Seleccione una opcion:";
        Leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    opcionAdmin <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para que opcionAdmin reciba un valor entero
		SiNo
			opcionAdmin <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
        
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
                    Leer opcionTexto;
					
					//Llamamos a la funcion para que se cambie "," por "."
					opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
					
					Si EsValido(opcionTexto) = Verdadero Entonces
						opcionAjuste <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para que opcionAjuste reciba un valor entero
					SiNo
						opcionAjuste <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
					FinSi
                    
                    Segun opcionAjuste Hacer
                        1: 
                            Escribir "Ingrese el monto a sumar: "; //Le pide un monto al admin y se lo suma al saldo actual (+ montoAjuste). 
							//Tiene una validación que exige que el monto sea un número positivo.
							leer opcionTexto;
							
							//Llamamos a la funcion para que se cambie "," por "."
							opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
							
							//Validamos y truncamos
							Si EsValido(opcionTexto) Entonces
								// Trunc() convierte la parte decimal en un entero (ej: 550.5 pasa a ser 550)
								montoAjuste <- Trunc(ConvertirANumero(opcionTexto));
							SiNo
								Escribir "Error: Monto no válido.";
								montoAjuste <- 0;
							FinSi
							
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
                            Leer opcionTexto;
							
							//Llamamos a la funcion para que se cambie "," por "."
							opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
							
							//Validamos y truncamos
							Si EsValido(opcionTexto) Entonces
								// Trunc() convierte la parte decimal en un entero (ej: 550.5 pasa a ser 550)
								montoAjuste <- Trunc(ConvertirANumero(opcionTexto));
							SiNo
								Escribir "Error: Monto no válido.";
								montoAjuste <- 0;
							FinSi
							
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
                            Leer opcionTexto;
							
							//Llamamos a la funcion para que se cambie "," por "."
							opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
							
							//Validamos y truncamos
							Si EsValido(opcionTexto) Entonces
								// Trunc() convierte la parte decimal en un entero (ej: 550.5 pasa a ser 550)
								nuevoSaldo <- ConvertirANumero(opcionTexto);
							SiNo
								Escribir "Error: Monto no válido.";
								nuevoSaldo <- 0;
							FinSi
							
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
				Limpiar Pantalla;
				Escribir "=== BANEAR / ELIMINAR USUARIO ===";
				Escribir "Ingrese el NOMBRE del usuario a banear:";
				Leer usuarioBuscar;
				
				// BÚSQUEDA DEL USUARIO
				usuarioModificar <- -1;
				i <- 0;
				
				Mientras (i < max) Y (usuarioModificar = -1) Hacer
					// Evitamos que se pueda banear a la cuenta de admin
					Si listaUsuarios[i] = usuarioBuscar Y usuarioBuscar <> "" Y usuarioBuscar <> "admin" Entonces
						usuarioModificar <- i; // Guarda la posición
					FinSi
					i <- i + 1;
				FinMientras
				
				Si usuarioModificar <> -1 Entonces
					// Blanqueamos los datos de la posición para liberar el cupo
					listaUsuarios[usuarioModificar] <- "";
					listaClaves[usuarioModificar] <- "";
					listaSaldos[usuarioModificar] <- 0;
					listaEdades[usuarioModificar] <- 0;
					
					Escribir "¡El usuario ", usuarioBuscar, " ha sido baneado y su cupo liberado!";
				SiNo
					Si usuarioBuscar = "admin" Entonces
						Escribir "Error: No esta permitido banear a la cuenta de administrador.";
					SiNo
						Escribir "Error: El usuario no existe en el sistema.";
					FinSi
				FinSi
				Esperar Tecla;
            4: 
                Escribir "Cerrando panel de administracion...";
                Esperar Tecla;
            De Otro Modo:
                Escribir "Opcion no valida.";
                Esperar Tecla;
        FinSegun
    Mientras Que opcionAdmin <> 4
FinSubProceso


SubProceso RegistrarUsuario(listaUsuarios Por Referencia, listaClaves Por Referencia, listaSaldos Por Referencia, listaEdades Por Referencia, max,PalabraAdmin Por Referencia, cantNoAdmin, EDAD_MIN, EDAD_MAX)
	definir i, posLibre, nuevaEdad Como Entero;
	definir nuevoUsuario, nuevaClave,usuarioMinuscula, caracterUsuario como cadena;
	definir existe, esAdminProhibido, usuarioValido, tieneLetra como logico;
	
	//Variables para la validacion de edad
	definir entradaEdad como cadena;
	definir esNumeroValido Como Logico;
	definir j como entero;
	definir caracterActual como cadena;
	
	posLibre <- -1; //Asume al principio que no hay espacio.
	Para i = 0 hasta max-1 Hacer
		si listaUsuarios[i] = "" y posLibre = -1 Entonces 
			//Si encuentra una posición vacía ("") y todavía no había guardado ninguna otra (posLibre = -1), anota ese número de índice en posLibre.
			posLibre <- i; 
		FinSi
	FinPara
	
	Limpiar Pantalla;
	Escribir "=== REGISTRO DE USUARIO ===";
	
	//Pedimos la edad para validar que sea mayor de edad para jugar (A prueba de letras y caracteres)
	repetir 
		Escribir "Ingrese su edad (permitido de ", EDAD_MIN, " a " ,EDAD_MAX, " años):";
		leer entradaEdad;
		
		esNumeroValido <- Verdadero;
		
		//validamos que no hayan presionado ENTER sin escribir nada
		
		si Longitud(entradaEdad) = 0 Entonces
			esNumeroValido <- falso;
		SiNo
			//Comprobamos que cada caracter sea un digito numerico (0 al 9)
			para j=0 hasta longitud(entradaEdad)-1 con paso 1 Hacer
				caracterActual <- Subcadena(EntradaEdad,j,j); // j,j extrae un caracter en la posicion j y eso lo guarda en el caracter actual
				si caracterActual < "0" o caracterActual > "9" Entonces
					esNumeroValido <- falso; // se encontro una letra o simbolo
				FinSi
			FinPara
		FinSi
		
		si esNumeroValido = falso Entonces
			Escribir "Error: Debe ingresar un numero entero valido (sin letras ni espacios.)";
			Escribir "";
		SiNo
			// Si paso la validacion, convertimos la cadena a numero entero
			nuevaEdad <- ConvertirANumero(entradaEdad);
			
			//Validamos que el rango de edad sea el permitido
			si nuevaEdad < EDAD_MIN O nuevaEdad > EDAD_MAX Entonces
				Escribir "Error: edad no permitida.";
			FinSi
		FinSi
		
		
	Mientras Que esNumeroValido = falso o nuevaEdad < EDAD_MIN O nuevaEdad > EDAD_MAX
	
	Repetir
		
		Escribir "Ingrese nombre de usuario (Debe llevar letras, pero puede incluir numeros):";
		leer nuevoUsuario;
		
		usuarioValido <- Verdadero;
		tieneLetra <- falso;  //Bandera para confirmar que haya al menos una letra
		
		//Validamos que no presione ENTER sin escribir nada
		si Longitud(nuevoUsuario) = 0 Entonces
			usuarioValido <- falso;
		SiNo
			usuarioMinuscula <- Minusculas(nuevoUsuario);
			
			//Comprobamos caracter por caracter
			para j=0 hasta Longitud(nuevoUsuario)-1 con paso 1 Hacer
				caracterUsuario <-Subcadena(usuarioMinuscula,j,j);
				
				//si es una letra entre "a" y "z"
				si caracterUsuario >= "a" y caracterUsuario <= "z" Entonces
					tieneLetra <- Verdadero; //confirmamos que al menos haya una letra 
				SiNo
					//si no es una letra y tampoco es un numero (0 a 9), es un simbolo o espacio
					si caracterUsuario < "0" o caracterUsuario > "9" Entonces
						usuarioValido <- falso; //caracter no permitido (espacio, guion, simbolo, etc)
					FinSi
				FinSi
			FinPara
		FinSi
		
		//Evaluacion de errores y mensajes
		si usuarioValido = falso Entonces
			Escribir "Error: El usuario no puede contener espacios ni simboolos especiales.";
			Escribir "";
		Sino
			//Si los caracteres eran validos pero eran solo numeros (ej=1234)
			si tieneLetra = falso Entonces
				Escribir "Error: El nombre de usuario no puede ser solo numeros, debe tener letras.";
				Escribir "";
			SiNo
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
					FinSi
				FinSi
			FinSi
		FinSi
	Mientras Que usuarioValido = falso o tieneLetra = falso o esAdminProhibido = Verdadero o existe = Verdadero
	
	si nuevoUsuario = "" Entonces
		Escribir "Error: El nombre de usuario no puede estar vacio.";
		//Comprueba si el usuario apretó "Enter" sin escribir nada. Si es así, muestra un error y detiene el proceso.
		Esperar Tecla;
	SiNo
		//Convertimos el textp ingresado a minusculas para comparar facilmente
		usuarioMinuscula <- Minusculas(nuevoUsuario);
		//RECORRIDO DEL ARREGLO PALABRAADMIN
		//Validacion de palabras prohibidas (Recorrido del arreglo PalabraAdmin)
	FinSi

	//Ingreso de clave y guardado de datos
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
FinSubProceso


SubProceso MenuCasino(listaUsuarios Por Referencia, listaSaldos Por Referencia, idSesion, max,MAX_SALDO_POKER, MAX_SALDO_BLACKJACK, MAX_SALDO_RULETA, MAX_SALDO_TRAGAMONEDAS)
	definir opcionJuego como entero;
	definir opcionTexto como cadena;
	
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
		leer opcionTexto;
		
		//Llamamos a la funcion del auxiliar por si el usuario escribe "2,5", esto lo convierte a "2.5"
		//para evitar que el programa falle
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto); 
		
		Si EsValido(opcionTexto) = Verdadero Entonces
            opcionJuego <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos porque el segun solo acepta numeros enteros
        SiNo
            opcionJuego <- 0; // Si escribió "veinte", asigna 0 para caer en 'De Otro Modo'[cite: 2]
        FinSi
		
		Segun opcionJuego Hacer
			1:  si listaSaldos[idSesion]>MAX_SALDO_RULETA Entonces //si el usuario tiene menos de $100 se le pide cargar fichas
					Ruleta_Laboratorio(listaSaldos[idSesion]);
				SiNo
					Escribir "Error: Saldo insuficiente ($",listaSaldos[idSesion],"). Requiere al menos $", MAX_SALDO_RULETA;
					Escribir "Por favor cargue saldo (opcion 5)";
					Esperar Tecla;
				FinSi
			2:
				si listaSaldos[idSesion]>MAX_SALDO_TRAGAMONEDAS Entonces //si el usuario tiene menos de $100 se le pide cargar fichas
					TRAGAMONEDAS(listaSaldos[idSesion]); //Pasamos el saldo real del arreglo
				SiNo
					Escribir "Error: Saldo insuficiente ($",listaSaldos[idSesion],"). Requiere $", MAX_SALDO_TRAGAMONEDAS;
					Escribir "Por favor cargue saldo (opcion 5)";
					Esperar Tecla;
				FinSi
			3:
				si listaSaldos[idSesion]>=MAX_SALDO_POKER Entonces //si el usuario tiene menos de $100 se le pide cargar fichas
					AnimacionBienvenida;
					MenuJuegoPoker(listaSaldos[idSesion]); //Pasamos el saldo real del arreglo
				SiNo
					Escribir "Error: Saldo insuficiente ($",listaSaldos[idSesion],"). Requiere al menos $", MAX_SALDO_POKER;
					Escribir "Por favor cargue saldo (opcion 5)";
					Esperar Tecla;
				FinSi
			4:
				si listaSaldos[idSesion] >MAX_SALDO_BLACKJACK Entonces
					blackjack(listaSaldos[idSesion]);
				SiNo
					Escribir "Error: Saldo insuficiente ($",listaSaldos[idSesion],"). Requiere al menos $", MAX_SALDO_BLACKJACK;
					Escribir "Por favor cargue saldo (opcion 5)";
					Esperar Tecla;
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
	definir opcionTexto como cadena;
	definir monto Como Real;
	
	Limpiar Pantalla;
	Escribir "=== CARGA DE SALDO ===";
	Escribir "Saldo actual: $", saldoUsuario;
	Escribir "Ingrese el monto a ingresar:";
	leer opcionTexto;
	
	//Llamamos a la funcion auxiliar  que transforma "550,5" a "550.5" antes de validar o convertir
	opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
	
	Si EsValido(opcionTexto) = Verdadero Entonces
		monto <- ConvertirANumero(opcionTexto);
	SiNo
		monto <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
	FinSi
	
	//validaciones de seguridad para evitar numeros negativos o depositos en cero
	si monto > 0 Entonces
		saldoUsuario <- saldoUsuario + monto; //Suma directa al acumulador del usuario
		Escribir "¡Carga exitosa! Nuevo saldo: $", saldoUsuario;
	SiNo
		Escribir "Monto invalido. La carga debe ser mayor a $0.";
	FinSi
	Esperar Tecla;
FinSubProceso
//================================================================================
// INICIO DE LA LOGICA DE LA RULETA
//================================================================================
SubProceso CargarColores(colores)
    Definir i Como Entero;
    
    Para i <- 0 Hasta 36 Con Paso 1 Hacer
        colores[i] = "N";
    FinPara
    
    colores[0] = "V";
    
    colores[1]  = "R"; colores[3]  = "R"; colores[5]  = "R"; colores[7]  = "R";
    colores[9]  = "R"; colores[12] = "R"; colores[14] = "R"; colores[16] = "R";
    colores[18] = "R"; colores[19] = "R"; colores[21] = "R"; colores[23] = "R";
    colores[25] = "R"; colores[27] = "R"; colores[30] = "R"; colores[32] = "R";
    colores[34] = "R"; colores[36] = "R";
FinSubProceso

SubProceso MostrarBienvenida
	Limpiar Pantalla;
    Escribir "==========================================";
    Escribir "            BIENVENIDOS AL                ";
    Escribir "         JUEGO DE LA RULETA               ";
    Escribir "==========================================";
FinSubProceso

SubProceso DibujarPanoRuleta
	Limpiar Pantalla;
    Escribir "==========================================================================";
    Escribir "                         PANEL DE LA RULETA EUROPEA                       ";
    Escribir "==========================================================================";
    Escribir "  +-----+---------------------------------------------------------------+";
    Escribir "  |     | [ 3R] [ 6N] [ 9R] [12R] [15N] [18R] [21R] [24N] [27R] [30R] [33N] [36R] |";
    Escribir "  |     |---------------------------------------------------------------|";
    Escribir "  | 0 V | [ 2N] [ 5R] [ 8N] [11N] [14R] [17N] [20N] [23R] [26N] [29N] [32R] [35N] |";
    Escribir "  |     |---------------------------------------------------------------|";
    Escribir "  |     | [ 1R] [ 4N] [ 7R] [10N] [13N] [16R] [19R] [22N] [25R] [28N] [31N] [34R] |";
    Escribir "  +-----+---------------------------------------------------------------+";
    Escribir "        |          1ra DOCENA           |          2da DOCENA           |          3ra DOCENA           |";
    Escribir "        |            (1 - 12)           |           (13 - 24)           |           (25 - 36)           |";
    Escribir "        +-------------------------------+-------------------------------+-------------------------------+";
    Escribir "        |    1 - 18     |      PAR      |     ROJO      |     NEGRO     |     IMPAR     |    19 - 36    |";
    Escribir "        +---------------+---------------+---------------+---------------+---------------+---------------+";
    Escribir "  Referencias: [R] = Rojo | [N] = Negro | [V] = Verde (0)";
    Escribir "==========================================================================";
FinSubProceso

// Simula visualmente el giro de la bola en la rueda
SubProceso AnimarGiroRuleta(numeroSalio, colorSalio)
	Limpiar Pantalla;
    Escribir "";
    Escribir "           .---.          ";
    Escribir "        .-/     /-.       ";
    Escribir "       /   ( o )   /      Girando la rueda y lanzando la bola...";
    Escribir "      |   /     /   |     * clic * * clac * * clic *";
    Escribir "       /   ( o )   /      ";
    Escribir "        .-/     /-.       ";
    Escribir "           ---          ";
    Esperar 1 Segundos;
    Limpiar Pantalla;
    Escribir "";
    Escribir "      +-------------------------------------------+";
    Escribir "      |           ¡LA BOLA SE HA DETENIDO!        |";
    Escribir "      |                                           |";
    Escribir "      |             NUMERO GANADOR: [ ", numeroSalio, " ]         |";
    Escribir "      |                COLOR: [ ", colorSalio, " ]                |";
    Escribir "      +-------------------------------------------+";
    Escribir "";
FinSubProceso

Funcion monto = SolicitarApuesta(saldoActual)
	Definir monto Como Real;
	Definir opcionTexto como cadena;
	Definir montoMinimo Como Real;
		
	// Configura aquí el valor del monto mínimo permitido
	montoMinimo <- 500; 
		
	Repetir
		Escribir "Saldo disponible: $", saldoActual;
		Escribir "Monto mínimo de apuesta: $", montoMinimo;
		Escribir "Ingrese monto a apostar:";
		Leer opcionTexto;
			
		// Llamamos a la funcion auxiliar por si el usuario coloca "," en lugar de "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
			
		Si EsValido(opcionTexto) = Verdadero Entonces
			monto <- ConvertirANumero(opcionTexto);
		SiNo
			monto <- 0; // Si escribieron letras, asigna 0
		FinSi
			
		Limpiar Pantalla;
			
		// --- VALIDACIONES ---
		Si monto <= 0 Entonces
			Escribir "Error: El monto debe ser un número válido mayor a 0.";
		SiNo
			Si monto < montoMinimo Entonces
				Escribir "Error: El monto mínimo para apostar es de $", montoMinimo, ".";
			FinSi
				
			Si monto > saldoActual Entonces
				Escribir "Error: Saldo insuficiente. Tu saldo actual es de $", saldoActual, ".";
			FinSi
		FinSi
			
		// El bucle se repite hasta que el monto sea válido, mayor o igual al mínimo y menor o igual al saldo
		Hasta Que monto >= montoMinimo Y monto <= saldoActual
FinFuncion


Funcion tipo = MenuApuestas
    Definir tipo Como Entero;
	Definir opcionTexto como cadena;
    Repetir
        Escribir "";
		Limpiar Pantalla;
        Escribir "=== TIPOS DE APUESTA DE LA RULETA ===";
        Escribir "1. Pleno (0 al 36)    [Paga 35:1]";
        Escribir "2. Color (Rojo/Negro) [Paga 1:1]";
        Escribir "3. Par o Impar        [Paga 1:1]";
		Escribir "4. Falta (1-18) / Pasa (19-36) [Paga 1:1]";
		Escribir "5. Docenas (1-12, 13-24, 25-36) [Paga 2:1]";
        Escribir "Seleccione una opcion (1-5):";
        Leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    tipo <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para tener un valor entero
		SiNo
			tipo <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
        Si tipo < 1 O tipo > 5 Entonces
            Escribir "Opcion invalida... Reintente";
        FinSi
    Mientras Que tipo < 1 O tipo > 5
FinFuncion

Funcion num = PedirNumeroPleno
    Definir num Como Entero;
	Definir opcionTexto como cadena;
	
    Repetir
        Escribir "Elija un numero (1 al 36):";
        Leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    num <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para obtener un valor entero
		SiNo
			num <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
		
		Si num <= 0 o num >=36 Entonces
			Escribir "Error: Numero fuera de rango";
		FinSi
		
    Mientras Que num <= 0  o num >= 36 
FinFuncion

Funcion col = PedirColor
    Definir col Como Caracter;
    Repetir
        Escribir "Elija color (R: Rojo / N: Negro):";
        Leer col;
        col = Mayusculas(col);
        Si col <> "R" Y col <> "N" Entonces
            Escribir "Error: Ingrese solo R o N";
        FinSi
    Mientras Que col <> "R" Y col <> "N"
FinFuncion

Funcion paridad = PedirParidad
    Definir paridad Como Entero;
	Definir opcionTexto como cadena;
	
    Repetir
		
        Escribir "Elija paridad (1: Par / 2: Impar):";
        Leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    paridad <- ConvertirANumero(opcionTexto);
		SiNo
			paridad <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
        Si paridad <> 1 Y paridad <> 2 Entonces
            Escribir "Error: Ingrese 1 para Par o 2 para Impar";
        FinSi
    Mientras Que paridad <> 1 Y paridad <> 2
FinFuncion

Funcion rango = PedirFaltaPasa
    Definir rango Como Entero;
	Definir opcionTexto como cadena;
    Repetir
        Escribir "Elija rango (1: Falta [1-18] / 2: Pasa [19-36]):";
        Leer opcionTexto;
		
		//Si el usuario coloca un valor con "coma" esta funcion lo convierte en "punto"
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    rango <- trunc(ConvertirANumero(opcionTexto)); //truncamos para obtener un valor entero 
		SiNo
			rango <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
        Si rango <> 1 Y rango <> 2 Entonces
            Escribir "Error: Ingrese 1 para Falta o 2 para Pasa";
        FinSi
    Mientras Que rango <> 1 Y rango <> 2
FinFuncion

Funcion docena = PedirDocena
	Definir docena Como Entero;
	Definir opcionTexto como cadena;
	Repetir
		Escribir "Elija la docena:";
        Escribir "1. Primera docena (1 al 12)";
        Escribir "2. Segunda docena (13 al 24)";
        Escribir "3. Tercera docena (25 al 36)";
        Leer opcionTexto;
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    docena <- ConvertirANumero(opcionTexto);
		SiNo
			docena <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
        Si docena < 1 O docena > 3 Entonces
            Escribir "Error: Ingrese una opcion valida (1, 2 o 3).";
        FinSi
	Mientras Que docena < 1 O docena > 3
FinFuncion

Funcion num = TirarRuleta
    Definir num Como Entero;
    num = Azar(37);
FinFuncion

SubProceso ResolverRonda(tipo, monto, colores, saldo Por Referencia)
    Definir numElegido, numeroSalio, paridadElegida, rangoElegido, docenaElegida Como Entero;
    Definir colElegido, colSalio Como Caracter;
    
	// Entrada de datos segun el tipo de jugada
    Segun tipo Hacer
        1:
            numElegido = PedirNumeroPleno();
        2:
            colElegido = PedirColor();
        3:
            paridadElegida = PedirParidad();
		4: 
			rangoElegido = PedirFaltaPasa();
		5:
			docenaElegida = PedirDocena();
    FinSegun
    
	// Gira la bolaa
    numeroSalio = TirarRuleta();
    colSalio = colores[numeroSalio];
	AnimarGiroRuleta(numeroSalio, colSalio);
    
    Segun tipo Hacer
        1:
            Si numElegido = numeroSalio Entonces
                Escribir "?Acertaste el pleno! Ganaste $", (monto * 35);
                saldo = saldo + (monto * 35);
            Sino
                Escribir "Perdiste :( $", monto;
                saldo = saldo - monto;
            FinSi
            
        2:
            // Si sale 0 (Verde), la casa gana frente a Rojo/Negro
            Si (colElegido = colSalio) Y (numeroSalio <> 0) Entonces
                Escribir "¡Acertaste el color! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Color incorrecto (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi
            
        3:
            // El 0 no es par ni impar; la casa gana
            Si (numeroSalio <> 0) Y (((paridadElegida = 1) Y (numeroSalio MOD 2 = 0)) O ((paridadElegida = 2) Y (numeroSalio MOD 2 <> 0))) Entonces
                Escribir "¡Acertaste la paridad! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Paridad incorrecta (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi
		4:
            // Si sale 0, la casa gana
            Si (numeroSalio <> 0) Y (((rangoElegido = 1) Y (numeroSalio >= 1 Y numeroSalio <= 18)) O ((rangoElegido = 2) Y (numeroSalio >= 19 Y numeroSalio <= 36))) Entonces
                Escribir "¡Acertaste el rango! Ganaste $", monto;
                saldo = saldo + monto;
            Sino
                Escribir "Rango incorrecto (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;
            FinSi		
		5:
            Si (numeroSalio <> 0) Y ( ((docenaElegida = 1) Y (numeroSalio >= 1 Y numeroSalio <= 12)) O ((docenaElegida = 2) Y (numeroSalio >= 13 Y numeroSalio <= 24)) O ((docenaElegida = 3) Y (numeroSalio >= 25 Y numeroSalio <= 36)) ) Entonces
                Escribir "¡Acertaste la docena! Ganaste $", (monto * 2);
                saldo = saldo + (monto * 2);
            Sino
                Escribir "Docena incorrecta (o salio el 0). Perdiste $", monto;
                saldo = saldo - monto;              
            FinSi
    FinSegun
FinSubProceso

Funcion continua = DeseaContinuar(saldoActual)
    Definir continua Como Caracter;
	
	Si saldoActual > 0 Entonces
        Escribir "";
        // Validación robusta: No saldrá de aca hasta que escriba S, s, N o n
        Repetir
            Escribir "¿Desea jugar otra ronda en la Ruleta? (S/N):";
            Leer continua;
            continua = Mayusculas(continua); // Lo pasamos a mayúscula para evaluar fácil
            
			Limpiar Pantalla;
            Si (continua <> "S") Y (continua <> "N") Entonces
                Escribir "Error: Ingrese únicamente S para Sí o N para No.";
                Escribir "";
            FinSi
        Hasta Que continua = "S" O continua = "N"
    Sino
        Escribir "Te has quedado sin saldo.";
        continua = "N";
    FinSi
FinFuncion

SubProceso Ruleta_Laboratorio (saldo Por Referencia)
    Dimension colores[37];
    Definir colores Como Caracter;
    Definir tipo Como Entero;
    Definir seguir Como Caracter;
    
    CargarColores(colores);
    MostrarBienvenida();
    
    seguir = "S";
    
    Mientras (saldo > 0) Y (Mayusculas(seguir) = "S") Hacer
		monto = SolicitarApuesta(saldo);
		DibujarPanoRuleta();
		tipo = MenuApuestas();
		ResolverRonda(tipo, monto, colores, saldo);
		seguir = DeseaContinuar(saldo);
	FinMientras

    
    Escribir "";
    Escribir "Fin de la partida... Te retiras con un saldo final de: $", saldo;
	Esperar Tecla;
FinSubProceso

//=================================================================================
// FIN DE LA LOGICA DE LA RULETA
//=================================================================================



//=================================================================================
// INICIO DE LA LOGICA DEL TRAGAMONEDAS
//=================================================================================

SubProceso TRAGAMONEDAS(saldo Por Referencia)
	Definir apuesta, apuestaMINIMA Como real;
	Definir continuar como logico;
	Definir opcionTexto como cadena;
	Definir textoSimbolos Como Cadena;
	Definir opcionSelect Como Entero;
	Definir rueda1, rueda2, rueda3, i, s Como Entero; //S para los ritmos.
	//Siete variables.
	
	continuar <- Verdadero;
	apuestaMINIMA<-500;
	
	Mientras continuar hacer
		Repetir
			Limpiar Pantalla;
			//Letrero gigante de entrada.
			CARTEL_TRAGAMONEDAS;
			//Escribir el saldo actual y leer la apuesta del juador.
			Escribir " Saldo Actual: [$", saldo, "]";
			Escribir " Ingresa tu apuesta (Minimo $: ", apuestaMINIMA, ")";
			Leer opcionTexto;
			
			//Llamamos a la funcion auxiliar por si el usuario coloca "," en lugar de "."
			opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
			
			Si EsValido(opcionTexto) = Verdadero Entonces
				apuesta <- ConvertirANumero(opcionTexto);
			SiNo
				apuesta <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
			FinSi
			
			Si apuesta>saldo o apuesta<apuestaMINIMA Entonces
				//Preguntar si la apuesta ingresada es mayor que el saldo. 
				//O menor al monto minimo de apuesta.
				APUESTA_INVALIDA;
				Esperar Tecla;
			FinSi
		Hasta Que (apuesta >= 10) Y (apuesta <= saldo)
		
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
		textoSimbolos <- "  Simbolos: ";
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
				Escribir "  ¡Felicidades! Consiguiste 3 simbolos iguales. ¡Gran Premio!";
				saldo <- saldo + (apuesta * 5);
				Para s <- 1 Hasta 5 Hacer
					Esperar 150 Milisegundos;
				FinPara
			FinSi
		SiNo
			Si rueda1 = rueda2 O rueda2 = rueda3 O rueda1 = rueda3 Entonces
				Escribir "  ¡Bien! 2 simbolos iguales. Duplicas tu apuesta.";
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
			Escribir " Seleccione una opcion: ";
			Leer opcionTexto;
			
			//Llamamos a la funcion para que se cambie "," por "."
			opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
			
			Si EsValido(opcionTexto) = Verdadero Entonces
				opcionSelect <- trunc(ConvertirANumero(opcionTexto)); //truncamos para tener un valor entero
			SiNo
				opcionSelect <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
			FinSi
			
			Segun opcionSelect Hacer
				1:
					continuar <- Verdadero;
				2:
					continuar <- Falso;
					Escribir " ¡Gracias por jugar! Te retiras con: $", saldo;
					Esperar Tecla;
				De Otro Modo:
					Escribir " Opcion invalida, continuando juego por defecto...";
					Esperar 1 Segundos;
			FinSegun
		SiNo
			SIN_FICHAS;
			Escribir "Te has quedado sin saldo suficiente para la apuesta minima ($10).";
			Escribir "Vuelve al menu de inicio para recargar.";
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
	Escribir "                       3 Simbolos Iguales          -> Gran Premio (x5)";
	Escribir "                       2 Simbolos Iguales          -> Recompensa (x2)";
	Escribir " ==========================================================================================";
	Escribir "";
FinSubProceso

SubProceso APUESTA_INVALIDA
	Escribir " .-------------------------------------------------------.";
	Escribir " |¡Apuesta invalida! ¡Presiona <<Enter>> para reintentar!|";
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
	Escribir "  ¡¡¡ JACKPOT GIGANTE !!! ¡REVENTASTE LA BANCA CON 3 CORONAS!";
	Escribir "  ***********************************************************";
FinSubProceso

SubProceso SIN_FICHAS
	Escribir "  ___________________________________________________________";
	Escribir " |                                                           |";
	Escribir " |   Te has quedado sin fichas. ¡Mejor suerte la proxima!    |";
	Escribir " |___________________________________________________________|";
	Esperar 3 Segundos;
FinSubProceso
//================================================================================
// FIN DE LA LOGICA DEL TRAGAMONEDAS
//================================================================================




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
		
		//Llamada a la funcion por si la maquina cambia cartas
		AnimacionDescarteMaquina(Verdadero);
	SiNo
		//Si la Maquina tiene par o mejor, prefiere no arriesgar y conserva sus cartas
		AnimacionDescarteMaquina(falso);
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
		
		Repetir
			Escribir "¿Cuantas cartas quiere cambiar? (0 a 5)";
			leer opcionTexto;
			
			//Llamamos a la funcion para que se cambie "," por "."
			opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
			
			Si EsValido(opcionTexto) = Verdadero Entonces
				cambiar <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para obtener un valor entero
			SiNo
				cambiar <- -1; //Asignamos -1 para alertar que fueron letras o datos inválidos
			FinSi
			Si (cambiar < 0) O (cambiar > 5) Entonces
				Escribir "Error: Entrada invalida. Debe ingresar un numero entero entre 0 y 5.";
				Escribir "";
				Esperar 1500 Milisegundos;
			FinSi
		Hasta Que (cambiar >= 0) Y (cambiar <= 5)
		
		si cambiar > 0 Entonces
			//Bucle segun la cantidad de descart elegida
			para i=0 hasta cambiar-1 con paso 1 Hacer
				//Validacion de entrada para evitar selecciones duplicados o rangos invalidos
				Repetir
					Escribir "Ingresa la carta a cambiar (1 a 5):";
					leer opcionTexto;
					
					//Llamamos a la funcion del auxiliar por si el usuario escribe "2,5", esto lo convierte a "2.5"
					//para evitar que el programa falle
					opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
					
					Si EsValido(opcionTexto) = Verdadero Entonces
						pos <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para obtener un valor entero
					SiNo
						pos <- -1; //Asignamos -1 para alertar que fueron letras o datos inválidos
					FinSi
					
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
			Escribir "Presione <<ENTER>> para continuar.";
			Esperar Tecla;
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
		Si saldo > 0 Entonces
			Repetir
				Escribir "";
				Escribir "¿Quieres jugar otra mano? (1: Si / 0: No)";
				Leer opcionTexto; // <-- Leemos como cadena de texto para evitar que se rompa
				
				//Llamamos a la funcion del auxiliar por si el usuario escribe "2,5", esto lo convierte a "2.5"
				//para evitar que el programa falle
				opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
				
				Si EsValido(opcionTexto) = Verdadero Entonces
					seguir <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para obtener un valor entero
				SiNo
					seguir <- -1; // Si ingresan letras (como "vde"), asigna un valor inválido
				FinSi
				
				Si (seguir <> 1) Y (seguir <> 0) Entonces
					Limpiar Pantalla;
					Escribir "Error: Ingrese únicamente 1 para Sí o 0 para No.";
				FinSi
			Hasta Que (seguir = 1) O (seguir = 0)
		SiNo
			Escribir "Te quedaste sin saldo. Volviendo al menu del casino...";
			seguir <- 0;
			Esperar Tecla;
		FinSi
	Mientras Que seguir = 1 y saldo >= 100;
	
	Escribir "¡Hasta Luego! Te vas con: $",saldo;
	Escribir "";
	Escribir "----------------------------------------";
	Escribir "Presiona <<ENTER>> para volver al menu";
	Escribir "----------------------------------------";
	Esperar Tecla;
FinSubProceso

//=================================================================================
// ESTRUCTURA PRINCIPAL, MENU Y APUESTAS
//=================================================================================

//SubProceso de entrada al juego de Poker desde el casino general
//Recibe la variable saldo por referencia para que las ganancias o perdidas
//se reflejen en la cuenta global del jugador
SubProceso MenuJuegoPoker(saldo Por Referencia)
	definir opcionSubMenu Como Entero;
	Definir opcionTexto como cadena;
	

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
		leer opcionTexto;
		
		//Llamamos a la funcion auxiliar por si el usuario coloca "," en lugar de "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
			opcionSubmenu <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para obtener un valor entero
		SiNo
			opcionSubmenu <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
		segun opcionSubMenu Hacer
			1:
				
				JugarPoker(saldo);
				
			2:
				MostrarReglas();
				Esperar Tecla;
			3:
				Escribir "¡Gracias por jugar! Te retiras con: $",saldo;
				Escribir "";
				Escribir "Presione <<ENTER>> para volver al menu.";
				Esperar Tecla;
			De Otro Modo:
				Escribir "============================================================";
				Escribir "Opcion no valida. Presiona <<ENTER>> para intentar de nuevo.";
				Escribir "============================================================";
				Esperar Tecla;
		FinSegun
	Mientras Que opcionSubmenu <> 3;
FinSubProceso

//SubProceso encargado de solicitar y validar el monto apostado por el usuario
//Modifica el saldo del jugador e iguala el pozo en la mesa por parte de la casa
SubProceso RealizarApuesta(saldo Por Referencia, pozo Por Referencia)
	definir apuesta, MINIMO como entero;
	Definir opcionTexto como cadena;
	
	MINIMO <- 5000;
	//Validar si el usuario tiene al menos el saldo minimo para empezar
	Si saldo < MINIMO Entonces
		Limpiar Pantalla;
		Escribir "======================================================";
		Escribir "            MESA DE POKER - ATENCION                  ";
		Escribir "======================================================";
		Escribir "[!] No tenes el saldo minimo de $", MINIMO, " para ingresar.";
		Escribir "   Tu saldo actual es: $", saldo;
		Escribir "======================================================";
		Escribir "Presione ENTER para regresar al menu...";
		Esperar Tecla;
		apuesta <- 0; //Retorna 0 para cancelar la mano en JugarPoker
	SiNo
		//Bucle de lectura y validacion de monto
		Repetir
			Limpiar Pantalla;
			Escribir "==================================================";
			Escribir "        MESA DE APUESTAS                          ";
			Escribir "==================================================";
			Escribir " Tu saldo disponible: $",saldo;
			Escribir " Apuesta minima por partida: $",MINIMO;
			Escribir "==================================================";
			Escribir "";
			Escribir sin saltar "Ingrese el monto a apostar: $";
			leer opcionTexto;
			
			//Llamamos a la funcion para que se cambie "," por "."
			opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
			
			Si EsValido(opcionTexto) = Verdadero Entonces
				apuesta <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para que opcionAdmin reciba un valor entero
			SiNo
				apuesta <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
			FinSi
			
			
			//Validaciones de entrada
			si apuesta < MINIMO Entonces
				Escribir "";
				Escribir "[x] Error: La apuesta minima permitida es de $",MINIMO;
				Esperar 1500 Milisegundos;
			SiNo
				si apuesta > saldo Entonces
					Escribir "";
					Escribir "[x] Error: no podes apostar mas de lo que tenes ($",saldo,")";
					Esperar 1500 Milisegundos;
				FinSi
			FinSi
			
		Mientras Que (apuesta < MINIMO) O (apuesta > saldo);
		
		//Descuento del saldo real del usuario 
		saldo <- saldo - apuesta;
		
		//llaamda de funcion del grafico
		AnimacionApuesta(apuesta);
	FinSi
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
	
	Para i <- 1 Hasta 2 Con Paso 1 Hacer 
		Limpiar Pantalla;
		Escribir "+--------------------------------------------------------+";
		Escribir "| [C] [D] [T] [P]    CASINO - GANO    [P] [T] [D] [C]    |";
		Escribir "+--------------------------------------------------------+";
		Escribir "|                                                        |";
		Escribir "|          * * * * * * * * * * * * * * * * * *           |";
		Escribir "|          *     BIENVENIDO AL CASINO-GANO   *           |";
		Escribir "|          * * * * * * * * * * * * * * * * * *           |";
		Escribir "|                                                        |";
		Escribir "+--------------------------------------------------------+";
		Escribir "";
		Escribir "         >>>> PRESIONA ENTER PARA REPARTIR <<<<          ";
		Esperar 350 Milisegundos;
		
		Escribir " +------+ +------+ +------+ +------+ +------+";
		Escribir " | 10   | | J    | | Q    | | K    | | A    |";
		Escribir " |  [P] | |  [P] | |  [P] | |  [P] | |  [P] |";
		Escribir " |   10 | |    J | |    Q | |    K | |    A |";
		Escribir " +------+ +------+ +------+ +------+ +------+";
		Escribir "==========================================================";
		Escribir "         < < < PRESIONA ENTER PARA APUESTAS > > >        ";
		Esperar 400 Milisegundos;
		
		Limpiar Pantalla;
        Escribir "+--------------------------------------------------------+";
		Escribir "| [C] [D] [T] [P]    CASINO - GANO    [P] [T] [D] [C]    |";
		Escribir "+--------------------------------------------------------+";
		Escribir "|                                                        |";
		Escribir "|          * * * * * * * * * * * * * * * * * *           |";
		Escribir "|          *     BIENVENIDO AL CASINO-GANO   *           |";
		Escribir "|          * * * * * * * * * * * * * * * * * *           |";
		Escribir "|                                                        |";
		Escribir "+--------------------------------------------------------+";
		Escribir "";
		Escribir "         >>>> PRESIONA ENTER PARA REPARTIR <<<<          ";
		Esperar 350 Milisegundos;
		
		Escribir " +------+ +------+ +------+ +------+ +------+";
		Escribir " | 10   | | J    | | Q    | | K    | | A    |";
		Escribir " |  [P] | |  [P] | |  [P] | |  [P] | |  [P] |";
		Escribir " |   10 | |    J | |    Q | |    K | |    A |";
		Escribir " +------+ +------+ +------+ +------+ +------+";
		Escribir "==========================================================";
		Escribir "         . . . PRESIONA ENTER PARA APUESTAS . . .        ";
		Esperar 300 Milisegundos;
	FinPara
	
	Esperar Tecla;
	Limpiar Pantalla;
FinSubProceso
	

SubProceso AnimacionMezclando
	Definir f Como Entero;
	
	Para f <- 1 Hasta 2 Con Paso 1 Hacer
		// Paso 1: Mazos separados arriba
		Limpiar Pantalla;
		Escribir "";
		Escribir "            [ MEZCLANDO EN CASCADA ]";
		Escribir "";
		Escribir "      +------+                      +------+";
		Escribir "      |######|                      |######|";
		Escribir "      +------+                      +------+";
		Escribir "";
		Escribir "";
		Esperar 250 Milisegundos;
		
		// Paso 2: Caída hacia el centro
		Limpiar Pantalla;
		Escribir "";
		Escribir "            [ MEZCLANDO EN CASCADA ]";
		Escribir "";
		Escribir "          +------+              +------+";
		Escribir "          |######|              |######|";
		Escribir "          +------+              +------+";
		Escribir "                \\              /";
		Escribir "                 \\            /";
		Esperar 250 Milisegundos;
		
		// Paso 3: Intercalado central
		Limpiar Pantalla;
		Escribir "";
		Escribir "            [ MEZCLANDO EN CASCADA ]";
		Escribir "";
		Escribir "                 +------+--+------+";
		Escribir "                 |######|##|######|";
		Escribir "                 |######|##|######|";
		Escribir "                 +------+--+------+";
		Escribir "                   |  |  |  |  |";
		Esperar 350 Milisegundos;
	FinPara
	
	Limpiar Pantalla;
FinSubProceso


SubProceso AnimacionApuesta(montoApuesta)
	Definir f Como Entero;
	
	Para f <- 1 Hasta 2 Con Paso 1 Hacer
		Limpiar Pantalla;
		Escribir "  /\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\";
		Escribir " <   [!] APUESTA CONFIRMADA EN MESA DE POKER [!]    >";
		Escribir "  \\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
		Escribir "  |                                                 |";
		Escribir "  |   Jugador pone : [ $", montoApuesta, " ]                       |";
		Escribir "  |   Casa iguala  : [ $", montoApuesta, " ]                       |";
		Escribir "  |   ------------------------------------------    |";
		Escribir "  |   POZO TOTAL   : >>> $", montoApuesta * 2, " <<<                  |";
		Escribir "  |                                                 |";
		Escribir "  \\=================================================/";
		Esperar 1000 Milisegundos;
		
		Limpiar Pantalla;
		Escribir "  \\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
		Escribir " <   [*] APUESTA CONFIRMADA EN MESA DE POKER [*]    >";
		Escribir "  /\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
		Escribir "  |                                                 |";
		Escribir "  |   Jugador pone : [ $", montoApuesta, " ]                       |";
		Escribir "  |   Casa iguala  : [ $", montoApuesta, " ]                       |";
		Escribir "  |   ------------------------------------------    |";
		Escribir "  |   POZO TOTAL   : >>> $", montoApuesta * 2, " <<<                  |";
		Escribir "  |                                                 |";
		Escribir "  \\=================================================/";
		Esperar 1000 Milisegundos;
	FinPara
	Limpiar Pantalla;
FinSubProceso

SubProceso AnimacionDescarteMaquina(cambio)
	Definir i Como Entero;
	
	Limpiar Pantalla;
	Escribir "";
	Escribir "==========================================================";
	Escribir "               TURNO DE LA MAQUINA (DESCARTE)             ";
	Escribir "==========================================================";
	Escribir "";
	
	Si cambio Entonces
		Escribir "       [ La maquina decide cambiar cartas del mazo ]";
		Escribir "";
		Escribir "      +------+  +------+  +------+  +------+  +------+";
		Escribir "      |######|  |######|  |######|  |######|  |######|";
		Escribir "      |######|  |######|  |######|  |######|  |######|";
		Escribir "      +------+  +------+  +------+  +------+  +------+";
		Escribir "                    ^^^        ^^^";
		Escribir "             ( Levantando cartas de la mesa... )";
		Esperar 2500 Milisegundos;
	SiNo
		Escribir "       [ La maquina conserva su mano intacta ]";
		Escribir "";
		Escribir "      +------+  +------+  +------+  +------+  +------+";
		Escribir "      |######|  |######|  |######|  |######|  |######|";
		Escribir "      |######|  |######|  |######|  |######|  |######|";
		Escribir "      +------+  +------+  +------+  +------+  +------+";
		Escribir "                   ( No realiza cambios )";
		Esperar 2500 Milisegundos;
	FinSi
	
	Limpiar Pantalla;
FinSubProceso
//=================================================================================
//FIN DE LA LOGICA DEL POKER
//=================================================================================


//=================================================================================
// INICIO LOGICA DEL BLACKJACK
//=================================================================================
//=================================================================================
// COMIENZO BLACK JACK 21
// ==============================================================================
// BLOQUE A: PROGRAMA PRINCIPAL (PANTALLA Y MEN?)
// -> Controla que opcion elige el usuario y conecta con las funciones de abajo.
// ==============================================================================
SubProceso blackjack(saldo Por Referencia)
	
	// --- VARIABLES DE CONTROL DEL SISTEMA ---
	Definir op Como Entero; 
	Definir opcionTexto como cadena;
	Definir montoMinimo Como Real;
	
	// Configuramos el valor mínimo global para el juego
	montoMinimo <- 1500; 
    
	Repetir
		Limpiar Pantalla;
		Escribir "+-----------------------------------------+";
		Escribir "|      * * *  !!BIENVENIDO!!  * * *       |";
		Escribir "|    -------------BLACKJACK------------    |";
		Escribir "+-----------------------------------------+";
		Escribir " Saldo en cuenta: $", saldo;
		Escribir " Minimo de apuesta: $", montoMinimo;
		Escribir "-------------------------------------------";
		Escribir " Elija una opcion:";
		Escribir "  1. Reglas del juego";
		Escribir "  2. Jugar ronda";
		Escribir "  3. Salir";
		Escribir " Por favor elija una opcion.";
		Escribir "===========================================";
		Leer opcionTexto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionTexto <- ReemplazarComaPorPunto(opcionTexto);
		
		Si EsValido(opcionTexto) = Verdadero Entonces
		    op <- trunc(ConvertirANumero(opcionTexto)); //lo truncamos para que opcionSeleccion reciba un valor entero
		SiNo
			op <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
		Segun op Hacer
			1:
				MostrarReglass();
				Esperar Tecla;
				
				// --- [CONEXIÓN 3]: VERIFICACIÓN DE FONDOS Y ARRANQUE DE RONDA ---
			2:
				// Validamos primero si el saldo alcanza para cubrir el mínimo del juego antes de entrar a la ronda
				Si saldo < montoMinimo Entonces
					Escribir " [!] Error: Tu saldo actual ($", saldo, ") es menor al minimo requerido ($", montoMinimo, ").";
					Escribir " Por favor, recarga saldo antes de jugar.";
					Esperar Tecla;
				SiNo
					JugarRonda(saldo, montoMinimo); // Pasamos el montoMinimo como parámetro
				FinSi
				
				// --- [CONEXIÓN 4]: SALIDA Y CIERRE ---
			3:
				Escribir "";
				Escribir "Te retiras con un saldo final de: $", saldo;
				Escribir "Gracias por jugar. Hasta luego!";
				
			De Otro Modo:
				Escribir "Opcion incorrecta. Presiona cualquier tecla para reintentar...";
				Esperar Tecla;
		FinSegun;
		
	Hasta Que op = 3;
	
FinSubProceso

// ==============================================================================
// BLOQUE B: GESTIÓN DE DINERO (RECARGA Y APUESTAS)
// ==============================================================================

//Permite sumar dinero a la cuenta asegurando que no metan numeros negativos
SubProceso CargarSaldoBLACKJACK(saldo Por Referencia)
	Definir ingreso Como Real;
	Escribir "";
	Escribir "--- PANEL DE DEPOSITOS ---";
	Repetir
		Escribir "Ingrese el monto a depositar: $";
		Leer ingreso;
		Si ingreso <= 0 Entonces
			Escribir " [!] Error: Debe ingresar una cifra mayor a 0.";
		FinSi;
	Hasta Que ingreso > 0;
	
	saldo <- saldo + ingreso; // 'Por Referencia' actualiza la variable del menú principal
	Escribir " [OK] Deposito exitoso. Saldo disponible: $", saldo;
	Esperar Tecla;
FinSubProceso

// [B.2] Solicita cuánto apostar y frena si quieren apostar menos del mínimo o más de lo que tienen
Funcion monto <- PedirMontoApuesta(saldo, montoMinimo)
	Definir monto Como Real;
	Definir opcionMonto como cadena;
	Repetir
		Escribir "Saldo disponible para apostar: $", saldo;
		Escribir "Monto minimo requerido: $", montoMinimo;
		Escribir "¿Cuanto deseas apostar en esta mano?: $";
		Leer opcionMonto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionMonto <- ReemplazarComaPorPunto(opcionMonto);
		
		Si EsValido(opcionMonto) = Verdadero Entonces
		    monto <- ConvertirANumero(opcionMonto);
		SiNo
			monto <- 0; // Si escribieron letras, asigna 0
		FinSi
		
		// --- VALIDACIONES DE APUESTA ---
		Si monto < montoMinimo Entonces
			Escribir " [!] Error: La apuesta minima permitida es de $", montoMinimo, ".";
		SiNo
			Si monto > saldo Entonces
				Escribir " [!] Fondos insuficientes. No puedes apostar mas de lo que posees.";
			FinSi;
		FinSi;
	Hasta Que monto >= montoMinimo Y monto <= saldo; // Bucle hasta que el monto cumpla ambas condiciones
FinFuncion


// ==============================================================================
// BLOQUE C: MOTOR DE LA RONDA DE JUEGO
// -> Este bloque contiene la mesa: cartas, decisiones y turnos.
// ==============================================================================
SubProceso JugarRonda(saldo Por Referencia, montoMinimo)
	// --- VARIABLES DE LA PARTIDA ---
	Definir monto Como Real;
	Definir jugador, crupier Como Entero;
	Definir jugadorMano2 Como Entero;
	Definir jugoMano2, continuar Como Logico;
	Definir opc Como Entero;
	Definir resultado Como Entero; 
	Definir opcionMonto como cadena;
	
	// [C.1] Descuenta y valida la apuesta inicial de esta ronda (pasando el mínimo requerido)
	monto <- PedirMontoApuesta(saldo, montoMinimo);
	
	// [C.2] Puesta a cero de la mesa
	jugador <- 0;
	crupier <- 0;
	jugadorMano2 <- 0;
	jugoMano2 <- Falso;
	continuar <- Verdadero;
	
	// [C.3] Reparto inicial de cartas
	jugador <- jugador + SacarCarta();
	jugador <- jugador + SacarCarta();
	crupier <- crupier + SacarCarta();
	crupier <- crupier + SacarCarta();
	
	Escribir "";
	Escribir "======================================================";
	Escribir "                   MESA DE JUEGO                      ";
	Escribir "======================================================";
	Escribir " -> Tus cartas suman: ", jugador;
	DibujarManoGrafica();
	Escribir " -> Cartas del crupier: ", crupier;
	DibujarManoGrafica();
	
	// [C.4] Decisiones del jugador
	Mientras jugador < 21 Y continuar = Verdadero Hacer
		Escribir "";
		Escribir "+--------------------------------+";
		Escribir "|  1. Pedir carta (Hit)          |";
		Escribir "|  2. Plantarse (Stand)          |";
		Escribir "|  3. Doblar apuesta (Double)    |";
		Escribir "|  4. Comprar seguro (Insurance) |";
		Escribir "|  5. Dividir juego (Split)      |";
		Escribir "+--------------------------------+";
		Leer opcionMonto;
		
		//Llamamos a la funcion para que se cambie "," por "."
		opcionMonto <- ReemplazarComaPorPunto(opcionMonto);
		
		Si EsValido(opcionMonto) = Verdadero Entonces
		    opc <- trunc(ConvertirANumero(opcionMonto)); //lo truncamos para quue tengamos un valor entero
		SiNo
			opc <- 0; // Si escribieron letras, asigna 0 para que caiga en 'De Otro Modo'
		FinSi
		
		Segun opc Hacer
			1:
				// Pide una carta más
				jugador <- jugador + SacarCarta();
				Escribir " (Carta) Nueva puntuacion: ", jugador;
				DibujarManoGrafica();
			2:
				// Finaliza el turno voluntariamente
				continuar <- Falso;
			3:
				// Doblar: verifica si tiene suficiente saldo para respaldar el doble
				Si saldo >= (monto * 2) Entonces
					monto <- monto * 2;
					Escribir " [x2] Apuesta duplicada a: $", monto;
					jugador <- jugador + SacarCarta();
					Escribir " (Carta) Puntuacion definitiva: ", jugador;
					DibujarManoGrafica();
					continuar <- Falso;
				SiNo
					Escribir " [!] No tienes saldo para duplicar la apuesta.";
				FinSi;
			4:
				Escribir " [!] Seguro contratado contra Blackjack del crupier.";
			5:
				// Dividir mano
				Escribir " [/] Mano dividida en dos jugadas.";
				jugoMano2 <- Verdadero;
				jugadorMano2 <- TRUNC(jugador / 2);
				jugador <- TRUNC(jugador / 2);
				jugador <- jugador + SacarCarta();
				jugadorMano2 <- jugadorMano2 + SacarCarta();
				Escribir " -> Mano 1: ", jugador, " puntos";
				Escribir " -> Mano 2: ", jugadorMano2, " puntos";
				DibujarManoGrafica();
			De Otro Modo:
				Escribir "Opcion no valida.";
		FinSegun;
	FinMientras;
	
	// [C.5] Turno automático de la banca (si el jugador sigue en carrera)
	Si jugador <= 21 O (jugoMano2 = Verdadero Y jugadorMano2 <= 21) Entonces
		Mientras crupier <= 16 Hacer
			crupier <- crupier + SacarCarta();
		FinMientras;
	FinSi;
	
	// [C.6] Cierre de mano y cálculo económico
	Escribir "";
	Escribir "======================================================";
	Escribir "  Total Mano 1: ", jugador;
	Si jugoMano2 = Verdadero Entonces
		Escribir "  Total Mano 2: ", jugadorMano2;
	FinSi;
	Escribir "  Total Crupier: ", crupier;
	Escribir "======================================================";
	
	// Paga o cobra Mano 1
	Escribir "";
	Escribir "--- RESOLUCION MANO 1 ---";
	resultado <- EvaluarGanador(jugador, crupier);
	AplicarPago(resultado, monto, saldo);
	
	// Paga o cobra Mano 2 (si dividió)
	Si jugoMano2 = Verdadero Entonces
		Escribir "";
		Escribir "--- RESOLUCION MANO 2 ---";
		resultado <- EvaluarGanador(jugadorMano2, crupier);
		AplicarPago(resultado, monto, saldo);
	FinSi;
	
	Escribir "";
	Escribir "Saldo actualizado: $", saldo;
	Esperar Tecla;
FinSubProceso


// ==============================================================================
// BLOQUE D: LÓGICA DE GANADOR Y PAGOS
// -> Aca se decide quién gana y se suma o resta plata del saldo.
// ==============================================================================

// [D.1] Compara los puntos y devuelve: 1 (Gana jugador), -1 (Gana crupier), 0 (Empate)
Funcion res <- EvaluarGanador(puntosJugador, puntosCrupier)
	Definir res Como Entero;
	
	Si puntosJugador > 21 Entonces
		Escribir " [X] Te pasaste de 21. Gana la casa.";
		res <- -1;
	SiNo
		Si puntosCrupier > 21 Entonces
			Escribir " [*] El crupier se paso de 21. ¡Ganaste!";
			res <- 1;
		SiNo
			Si puntosJugador > puntosCrupier Entonces
				Escribir " [!] Superaste a la banca. ¡Ganaste!";
				res <- 1;
			SiNo
				Si puntosCrupier > puntosJugador Entonces
					Escribir " [X] La banca obtuvo mejor mano. Pierdes.";
					res <- -1;
				SiNo
					Escribir " [-] Empate exacto.";
					res <- 0;
				FinSi;
			FinSi;
		FinSi;
	FinSi;
FinFuncion

// [D.2] Modifica el saldo real según el resultado del juego
SubProceso AplicarPago(resultado, monto, saldo Por Referencia)
	Si resultado = 1 Entonces
		saldo <- saldo + monto;
		Escribir " [+] ¡Felicidades! Ganancia acreditada: +$", monto;
	SiNo
		Si resultado = -1 Entonces
			saldo <- saldo - monto;
			Escribir " [-] Apuesta perdida: -$", monto;
			
			// Validación de seguridad por si el jugador se queda sin fondos
			Si saldo < 0 Entonces
				saldo <- 0; // Evita saldos negativos por errores de redondeo o lógicos
			FinSi;
			
			Si saldo = 0 Entonces
				Escribir " [!] Te has quedado sin saldo disponible en tu cuenta.";
			FinSi;
		SiNo
			Escribir " [=] Mano empatada: conservas tus $", monto;
		FinSi;
	FinSi;
FinSubProceso


// ==============================================================================
// BLOQUE E: HERRAMIENTAS AUXILIARES
// -> Cartas al azar, dibujos e impresiones de reglas.
// ==============================================================================

// [E.1] Generador de cartas aleatorias (1 al 11)
Funcion carta <- SacarCarta
	Definir carta Como Entero;
	carta <- Aleatorio(1,11);
FinFuncion

// [E.2] Gr?fico decorativo de cartas
SubProceso DibujarManoGrafica
	Escribir "   +---------+";
	Escribir "   |  A *    |";
	Escribir "   |    * J  |";
	Escribir "   +---------+";
FinSubProceso

// [E.3] Texto con las reglas oficiales
SubProceso MostrarReglass
	Limpiar Pantalla;
//	Escribir "===================================================== REGLAS =====================================================";
//	Escribir " 1. OBJETIVO: Sumar 21 o lo mas cercano posible sin pasarte. Si sumas 22 o mas, pierdes.";
//	Escribir " 2. CARTAS: Numeros valen su valor facial, figuras valen 10, y el As vale 1 u 11.";
//	Escribir " 3. CRUPIER: Esta obligado a pedir carta con 16 o menos, y se planta con 17 o mas.";
//	Escribir " 4. FONDOS: Debes contar con saldo disponible para apostar o doblar.";
//	Escribir "==================================================================================================================";
//	Escribir "";
	Escribir "------------------------------------------------------------------";
	Escribir "Presiona <<ENTER>> para ver las reglas de forma dinamica";
	Escribir "------------------------------------------------------------------";
	Escribir "";
	Esperar Tecla;
	Escribir " 1. OBJETIVO BLACK JACK 21 ";
	Escribir " 	El objetivo principal es ganarle al crupier (la banca). "; 
	Escribir " 	para lograrlo, debes obtener una mano que sume lo mas cerca posible a 21 puntos, "; 
	Escribir " 	pero con una condicion estricta: si sumas 22 o mas puntos, perdes automaticamente. ";
	Escribir " 	En este juego competis unicamente contra la banca, no contra los demas jugadores. ";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Escribir ""; Esperar Tecla;
	Escribir " 2. EL VALOR DE LAS CARTAS ";
	Escribir "		Cartas del 2 al 10: Tienen el mismo valor que el numero ";
	Escribir " 	impreso en ellas (un 5 vale 5 puntos, un 9 vale 9 puntos, etc.). ";
	Escribir " 	Figuras (J, Q, K): Valen 10 puntos cada una. ";
	Escribir " 	El As (A): Es la carta ms flexible. Vale 1 u 11 puntos, applying de ";
	Escribir " 	forma automtica el valor que mas te favorezca para no pasarte de 21. ";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Escribir ""; Esperar Tecla;
	Escribir " 3. DINAMICA DE UNA PARTIDA PASO A PASO";
	Escribir " 	Fase de apuestas: Cada jugador coloca sus fichas en la mesa antes de recibir cualquier carta. ";
	Escribir " 	El reparto inicial: El crupier reparte dos cartas boca arriba a cada jugador, "; 
	Escribir "		y se reparte a s mismo una carta boca arriba y otra boca abajo (oculta). ";
	Escribir " 	El Blackjack Natural: Si tus dos primeras cartas son un As y una ";
	Escribir "		carta de valor 10 (10, J, Q o K), tens BLACKJACK "; 
	Escribir "		Si el crupier no tiene lo mismo, ganas la mano inmediatamente con un ";
	Escribir "		pago de 3 a 2 (recibs 1.5 veces el valor de tu apuesta original). ";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Escribir ""; Esperar Tecla;
	Escribir "4. OPCIONES DEL JUGADOR DURANTE SU TURNO ";
	Escribir "		Cuando sea tu turno, debs elegir una de las siguientes acciones segun tus cartas: ";
	Escribir " Pedir carta (Hit): Solicitas una carta mas para aumentar tu puntaje. Podes pedir todas las que quieras, ";
	Escribir "		pero si la suma pasa de 21, te pasas (*Bust*) y perdes tu apuesta al instante. ";
	Escribir " Plantarse (Stand): Si estas conforme con tu puntaje actual, decidis no recibir ms cartas y finalizas tu turno. ";
	Escribir " Doblar apuesta (Double Down): Podes duplicar tu apuesta inicial. Al hacer esto, recibis obligatoriamente una sola carta mas y tu turno termina. ";
	Escribir " 	Se usa habitualmente cuando tus dos primeras cartas suman 9, 10 u 11. ";
	Escribir " Dividir (Split): Si tus dos primeras cartas son del mismo valor (por ejemplo, dos 8), podes separarlas para jugar dos manos ";
	Escribir " 	independientes. Debes colocar una apuesta identica para la segunda mano y cada una se juega por separado. ";
	Escribir "	Seguro (Insurance): Si la carta visible del crupier es un As, podes hacer una apuesta secundaria ";
	Escribir " 	(de hasta la mitad de tu apuesta original) apostando a que el crupier tiene un 10 oculto. ";
	Escribir " 	Si el crupier tiene Blackjack, esta apuesta te paga 2 a 1. ";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Escribir ""; Esperar Tecla;
	Escribir "5. REGLAS ESTRICTAS PARA EL CRUPIER ";
	Escribir " 	El crupier no decide cmo jugar; debe seguir estas reglas fijas de forma obligatoria: ";
	Escribir "		Si suma 16 puntos o menos: Esta obligado a pedir cartas hasta alcanzar o superar los 17 puntos. ";
	Escribir "		Si suma 17 puntos o ms: Est obligado a plantarse de inmediato y no puede pedir mas cartas. ";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Escribir ""; Esperar Tecla;
	Escribir "6. COMO SE DEFINEN LOS RESULTADOS Y PAGOS ";
	Escribir "		Victoria Estandar (Pago 1 a 1): Tu puntuacion final es mas alta que la del crupier sin pasarte de 21, ";
	Escribir " 		o el crupier se pasa de 21 y vos te mantuviste en juego. Recibis de ganancia lo mismo que apostaste. ";
	Escribir " 	Victoria por Blackjack (Pago 3 a 2): Ganas con un As y un 10 en tus dos primeras cartas. ";
	Escribir "		Empate (Push): Vos y el crupier terminan con el mismo puntaje. No gana nadie y recupers tu apuesta intacta. ";
	Escribir "		Derrota: Te pasas de 21 puntos, o el crupier logra una puntuacin ms alta que la tuya sin pasarse. Perds el dinero apostado. ";
	Escribir "=======================================================================================================================================================";
	Escribir "";
	Escribir "Presiona <<ENTER>>";
	Escribir "";
	Esperar Tecla;
FinSubProceso