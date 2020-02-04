
color animate_background = color (80);


///////////// Variables /////////////

// Save
String file_name = "Untitled";

// Playback
float frame_rate = 30;
boolean video_playing = false; // says if the animation is playing or not

// Frame
float[] frameRatio = {4,3}; // ratio (can be 16x9, 4x3, anything)
//         frame     type     data

int current_frame = 0;

int nearest_hostframe = 0; // closest keyframe or subframe behind the current frame

// Canvas
float zoom = 100; // 100%
float frame_rotate = 0; // maybe implemented later
float frameX = 0; // screen scroll (0 = millde of the screen horizontal)
float frameY = 0; // screen scroll (0 o middle of the screen vertical);
float canvas_scrollX = 0;
float canvas_scrollY = 0;

// Tools
int tool_in_use = 2; // 0 = mouse, 1 = selecter, 2 = pen, 3 = eraser, 4 = text, 5 = line, 6 = oval, 7 = rectangle, 8 = polyline, 10 = paint bucket
boolean use_tools = false;
boolean drawing = false; // if user is drawing (mousePressed)

// Properties
boolean properties_in = false;
float line_thickness_x = 0;
float line_alpha_x = 0;
float color_choose_x = 0; // says where to place the circle on the choose-color line
float rgbContrast = 255/2; // adjusts the brightness/darkness of the color

// stroke
float line_thickness = 5;
ArrayList line_colour = new ArrayList(Arrays.asList(0.0, 0.0, 0.0, 255.0)); // arraylist version of line_color

// fill
//int[] shape_fill = {0, 0, 0, 255};
ArrayList shape_fill = new ArrayList(Arrays.asList(0.0, 0.0, 0.0, 255.0)); // arraylist  version of shape_fill

// frame panel
float frame_scroll = 0;
boolean frameTypePrompt = false; // says if the prame type prompt is up
float frameTypePromptX = 0; // middle of the prame type prompt (x coord where the bottom point is)
int frameTypePromptFrameNum = 0; // frame number that user is referring to when they click on an unused frame
float frameTypePromptStartX = 0; // left side (x coord) of the frame type prompt
boolean frameSliderOn = false; // if user is pressing on slider for the frame panel
float frameSliderMouse = 0; // used to track movement of mouseX when sliding
boolean usedFramePrompt = false; // says if prompt for when user clicks on a used frame should be up
float usedFramePromptX = 0; // middle of the used frame prompt (where the point is)
int usedFramePromptFrameNum = 0; // number of the frame the used frame prompt is affecting
boolean frame_panel_drag = false;

// Zoom
boolean zoomTrayOpen = false;
boolean custom_zoom_on = false;
float[] zoom_options = {50, 100, 200, 500, -1};
float[] custom_zoom_coords = {-1, -1}; // coordinates for the custom zoom window
boolean custom_zoom_drag = false;
float[] custom_zoom_latch_coords = {-1, -1}; // original coordinates of mouse if window is being dragged

// File Options             File   Edit   View  Insert  Help
boolean[] fileOptionOpen = {false, false, false, false, false};

//                                file                                                       edit                                                           view
String[][] fileOptions = {{"New >", "Open", "Ratio", "Save", "Save As", "Export"}, {"Undo", "Redo", "Cut", "Copy", "Paste", "Duplicate"}, {"Zoom             >", "Canvas Rotation", "Grid               >"}, 
                          {"Layer", "Frame", "Keyframe", "Blank Keyframe"}, {"About", "Find"}};
//                                      insert                                  help  

// scale based on display height
float scaledH(float x){
  return (x*displayHeight)/2000;
}
float scaledH(int x){
  return (x*displayHeight)/2000;
}

void gradientLine(float x_s, float y_s, float x_e, float y_e, int col_s, int col_e) {
  float deltaX = x_s-x_e;
  float deltaY = y_s-y_e;
  int steps = (int) (Math.sqrt(pow(deltaX,2) + pow(deltaY,2))*0.8);
  float[] xs = new float[steps];
  float[] ys = new float[steps];
  color[] cs = new color[steps];
  for (int i=0; i<steps; i++) {
    float amt = (float) i / steps;
    xs[i] = lerp(x_s, x_e, amt) + amt;
    ys[i] = lerp(y_s, y_e, amt) + amt;
    cs[i] = lerpColor(col_s, col_e, amt);
  }
  for (int i=0; i<steps-1; i++) {
    stroke(cs[i]);
    line(xs[i], ys[i], xs[i+1], ys[i+1]);
  }
}

void weightRangeLine(float x1, float y1, float x2, float y2, float weight1, float weight2, float multiplier){
  
  float deltaX = x2-x1;
  float deltaY = y2-y1;
  float dist = (float) Math.sqrt(pow(deltaX,2) + pow(deltaY,2));
  int steps = (int)(dist*multiplier);
  float step_dist = (float) (dist/steps);
  
  float weightRange = weight2 - weight1;
  
  float startX = x1;
  float startY = y1;
  
  for (float i = 0; i < steps; i+= step_dist){
    strokeWeight(i/steps * weightRange + weight1);
    
    line(startX, startY, startX + deltaX/steps, startY + deltaY/step_dist);
    startX += deltaX / (steps/step_dist);
    startY += deltaY / (steps/step_dist);
    
  }
  
}
  
void linearRGBGradient(float x, float y, float wid){
  for (float i = 0; i < wid; i+= 1) {
    float[] filling = gradientColors(i, wid);
    stroke(filling[0], filling[1], filling[2]);
    point(i+x, y);
  }
}

void animator(){
  
  background(animate_background);
  
  find_nearest_hostframe();
  
  canvas(); // canvas (each frame)
  
  outline(); // all the selection things

  if(video_playing){
    play_animation();
  }

  
}