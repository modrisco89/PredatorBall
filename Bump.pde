public class Bump {

  private float xCoord;      //x coordinate of the bump
  private float yCoord;      //y coordinate of the bump
  private float diameter;    //diameter of the bump
  public float getXCoord() {  
    return xCoord;
  }  // getter

  public float getYCoord() {
    return yCoord;
  }  //getter

  public float getDiameter() {
    return diameter;
  } //getter

  public void setXCoord(float xCoord) {
    this.xCoord = xCoord;
  }//setter

  public void setYCoord(float yCoord) {
    this.yCoord = yCoord;
  }//setter

  public void setDiameter(float diameter) {
    //The ball diameter must be between 20 and 50 (inclusive)
    if ((diameter >= 20) && (diameter <= 60)) {
      this.diameter = diameter;
    } else {
      // If an invalid diameter is passed as a parameter, a default of 20 is imposed.
      this.diameter = 20;
    }
  }//setter

  public void display(float xCoord, float yCoord) {
    fill(random(255), random(255), random(255));
    setXCoord(xCoord);
    setYCoord(yCoord);
    ellipse(xCoord, yCoord, diameter, diameter);
  }  //display method that's public

  public Bump(float diameter) {
    setDiameter(diameter);
  }//public constructor for bump
}
