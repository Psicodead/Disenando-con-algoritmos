Logica app;
void setup(){
  size(1200,700);
  app = new Logica();
}
void draw(){
  app.ejecutar();
}
void mousePressed(){
  app.coger(mouseX,mouseY);
  // aqui se colocara el metodo para coger el objeto
}
void mouseReleased(){
  app.cambPant();
  app.soltar(mouseX,mouseY);
  //aquie se colocara el metodo para soltar el objeto
}
void mouseDragged(){
  app.arrastrar(mouseX,mouseY);
  //aquie se colocara el metodo para soltar el objeto
}
void keyPressed(){
  app.crear(key);
}
  

