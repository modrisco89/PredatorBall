public class Ball
{
  private float xCoord;      //x coordinate of the ball
  private float yCoord;      //y coordinate of the ball
  private float diameter;    //diameter of the ball
  private float speedX;      //speed along the x-axis
  private float speedY;      //speed along the y-axis

  public float getXCoord() {  
    return xCoord;
  }  // getter

  public float getYCoord() {
    return yCoord;
  }  //getter
  public float getSpeedX() {  
    return speedX;
  }  // getter

  public float getSpeedY() {
    return speedY;
  } // getter
  public float getDiameter() {
    return diameter;
  } //getter

  public void setDiameter(float diameter) {
    //The ball diameter must be between 10 and 20 (inclusive)
    if ((diameter >= 10) && (diameter <= 20)) {
      this.diameter = diameter;
    } else {
      // If an invalid diameter is passed as a parameter, a default of 10 is imposed.
      this.diameter = 10;
    }
  }//setter

  public void display() {
    fill(255, 0, 0);
    ellipse(xCoord, yCoord, diameter, diameter);
  }  //display method that's public


  public void resetBall() {// reset method that's public
    xCoord = 50;//initilise xCoord
    yCoord = 350;//initilise ycoord
    speedX = random(-1.5, 1.5);//speed is randomised on xaxis
    speedY = random(0.5, 1.5);//speed is randomised on yaxis
  }

  public Ball(float diameter) {
    setDiameter(diameter);
    resetBall();
  } //ball constructor that's public

  public void hit(String flag) {
    if (flag == "bounce") {
      speedY = speedY * -random(0.5, 1.5);
      speedX = speedX * -random(0.5, 1.5);
      xCoord = xCoord + speedX;
      yCoord = yCoord + speedY;
    }//this is the bounce decision, which randomises the speed on x and y and increments the x/y coord with speedx/y

    else if (flag == "rollLeftTriangle") {
      if (yCoord<545) {
        xCoord+=2;
        yCoord+=2;
      }
    }//causes ball to roll down left triangle when used
    else if (flag == "rollRightTriangle") {
      if (yCoord<545) {
        yCoord+=2;
        xCoord-=2;
      }
    }//causes ball to roll down right triangle when used
    else if (flag == "RollAlongLeftPin") {
      xCoord++;
      yCoord=544;
    }//causes ball to roll on left flipper
    else if (flag == "RollAlongRightPin") {
      xCoord--;
      yCoord=544;
    }//causes ball to roll along right flipper
    else if (flag == "pinDrop") {
      yCoord+=2;
    }//causes ball to drop down
  }//hit method that's public


  public void update() {
    if (yCoord > height + diameter/2) {
      resetBall();
    }//resets ball if the ball goes beyond the bottom of the window

    //update ball coordinates
    xCoord = xCoord + speedX;
    yCoord = yCoord + speedY;

    if (xCoord > width - diameter/2) {
      xCoord = width - diameter/2;
      speedX = speedX * -random(0.5, 1.5);
    }
    // If ball hits the right edge of the display 
    // window, change direction of xCoord
    else if (xCoord < diameter/2) {
      xCoord = diameter/2;
      speedX = speedX * -random(0.5, 1.5);
    }
    // If ball hits the left edge of the display 
    // window, change direction of xCoord

    else if (yCoord < diameter/2) {
      yCoord = diameter/2;
      speedY = speedY * -random(0.5, 1.5);
    }//if the ball hits the top of the window, change direction of the yCoord
  }
}
