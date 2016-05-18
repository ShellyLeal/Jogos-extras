boolean showTitleScreen = true;


boolean playing = false;
boolean playing2 = false;

boolean gameOver = false;

float playerOneX = 25;
float playerOneY = 250;
float playerOneWidth = 10;
float playerOneHeight = 50;

float playerTwoX = 465;
float playerTwoY = 250;
float playerTwoWidth = 10;
float playerTwoHeight = 50;

float paddleSpeed = 5;

boolean upPressed = false;
boolean downPressed = false;
boolean wPressed = false;
boolean sPressed = false;

int playerOneScore = 0;
int playerTwoScore = 0;

float ballX = 250;
float ballY = 250;
float radius = 10;
float ballDeltaX = -1;
float ballDeltaY = 3;

void setup() {
  size(500, 500);

  ellipseMode(CENTER);
  ellipseMode(RADIUS);
  
  //draw with white
  stroke(255, 255, 255);
}

void keyPressed() {
  if (showTitleScreen) {
    if (key == 'P' || key == 'p') {
      showTitleScreen = false;
      playing = true;
    }
    if(key == 'F' || key == 'f'){
    showTitleScreen = false;
      playing2 = true;
    }
  }
  else if (playing) {
    if (key == CODED) {
      if (keyCode == UP) {
        upPressed = true;
      }
      else if (keyCode == DOWN) {
        downPressed = true;
      }
    }
    else if (key == 'W' || key == 'w') {
      wPressed = true;
    }
    else if (key == 'S' || key == 's') {
      sPressed = true;
    }
  }
    
  else if (gameOver) {
    if (key == ' ') {
      gameOver = false;
      showTitleScreen = true;
      playerOneY = 250;
      playerTwoY = 250;
      ballX = 250;
      ballY = 250;
      playerOneScore = 0;
      playerTwoScore = 0;
    }
  }
}

void keyReleased() {
  if (playing) {
    if (key == CODED) {
      if (keyCode == UP) {
        upPressed = false;
      }
      else if (keyCode == DOWN) {
        downPressed = false;
      }
    }
    else if (key == 'W' || key == 'w') {
      wPressed = false;
    }
    else if (key == 'S' || key == 's') {
      sPressed = false;
    }
  }
}

void draw() {
  if (showTitleScreen) {
    background(0, 0, 0);

    textSize(36);
    text("Pong", 165, 100);

    textSize(18);
    text("Press 'P' to play pong. \n Press 'Q' to play extra.", 175, 400);
  }
  else if (playing) {
    background(0, 0, 0);

    if (upPressed) {
      if (playerOneY-paddleSpeed > 0) {
        playerOneY -= paddleSpeed;
      }
    }
    if (downPressed) {
      if (playerOneY + paddleSpeed + playerOneHeight < height) {
        playerOneY += paddleSpeed;
      }
    }
    if (wPressed) {
      if (playerTwoY-paddleSpeed > 0) {
        playerTwoY -= paddleSpeed;
      }
    }
    if (sPressed) {
      if (playerTwoY + paddleSpeed + playerTwoHeight < height) {
        playerTwoY += paddleSpeed;
      }
    }

    float nextBallLeft = ballX - radius + ballDeltaX;
    float nextBallRight = ballX + radius + ballDeltaX;
    float nextBallTop = ballY - radius + ballDeltaY;
    float nextBallBottom = ballY + radius + ballDeltaY;

    float playerOneRight = playerOneX + playerOneWidth;
    float playerOneTop = playerOneY;
    float playerOneBottom = playerOneY + playerOneHeight;

    float playerTwoLeft = playerTwoX;
    float playerTwoTop = playerTwoY;
    float playerTwoBottom = playerTwoY + playerTwoHeight;
    
    //ball bounces off top and bottom of screen
    if (nextBallTop < 0 || nextBallBottom > height) {
      ballDeltaY *= -1;
    }

    //will the ball go off the left side?
    if (nextBallLeft < playerOneRight) { 
      //is it going to miss the paddle?
      if (nextBallTop > playerOneBottom || nextBallBottom < playerOneTop) {
        playerTwoScore ++;

        if (playerTwoScore == 3) {
          playing = false;
          gameOver = true;
        }

        ballX = 250;
        ballY = 250;
      }
      else {
        ballDeltaX *= -1;
      }
    }

    //will the ball intersect player two?
    if (nextBallRight > playerTwoLeft) {
      //is it going to miss the paddle?
      if (nextBallTop > playerTwoBottom || nextBallBottom < playerTwoTop) {
        playerOneScore ++;

        if (playerOneScore == 3) {
          playing = false;
          gameOver = true;
        }

        ballX = 250;
        ballY = 250;
      }
      else {
        ballDeltaX *= -1;
      }
    }

    ballX += ballDeltaX;
    ballY += ballDeltaY;

    //draw dashed line down center
    for (int lineY = 0; lineY < height; lineY += 50) {
     line(250, lineY, 250, lineY+25);
    }
    
    //draw "goal lines" on each side
    line(playerOneRight, 0, playerOneRight, height);
    line(playerTwoLeft, 0, playerTwoLeft, height);

    textSize(36);
    text(playerOneScore, 100, 100);
    text(playerTwoScore, 400, 100);

    rect(playerOneX, playerOneY, playerOneWidth, playerOneHeight);
    rect(playerTwoX, playerTwoY, playerTwoWidth, playerTwoHeight);
    ellipse(ballX, ballY, radius, radius);
  }
  else if(playing2){}
  
  
  else if (gameOver) {
    background(0, 0, 0);

    textSize(36);
    text(playerOneScore, 100, 100);
    text(playerTwoScore, 400, 100);

    textSize(36);
    if (playerOneScore > playerTwoScore) {
      text("Player 1 Wins!", 165, 200);
    }
    else {
      text("Player 2 Wins!", 165, 200);
    }

    textSize(18);
    text("Press space to restart.", 150, 400);
  }
}