import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;     // Data received from the serial port
PImage plazamap, success_macys, fir_macys;
PImage fir_sears, sears_success, sears_info;  
PImage fir_jcpenny, jcpenny_success;
PImage fir_nordstrom, nordstrom_failure, nordstrom_success;
boolean plaza=true;
boolean macys=false;
boolean jcpenny=false;
boolean nordstrom=false;
boolean sears=false;
boolean success=false;
boolean failure=false;
boolean personalInfo=false;

void setup()
{
  smooth();
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  //println(Serial.list());
  size(1092, 720);
  //fullScreen();

  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  plazamap=loadImage("map.jpg");

  success_macys=loadImage("macys_success.jpg");
  fir_macys=loadImage("macys.jpg");

  fir_sears=loadImage("sears.jpg");
  sears_success=loadImage("sears_success.jpg");
  sears_info=loadImage("sears_info.jpg");

  fir_jcpenny=loadImage("jcpenney.jpg");
  jcpenny_success=loadImage("jcpenny_success.jpg");

  fir_nordstrom=loadImage("nordstrom.jpg");
  nordstrom_failure=loadImage("nordstrom_failure.jpg");
  nordstrom_success=loadImage("nordstrom_success.jpg");
}

void draw()
{
  if (plaza==true) {
    image(plazamap, 0, 0, width, height);
  }
  val=myPort.read();

  //------macys------
  if (macys==true && success==false) {
    image(fir_macys, 0, 0, width, height);
  }

  if (macys==true && success==true) {
    image(success_macys, 0, 0, width, height);
  }
  //-----------------

  //------jcpenny------
  if (jcpenny==true && success==false) {
    image(fir_jcpenny, 0, 0, width, height);
  }

  if (jcpenny==true && success==true) {
    image(jcpenny_success, 0, 0, width, height);
  }
  //-----------------

  //------norstrom------
  if (nordstrom==true && success==false) {
    image(fir_nordstrom, 0, 0, width, height);
  }
  if (nordstrom==true && failure==true) {
    image(nordstrom_failure, 0, 0, width, height);
  }
  if (nordstrom==true && success==true) {
    image(nordstrom_success, 0, 0, width, height);
  }
  //-----------------

  //------sears------
  if (sears==true && success==false) {
    image(fir_sears, 0, 0, width, height);
  }

  if (sears==true && personalInfo==true) {
    image(sears_info, 0, 0, width, height);
    if (success==true) {
      image(sears_success, 0, 0, width, height);
    }
  }
  //-----------------

  //---scan a tag---
  if (val==1) {
    println("fail");
    success=false;
    failure=true;
  }
  if (val==0) {
    success=true;
    println("success");
  }
  if (val==2) {
    personalInfo=true;
    image(sears_info, 0, 0, width, height);
    plaza=false;
  }
  //------------------
}

void mousePressed() {
  if (plaza==true && mouseX>527 && mouseX<710 && mouseY>268 && mouseY<328) {
    macys=true;
    plaza=false;
  }
  if (plaza==true && mouseX>899 && mouseX<1060 && mouseY>117 && mouseY<262) {
    sears=true;
    plaza=false;
  }
  if (plaza==true && mouseX>28 && mouseX<169 && mouseY>340 && mouseY<496) {
    nordstrom=true;
    plaza=false;
  }
  if (plaza==true && mouseX>907 && mouseX<1035 && mouseY>386 && mouseY<505) {
    jcpenny=true;
    plaza=false;
  }

  if (macys==true && mouseY>614 && mouseY<720 ) {
    macys=false;
    plaza=true;
  }
  if (macys==true && success==true) {
    macys=false;
    success=false;
    plaza=true;
  }

  if (jcpenny==true && mouseY>614 && mouseY<720 ) {
    jcpenny=false;
    plaza=true;
  }
  if (jcpenny==true && success==true) {
    jcpenny=false;
    success=false;
    plaza=true;
  }

  if (nordstrom==true && mouseY>614 && mouseY<720 ) {
    nordstrom=false;
    plaza=true;
  }
  if (nordstrom==true && success==true) {
    nordstrom=false;
    success=false;
    plaza=true;
    failure=false;
  }
  if (nordstrom==true && failure==true) {
    nordstrom=false;
    failure=false;
    plaza=true;
  }

  if (sears==true && mouseY>614 && mouseY<720 ) {
    sears=false;
    plaza=true;
  }
  if (sears==true && personalInfo==true && mouseY>614 && mouseY<720) {
    sears=false;
    personalInfo=false;
    plaza=true;
  }
}