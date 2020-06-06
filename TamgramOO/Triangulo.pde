class Triangulo extends Figura {
  int [] vert= new int [6];

  Triangulo (int [] pos, int [] col1, int [] col2, int [] punT) {
    super (pos, col1, col2);
    arrayCopy (punT, vert);
  }

  void dibujarF () {
    triangle (vert[0], vert[1], vert[2], vert[3], vert[4], vert[5]);
  }
}
