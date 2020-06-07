PImage [] plantillanivel = new PImage [6] ;
String imagenes [] = {"Barco", "Gato", "Oso", "imagen1", "imagen2", "imagen3"};
PFont fuente;

//contador pixels negros
float conegro=0;
color pxnegro= color (0, 0, 0);
color pxgris= color (137, 135, 135);
color fondo= color (62, 162, 159);
float mul=0.0025;

// angulo, posicion en X y Y de todas las piezas = 2 triangulos grandes- 1 triangulo mediano- 2 triangulos pequeños- 1 cuadrado- 1 paralelogramo  
int [][] coord ={{0, 120, 70}, {0, 70, 120}, {0, 195, 195}, {0, 195, 70}, {0, 120, 145}, {0, 170, 120}, {0, 95, 195}};

//informacion de los vertices de los triangulos n0-n5 
int [][] triangulos = {{0, 50, 100, -50, -100, -50}, {50, 0, -50, 100, -50, -100}, {25, 25, 25, -75, -75, 25}, {25, -50, 25, 50, -25, 0}, {50, 25, -50, 25, 0, -25}};

//informacion de los vertices de los paralelogramos  n0-n7 
int [][] paralelogramo = {{50, 0, 0, 50, -50, 0, 0, -50}, {25, 25, 75, -25, -25, -25, -75, 25}};

//colores figuras sin seleccionar RGB
int [][] colorori = {{198, 40, 40}, {40, 53, 147}, {2, 119, 189}, {249, 168, 37}, {106, 27, 154}, {46, 125, 50}, {0, 105, 92}};

//colores figuras seleccionadas RGB
int [][] colorsel = {{229, 115, 115}, {121, 134, 203}, {145, 219, 252}, {255, 241, 118}, {186, 104, 200}, {129, 199, 132}, {76, 180, 77}};

//piezas tamgram
Figura [] figuras = new Figura[7];
//piezas creador 
Figura [] figurasCrea = new Figura[7];

//Botones 
// crea todos los botones de los menus
Figura [] botones = new Figura[9];
int verticesboton []= {-90, -30, 180, 60, 3, 6, 12, 18}; //vertices de los botones y acabado de los bordes
// centro de los botones
int centboton1 [][]= {{0, 490, 280}, {0, 490, 370}, {0, 490, 460}, {0, 250, 280}, {0, 250, 370}, {0, 500, 280}, {0, 500, 370}, {0, 750, 280}, {0, 750, 370}};
int color1 []= {192, 250, 247};// color natural 
int color2 []= {250, 250, 250};// color seleccionado 
int ubicatex [] = {53, 7, 7, 50, 55, 68, 33, 33, 33};// centra el texto en el boton
//nombra los botones
String  textbotones [] = {"Jugar", "Modo Creador", "Instrucciones", "Barco", "Gato", "Oso", "Mi Nivel 1", "Mi Nivel 2", "Mi Nivel 3"};

//contador sirve para la seleccion del menu 
int cont = 0; // menu principal
int cont1=0;// menu niveles 
int bo=0; //  entra al nivel de juego 
int bo1=0;// entra a alguna de las opciones del menu principal

//van ligados a la funcion matrizinter y la funcion mouseDragged
int [][] coord1 = new int [7][2];
int coo;
int c;
int nd;

// menu instrucciones 
int ins = 0; // permite cambiar en las instrucciones
int a = 30; // da el espacio entre renglones
int texX = 60; 
int texY = 180;

float connn;
int cn;

boolean drawGrid = false;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FUNCIONES MODO CREADOR

//cuando se toma la captura de pantalla rellena de pixels negros los espacios 
// que puedan quedar entre las figuras siempre y cuando esten entre un maximo de 4 pixels
void rellepx () {
  loadPixels();
  int dimension = width * height;
  for (int i = 1; i < dimension - 1; i++) { 
    color px=pixels[i];
    if ((pxgris != px)) {
      color ant = pixels[i - 1];
      color des = pixels[i + 1];
      if ((pxnegro == ant ) && (pxnegro == des)) {
        pixels[i] = pxnegro;
      }
    }
  }
  updatePixels();
}

