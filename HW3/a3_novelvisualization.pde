import java.util.Random;

color[] colorPallete = {#80d367,#6675d3, #d15a6a};
PFont Font;
int cur_x = 0;
int cur_y= 32;
int max_x = 700;
int max_y = 600;

String[] lines;
int numWords;
int space = 10;
boolean pageFilled = false;

void setup(){
  size(700, 600);
  lines = loadStrings("uniquewords.txt");
  numWords = lines.length;
  Font = createFont("Quicksand_Dash.otf", 32);
  textFont(Font);
  background(240);
}

void draw(){
  fillPage();
}

//function for clicking canvas/saving words
void mouseClicked(){
  background(240);
  pageFilled = false;
  cur_x = 0;
  cur_y= 32;
  fillPage();
}

//array for uniquewords.txt
float wordSize(String word){
  int wordWidth = 0;
  for(int i = 0; i<word.length(); i++){
    char c = word.charAt(i);
    wordWidth += textWidth(c);
  }
  wordWidth += space;
  return wordWidth;
}

color pickColor(String word){
  if(word.charAt(0) < 'h'){
    return colorPallete[0];
  }
  else if(word.charAt(0) > 'h' && word.charAt(0) < 'q'){
    return colorPallete[1];
  }
  else{
    return colorPallete[2];
   }
}

void fillPage(){
  while(!pageFilled){
    Random rand = new Random();
    int n = rand.nextInt(numWords);
    String curWord = (lines[n]);
    fill(pickColor(curWord));
    float lenWord = wordSize(curWord);
    if(lenWord > max_x - cur_x){
      cur_x = 0;
      cur_y += 32;
    }
    if(cur_y > max_y){
      pageFilled = true;
    }
    if(!pageFilled){
      text(curWord, cur_x, cur_y);
      cur_x += lenWord + space;
    }
  }   
}
