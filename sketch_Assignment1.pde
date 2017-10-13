/////////////////////////////////////////////////
/// Project not done in OOP design due to NPE ///
/////////////////////////////////////////////////

float x, y;
float xspeed = 7;
float yspeed = 7;
boolean clicked = false;
int score = 0;
int lives = 5;
int rad = 50;
int startTimer = millis(); // setting our timer to equal the milli seconds since program started

// States vars
int MAIN_MENU = 1;
int END_SCREEN = 2;
int state = MAIN_MENU;

void setup() {  // Set up the screen
  fullScreen();
  noStroke();
  frameRate(60);
  smooth();
  fill(255, 0, 0);
  ellipseMode(RADIUS);
  newRandomLocation(); //Chosing our first random location
}

void draw() { //render the circle or call new location func
  background(255, 192, 134);
  textSize(25);
  if (state == 1) {
    mainMenu(); //Drawing main menu at start of runtime
    if (keyCode == ENTER) {
      mainMenu(); //getting rid of menu menu after ENTER is pressed
    }
  }
  move();
  displayStats();
  endGame();
  quitGame();
  if (!clicked) { // check if circle is clicked
    ellipse(x, y, 50, 50);
  } else {
    newRandomLocation();
    loop();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////  Where the fun beings  /////////////////////////////////////////////////////////////

void newRandomLocation() { //chooses new location for circle
  x = (int)random(0, width);
  y = (int)random(0, height);
  clicked = false; // clicked set to false so circle doesnt disappear after new spawn
}

void move() { // method that allows circle to move in 2 axis, positively and negatively
  while (x >= width-rad || x <= 0) { // defining the circle to move to right
    x += xspeed;
  }
  while (y >= height-rad || y <= 0) { // defining the circle to move up
    y += yspeed;
  }
  x = x + xspeed; // defining the circle to bounce on x axis
  if (x >= width-rad || x <= 0+rad) {
    xspeed *= -1;
  } 
  y = y + yspeed; // defining the circle to bounce on y axis
  if (y >= height-rad || y <= 0+rad) {
    yspeed *= -1;
  }
}

void mousePressed() { // function for giving points
  if (dist(mouseX, mouseY, x, y) < 50) {
    score += 10;
    clicked = true;
  } else
    lives -=1;
}

void displayStats() { // method to display score
  fill(0);
  text("Lives: " + lives, (width/2) + (width/4), (height/2) + (height/3));
  text("Score: " + score, width/2 - (width/4), (height/2) + (height/3));
  float timer = (millis() - startTimer) / 1000; // we divide by 1000 to get rid of milli-second effect
  text(timer, (width/2), (height/2) + (height/3));
}

void hideCircle() { // hide the ball visually from the player
  x = -100;
  y = -100;
  xspeed = 0;
  yspeed = 0;
}

void mainMenu() { // main menu
  rect(0, 0, 10000, 10000);
  fill(198, 123, 153);
  text("Welcome to a bouncing ball game", 125, 100);
  text("Press ENTER key to play", 125, 200);
  text("Press Q key to exit game", 125, 700);
  text("Use the UP key to set game difficulty to impossible (No turning back)", 125, 300);
  if (keyCode == UP) { // increase difficulty
    xspeed += 1; //increase speed of axis
    yspeed += 1; //increase speed of axis
    fill(0, 255, 0);
    text("GAME DIFFICULTY SET TO IMPOSSIBLE", 125, 400);
  } else {
    text("GAME DIFFICULTY SET TO NORMAL", 125, 400);
  }
}

void gameTimer(int timer) { // timer method
  timer = millis();
}

void endGame() { // function for endgame
  if (lives <= 0) { // Player loses if statement
    fill(134, 134, 255);
    hideCircle();
    text("game over :(", width/2, height/2);
    textAlign(CENTER, TOP);
  }
  if (score >= 100) { // Player wins if statement
    fill(134, 134, 255);
    hideCircle();
    text("You win!", width/2, height/2);
    textAlign(CENTER, TOP);
  }
}

void quitGame() {
  if (key == 'q') { // Key to force exit application
    exit();
  }
}