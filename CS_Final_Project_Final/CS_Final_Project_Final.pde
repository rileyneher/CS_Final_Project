import processing.sound.*;
  
SoundFile file;
SoundFile gameOver;
  //put your audio file name here
String audioName = "alexander-nakarada-chase.mp3";
String audioNameGameOver = "382310__myfox14__game-over-arcade.wav";
InsertGameNameHere game;
User user;
Obstacle obstacle1;
Obstacle obstacle2;
Obstacle obstacle3;
Obstacle obstacle4;
PImage cityRoad;
PImage countryRoad;

void setup() {
  file = new SoundFile(this, audioName);
  gameOver = new SoundFile(this, audioNameGameOver);
  file.play();
  final int WIDTH = 300;
  final int LENGTH = 600;
  
  size(300, 600);
  // Parameters go inside the parentheses when the object is constructed.
  cityRoad = loadImage("Road.jpg");
  countryRoad = loadImage("Road2.png");
  
  fill(255,255,255);
  game = new InsertGameNameHere(WIDTH, LENGTH);
  user = new User(game);
  obstacle1 = new Obstacle(game);
  obstacle2 = new Obstacle(game);
  obstacle3 = new Obstacle(game);
  obstacle4 = new Obstacle(game);
  obstacle1.setSpeed(1f);
  obstacle2.setSpeed(2f);
  obstacle3.setSpeed(3f);
  obstacle4.setSpeed(4f);
  obstacle1.setNewStartingPos(100f);
  obstacle2.setNewStartingPos(175f);
  obstacle3.setNewStartingPos(250f);
  obstacle4.setNewStartingPos(275f);
}
void draw(){
  background(255);
  game.printInstructions();
  game.setTheme();
  obstacle1.display();
  obstacle2.display();
  obstacle3.display();
  obstacle4.display();
  obstacle1.moveObstacles(user);
  obstacle2.moveObstacles(user);
  obstacle3.moveObstacles(user);
  obstacle4.moveObstacles(user); // Save the current time to restart the timer!
  user.moveUser();
  user.isHit(obstacle1, game, gameOver);
  user.isHit(obstacle2, game, gameOver); 
  user.isHit(obstacle3, game, gameOver);
  user.isHit(obstacle4, game, gameOver);
  }
  
class InsertGameNameHere {
  String theme;
  int background;
  int startingX;
  int startingY;
  float currentPosX;
  float currentPosY;
  final int WIDTH;
  final int LENGTH;
  float speed;
  String scoreFormat;
  

  InsertGameNameHere(int w, int l) {
    
    this.WIDTH = w;
    this.LENGTH = l;
  }
  void setTheme() {
      if (key == 'a' || key == 'A') {
        this.theme = "Theme 1";
        background(cityRoad);
        game.printInstructions();
      }
      else if (key == 'b' || key == 'B') {
        this.theme = "Theme 2";
        background(countryRoad);
        game.printInstructions();
      }
      else if (keyCode == LEFT ||  keyCode == RIGHT || keyCode == UP || keyCode == DOWN) {
        if (this.theme == "Theme 1") {
          background(cityRoad);
          game.printInstructions();
        }
        else if (this.theme == "Theme 2") {
          background(countryRoad);
          game.printInstructions();
        }
      }
  }
  void printInstructions() {
    textSize(15);
    fill(0,0,0);
    textAlign(LEFT);
    text("Press 'A' for city streets \nPress 'B' for country roads \nScore = " + user.scoreFormat + " miles", 0, 20);
  }
  
  // Display “Game Over” and the final score
  void gameOver(User user, SoundFile gameOver) {
    gameOver.play();
    textSize(20);
    fill(255,0,0);
    textAlign(RIGHT);
    text("GAME OVER" + "\nScore = " + user.scoreFormat + " miles", 200, 300);
    exit();
    delay(3000);
  }
}





class User extends InsertGameNameHere{
 
  private String userName;
  SoundFile gameOver;
  
  float score;
  
  User(InsertGameNameHere game){
    
    super(300, 600);
  
    this.theme = theme;
    
    //##################################//
    // WHAT ARE WE USING BACKGROUND FOR?//
    //##################################//
    this.background = background;
    
    //####################################################//
    // NEED TO USE CONSTANT VARIABLES FOR BOARD DIMENSIONS//
    //####################################################//
    this.startingX = game.WIDTH/2;
    
    this.startingY = game.LENGTH-(game.LENGTH/8);
    
    this.currentPosX = this.startingX;
    
    this.currentPosY = this.startingY;
    
    this.speed = 5f;
  
  }
  
  void display() {
    stroke(0);
    fill(this.background);
    rectMode(CENTER);
    rect(this.currentPosX, this.currentPosY, 50, 75);
  }
  
 
  