// pinta las figuras de negro para crear un nivel 
void pintarTablero() {
  loadPixels();
  int dimension = width * height;
  for (int i = 0; i < dimension-1; i++) { 
    color px=pixels[i];
    if ((px != fondo)) {
      pixels[i] = pxnegro;
    }
  }
  updatePixels();
}

// guarda las imagenes en el data actualizando los niveles 
void guardarima() {
  if ((key == '1') && (keyPressed)) {
    pintarTablero();
    rellepx(); 
    save("data\\imagen1.png");
  } else if ((key == '2') && (keyPressed)) {
    pintarTablero();
    rellepx(); 
    save("data\\imagen2.png");
  } else if ((key == '3') && (keyPressed)) {
    pintarTablero();
    rellepx(); 
    save("data\\imagen3png");
  }
}



/////////////////////////////////////////////////////////////////////////////////////////////////
// FUNCIONES JUEGO PRINCIPAL 
//Inicializa los botones de todos los menu (menu principal y menu de seleccion de niveles)
void boton () {
  for ( int i = 0; i < botones.length; i++) {
    int [] centroboton = new int [3]; //coordenadas en X, Y - de los botones 

    for ( int j=0; j<=2; j++) {
      centroboton [j] = centboton1 [i][j];
    }

    botones [i] = new Boton (centroboton, color1, color2, verticesboton, textbotones [i], ubicatex[i] );
  }
}


//dibuja los botones en la pantalla de inicio 
void pantInic (String Textprin, int centertex, int in, int fi ) {
  textFont(fuente, 200);
  text(Textprin, 220 + centertex, 150);
  noStroke();
  for (int i = in; i <= fi; i++) {
    textFont(fuente, 42); 
    botones [i].coordenadas();
    botones [i].controlarF();
  }
}

// rellena las piezas del tamgram
void inicializacionFiguras ( ) {

  for ( int i = 0; i <= figuras.length-1; i++) {
    int [] coor = new int [3]; //coordenadas en X, Y - Angulo de las figuras 
    int [] colS = new int [3];// color de la figura al momento de seleccionarse
    int [] colO = new int [3];//color de la figura sin seleccionarse
    int [] trian = new int [6];//vertices triangulos
    int [] paral = new int [8];//vertices paralelogramos 

    for ( int j=0; j<=2; j++) {
      coor [j] = coord [i][j];
      colS [j] = colorsel [i][j];
      colO [j] = colorori [i][j];
    }

    //llenar parametros para dibujar triangulos
    if (i <=4) {
      for (int k = 0; k <= 5; k++) {
        trian [k] = triangulos [i][k];
      }
      figuras [i] = new Triangulo ( coor, colS, colO, trian);
      figurasCrea [i] = new Triangulo ( coor, colS, colO, trian);
    }

    //llenar parametros para dibujar paralelogramos
    else {
      for (int l = 0; l <= 7; l++) {
        paral [l] = paralelogramo [i-5][l];
      } 
      figuras[i] = new Paralelogramo ( coor, colS, colO, paral);
      figurasCrea [i] = new Paralelogramo ( coor, colS, colO, paral);
    }
  }
}

// cuenta los pixels negros
void copixel() {
  conegro = 0;
  loadPixels();
  int dimension = width * height;
  for (int i = 0; i < dimension; i++) { 
    color colpix = pixels [i];
    if (colpix == pxnegro) {
      conegro++;
    }
  }
}

// ejecucion de botones para volver al menu principal y para reiniciar el nivel 
//(backspace vuelve al menu principal, TAB reinicia nivel)
void keyPressed () {
  if ((keyCode == BACKSPACE) && (keyPressed)) {
    cont = 0;
    bo1 = 0;
    c = 0;
    ins = 0;
    cn = 0;
    inicializacionFiguras();
    for (int i = 0; i <= plantillanivel.length-1; i++) {
      plantillanivel [i] = loadImage (imagenes[i] +".png");
    }
  }
  if ((keyCode == TAB) && (keyPressed)) {
    c=0;
    inicializacionFiguras();
  }
  if (key == 'g' || key == 'G') {
    drawGrid = !drawGrid;
  }
}

