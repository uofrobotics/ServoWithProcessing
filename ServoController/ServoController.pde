// base code

import processing.serial.*;

import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import cc.arduino.*;
import org.firmata.*;

ControlDevice URbtxLtechCtrlr;
ControlIO URbtxcontrol;

Arduino URbtxUnoR3;

float analogStick;
float otherAnalogStick;

void setup()
{
 size(300, 200);
 
 URbtxcontrol =  ControlIO.getInstance(this);
 //URbtxLtechCtrlr = URbtxcontrol.getMatchedDevice("URbtxLtechServoMvr");
 //URbtxLtechCtrlr = URbtxcontrol.getMatchedDevice("URbtxLtechServoMvr2"); 
 URbtxLtechCtrlr = URbtxcontrol.getMatchedDevice("TwoServoCtrl");
 
 if(URbtxLtechCtrlr == null){
   println("Controller not connected");
   System.exit(-1);
 }
   
   // uncomment the line below to print a list of the connected arduinos.
   // println(Arduino.list());
      URbtxUnoR3 = new Arduino(this, Arduino.list()[1], 57600);
      URbtxUnoR3.pinMode(10, Arduino.SERVO);
      URbtxUnoR3.pinMode(9, Arduino.SERVO);
      
}

public void getUserInput() {
  analogStick = map(URbtxLtechCtrlr.getSlider("servoPos").getValue(), -1, 1, 0, 180);
  otherAnalogStick = map(URbtxLtechCtrlr.getSlider("servoPos2").getValue(), 1, 1, 0, 180);
  
}

void draw() {
  getUserInput();
  background(analogStick, 200, 150);
  background(otherAnalogStick, 200, 150);
  
  URbtxUnoR3.servoWrite(10, (int)analogStick);
  URbtxUnoR3.servoWrite(9, (int)otherAnalogStick);
}
