import java.util.*;

PShape las, crew, booster, boosterOn, lasA1, lasA2, lasA3;

PImage groundTexture;

float lasheight = 23.0886, boosterheight = 2.159;

String[] file;

int frames = 0, centerx = 0, centery = 0, centerz = 600;
int[] camera = {0, 0, 0};

int llaRad = 10, textS = 36;

//                x/y len   z   pic x  pic y
int[] gdCoords = {61000,     0, 2972,  2742};

//                          LAS                                      CREW                                       BOOSTER
ArrayList<ArrayList<Float>> LAS = new ArrayList<ArrayList<Float>>(), CREW = new ArrayList<ArrayList<Float>>(), BOOSTER = new ArrayList<ArrayList<Float>>();
ArrayList<Float> time = new ArrayList<Float>();

void settings(){
  size((int)1800 * displayWidth/3000, (int)1800 * displayHeight/2000, P3D);
  textS = 36 * height/1800;

}

int lasNum = 0;

void setup() {
  las = loadShape("las.obj");
  //lasA1 = loadShape("lasAnim1.obj");
  //lasA2 = loadShape("lasAnim2.obj");
  //lasA3 = loadShape("lasAnim3.obj");
  crew = loadShape("crew.obj");
  booster = loadShape("booster.obj");
  //boosterOn = loadShape("boosterOn.obj");

  groundTexture = loadImage("groundTexture.jpg");
  
  gdCoords[2] = groundTexture.width;
  gdCoords[3] = groundTexture.height;

  file = loadStrings("Data.csv");


  for (String i : file) {
    String[] nums = i.split(",");
    if (!nums[0].equals("MET")) {

      time.add(Float.parseFloat(nums[0]));
      LAS.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[4]), Float.parseFloat(nums[5]), Float.parseFloat(nums[6]),Float.parseFloat(nums[0]))));
      LAS.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[14]), Float.parseFloat(nums[15]), Float.parseFloat(nums[16]), Float.parseFloat(nums[17]))));

     
      CREW.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[1]), Float.parseFloat(nums[2]), Float.parseFloat(nums[3]))));
      CREW.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[10]), Float.parseFloat(nums[11]), Float.parseFloat(nums[12]), Float.parseFloat(nums[13]))));

      BOOSTER.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[7]), Float.parseFloat(nums[8]), Float.parseFloat(nums[9]))));
      BOOSTER.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[18]), Float.parseFloat(nums[19]), Float.parseFloat(nums[20]), Float.parseFloat(nums[21]))));
    }
  }

  frameRate(999);

  lights();

  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 0.1, cameraZ*10000.0);
  
  
  
  //while(!mousePressed){
    
  //}

}

void rotate(float z, float y, float x) {rotateY(z);rotateX(y);rotateZ(x);}

float[] llaToXyz(float lon, float lat, float alt, int r){
  
  r += alt;

  float[] xyz = {r * (cos(lon) - sin(lat)), r  * (sin(lon) - sin(lat)), r * sin(lat)};
  
  return xyz;
  
}

float[] QuatToYRP(ArrayList<Float> quats){
  float yrp[] = new float[3];
  float q0 = quats.get(0), q1 = quats.get(1), q2 = quats.get(2), q3 = quats.get(3);

  // roll
  yrp[0] = atan2(2*(q0*q1 + q2*q3), 1 - 2*(q1*q1 + q2*q2));
  // pitch
  yrp[1] = asin(2*(q0*q2 - q3*q1));
  // yaw
  yrp[2] = atan2(2*(q0*q3 + q1*q2), 1 - 2*(q2*q2 + q3*q3));

  return yrp;
}

float[] cCs = {0, 0, 0};

