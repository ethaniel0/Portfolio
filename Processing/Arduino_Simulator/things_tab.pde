

int wid = 100;

int modchoice = 1;


boolean closed = true;

void things_tab(){
  fill(255);
  strokeWeight(5);
  
  stroke(0);
  
  rect(scales(625), scales(20), scales(300), scales(wid));
  line(scales(850), scales(90), scales(870), scales(100));
  line(scales(890), scales(90), scales(870), scales(100));
  
  
  
  if (modchoice == 1){ ////////////////// draw a wire at the top of th things tab //////////////////
    stroke(255, 140, 0);

    ellipse(scales(650), scales(60), scales(14), scales(14)); 
    ellipse(scales(900), scales(60), scales(14), scales(14)); 
    line(scales(650), scales(60), scales(900), scales(60));
    
  }
  if (modchoice == 2){ ////////////////// draw an LED at the top of th things tab //////////////////
    
    stroke(70,130,180);
    
    ellipse(scales(650), scales(60), scales(14), scales(14));
    ellipse(scales(900), scales(60), scales(14), scales(14));
    line(scales(650), scales(60), scales(900), scales(60));
    ellipse(scales(775), scales(60), scales(26), scales(26));
    
  }
  
  
  if (!closed){
    
    if (modchoice == 1){ ////////////////// draw an LED at the bottom of the things tab //////////////////
      
    LED(scales(650), scales(200), scales(900), scales(200));
    }
    
    if (modchoice == 2){ ////////////////// draw a wire at the bottom of th things tab //////////////////
      
      stroke(255, 140, 0);

      ellipse(scales(650), scales(200), scales(14), scales(14)); 
      ellipse(scales(900), scales(200), scales(14), scales(14)); 
      line(scales(650), scales(200), scales(900), scales(200));  
    }
    
    if (mousePressed && mouseX >= scales(625) && mouseX <= scales(925) && mouseY >= scales(150) && mouseY <= scales(300)){
      
      if (modchoice == 1){
        modchoice = 2;
        delay(200);
      }
      
      else if (modchoice == 2){
        modchoice = 1;
        
        delay(200);
        
      }
      wid = 100;
      closed = true;
      
    }
    
  }
  
}

void open_ttab(){
  
  if (mousePressed && mouseX >= scales(625) && mouseX <= scales(925) && mouseY >= scales(20) && mouseY <= scales(120)){
    
    if (closed){
      wid = 300;
      closed = false;
      delay(200);
    }
    
    else{
      wid = 100;
      closed  = true;
      delay(200);
      
    }
    
  }
  
  
}