// copia la matriz de coordenadas de las piezas en una nueva matriz 
//la cual servira para que las piezas no se intercepten
void matrizinter () {
  for (int i = 0; i <= 6; i++) {
    for (int j = 0; j <= 1; j++) {
      coord1 [i][j]= coord [i][j+1];
    }
  }
}

//identifica en que figura esta parado el puntero siempre y cuando se tenga presionado el mouse
// luego guarda esta posicion la cual ira cambiando de acuerdo se mueva la figura 
// una vez se deja de presionar el mouse vuelve a identificar si esta encima de otra figura
// y vuelve a guardar el dato de dicha figura
void mouseDragged (Figura [] figu) {
  if (mousePressed == false) {
    nd=0;
  }
  if (c == 0) {
    matrizinter();
    c=1;
  }
  for (int i=0; i <=6; i++) {
    if (nd == 0) {
      if ((dist(coord1 [i][0], coord1 [i][1], mouseX, mouseY)<20) && (mousePressed)) {
        coo=i;
        nd = 1;
      }
    }
  }

  if ((dist(coord1 [coo][0], coord1 [coo][1], mouseX, mouseY)<20) && (mousePressed)) {
    coord1 [coo][0]= mouseX;
    coord1 [coo][1]= mouseY;
    push ();
    translate(coord1 [coo][0], coord1 [coo][1]);
    pop ();
  }

  for ( int k = 0; k < figuras.length; k++) {
    figu [k].keyPressed();
  }


  for ( int i = 0; i < figuras.length; i++) {
    if (coo != i) {
      figu [i].controlarF();
    }
  }
  figu [coo].coordenadas();
  figu [coo].controlarF();
}

// navega entre los menu
void mouseClicked () {
  //selecciona el nivel a jugar
  if (cont == 1) {
    for (int i = 3; i < 9; i++) {

      if (bo == 0) {
        if ((dist(centboton1[i][1], centboton1[i][2], mouseX, mouseY)<30)) {
          cont1 = i-2;
          bo = 1;
        }
      }
    }
  }
  // entra en el menu al que se le de click en el menu principal
  if (bo1 == 0) {
    for (int i=0; i <= 2; i++) {
      if ((dist(centboton1[i][1], centboton1[i][2], mouseX, mouseY)<30)) {
        cont = i+1;
        bo1 = 1;
      }
    }
  }

  // pasa entre las instrucciones
  if (cont == 3 ) {
    if (ins == 0) {
      ins = 1;
    } else if (ins == 1) {
      ins = 2;
    } else if (ins == 2) {
      ins = 3;
    }
  }
}

void drawGrid(float scale) {
  push();
  strokeWeight(1);
  int i;
  for (i=0; i<=width/scale; i++) {
    stroke(0, 0, 0, 20);
    line(i*scale, 0, i*scale, height);
  }
  for (i=0; i<=height/scale; i++) {
    stroke(0, 0, 0, 20);
    line(0, i*scale, width, i*scale);
  }
  pop();
}

