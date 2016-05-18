PImage hangman;
String [] hangImage = {"00hang.png","01hang.png","02hang.png","03hang.png","04hang.png",
"05hang.png","06hang.png","07hang.png","08hang.png","09hang.png","10hang.png",
};
PFont myFont;
int numRigth = 0;
int numWrong = 0;
int winner = 0;
//escolha da palavra
String [] game = {
  "VEADAGE","OLHAELA","LOVELACE","AGITA","NUNCATEPEDINADA"
};
int answerKey = 0;
String answer = "";
char guessed[];
char wrong[];

String display = "Qual letra voce chuta?";
String display2 = "Nao se esqueça de apertar enter";
String display3 = "";
String wrongAnswers = "";

String typing = "";
String guess = "";

void setup (){
  size(600,600);
  myFont = createFont("Verdana", 20, true);
  hangman = loadImage("00hang.png");
  answerKey = int(random(0,game.length));
  answer = game[answerKey];
  winner = answer.length();
  
  char[] gameChar = new char[answer.length()];
  guessed = new char[answer.length()];
  for(int i = 0; i < answer.length(); i++){
    gameChar[i] = answer.charAt(i);
    guessed[i] = '_';
  }
  
  wrong = new char[11];
  for(int i = 0; i < 10; i ++){
    wrong[i] = '*';
  }
}

void draw(){
  background(255);
  wrongAnswers = "Letras ja ditas :";
  int indent = 25;
  display3 = "";
  
  for(int i = 0; i <10; i++)
    wrongAnswers = wrongAnswers + " " + wrong[i];
   

 image(hangman, 350, 80);
  
  textFont(myFont);
  fill(0);
  
  for(int i = 0; i <guessed.length; i++)
    display3 = display3 + " "+ guessed[i];
    
  text(display3, indent,200);
  text(display, indent,400);
  text(display2, indent,430);
  text(typing, indent,490);
  text(wrongAnswers, indent,550);
  guess = typing;
  
  if(guess.length()>1){
    //display = "Tenta mais uma letra";
    typing = "";
  }
}

void keyPressed (){
  if(key == '\n'){
    play(typing);
    typing = "";
  }else
  {
    typing = typing + key;
  }
}

void play(String guess){
  boolean guessedRight = false;
  guess = guess.toUpperCase();
  char myGuess = guess.charAt(0);
  for(int c = 0; c < answer.length(); c++){
    if(myGuess == answer.charAt(c)){
      guessed[c] = myGuess;
      numRigth += 1;
      guessedRight  = true;
      if(numRigth == winner){
        display = "Venceu!!";
        display2 = "";
      }
    }
  }
  if (guessedRight  == false){
    wrong[numWrong] = myGuess;
    numWrong +=1;
    hangman = loadImage(hangImage[numWrong]);
    if(numWrong == 10){
        display = "Morreu!!";
        display2 = "";
      }
  }
}