  // CHANGES TO PARAMETERS BEING PASSED
  void isHit(Obstacle obstacle, InsertGameNameHere game, SoundFile gameOver){
    float userLeft = (this.currentPosX - game.WIDTH/12);
    float userRight = (this.currentPosX + game.WIDTH/12);
    float userTop = (this.currentPosY - game.LENGTH/16);
    float userBottom = (this.currentPosY + game.LENGTH/16);
    float obstacleRight, obstacleLeft, obstacleTop, obstacleBottom;
    
    obstacleLeft = obstacle.currentPosX - (game.WIDTH/12);
    obstacleRight = obstacle.currentPosX + (game.WIDTH/12);
    obstacleTop = obstacle.currentPosY - (game.LENGTH/16);
    obstacleBottom = obstacle.currentPosY + (game.LENGTH/16);

    if(((userLeft == obstacleRight) || (userRight == obstacleLeft)) && ((userTop < obstacleBottom) && (userBottom > obstacleTop))) game.gameOver(this, gameOver);
    
    if(((userTop == obstacleBottom) || (userBottom == obstacleTop)) && ((userRight > obstacleLeft) && (userLeft < obstacleRight))) game.gameOver(this, gameOver);
    
    else if((this.currentPosY > obstacle.currentPosY) && ((userTop - obstacle.currentPosY) < (game.LENGTH/16)) && ((userRight > obstacleLeft) && (userLeft < obstacleRight))) game.gameOver(this, gameOver);
    
    else if(((this.currentPosY < obstacle.currentPosY) && (obstacleTop - this.currentPosY) < (game.LENGTH/16)) && ((userRight > obstacleLeft) && (userLeft < obstacleRight))) game.gameOver(this, gameOver);
    
    //{
      
    //  obstacleTop = obstacle.currentPosY - (game.LENGTH/4);
    //  obstacleBottom = obstacle.currentPosY + (game.LENGTH/4);
      
    //  if((userTop < obstacleBottom) || (userBottom > obstacleTop)) game.gameOver(this);
      
    //else{
    //  obstacleLowerYRange = obstacle.currentPosY - (LENGTH/5);
    //  obstacleUpperYRange = obstacle.currentPosY + (LENGTH/5);
      
    //  if((userLowerYRange > obstacleUpperYRange) && (userUpperYRange < obstacleLowerYRange)) null;
      
    //  // CHANGE HERE//
    //  // THE GAME OVER FUNCTION IS CALLED WHNE THE GAME IS OVER,
    //  //NO NEED TO HAVE IT DO ANY PROCESSING TO CHECK IF GAME IS OVER. 
    //  else game.gameOver(this);          
    //}
    
  }   

  
  // No need for speed input, saved in object.
  void moveUser(){
    
    // check if arrow keys are pressed and which one to perform a specific action 
    if ( keyPressed && key == CODED ){
      
      if (keyCode == LEFT) this.currentPosX -= this.speed;
      
      else if (keyCode == RIGHT) this.currentPosX += this.speed;
        
      else if (keyCode == UP) this.currentPosY -= this.speed;
      
      else if (keyCode == DOWN) this.currentPosY += this.speed;

      // check for boundries
      if (this.currentPosX < (game.WIDTH/12)) this.currentPosX = (game.WIDTH/12);
      
      if (this.currentPosX > game.WIDTH-(game.WIDTH/12)) this.currentPosX = game.WIDTH-(game.WIDTH/12);
      
      if (this.currentPosY < game.LENGTH/16) this.currentPosY = LENGTH/16;
      
      if (this.currentPosY > game.LENGTH-(game.LENGTH/16)) this.currentPosY = game.LENGTH-(game.LENGTH/16);
     
    }
    
    this.display();
   
  }
  
}






class Obstacle {
  private float currentPosY;
  private float currentPosX;
  private int obstacleWidth;
  private int obstacleLength;
  private float speed;
  private String scoreFormat;
  
    Obstacle (InsertGameNameHere game) {
      
      this.currentPosY = 0;
      this.obstacleWidth = game.WIDTH/6;
      this.obstacleLength = game.LENGTH/8;
      
    }
    // method used only for setting the size of the window
    
    void setSpeed(float speed) {
      this.speed = speed;
    }
    
    void setNewStartingPos(float xPos) {
      this.currentPosX = xPos;
    }
    
    void display(){
      
//    this draws a rectangle with both sides equal to 10 
//    (that makes it a square) at a randomly generated x,y coordinates;
//      the method random(0,500) generates a random number from 0 to 500
    rect (this.currentPosX, this.currentPosY, obstacleWidth, obstacleLength);
    
    }
    // identical use to draw in Processing IDE
    //void draw() {
    //background(255);
    //this.display();
    //this.moveObstacles();
    //}
    
    void moveObstacles(User user) {
      this.currentPosY += this.speed;
      
      if (this.isAtBottom()) {
        this.currentPosY = 0;
        this.setNewStartingPos((float) (int)(Math.random() * 300) / 10 * 10);
      }
      
      user.score += this.speed/1000;
      user.scoreFormat = nf(user.score,1,0);
    }
    
    boolean isAtBottom() {
      if (this.currentPosY > 600) {
        return true;
      } else {
        return false;
      }
    }
}
