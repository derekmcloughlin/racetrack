
/**
 * PID Controller - Following a Line. 
 * 
 * This example presents a software implementation of a PID controller that follows a 
 * white line on a dark background.
 *
 * To simulate analog sensors the line is Gaussian blurred.
 *
 */
 
// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="racetrack-1.png"; */

PImage bg;

int xpos = 80;
int ypos = 850;
float angle = 0;

color color_left;
color color_mid;
color color_right;

long proportional = 0;
long error = 0;
float integral = 0.0;
long derivative = 0;

float Kp = 0.0;
float Ki = 0.0;
float Kd = 0.0;

long previous_error = 0;

void setup() {
  size(1920, 1200);
  // The background image must be the same size as the parameters
  // into the size() method. In this program, the size of the image
  // is 650 x 360 pixels.
  bg = loadImage("racetrack-1.png");
}

void draw() {

  background(bg);

  fill(#FFFFFF);
  text("MOUSE", 25, 20);
  color c = get(mouseX, mouseY);
  fill(c);
  noStroke();
  rect(25, 25, 50, 50);
  
  ypos = ypos -1;
  

  
  // Create a red rectangle whose centre is the new origin
  noFill();
  stroke(#FF0000);  
  translate(xpos + 45, ypos + 5);
  rotate(angle);
  rect(-45, -5, 91, 11);
  
  // Need to reset translations if we want to draw something
  // at an absolute position
  resetMatrix();
  
  // Get the colour of the left sensor
  color_left = get(xpos + 30, ypos + 5);
  fill(color_left);
  noStroke();
  rect(150, 25, 50, 50);
  fill(#FFFFFF);
  text("L: " + hex(color_left, 6), 150, 20);

  // Get the colour of the middle sensor
  color_mid = get(xpos + 45, ypos + 5);
  fill(color_mid);
  noStroke();
  rect(275, 25, 50, 50);
  fill(#FFFFFF);
  text("M: " + hex(color_mid, 6), 275, 20);

  // Get the colour of the right sensor
  color_right = get(xpos + 60, ypos + 5);
  fill(color_right);
  noStroke();
  rect(400, 25, 50, 50);
  fill(#FFFFFF);
  text("R: " + hex(color_right, 6), 400, 20);
  
  // Now calculate error, proportional, integral and derivative
  delay(10);
 
  error = (color_left - color_right) / 100000;
  proportional = error;
  integral = integral + error;
  derivative = error - previous_error;
  
  float correction = Kp * proportional + Ki * integral + Kd * derivative;
  
  angle = (error * 6)/ 360;
 
  fill(#FFFFFF);
  text("A: " + str(angle), 550, 20);
  println(str(angle));

  
}
