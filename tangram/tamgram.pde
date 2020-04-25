// posicion del tangram
int X=400;
int Y=200;

int coo;
int varT;
int varP;

// angulo, posicion en X y Y de todas las piezas = 2 triangulos grandes- 1 triangulo mediano- 2 triangulos pequeños- 1 cuadrado- 1 paralelogramo  
int [][] coord ={{0, 120, 70}, {0, 70, 120}, {0, 195, 195}, {0, 195, 70}, {0, 120, 145}, {0, 170, 120}, {0, 95, 195}};

//informacion de los vertices de los triangulos n0-n5 
int [][] triangulos = {{0, 50, 100, -50, -100, -50}, {50, 0, -50, 100, -50, -100}, {25, 25, 25, -75, -75, 25}, {25, -50, 25, 50, -25, 0}, {50, 25, -50, 25, 0, -25}};

//informacion de los vertices de los paralelogramos  n0-n7 
int [][] paralelogramo = {{50, 0, 0, 50, -50, 0, 0, -50}, {25, 25, 75, -25, -25, -25, -75, 25}};
int h=1;

//colores figuras sin seleccionar RGB
int [][] colorori = {{198, 40, 40}, {40, 53, 147}, {2, 119, 189}, {249, 168, 37}, {106, 27, 154}, {46, 125, 50}, {0, 105, 92}};

//colores figuras seleccionadas RGB
int [][] colorsel = {{229, 115, 115}, {121, 134, 203}, {79, 195, 247}, {255, 241, 118}, {186, 104, 200}, {129, 199, 132}, {77, 182, 172}};

void varivec () {
  if ((dist(coord [0][1], coord [0][2], mouseX, mouseY)<20)) {
    coo=0;
    varT=0;
  } else if ((dist(coord [1][1], coord [1][2], mouseX, mouseY)<20)) {
    coo=1;
    varT=1;
  } else if ((dist(coord [2][1], coord [2][2], mouseX, mouseY)<20)) {
    coo=2;
    varT=2;
  } else if ((dist(coord [3][1], coord [3][2], mouseX, mouseY)<20)) {
    coo=3;
    varT=3;
  } else if ((dist(coord [4][1], coord [4][2], mouseX, mouseY)<20)) {
    coo=4;
    varT=4;
  } else if ((dist(coord [5][1], coord [5][2], mouseX, mouseY)<20)) {
    coo=5;
    varP=0;
  } else if ((dist(coord [6][1], coord [6][2], mouseX, mouseY)<20)) {
    coo=6;
    varP=1;
  }
}


void Triangulos() {

  varivec ();

  if ((dist(coord[coo][1], coord [coo][2], mouseX, mouseY)<20)&&(keyPressed)) {
    if (keyCode == RIGHT) {
      coord [coo][0]= coord [coo][0] + 1;
    }
    if (keyCode == LEFT) {
      coord [coo][0]= coord [coo][0] - 1;
    }
  }

  //se dibujan todos los triangulos con sus respectivos colores
  for (int i = 0; i <= 4; i++) {
    if (i!= coo) {

      fill(colorori[i][0], colorori[i][1], colorori[i][2]);
      push();
      translate(coord [i][1], coord [i][2]);
      rotate(radians (coord [i][0]));
      triangle(triangulos [i][0], triangulos [i][1], triangulos [i][2], triangulos [i][3], triangulos [i][4], triangulos [i][5]);
      pop ();
    }
  }
  if (coo <= 4) {
    //se interactua con el triangulo que este cerca a la posicion del mouse
    if ((dist(coord [coo][1], coord [coo][2], mouseX, mouseY)<20)&&(mousePressed)) {
      coord [coo][1] = mouseX;
      coord [coo][2] = mouseY;
    }

    if ((dist(coord [coo][1], coord [coo][2], mouseX, mouseY)<20)) {
      fill(colorsel[coo][0], colorsel[coo][1], colorsel[coo][2]);
    } else {
      fill(colorori[coo][0], colorori[coo][1], colorori[coo][2]);
    }

    push();
    translate(coord [coo][1], coord [coo][2]);
    rotate(radians (coord [coo][0]));
    triangle(triangulos [varT][0], triangulos [varT][1], triangulos [varT][2], triangulos [varT][3], triangulos [varT][4], triangulos [varT][5]);     
    pop();
  }
}

