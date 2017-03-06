import processing.serial.*;

Serial myPort;                       // The serial port
float value;
String[] message=new String[5];

int num=5;
PFont[] pf=new PFont[num];

String[] letters14 = {"A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f", "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l", "M", "m", "N", "n", "O", "o", "P", "p", "Q", "q", "R", "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X", "x", "Y", "y", "Z", "z"};
String[] letters2 = {"A", "B", "e", "f", "h", "i", "L", "l", "o", "m", "n", "P", "r", "R", "s", "t", "y", "z"};
String[] letters3 = {"a", "C", "e", "f", "h", "i", "I", "J", "l", "n", "O", "o", "P", "s", "p", "q", "e", "T", "t", "u"};
String[] letters5 = {"A", "B", "E", "G", "H", "I", "N", "R", "S", "T", "U"};

Cockpit[] units1, units2, units3, units4, units5;

float angle = 0.0;
int opacity = 0;
int numOfWords14 = letters14.length;
int numOfWords2 = letters2.length;
int numOfWords3 = letters3.length;
int numOfWords5 = letters5.length;
int i;

boolean draw1, draw2, draw3, draw4, draw5;

void setup() {
  fullScreen();
  fill(0);

  pf[0]=loadFont("Helvetica.vlw");
  pf[1]=loadFont("LucidaBlackletter.vlw");
  pf[2]=loadFont("Coquette_Bold.vlw");
  pf[3]=loadFont("Sirba.vlw");
  pf[4] = loadFont("FTYIRONRIDERNCV-48.vlw");

  // Print a list of the serial ports for debugging purposes
  // if using Processing 2.1 or later, use Serial.printArray()
  //println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);

  units1 = new Cockpit[numOfWords14];
  units2 = new Cockpit[numOfWords2];
  units3 = new Cockpit[numOfWords3];
  units4 = new Cockpit[numOfWords14];
  units5 = new Cockpit[numOfWords5];

  for (i = 0; i < numOfWords14; i++) {
    units1[i] = new Cockpit(width/2, height/2, 1600, 27, i, int(random(45, 255)), 1);
  }
  for (i = 0; i < numOfWords2; i++) {
    units2[i] = new Cockpit(width/2, height/2, 1600, 27, i, int(random(45, 255)), 2);
  }
  for (i = 0; i < numOfWords3; i++) {
    units3[i] = new Cockpit(width/2, height/2, 1600, 27, i, int(random(45, 255)), 3);
  }
  for (i = 0; i < numOfWords14; i++) {
    units4[i] = new Cockpit(width/2, height/2, 1600, 27, i, int(random(45, 255)), 4);
  }
  for (i = 0; i < numOfWords5; i++) {
    units5[i] = new Cockpit(width/2, height/2, 1600, 27, i, int(random(45, 255)), 5);
  }

  frameRate(10);

  draw1=false;
  draw2=false;
  draw3=false;
  draw4=false;
  draw5=false;
}
void draw() {
  background(255);
  serialEvent();

  if (draw1==true) {
    for (i = 0; i < numOfWords14; i++) {
      units1[i].positionWord();
    }
  }else if (draw2==true) {
    for (i = 0; i < numOfWords2; i++) {
      units2[i].positionWord();
    }
  }else if (draw3==true) {
    for (i = 0; i < numOfWords3; i++) {
      units3[i].positionWord();
    }
  }else if (draw4==true) {
    for (i = 0; i < numOfWords14; i++) {
      units4[i].positionWord();
    }
  }else if (draw5==true) {
    for (i = 0; i < numOfWords5; i++) {
      units5[i].positionWord();
    }
  }
  if (draw1==false && draw2==false && draw3==false && draw4==false && draw5==false) {
    for (i = 0; i < numOfWords14; i++) {
      units1[i].positionWord();
    }
    for (i = 0; i < numOfWords2; i++) {
      units2[i].positionWord();
    }
    for (i = 0; i < numOfWords3; i++) {
      units3[i].positionWord();
    }
    for (i = 0; i < numOfWords14; i++) {
      units4[i].positionWord();
    }
    for (i = 0; i < numOfWords5; i++) {
      units5[i].positionWord();
    }
  }
}

