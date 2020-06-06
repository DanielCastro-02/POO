abstract class Figura {

  int [] posxyA = new int [3];
  int [] colse = new int [3] ;
  int [] colo = new int [3];

  Figura (int [] pos, int [] col1, int [] col2) {  
    arrayCopy (pos, posxyA);
    arrayCopy (col1, colse);
    arrayCopy (col2, colo);
  }

  void coordenadas() {

    if ((dist(posxyA [1], posxyA [2], mouseX, mouseY)<20) && (mousePressed) ) {
      posxyA [1] = mouseX;
      posxyA [2] = mouseY;
    }
  }

  void pintarF () {
    if ((dist(posxyA [1], posxyA [2], mouseX, mouseY)<20)) {
      fill(colse [0], colse [1], colse [2]);
    } else {
      fill(colo [0], colo [1], colo [2]);
    }
  }

  abstract void dibujarF ();

  void controlarF () {   
    push();
    translate(posxyA [1], posxyA [2]);
    rotate(radians (posxyA [0]));
    pintarF();
    dibujarF ();
    pop();
  }

  void keyPressed() {
    if ((dist(posxyA [1], posxyA [2], mouseX, mouseY)<20)&&(keyPressed)) {
      if (keyCode == RIGHT) {
        posxyA [0]= posxyA [0] + 5;
        delay (100);
      }
      if (keyCode == LEFT) {
        posxyA [0]= posxyA [0] - 5;
        delay (100);
      }
    }
  }
}
