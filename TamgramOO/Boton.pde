class Boton extends Figura {
  int [] vert= new int [8];
  String tex;
  int b;
  Boton (int [] pos, int [] col1, int [] col2, int [] punT, String  let_, int  a) {
    super (pos, col1, col2);
    arrayCopy (punT, vert);

    tex = let_;
    b = a;
  }

  void coordenadas () {
  }
  void pintarF () {
    if ((dist(posxyA [1], posxyA [2], mouseX, mouseY)<30)) {
      fill(colse [0], colse [1], colse [2]);
    } else {
      fill(colo [0], colo [1], colo [2]);
    }
  }
  void dibujarF () {
    rect(vert[0], vert[1], vert[2], vert[3], vert[4], vert[5], vert [6], vert[7]);
    fill (0);
    text(tex, vert[0]+b, vert[1]+45);
  }  
  void keyPressed () {
  }
}
