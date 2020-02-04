import java.util.Arrays;


// three types of frames: a keyframe, subframe, and frame
// keyframes are the original keyframe, in which everything changes if that is changes
// subframes are like keyframes, but are linked to the original keyframe. Every frame after them changes based on the subframe,
//                       but all frames before the subframe remain unchanged
// frames change based on whatever higher type of frame is before them
// a change to a frame makes the frame it's own keyframe or subframe (undecided)
// keyframes and subframes together are called hostframes


int page = 1;

int tools_width;
int properties_width;
int framePanel_height; // height of the frame panel
float framePanelSliderHeight;
float framePanelSliderWidth;
float frame_width = 0; // frame represented in the frame panel
float frameHeight; // height of frame represented by the frame panel
float frameTypePromptWidth;
ArrayList<Object> frames;
float canvas_x;
float canvas_y;
float file_options_height;
int frameSliderLeftSide;

void settings(){
  
  size(displayWidth/2, displayHeight/2);
  
}

void setup() {
  
  surface.setResizable(true); // make the screen resizeable


  tools_width = displayWidth/40; // width of the tool selection pane (left side)
  properties_width = displayWidth/8;
  
  file_options_height = displayHeight/50;
  
  frame_width = displayWidth/100;
  framePanel_height = displayHeight/7;
  framePanelSliderHeight = displayHeight/75;
  framePanelSliderWidth = displayWidth/25;
  frameHeight = height - framePanel_height/1.5;
  frameTypePromptWidth = displayWidth/20;
  
  frames = new ArrayList();
  frames.add(new ArrayList());
  ((ArrayList)frames.get(0)).add(2);
  ((ArrayList)frames.get(0)).add(0);
  
  canvas_x = width/2 + (tools_width + properties_width)/2;
  canvas_y = height/2 - framePanel_height/2;

  frameRate(60);

}


// REMINDER: PEN TOOL IS USING curveVertex() INSTEAD OF vertex()

/*
Things to finish:

1. custom zoom box
2. stop making new drawings when mouse is over a tab (not canvas)


*/

/*
keyboard controls:

ctrl+. = move forward one frame
ctrl+, = move back one frame


*/




void draw(){

  frameHeight = height - framePanel_height/1.5;
  
  canvas_y = height/2 - framePanel_height/2;
  canvas_x = width/2 + (tools_width + properties_width)/2;
  frameSliderLeftSide = tools_width + properties_width + displayWidth/20;
  
  // menu screen -- give options for the animation
  if(page == 0){
    menu();
  }


  //main animation page
  if(page == 1){
   animator();
  }


}