//PARALELOGRAMOS

void paralelogramos() {

  varivec ();


  if ((dist(coord [coo][1], coord [coo][2], mouseX, mouseY)<20)&&(keyPressed)) {
    if (keyCode == RIGHT) {
      coord [coo][0]= coord [coo][0] + 1;
    }
    if (keyCode == LEFT) {
      coord [coo][0]= coord [coo][0] - 1;
    }
    if (keyCode == UP ) {
      //h=false;
      h=-1;
    } 
    if (keyCode == DOWN ) {
      h=1;
    }
  }

  //se dibujan todos los paralelogramos con sus respectivos colores
  for (int j = 0; j <= 1; j++) {


    fill(colorori[j+5][0], colorori[j+5][1], colorori[j+5][2]);
    push();
    translate(coord [j+5][1], coord [j+5][2]);
    rotate(radians (coord [j+5][0]));
    if (h == 1) {
      quad(paralelogramo [j][0], paralelogramo [j][1], paralelogramo [j][2], paralelogramo [j][3], paralelogramo [j][4], paralelogramo [j][5], paralelogramo [j][6], paralelogramo [j][7]);
    } else {
      quad(paralelogramo [j][0], paralelogramo [j][1]*(-1), paralelogramo [j][2], paralelogramo [j][3]*(-1), paralelogramo [j][4], paralelogramo [j][5]*(-1), paralelogramo [j][6], paralelogramo [j][7]*(-1));
    }
    pop ();
  }

  //se interactua con el paralelogramo que este cerca a la posicion del mouse
  if (coo > 4) {
    if ((dist(coord [coo][1], coord [coo][2], mouseX, mouseY)<20)&&(mousePressed)) {
      coord [coo][1] = mouseX;
      coord [coo][2] = mouseY;
    }

    if ((dist(coord [coo][1], coord [coo][2], mouseX, mouseY)<20)) {
      fill(colorsel[coo][0], colorsel[coo][1], colorsel[coo][2]);
    } else {
      fill(colorori[coo][0], colorori[coo][1], colorori[coo][2]);
    }

    push();
    translate(coord [coo][1], coord [coo][2]);
    rotate(radians (coord [coo][0]));
    if (h==1) {
      quad(paralelogramo [varP][0], paralelogramo [varP][1], paralelogramo [varP][2], paralelogramo [varP][3], paralelogramo [varP][4], paralelogramo [varP][5], paralelogramo [varP][6], paralelogramo [varP][7]);
    } else {
      quad(paralelogramo [varP][0], paralelogramo [varP][1]*(-1), paralelogramo [varP][2], paralelogramo [varP][3]*(-1), paralelogramo [varP][4], paralelogramo [varP][5]*(-1), paralelogramo [varP][6], paralelogramo [varP][7]*(-1));
    }
    pop();
  }
}


void setup () {
  size(1000, 600);
}

//mouseX >= 25 && mouseX <= 50 || mouseY>= 25 && mouseY <= 50 &&
void draw () {

  background(0, 0, 25);

  noStroke();

  fill(80, 20, 170);
  triangle(40+X, 40+Y, 242+X, 40+Y, 142+X, 140+Y); //A
  triangle(318+X, 40+Y, 520+X, 40+Y, 418+X, 140+Y);//B
  triangle(280+X, 0+Y, 210+X, 70+Y, 350+X, 70+Y);//C
  triangle(280+X, 70+Y, 280+X, 140+Y, 208+X, 140+Y);//D
  triangle(350+X, 70+Y, 350+X, 140+Y, 420+X, 140+Y);//E
  rect (280+X, 70+Y, 70, 70);//F
  quad (210+X, 70+Y, 280+X, 70+Y, 210+X, 140+Y, 140+X, 140+Y);//G 
  Triangulos ();
  paralelogramos();
}
