class Paralelogramo extends Figura {
  int [] vert= new int [8];
  int h=1;

  Paralelogramo (int [] pos, int [] col1, int [] col2, int [] punT) {
    super (pos, col1, col2);
    arrayCopy (punT, vert);
  }

  void keyPressed() {
    super.keyPressed();
    if ((dist(posxyA [1], posxyA [2], mouseX, mouseY)<20) && (keyPressed)) {

      if (keyCode == UP) {
        h = -1;
      } 
      if (keyCode == DOWN) {
        h = 1;
      }
    }
  }

  void dibujarF () {
    if (h==1) {
      quad (vert[0], vert[1], vert[2], vert[3], vert[4], vert[5], vert[6], vert[7]);
    } else {
      quad (vert[0], -vert[1], vert[2], -vert[3], vert[4], -vert[5], vert[6], -vert[7]);
    }
  }
}
