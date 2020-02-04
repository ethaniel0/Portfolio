import processing.core.*;
import java.util.*;
public class Rocket extends PApplet{
	PShape las, crew, booster, ground;
	PImage groundTexture;
	float lasHeight = (float) 23.0886, boosterHeight = (float) 2.159;
	String [] file;
	int frames = 0, centerX = 0, centerY = 0, centerZ = 600;
	int[] camera = {0,0,0};
	int llaRad = 10, textS = 36;
	//  				x/y len   	z   pic x  pic y
	int[] gdCoords = {61000,     0, 2972,  2742};
	//  							LAS                                        CREW                                       BOOSTER
	ArrayList<ArrayList<Float>> part1 = new ArrayList<ArrayList<Float>>(), part2 = new ArrayList<ArrayList<Float>>(), part3 = new ArrayList<ArrayList<Float>>();
	ArrayList<Float> time = new ArrayList<>();
	public static void main(String[] args) {
		PApplet.main("Rocket");
	}
	public void settings() {
		size((int)1800 * displayWidth/3000, (int)1800 * displayHeight/2000,P3D);
		textS = 36 * height/1800;
	}
	public void setup() {
		las = loadShape("las.obj");
		crew = loadShape("crew.obj");
		booster = loadShape("booster.obj");
		groundTexture = loadImage("groundTexture.tga");
		 
		gdCoords[2] = groundTexture.width;
		gdCoords[3] = groundTexture.height;

		file = loadStrings("Data v2.csv");
		
		for (String i : file) {
		    String[] nums = i.split(",");
		    if (!nums[0].equals("MET")) {

		      time.add(Float.parseFloat(nums[0]));
		      part1.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[4]), Float.parseFloat(nums[5]), Float.parseFloat(nums[6]),Float.parseFloat(nums[0]))));
		      part1.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[10]), Float.parseFloat(nums[11]), Float.parseFloat(nums[12]), Float.parseFloat(nums[13]))));

		     
		      part2.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[1]), Float.parseFloat(nums[2]), Float.parseFloat(nums[3]))));
		      part2.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[14]), Float.parseFloat(nums[15]), Float.parseFloat(nums[16]), Float.parseFloat(nums[17]))));

		      part3.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[7]), Float.parseFloat(nums[8]), Float.parseFloat(nums[9]))));
		      part3.add(new ArrayList<Float>(Arrays.asList(Float.parseFloat(nums[18]), Float.parseFloat(nums[19]), Float.parseFloat(nums[20]), Float.parseFloat(nums[21]))));
		    }
		  }

		  frameRate(200);
		  lights();
		  float fov = (float)(Math.PI/3.0);
		  float cameraZ = (float)((height/2.0) / Math.tan(fov/2.0));
		  perspective(fov, (float)(width/height), (float)0.1, (float)(cameraZ*10000.0));
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
	float[] cCs = {0,0,0};
	public void draw() {
		background(200);
		lights();
		booster.setFill(color(40, 80, 55));
		pushMatrix();
			translate(width/2, height/2);
			camera(cCs[0], cCs[1] - 1000, cCs[2] + 200, // idk what these do
		      0, 0, 0, // center
		      0, 1, 0); // idk what these do
			pushMatrix();
				float[] yrp = QuatToYRP(part1.get(frames + 1));
				float[] xyz = llaToXyz(part1.get(frames).get(2), part1.get(frames).get(1), part1.get(frames).get(0), llaRad);
				translate(xyz[0], xyz[1], xyz[2]);
				rotate(yrp[0], yrp[1], yrp[2]);
		      
				shape(las, 0, 0);
		    popMatrix();
		  
		    pushMatrix();
		    		yrp = QuatToYRP(part2.get(frames + 1));

		    		xyz = llaToXyz(part2.get(frames).get(2), part2.get(frames).get(1), part2.get(frames).get(0), llaRad);
		    		cCs[0] = xyz[0]; cCs[1] = xyz[1]; cCs[2] = xyz[2];
		    		translate(xyz[0], xyz[1] + 5, xyz[2]);
		    		rotate(yrp[0], yrp[1], yrp[2]);
		    		shape(crew, 0, 0);
		    popMatrix();
		  
		    pushMatrix();
		      yrp = QuatToYRP(part3.get(frames + 1));
		      
		      xyz = llaToXyz(part3.get(frames).get(2), part3.get(frames).get(1), part3.get(frames).get(0), llaRad);
		      translate(xyz[0], xyz[1] +15, xyz[2]);
		      rotate(yrp[0], yrp[1], yrp[2]);
		      
		      shape(booster, 0, 0);
		    popMatrix();
		    
		    
		    pushMatrix();
		      

		      xyz = llaToXyz(part3.get(0).get(2), part3.get(0).get(1), part3.get(0).get(0), llaRad);
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
		  
		  fill(255);
		  textSize(textS+10);
		  text("Time: " + part1.get(frames).get(3), 20, 40);
		  text("LAS\nAlt: " + part1.get(frames).get(0) + "\nLat:" + part1.get(frames).get(1) + "\nLong:" + part1.get(frames).get(2), 20, 120);

		  text("Crew\nAlt: " + part2.get(frames).get(0) + "\nLat:" + part2.get(frames).get(1) + "\nLong:" + part2.get(frames).get(2), 20, 380);

		  text("Booster\nAlt: " + part3.get(frames).get(0) + "\nLat:" + part3.get(frames).get(1) + "\nLong:" + part3.get(frames).get(2), 20, 640);

		  if (frames < part1.size()-2) {
		    frames += 2;
		  }
	}
}
