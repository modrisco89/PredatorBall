Ball ball; //instantiating ball //<>// //<>//
Bump[] bumps; //instantiating array of bumps
Triangle triangleL; //instantiating left triangle
Triangle triangleR; //instantiating right triangle
Flipper FlipperL; //instantiating left flipper
Flipper FlipperR; //instantiating right flipper
Player player; //instantating player

import javax.swing.*; // import for input dialog
PImage bg; // instance of import of PImage
public boolean rollFlagL = false; //ball rolling on left triangle flag
public boolean rollFlagR = false; //ball rolling on right triangle flag
public boolean rollPinL = false; //ball rolling on left flipper flag
public boolean rollPinR = false; //ball rolling on right flipper flag
public boolean ballDrop = false; //ball drop flag
float pinYCoordL=550; //float variable for Left flipper movement
float pinYCoordR=550; //float variable for Right flipper movement
int score=0; //integer score variable initialised at 0.
int numberOfLives; //integer of number of lives



void setup()
{
  bg = loadImage("predator.jpg"); //loads up background image of predator
  size(400, 700); //sizes window to 400X700
  bumps = new Bump[4]; //instance for bump initialisng size of array
  ball = new Ball(10); //instance of constructor for ball
  triangleL = new Triangle(0, 400, 0, 550, 150, 550); //instance of constructor for left triangle
  triangleR = new Triangle(400, 400, 400, 550, 250, 550); //instance of constructor for right triangle
  FlipperL = new Flipper(150, 550, 180, pinYCoordL);  //instance of constructor for left triangle
  FlipperR = new Flipper(250, 550, 220, pinYCoordR); //instance of constructor for right triangle
  frameRate(120);
  for (int i = 1; i <= bumps.length; i++) {
    bumps[i-1] = new Bump(60); //cycling through each constructor for bump with diameter of 60
  }
  Integer[] options = {1, 2, 3, 4, 5};//array of options for choosing number of lives
  numberOfLives = ((Integer)JOptionPane.showInputDialog(null, "Welcome to Predatorball\n\n Please enter the number of lives: ", "Lives", JOptionPane.QUESTION_MESSAGE, null, options, options[2]));
  //input dialog enabling dropdown menu of choices, with a question icon
  player = new Player(JOptionPane.showInputDialog("Enter the player initials (max 3 chars: "), numberOfLives);
  //input dialog enabling user to type initials max 3 characters
}


void draw()
{
  background(bg);//prints background image of predator
  if (numberOfLives <1) {
    JOptionPane.showMessageDialog(frame, 
      "GAME OVER \n" + player.toString());
    System.exit(0);
  }
  //if number of lives goes to 0, dialog box of information showing score per each life appears and saying "Game over" then closes the game
  pinDrop(); //pin drop method executes
  if (numberOfLives != 0) { //this if statement executes the rest of the code in draw while lives are not 0, if 0 the game stops
    bumps[0].display(50, 50); //displaying bump 1
    bumps[1].display(200, 100); //displaying bump 2
    bumps[2].display(150, 250); //displaying bump 3
    bumps[3].display(350, 350); //displaying bump 4
    triangleL.display(); //displays triangle
    triangleR.display();  //displays triangle
    if (rollFlagL == false && rollFlagR == false && rollPinL == false && rollPinR == false && ballDrop == false ) {
      //as long as the ball is not rolling on the triangles, pins or in the drop state, the ball updates coordinates.
      ball.update(); //updates ball coordinates
    }
    ball.display(); //displays ball
    collisionObject(); //collision with bumps method 
    FlipperL.display(pinYCoordL); //display left flipper
    FlipperR.display(pinYCoordR); //display right flipper
    triangleCollision(true, false, triangleL.getXCoord1(), triangleL.getYCoord1(), triangleL.getXCoord3(), triangleL.getYCoord3()); //triangle collision method (left)
    triangleRollL("rollLeftTriangle"); //roll along triangle left
    rollPinL(); //flipper roll left
    pinCollisionLeft(); //flipper collision left
    triangleCollision(false, true, triangleR.getXCoord3(), triangleR.getYCoord3(), triangleR.getXCoord1(), triangleR.getYCoord1()); //triangle collision method (right)
    triangleRollR("rollRightTriangle"); //roll along triangle right
    rollPinR(); //flipper roll right
    pinCollisionRight(); //flipper collision left
  }
}


void keyReleased() {
  background(bg);//prints background image of predator
  pinYCoordL=FlipperL.getYCoord1();
  FlipperL.setYCoord2(FlipperL.getYCoord1());
  pinYCoordR=FlipperR.getYCoord1();
  FlipperR.setYCoord2(FlipperR.getYCoord1());
  //resets flippers after key is released
  fill(0);
  strokeWeight(0);
  triangleL.display();
  triangleR.display();
  //diaplays left and right trianles colouring them black getting rid of outline
  bumps[0].display(50, 50);
  bumps[1].display(200, 100);
  bumps[2].display(150, 200);
  bumps[3].display(350, 300);
  //displays bumps 1 to 4
}