void serialEvent()
{
  // get message till line break (ASCII > 13)

  for (int i=0; i<4; i++)
  {
    message[i] = myPort.readStringUntil(13);
    if (message[0] !=null)
    {
      value = int(message[0]);
      println(value);
      if (value>0) {
        if (draw1==false) {
          draw1=true;
        } else {
          draw1=false;
        }
      }
    }
    if (message[1] !=null)
    {
      value = int(message[1]);
      println(value);
      if (value>0) {
        if (draw2==false) {
          draw2=true;
        } else {
          draw2=false;
        }
      }
    }
    if (message[2] !=null)
    {
      value = int(message[2]);
      println(value);
      if (value>0) {
        if (draw3==false) {
          draw3=true;
        } else {
          draw3=false;
        }
      }
    }
    if (message[3] !=null) {
      value = int(message[3]);
      println(value);
      if (value>0) {
        if (draw4==false) {
          draw4=true;
        } else {
          draw4=false;
        }
      }
    }
    if (message[4] !=null) {
      value = int(message[4]);
      println(value);
      if (value>0) {
        if (draw5==false) {
          draw5=true;
        } else {
          draw5=false;
        }
      }
    }
  }
}

class Cockpit {
  int    numOfWord, typenum;
  float  remainingWidth, yCenter, xCenter, speed, myColor, xWord, yWord, wordPositionAngle, diameter, orbitingSpeed, myCurrentWidth, fontSize, speedBackUp, myFinalWidth, offset, nOffset;
  String myWord;

  Cockpit(int _xCenter, int _yCenter, int _myFinalWidth, int _maxSpeed, int _numOfWord, int _color, int _typenum) {
    myFinalWidth = _myFinalWidth;
    myColor = _color;
    speed = random(4, _maxSpeed);                 //FINAL SPEED SETTER
    speedBackUp = _maxSpeed;
    fontSize = 4;
    numOfWord = _numOfWord;
    myCurrentWidth = 0;
    typenum=_typenum;
    if (typenum==1) {
      myWord = letters14[numOfWord];
    }
    if (typenum==2) {
      myWord = letters2[numOfWord];
    }
    if (typenum==3) {
      myWord = letters3[numOfWord];
    }
    if (typenum==4) {
      myWord = letters14[numOfWord];
    }
    if (typenum==5) {
      myWord = letters5[numOfWord];
    }

    calculateOffset();
  }

  void calculateOffset() {
    wordPositionAngle = random(0, TWO_PI);
    nOffset = random(0, 165);
    remainingWidth = myFinalWidth - nOffset;
    xCenter = width/2 + (cos(wordPositionAngle) * nOffset);
    yCenter = height/2 + (sin(wordPositionAngle) * nOffset);
  }

  float expandOrbit() {
    //ORBIT EXPANTION CONTROLLER
    if (myCurrentWidth > remainingWidth) {
      calculateOffset();
      myCurrentWidth = 0;
      myCurrentWidth = myCurrentWidth + speed;
      fontSize = 4;
      return (myCurrentWidth - speed);
    } else {
      myCurrentWidth = myCurrentWidth + speed;

      return (myCurrentWidth - speed);
    }
  }
  void positionWord() {
    diameter = expandOrbit();
    diameter = diameter/2;
    xWord = xCenter + (cos(wordPositionAngle) * diameter);
    yWord = yCenter + (sin(wordPositionAngle) * diameter);
    if (fontSize < 130 ) {
      fontSize = fontSize + (speed/10);
      fill(0, 0, 0, 255*(diameter/200));
      if (typenum==1) {
        //fill(0, 102, 153, 255*(diameter/200));
        textFont(pf[0], fontSize);
        text(myWord, xWord, yWord);
      }
      if (typenum==2) {
        textFont(pf[1], fontSize);
        text(myWord, xWord, yWord);
      }
      if (typenum==3) {
        textFont(pf[2], fontSize);
        text(myWord, xWord, yWord);
      }
      if (typenum==4) {
        textFont(pf[3], fontSize);
        text(myWord, xWord, yWord);
      }
      if (typenum==5) {
        textFont(pf[4], fontSize);
        text(myWord, xWord, yWord);
      }
    } else {
      textFont(pf[0], fontSize);
      //fill(0, 102, 153, 255*(diameter/200));
      fill(0, 0, 0, 255*(diameter/200));
      text(typenum, xWord, yWord);
      textFont(pf[1], fontSize);
      //fill(0, 102, 153, 255*(diameter/200));
      fill(0, 0, 0, 255*(diameter/200));
      text(typenum, xWord, yWord);
      textFont(pf[2], fontSize);
      //fill(0, 102, 153, 255*(diameter/200));
      fill(0, 0, 0, 255*(diameter/200));
      text(typenum, xWord, yWord);
      textFont(pf[3], fontSize);
      //fill(0, 102, 153, 255*(diameter/200));
      fill(0, 0, 0, 255*(diameter/200));
      text(typenum, xWord, yWord);
      textFont(pf[4], fontSize);
      //fill(0, 102, 153, 255*(diameter/200));
      fill(0, 0, 0, 255*(diameter/200));
      text(typenum, xWord, yWord);
    }

    return;
  }
}