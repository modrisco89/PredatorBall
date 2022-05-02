public class Flipper {

  private float xCoord1;//x1 coordinate of the flipper
  private float yCoord1;//y1 coordinate of the flipper
  private float xCoord2;//x2 coordinate of the flipper
  private float yCoord2;//y2 coordinate of the flipper

  public float getXCoord1() {  
    return xCoord1;
  }  // getter

  public float getYCoord1() {
    return yCoord1;
  }  //getter

  public float getXCoord2() {  
    return xCoord2;
  }  // getter

  public float getYCoord2() {
    return yCoord2;
  }  //getter

  public void setXCoord1(float xCoord1) {

    this.xCoord1 = xCoord1;
  }//setter
  public void setXCoord2(float xCoord2) {

    this.xCoord2 = xCoord2;
  }//setter

  public void setYCoord1(float yCoord1) {

    this.yCoord1 = yCoord1;
  }//setter

  public void setYCoord2(float yCoord2) {

    this.yCoord2 = yCoord2;
  }//setter

  public void display(float yCoord2) {
    stroke(0);
    strokeWeight(2);
    line(xCoord1, yCoord1, xCoord2, yCoord2);
  }//display method that's public



  public Flipper(float xCoord1, float yCoord1, float xCoord2, float yCoord2) {
    setXCoord1(xCoord1);
    setXCoord2(xCoord2);
    setYCoord1(yCoord1);
    setYCoord2(yCoord2);
  }//flipper constructor that's public which sets the coordinates
}