void keyPressed() {

  if (key == CODED) {
    //below for right handed user
    if (keyCode == LEFT) {
      if (pinYCoordL>535) {
        pinYCoordL-=2; //if key pressed left, decrement the left flipper cooordinate by 2
        FlipperL.setYCoord2(pinYCoordL); //use setter from flipper class to take in decremented value
      }
    } else if (keyCode == RIGHT) {
      if (pinYCoordR>535) {
        pinYCoordR-=2; //if key pressed right, decrement the right flipper cooordinate by 2
        FlipperR.setYCoord2(pinYCoordR); //use setter from flipper class to take in decremented value
      }
    }
    ///below code for left handed user
    else if (keyCode == UP) {
      if (pinYCoordL>535) {
        pinYCoordL-=2; //if key pressed UP, decrement the left flipper cooordinate by 2
        FlipperL.setYCoord2(pinYCoordL); //use setter from flipper class to take in decremented value
      }
    } else if (keyCode == DOWN) {
      if (pinYCoordR>535) {
        pinYCoordR-=2; //if key pressed down, decrement the right flipper cooordinate by 2
        FlipperR.setYCoord2(pinYCoordR); //use setter from flipper class to take in decremented value
      }
    }
  }
}



void pinDrop() {
  if ( ballDrop == true && (ball.getXCoord() >= FlipperL.getXCoord1() || ball.getXCoord() <=FlipperR.getXCoord2())) {
    ball.hit("pinDrop");//ball drop executes in hit method in ball class if ball is falling off flippers (greater than max flipper left coordinate/less than max flipper right coordinate)
    if (ball.getYCoord() + ball.getDiameter()/2 > height) {
      if (numberOfLives > 0) {
        player.addScore(score); //add score to array in Player class for storing
        score=0;//reset score
        ball.resetBall(); //reset the ball
      }
      numberOfLives--; //decrement number of lives after ball falls through flippers
      ballDrop = false;
      rollFlagL= false;
      rollFlagR = false;
      rollPinL = false;
      rollPinR = false;
      //reset all flags
    }
  }
}

void collisionObject()
{


  for (int i=0; i < bumps.length; i++) {//cycles through bumps to check if there is a collision between the ball and the bumps 
    float circleDistanceX = abs(ball.getXCoord() - (bumps[i].getXCoord()));//get absolute value of X distance between centers of objects
    float circleDistanceY = abs(ball.getYCoord() - (bumps[i].getYCoord())); //get absolute value of Y distance between centers of objects
    if (((circleDistanceX < (ball.getDiameter()/2)+bumps[i].getDiameter()/2)) && ((circleDistanceY <(ball.getDiameter()/2+bumps[i].getDiameter()/2)))) {
      //check that the X and Y distances are less than sum of half the ball diamter and half the bump diameter
      if (i==0) {
        score= score+ 1000;//if bump 1, score is incremented by 1000
      }
      if (i==1) {
        score= score+800; //if bump 2, score is incremented by 800
      }
      if (i==2) {
        score= score+500; //if bump 3, score is incremented by 500
      }
      if (i==3) {
        score= score+200; //if bump 4, score is incremented by 200
      }
      ball.hit("bounce");//execute bounce in hit method in ball class
    }
  }
}



void pinCollisionLeft() { //left flipper collision method
  int i = int(FlipperL.getXCoord1()); //initilises i  as integer of the flipper xcoordinate
  while (i<=int(FlipperL.getXCoord2())) {//while loop to cyle from FlipperL.getXCoord1() to FlipperL.getXCoord2()


    float slope = ((-FlipperL.getYCoord2()+FlipperL.getYCoord1())/(FlipperL.getXCoord2()-FlipperL.getXCoord1()));// variable slope calculation of line
    float constant = FlipperL.getYCoord2()+slope*FlipperL.getXCoord2();//variable constant calulation of line
    float xCoord = i; //set x to i
    float yCoord = -i*slope+constant;//using equation of line to calculate the y coordinate
    float circleDistanceX = abs(ball.getXCoord() - xCoord);//get absolute distance between ball xcoord and xcoord of line
    float circleDistanceY = abs(ball.getYCoord() - yCoord);//get absolute distance between ball ycoord and ycoord of line
    if (((circleDistanceX <= (ball.getDiameter()/2))) && ((circleDistanceY <= (ball.getDiameter()/2)))) {//check the distance from the line to the ball using half the diameter
      rollFlagL = false;
      rollFlagR = false;
      //left and right roll triangle flags set to false
      if (slope>0) { //if flipper is at an angle (slope>0) execute the below
        rollPinL = false;
        rollPinR = false;
        //set flipper flags to false
        ball.hit("bounce");//execute bounce in hit method in ball class
        break;//breakout of while loop
      } else if (slope==0) {//as long as flipper is not at an angle the belown will execute
        rollPinL = true;//set rolling on left flipper to true
        break;//breakout of while loop
      }
    }
    i++; //increment i by 1
  }
}


