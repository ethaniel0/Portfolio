import java.util.*;
import java.net.*;
import java.io.*;
import java.nio.*;

// {alt, lat, long, q0, q1, q2, q3}
float[] CREW = new float[7];
float[] LAS = new float[7];
float[] BOOSTER = new float[7];
int mcTime = 0, mcEngine = 0, llaRad = 10000, textS = 18, frames = 0, centerx = 0, centery = 0, centerz = 600;

PShape las, crew, booster, ground, earth;
PImage groundTexture;
float lasheight = 23.0886, boosterheight = 2.159;
String[] file;
//                                   x/y len   z   pic x  pic y
int[] camera = {0, 0, 0}, gdCoords = {61000, 0, 2972, 2742};

float scale = 0;

void settings() {
  size((int)1800 * displayWidth/3000, (int)1800 * displayHeight/2000, P3D);
  textS = 36;
  System.setProperty("java.net.preferIPv4Stack", "true");
}

void setup() {
  las = loadShape("las.obj");
  crew = loadShape("crew.obj");
  booster = loadShape("booster.obj");
  groundTexture = loadImage("groundTexture.jpg");
  gdCoords[2] = groundTexture.width;
  gdCoords[3] = groundTexture.height;
  frameRate(200);
  lights();
  
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 0.1, cameraZ*10000.0);
 
  
  noStroke();
  earth = createShape(SPHERE, llaRad);
  earth.setTexture(groundTexture);
  
  scale = (float)llaRad/20902000;
  
}

float[] cCs = {0, 0, 0};
String abort = "";
boolean t = true;
long tm = 0;
int pEng = 0;

void draw() {
  readValues();
  background(0);
  lights();
  booster.setFill(color(40, 80, 55));
  
  pushMatrix();
    translate(width/2, height/2);

    //camera(cCs[0] - 500, cCs[1] - 426, cCs[2] - -83, 
    //    0, 0, 0, 
    //     0, 1, 0);
         
    camera(-llaRad*1.5, -llaRad*1.5, -llaRad*1.5, 
        0, 0, 0, 
         0, 1, 0);

    shape(earth);

    pushMatrix();
      float[] yrp = QuatToYRP(LAS[3], LAS[4], LAS[5], LAS[6]);
      
      if(LAS[0] < 0) LAS[0] = 0;
      
      float[] xyz = llaToXyz(LAS[2], LAS[1], LAS[0], llaRad);

      //cCs[0] = xyz[0]; 
      //cCs[1] = xyz[1]; 
      //cCs[2] = xyz[2];

      translate(xyz[0], xyz[1], xyz[2]);
      rotate(yrp[0], yrp[1], yrp[2]);
      
      rotateX(PI/6);
      
      shape(las, 0, 0);

    popMatrix();

    pushMatrix();
      yrp = QuatToYRP(CREW[3], CREW[4], CREW[5], CREW[6]);
      
      if(CREW[0] < 0) CREW[0] = 0;

      xyz = llaToXyz(CREW[2], CREW[1], CREW[0], llaRad);
      cCs[0] = xyz[0]; 
      cCs[1] = xyz[1]; 
      cCs[2] = xyz[2];

      translate(xyz[0], xyz[1], xyz[2] + 12);
      rotate(yrp[0], yrp[1], yrp[2]);
      
      rotateX(PI/6);

      shape(crew, 0, 0);
    popMatrix();

    pushMatrix();
      yrp = QuatToYRP(BOOSTER[3], BOOSTER[4], BOOSTER[5], BOOSTER[6]);

      if(BOOSTER[0] < 0) BOOSTER[0] = 0;

      xyz = llaToXyz(BOOSTER[2], BOOSTER[1], BOOSTER[0], llaRad);
      translate(xyz[0], xyz[1] + 15, xyz[2]);
      rotate(yrp[0], yrp[1], yrp[2]);
      
      rotateX(PI/6);

      shape(booster, 0, 0);
    popMatrix();


  popMatrix();

  fill(255, 255, 0);
  textSize(36);
  text("Time: " + (millis()-tm)/1000.0, 20, 40);
  text("LAS\nAlt: " + LAS[0] + "\nLat:" + LAS[1] + "\nLong:" + LAS[2], 20, 120);
  text("Crew\nAlt: " + CREW[0] + "\nLat:" + CREW[1] + "\nLong:" + CREW[2], 20, 380);
  text("Booster\nAlt: " + BOOSTER[0] + "\nLat:" + BOOSTER[1] + "\nLong:" + BOOSTER[2], 20, 620);
  String bEng = "OFF";
  if (mcEngine % 2 == 1) bEng = "ON";
  String lEng = "OFF";
  if (mcEngine > 1) lEng = "ON";
  if(pEng > 1 && mcEngine < 1) abort = "\nABORT ACTIVATED";
  pEng = mcEngine;
  text("BOOSTER ENGINE: "+ bEng + "\nLAS ENGINE: " + lEng + abort, 20, 900);

  
  
}
