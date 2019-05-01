final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24,soil0,soil1,soil2,soil3,soil4,soil5,stone1,stone2,life;
PImage hoglDle,hogldleDown,hogldleLeft,hogldleRight;

int hogldleX = 310,hogldleY = 80;
int hogldleW = hogldleX+80,hogldleH = hogldleY+80;
int hogldleSpeed = 5;

int soilH = 0;

boolean  downPressed, rightPressed, leftPressed;
boolean  hogDle;

int n=0,b=0;




// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  hoglDle = loadImage("img/groundhogIdle.png");
  hogldleDown = loadImage("img/groundhogDown.png");
  hogldleLeft = loadImage("img/groundhogLeft.png");
  hogldleRight = loadImage("img/groundhogRight.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  
  playerHealth = 2;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		  image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		  fill(124, 204, 25);
		  noStroke();
		  rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    pushMatrix();
    translate(0, soilH);
    
		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!

    for(int i=0; i<width; i+= 80){
      for(int n=0; n<320; n+= 80){
      image(soil0,i,160+n,80,80);
      image(soil1,i,480+n,80,80);
      image(soil2,i,800+n,80,80);
      image(soil3,i,1120+n,80,80);
      image(soil4,i,1440+n,80,80);
      image(soil5,i,1760+n,80,80);
      }
    }
    
    // Stone
    
    for(int i=0; i<width; i+= 80){
      image(stone1,i,160+i,80,80);
    }
    for(int b=0; b<width; b+=320){
      for(int i=0; i<320; i += 240){      
        image(stone1,b+80,800+i);
        image(stone1,b+160,800+i);
        image(stone1,b+80,1120+i);
        image(stone1,b+160,1120+i);
      }
    for(int i=0; i<320; i+=240){
      for(int j=0; j<560; j+=320){
        image(stone1,i,880+j);
        image(stone1,i+320,880+j);
        image(stone1,i,960+j);
        image(stone1,i+320,960+j);
      }
    for(int a=0; a<width ; a+=80){
      image(stone1,80-a,1440+a);
      image(stone1,160-a,1440+a);image(stone2,160-a,1440+a);
      image(stone1,320-a,1440+a);
      image(stone1,400-a,1440+a);image(stone2,400-a,1440+a);
      image(stone1,560-a,1440+a);
      image(stone1,560-a,1520+a);image(stone2,560-a,1520+a);
      image(stone1,560-a,1680+a);
      image(stone1,560-a,1760+a);image(stone2,560-a,1760+a);
      image(stone1,560-a,1920+a);
      image(stone1,560-a,2000+a);image(stone2,560-a,2000+a);
    }
    }

    
    }
		// Player

    if(hogDle){
    image(hoglDle,hogldleX,hogldleY,80,80);
    }
    
    if(downPressed){
      
      hogldleY += hogldleSpeed;
      leftPressed = false; rightPressed = false; hogDle = false;
      image(hogldleDown,hogldleX,hogldleY);
      if(hogldleY %80 ==0){
          downPressed = false; hogDle = true;
      if(hogldleY + hogldleH > 1920){
        hogldleY = 1920 - hogldleH;
      }
      
      }     
    }else{
      hogDle = true;
      
    if(rightPressed){
      hogldleX += hogldleSpeed;
      leftPressed = false; downPressed = false; hogDle = false;
      image(hogldleRight,hogldleX,hogldleY);
      if(hogldleX %80 ==0){
          rightPressed = false; hogDle = true;
      }
      if(hogldleX+80>width){
         hogldleX = width-80; rightPressed = false; hogDle = true;
        }
    }
    
    if(leftPressed){
      hogldleX -= hogldleSpeed;
      rightPressed = false; downPressed = false; hogDle = false;
      image(hogldleLeft,hogldleX,hogldleY);
      if(hogldleX %80 ==0){
          leftPressed = false; hogDle = true;
      }
      if(hogldleX< 0){
         hogldleX = 0; leftPressed = false; hogDle = true;
      }
    }
    }
    

		// Health UI

       if(playerHealth == 0){
         gameState = GAME_OVER;
       }
       if(playerHealth == 1){
         image(life,10,10);
       }
       if(playerHealth == 2){
         for(int a=0; a<2; a++){
         image(life,10+a*70,10);
         }
       }
         if(playerHealth == 3){
         for(int a=0; a<3; a++){
         image(life,10+a*70,10);
         }
         }
         if(playerHealth == 4){
         for(int a=0; a<4; a++){
         image(life,10+a*70,10);
         }
         }
         if(playerHealth == 5){
         for(int a=0; a<5; a++){
         image(life,10+a*70,10);
         }
         }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

    switch(keyCode){
      case DOWN:
      hogldleSpeed = 80/16;
      downPressed = true;           
      break;
      case RIGHT:
      hogldleSpeed = 80/16;
      rightPressed = true;
      break;
      case LEFT:
      hogldleSpeed = 80/16;
      leftPressed = true;
      break;
    }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}