void cuadric () {
  if (drawGrid == true) {
    drawGrid(10);
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////

void setup () {
  size(1000, 600);
  inicializacionFiguras();
  boton ();
  for (int i = 0; i < plantillanivel.length; i++) {
    plantillanivel [i] = loadImage (imagenes[i] +".png");
  }
  fuente = loadFont ("Chiller-Regular-48.vlw");
}


void draw() {
  noStroke ();

  if (cont == 0) {
    background(fondo);
    pantInic ("Tamgram", 0, 0, 2);
    bo = 0;
    cont1 = 0;
  } else  if (cont == 1) {// entran al menu para seleccionar nivel
    if (cont1 == 0) {
      background(fondo);
      pantInic ("Niveles", 30, 3, 8);
    } else {// entran al nivel del juego 
      image(plantillanivel[cont1-1], 0, 0);
      if (cn == 0) {
        copixel ();
        connn = conegro;
        cn++;
      }
      mouseDragged (figuras);
      copixel (); 

      if (conegro <= (connn*mul)) {
        delay(500);
        background(fondo);
        textFont(fuente, 60);
        text("FELICIDADES HAS COMPLETADO EL NIVEL", (width/4)-170, height/3);
        textFont(fuente, 30);
        text("(presiona 'Backspace' para volver al menu principal)", (width/4), height/2);
      }
    }
  } else if (cont == 2) { // se entra al modo creador

    if ((key == '1') || (key == '2') || (key == '3') && (keyPressed)) {
      background(fondo);
    } else {
      background(fondo);
      cuadric ();
    }
    mouseDragged (figurasCrea);
    guardarima();
  } else if (cont == 3) { // se entra a las instrucciones 
    background(fondo);
    if (ins == 1) {
      textFont(fuente, 60);
      text ("INSTRUCCIONES", (width/2)-170, 100);
      textFont(fuente, 32);
      text ("El tangram es un juego chino muy antiguo, que consiste en formar siluetas de figuras con las siete ", texX, texY);
      text ("piezas dadas.", texX, texY + (a*1));
      textFont(fuente, 45);
      text ("INSTRUCCIONES GENERALES", texX, texY + (a*3));
      textFont(fuente, 32);
      text ("- Si te encuentras dentro de un menu o dentro de alguno de los modos de juego podras regresar", texX, texY + (a*4.5));
      text ("  al menu principal oprimiento 'Backspace'.", texX, texY + (a*5.5));
      text ("- Si quieres reiniciar el tablero de juego oprime 'TAB'.", texX, texY + (a*6.5));
      text ("- Si quieres activar la cuadricula dentro del juego oprime g", texX, texY + (a*7.5));
    } else  if (ins == 2) {
      textFont(fuente, 50);
      text ("INSTRUCCIONES DE JUEGO", (width/2)-210, texY - 80 );
      textFont(fuente, 32);
      text ("Si quieres manipular alguna pieza a traves del tablero de juego, debes: ", texX + 80, (texY - 80) + (a*1.5));
      text ("   1. Ubicar el punteron encima de la pieza, hasta que esta cambie su color.", texX + 80, (texY - 80) + (a*2.5));
      text ("   2. Seleccionar la pieza dando click con el mouse ", texX + 80, (texY - 80) + (a*3.5));
      text ("   3. Puedes rotar las piezas con las flechas 'Derecha' e 'Izquierda' del teclado,  ", texX + 80, (texY - 80)+ (a*4.5));
      text ("      respectivamente", texX + 80, (texY - 80) + (a*5.5));
      text ("   4. Para el PARALELOGRAMO: lo puedes reflejar con las flechas 'Arriba' y 'Abajo'", texX + 80, (texY - 80) + (a*6.5));
      text ("El juego termina cuando la cantidad de espacios en negro sea muy baja", texX + 80, (texY - 80) + (a*8));
    } else if (ins == 3) {
      textFont(fuente, 50);
      text ("MODO CREADOR", (width/2)- 200, texY - 80);
      textFont(fuente, 32);
      text ("El modo creador es una opcion que te permite crear tus propios niveles de juego, para ello", texX + 55, (texY - 80) + (a*1.5));
      text ("   1. Debes armar una figura o un nivel manipulando las piezas en el tablero", texX + 55, (texY - 80) + (a*2.5));
      text ("   2. Una vez termines de armar tu nivel, oprime un numero del 1 al 3,", texX + 55, (texY - 80) + (a*3.5));
      text ("       y automaticamente se actualizará el nivel dentro del boton con el numero de la figura", texX + 80, (texY - 80) + (a*4.5));
      text ("       en el menú de niveles.", texX + 55, (texY - 80) + (a*5.5));
      textFont(fuente, 28);
      text ("(presione 'Backspace' para regresar al menu principal)", texX + 210, (texY - 80) + (a*8.5));
    }
  }
}