void pinCollisionRight() {//collison with right flipper method
  int j = int(FlipperR.getXCoord1()); //initialises integer j as right flipper x1 coord
  while (j>=int(FlipperR.getXCoord2())) {//loop through until j is greater than or equalled to right flipper x2 coord


    float slope = ((-FlipperR.getYCoord2()+FlipperR.getYCoord1())/(FlipperR.getXCoord2()-FlipperR.getXCoord1())); //calculate slope of right flipper
    float constant = pinYCoordR+slope*FlipperR.getXCoord2(); //calculate constant of right flipper
    float xCoord = j; //set xCoord to j
    float yCoord = -j*slope+constant;//use equation of line to calculate slope
    float circleDistanceX = abs(ball.getXCoord() - xCoord);//calculate distance of ball xCoord to the xCoord of the right flipper (line)
    float circleDistanceY = abs(ball.getYCoord() - yCoord);//calculate distance of ball xCoord to the yCoord of the right flipper (line)
    if (((circleDistanceX <= (ball.getDiameter()/2))) && ((circleDistanceY <=(ball.getDiameter()/2)))) {//check the distance from the line to the ball using half the diameter
      rollFlagR = false;
      rollFlagL = false;
      //set triagngle rolling flags to false
      if (slope<0) {//if slope less than 0 (since it's a negative slope on the right flipper) execute the below
        rollPinL = false;//set flipper rolling flag to false
        rollPinR = false;
        //set flipper rolling flags to false
        ball.hit("bounce");//bounce in ball class hit method executes
        break;//break out of loop
      } else if (slope==0) {//if slope is 0 or flipper right is flat execute the below
        rollPinR = true;//set flipper roll to true
        break;//break out of loop
      }
    }
    j--;//decrement j
  }
}

void rollPinL() {//rolling on left flipper method
  if (rollPinL == true && rollFlagR==false) {//as long as rolling on flipper is true and rolling on triangle is false, execute the below
    ball.hit("RollAlongLeftPin");//executes ball class hit method "rollingalongleftPin" to roll the ball on the left flipper
    if (ball.getXCoord()>FlipperL.getXCoord2()) {//if the ball coord is greater than the max X coord of the left flipper
      rollPinL = false; //set rolling on left flipper to false
      ballDrop = true; //set ballDrop flag to true
    }
  }
}

void rollPinR() { //rolling on right flipper method
  if (rollPinR == true && rollFlagR==false) {//as long as rolling on flipper is true and rolling on triangle is false, execute the below
    //executes ball class hit method "rollingalongRightPin" to roll the ball on the right flipper
    ball.hit("RollAlongRightPin"); //executes ball class hit method "rollingalongleftPin" to roll the ball on the right flipper
    if (ball.getXCoord()<FlipperR.getXCoord2()) { //if the ball coord is less than the max X coord of the right flipper
      rollPinR = false; //set rolling on left flipper to false
      ballDrop = true; //set ballDrop flag to true
    }
  }
}  


void triangleCollision(boolean rollL, boolean rollR, float xCoord1, float yCoord1, float xCoord2, float yCoord2) {  //triangleCollison method (used of left and right triangle collisions)
  int i;//set i as integer
  int max = int(xCoord2);//initialise max as max xcooord of triangle
  for (i = int(xCoord1); i<=max; i++) { //for loop cyles through i from xCoord1 to xCoord2 (max)
    float slope = ((-yCoord2+yCoord1)/(xCoord2-xCoord1)); // slope of triangle
    float constant = yCoord1+slope*xCoord1;//constant of triangle
    float xCoord = i;//set xCoord as i
    float yCoord = -i*slope+constant; //set yCoord as result of equation of line
    float circleDistanceX = abs(ball.getXCoord() - xCoord);//calculate distnace from ball center to line (x axis)
    float circleDistanceY = abs(ball.getYCoord() - yCoord); //calculate distnace from ball center to line (y axis)
    if (((circleDistanceX <= (ball.getDiameter()/2))) && ((circleDistanceY <= (ball.getDiameter()/2)))) {
      //if distance from circle on y and x is less than half the ball diameter execute the below
      rollFlagR = rollR;
      rollFlagL = rollL;
      //set roll flags depending if it is a left or right triangle
      break;
      //break out from for loop
    }
    //i++;
  }
}
void triangleRollR(String collisionDec) {//rolling on triangle right
  if (rollFlagR==true && ball.getYCoord()<=544) {//as long as rolling on triangle is true and not at the bottom of the triangle the below will execute
    ball.hit(collisionDec);//execute ball class hit method depending on the collision used
    if (ball.getYCoord()>544) {//if it rolls to the bottom of the triangle execute the below
      rollFlagR=false;
      rollPinR=true;
      //set roll triangle flag to false
      //set rolling on flipper triangle to true
    }
  }
}


void triangleRollL(String collisionDec) {//rolling on triangle right
  if (rollFlagL==true && ball.getYCoord()<=544) {//as long as rolling on triangle is true and not at the bottom of the triangle the below will execute
    ball.hit(collisionDec);//execute ball class hit method depending on the collision used
    if (ball.getYCoord()>544) {//if it rolls to the bottom of the triangle execute the below
      rollFlagL=false;
      rollPinL=true;
      //set roll triangle flag to false
      //set rolling on flipper triangle to true
    }
  }
}
