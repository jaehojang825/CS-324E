PImage img;
PImage img2;

void setup() {
  
  //loading image
  surface.setResizable(true); 
  img = loadImage("Doggo.jpg");
  surface.setSize(img.width, img.height);
  
  //copy of the original image
  img2 = createImage(img.width, img.height, ARGB);
  img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
}

void draw() {
  image(img2, 0, 0);
  
  //user presses 1
  if ((keyPressed == true) && (key == '1')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    img2.loadPixels();
    //loop through every pixel column
    for (int x = 0; x < width; x++) {
      //loop through every pixel row
      for (int y = 0; y < height; y++) {
        //use formula to find 1D index
        int ind = x + y * width;
      
        //pull out the 3 colors
        float red = red(img2.pixels[ind]);
        float green = green(img2.pixels[ind]);
        float blue = blue(img2.pixels[ind]);
      
        //average across pixels
        int gray = (int)(red+green+blue)/3;
      
        //set pixel to grayscale
        img2.pixels[ind] = color(gray);
      }
    }
    img2.updatePixels();
  }
  

  //user presses 2
  //calculate brigtness of each pixel and find appropriate average
  int average = 65;

  if ((keyPressed == true) && (key == '2')) {
    colorMode(HSB);
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    
    img2.loadPixels();
    //loop through every pixel column
    for (int x = 0; x < width; x++) {
      //loop through every pixel row
      for (int y = 0; y < height; y++) {
        //use formula to find index
        int ind = x + y * width;
      
        //pull out the 3 components
        float hue = hue(img2.pixels[ind]);
        float satur = saturation(img2.pixels[ind]);
        float bright = brightness(img2.pixels[ind]);
        
        //if pixel's brigthness above average, increase brightnes to pixel
        if (bright > average) { 
          bright += 20;
        }
        
        //else, drop brightness
        else if (bright < average) { 
          bright -= 20;
        }
        hue = constrain(hue, 0, 100);
        satur = constrain(satur, 0, 100);
        bright = constrain(bright, 0, 100);
        
        //set pixel to new component
        img2.pixels[ind] = color(hue, satur, bright);
      }
    }
    img2.updatePixels();
    colorMode(RGB);
  }
  
  //user press 0
  //create copy of original image and return to the copied image
  if ((keyPressed == true) && (key == '0')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
  }

  //user presses 3
  //pixel manipulation; buffer created to prevent changes in neighbor pixels
  //parameters of 0.25, 0.125, and 0.0625
  if ((keyPressed == true) && (key == '3')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    PImage buffer = loadImage("Doggo.jpg");
    
    buffer.loadPixels();
    img2.loadPixels();

    float[][] matrix = {
    {0.0625, 0.125, 0.0625}, {0.125, 0.25, 0.125}, {0.0625, 0.125, 0.0625}
    };

    //loop through every pixel column
    for (int x = 1; x < width - 1; x++) {
      //loop through every pixel row
      for (int y = 1; y < height - 1; y++) {
        float red = 0.0;
        float green = 0.0;
        float blue = 0.0;
        if ((x > 0) && (y > 0) && (x < img2.width - 1) && (y < img2.height - 1)) {
          //pixel traversal
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              int ind = (x + i - 1) + img2.width*(y + j - 1);
              
              //Perform convolution 3 color scheme
              red += red(img2.pixels[ind]) * matrix[i][j];
              green += green(img2.pixels[ind]) * matrix[i][j];
              blue += blue(img2.pixels[ind]) * matrix[i][j];
            }
          }
        }
        
        //red, green and blue values
        red = constrain(abs(red), 0, 255);
        green = constrain(abs(green), 0, 255);
        blue = constrain(abs(blue), 0, 255);
          
        //use formula to find index
        int index = x + y * width;
        buffer.pixels[index] = color(red, green, blue);
      }
    }
    buffer.updatePixels();
    img2.copy(buffer, 0, 0, buffer.width, buffer.height, 0, 0, img2.width, img2.height);
    
    image(buffer, 0, 0);
  }

  //user press 4
  //2 sobel operators
  //update pixel value based on operator to take magnitude for final convolution value
  //buffers applied
  if ((keyPressed == true) && (key == '4')) {
    img2.copy(img, 0, 0, img.width, img.height, 0, 0, img2.width, img2.height);
    PImage buffer = loadImage("Doggo.jpg");
    //image(img2, 0, 0);
    
    buffer.loadPixels();
    img2.loadPixels();

    float[][] matrixH = {
    {-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}
    };
    
    float[][] matrixV = {
    {-1, -2, -1}, {0, 0, 0}, {1, 2, 1}
    };

    //loop through every pixel column
    for (int x = 1; x < width - 1; x++) {
      //loop through every pixel row
      for (int y = 1; y < height - 1; y++) {
        //intial vertical/horizontal pixels declared
        float redV = 0.0;
        float greenV = 0.0;
        float blueV = 0.0;
        
        float redH = 0.0;
        float greenH = 0.0;
        float blueH = 0.0; 
        
        if ((x > 0) && (y > 0) && (x < img2.width - 1) && (y < img2.height - 1)) {
          //Code to access individual pixel location (x, y)
          for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
              int index = (x + i - 1) + img2.width*(y + j - 1);
              
              //Perform convolution on vertical red, green and blue color channels
              redV += red(img2.pixels[index]) * matrixV[i][j];
              greenV += green(img2.pixels[index]) * matrixV[i][j];
              blueV += blue(img2.pixels[index]) * matrixV[i][j];

              //Perform convolution on horizontal red, green and blue color channels
              redH += red(img2.pixels[index]) * matrixH[i][j];
              greenH += green(img2.pixels[index]) * matrixH[i][j];
              blueH += blue(img2.pixels[index]) * matrixH[i][j];
            }
          }
        }
        
        //red, green and blue values
        redV = constrain(abs(redV), 0, 255);
        greenV = constrain(abs(greenV), 0, 255);
        blueV = constrain(abs(blueV), 0, 255);
 
        redH = constrain(abs(redH), 0, 255);
        greenH = constrain(abs(greenH), 0, 255);
        blueH = constrain(abs(blueH), 0, 255); 
        
        //Gradient magnitude calculations
        float redNew = sqrt(pow(redV, 2) + pow(redH, 2));
        float greenNew = sqrt(pow(greenV, 2) + pow(greenH, 2));
        float blueNew = sqrt(pow(blueV, 2) + pow(blueH, 2));
          
        //use formula to find index
        int index = x + y * width;
        buffer.pixels[index] = color(redNew, greenNew, blueNew);
      }
    }
    buffer.updatePixels();
    img2.copy(buffer, 0, 0, buffer.width, buffer.height, 0, 0, img2.width, img2.height);
    
    image(buffer, 0, 0);
  }
}
 
