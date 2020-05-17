// angulo, posicion en X y Y de todas las piezas = 2 triangulos grandes- 1 triangulo mediano- 2 triangulos pequeños- 1 cuadrado- 1 paralelogramo  
int [][] coord ={{0, 120, 70}, {0, 70, 120}, {0, 195, 195}, {0, 195, 70}, {0, 120, 145}, {0, 170, 120}, {0, 95, 195}};

//informacion de los vertices de los triangulos n0-n5 
int [][] triangulos = {{0, 50, 100, -50, -100, -50}, {50, 0, -50, 100, -50, -100}, {25, 25, 25, -75, -75, 25}, {25, -50, 25, 50, -25, 0}, {50, 25, -50, 25, 0, -25}};

//informacion de los vertices de los paralelogramos  n0-n7 
int [][] paralelogramo = {{50, 0, 0, 50, -50, 0, 0, -50}, {25, 25, 75, -25, -25, -25, -75, 25}};

//colores figuras sin seleccionar RGB
int [][] colorori = {{198, 40, 40}, {40, 53, 147}, {2, 119, 189}, {249, 168, 37}, {106, 27, 154}, {46, 125, 50}, {0, 105, 92}};

//colores figuras seleccionadas RGB
int [][] colorsel = {{229, 115, 115}, {121, 134, 203}, {79, 195, 247}, {255, 241, 118}, {186, 104, 200}, {129, 199, 132}, {77, 182, 172}};


Figura [] figuras = new Figura[7];

void setup () {
  size(1000, 600);

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
    }

    //llenar parametros para dibujar paralelogramos
    else {
      for (int l = 0; l <= 7; l++) {
        paral [l] = paralelogramo [i-5][l];
      }
      figuras [i] = new Paralelogramo ( coor, colS, colO, paral);
    }
  }
}

void draw() {
  background (80, 162, 120);
  noStroke ();

  for ( int i = 0; i <= figuras.length-1; i++) {
    figuras [i].keyPressed();
    figuras [i].coordenadas();
    figuras [i].controlarF();
  }
}