void draw() {
  
  

  background(200);
  lights();
  
  las.setFill(color(100, 100, 100));
  crew.setFill(color(100, 100, 100));
  booster.setFill(color(40, 80, 55));

  pushMatrix();
    translate(width/2, height/2);

    camera(cCs[0], cCs[1] - 1000, cCs[2] + 200, // idk what these do
      0, 0, 0, // center
      0, 1, 0); // idk what these do
      
    
    ambientLight(102, 102, 102);
    lightSpecular(204, 204, 204);
    directionalLight(102, 102, 102, 0, 0, -1);
    specular(255, 255, 255);
    shininess(10.0);
  
    pushMatrix();
    
      float[] yrp = QuatToYRP(LAS.get(frames + 1));
      
      float[] xyz = llaToXyz(LAS.get(frames).get(2), LAS.get(frames).get(1), LAS.get(frames).get(0), llaRad);
      
      translate(xyz[0], xyz[1], xyz[2]);
      rotate(yrp[0], yrp[1], yrp[2]);

        shape(las, 0, 0);

      //if (lasNum == 0) shape(lasA1, 0, 0);
      //if (lasNum == 1) shape(lasA2, 0, 0);
      //if (lasNum == 2) shape(lasA3, 0, 0);
      
      //lasNum = (lasNum + 1)%3;
      
      
    popMatrix();
  
    pushMatrix();
      yrp = QuatToYRP(CREW.get(frames + 1));

      xyz = llaToXyz(CREW.get(frames).get(2), CREW.get(frames).get(1), CREW.get(frames).get(0), llaRad);
      cCs[0] = xyz[0]; cCs[1] = xyz[1]; cCs[2] = xyz[2];

      translate(xyz[0], xyz[1] + 5, xyz[2]);
      rotate(yrp[0], yrp[1], yrp[2]);
      
      shape(crew, 0, 0);
    popMatrix();
  
    pushMatrix();
      yrp = QuatToYRP(BOOSTER.get(frames + 1));
      
      xyz = llaToXyz(BOOSTER.get(frames).get(2), BOOSTER.get(frames).get(1), BOOSTER.get(frames).get(0), llaRad);
      
      translate(xyz[0], xyz[1] +15, xyz[2]);
      rotate(yrp[0], yrp[1], yrp[2]);
      
      shape(booster, 0, 0);
      
    popMatrix();

    
    
    pushMatrix();
      

      xyz = llaToXyz(BOOSTER.get(0).get(2), BOOSTER.get(0).get(1), BOOSTER.get(0).get(0), llaRad);
      translate(xyz[0], xyz[1] + 18, xyz[2]);
      rotateX(PI/2);
      rotateZ(PI/5);
      fill(255);
      beginShape();
        texture(groundTexture);
        vertex(-gdCoords[0], -gdCoords[0], gdCoords[1], 0,           0);
        vertex( gdCoords[0], -gdCoords[0], gdCoords[1], gdCoords[2], 0);
        vertex( gdCoords[0],  gdCoords[0], gdCoords[1], gdCoords[2], gdCoords[3]);
        vertex(-gdCoords[0],  gdCoords[0], gdCoords[1], 0,           gdCoords[3]);
       endShape();
    popMatrix();


  popMatrix();
  
  fill(255, 255, 0);
  textSize(textS);
  text("Time: " + LAS.get(frames).get(3), 20, 40);
  text("LAS\nAlt: " + LAS.get(frames).get(0) + "\nLat:" + LAS.get(frames).get(1) + "\nLong:" + LAS.get(frames).get(2), 20, 120 * (height/1800));

  text("Crew\nAlt: " + CREW.get(frames).get(0) + "\nLat:" + CREW.get(frames).get(1) + "\nLong:" + CREW.get(frames).get(2), 20, 380 * (height/1800));

  text("Booster\nAlt: " + BOOSTER.get(frames).get(0) + "\nLat:" + BOOSTER.get(frames).get(1) + "\nLong:" + BOOSTER.get(frames).get(2), 20, 640 * (height/1800));

  if (frames < LAS.size()-2) {
    frames += 2;
  }

}
