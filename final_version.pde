import processing.serial.*;
import grafica.*;

float COP_x_max=-100;
float COP_y_max=-100;
float COP_x_min=100;
float COP_y_min=100;
int flag_lunghezza_tracciato=0;
float lunghezza_tracciato=0;
int reference_analysis=0;
float COP_x[];
float COP_y[];
int flag_analysis=0;
int flag_button=0;
int x_button=930;
int y_button=340;
int w_button=150;
int h_button=50;
int xtd=700;
int ytd=520;
int xts=600;
int yts=520;
int xss=580;
int yss=200;
int xsd=700;
int ysd=200;
float x_cop;
float y_cop;
float d1;
float d2;
float d3;
float d4;
float reference2=0;
float tempo_trascorso2=0;
int counter=5;
int flag_start=0;
int flag_calibrazione=1;
float reference=0;
float tempo_trascorso=0;
float max_Tallone_dx=0;
float max_Tallone_sx=0;
float max_Superiore_dx=0;
float max_Superiore_sx=0;
float min_Tallone_dx=100;
float min_Tallone_sx=100;
float min_Superiore_dx=100;
float min_Superiore_sx=100;
int R,G,B;
int R_Tallone_sx=0;int G_Tallone_sx=0;int B_Tallone_sx=0;
int R_Tallone_dx=0;int G_Tallone_dx=0;int B_Tallone_dx=0;
int R_Superiore_sx=0;int G_Superiore_sx=0;int B_Superiore_sx=0;
int R_Superiore_dx=0;int G_Superiore_dx=0;int B_Superiore_dx=0;
int n_max=50;
float datain_Tallone_dx;
float datain_Tallone_sx;
float datain_Superiore_sx;
float datain_Superiore_dx;
GPlot plot_Tallone_dx;
GPlot plot_Tallone_sx;
GPlot plot_Superiore_sx;
GPlot plot_Superiore_dx;
GPlot plot_stabilo_x;
GPlot plot_stabilo_y;
GPointsArray points_Tallone_dx= new GPointsArray(n_max);
GPointsArray points_Tallone_sx= new GPointsArray(n_max);
GPointsArray points_Superiore_sx= new GPointsArray(n_max);
GPointsArray points_Superiore_dx= new GPointsArray(n_max);
GPointsArray points_stabilo_x= new GPointsArray(n_max);
GPointsArray points_stabilo_y= new GPointsArray(n_max);
int x_Tallone_sx=0;
int x_Tallone_dx=0;
int x_Superiore_sx=0;
int x_Superiore_dx=0;
int flag_Tallone_dx=0;
int flag_Tallone_sx=0;
int flag_Superiore_sx=0;
int flag_Superiore_dx=0;
int counter_Tallone_dx=0;
int counter_Tallone_sx=0;
int counter_Superiore_sx=0;
int counter_Superiore_dx=0;
int counter_stabilo_x=0;
int counter_stabilo_y=0;
int flag_draw_Tallone_sx=0;
int flag_draw_Tallone_dx=0;
int flag_draw_Superiore_sx=0;
int flag_draw_Superiore_dx=0;
String datai;
Serial myPort;
PImage img;
PImage img_start;
PImage img_superiore_dx;
PImage img_superiore_sx;
PImage img_tallone_dx;
PImage img_tallone_sx;
PImage img_calibrazione;


void setup(){
  
  COP_x = new float[0];
  COP_y = new float[0];
  
  size(645,859);
  surface.setResizable(true);
  
  frameRate(150);
  background(255);
  
  plot_stabilo_x= new GPlot(this);
  plot_stabilo_x.setPos(295,0);
  plot_stabilo_x.setOuterDim(1000-295,648/2);
  plot_stabilo_x.setTitleText("Stabilogramma COPx");
  plot_stabilo_x.getYAxis().setAxisLabelText("Position[cm]");
  plot_stabilo_x.getXAxis().setAxisLabelText("Time");
  
  plot_stabilo_y= new GPlot(this);
  plot_stabilo_y.setPos(295,648/2);
  plot_stabilo_y.setOuterDim(1000-295,648/2);
  plot_stabilo_y.setTitleText("Stabilogramma COPy");
  plot_stabilo_y.getYAxis().setAxisLabelText("Position[cm]");
  plot_stabilo_y.getXAxis().setAxisLabelText("Time");
  
  plot_Superiore_sx= new GPlot(this);
  plot_Superiore_sx.setPos(0,0);
  plot_Superiore_sx.setOuterDim(500,700/2-20);
  plot_Superiore_sx.setTitleText("Superiore sinistro");
  plot_Superiore_sx.getYAxis().setAxisLabelText("Capacitance[pf]");
  plot_Superiore_sx.getXAxis().setAxisLabelText("Time");
  
  plot_Tallone_dx= new GPlot(this);
  plot_Tallone_dx.setPos(795,700/2+40);
  plot_Tallone_dx.setOuterDim(500,700/2-20);
  plot_Tallone_dx.setTitleText("Tallone destro");
  plot_Tallone_dx.getYAxis().setAxisLabelText("Capacitance[pf]");
  plot_Tallone_dx.getXAxis().setAxisLabelText("Time");
  
  plot_Tallone_sx= new GPlot(this);
  plot_Tallone_sx.setPos(0,700/2+40);
  plot_Tallone_sx.setOuterDim(500,700/2-20);
  plot_Tallone_sx.setTitleText("Tallone sinistro");
  plot_Tallone_sx.getYAxis().setAxisLabelText("Capacitance[pf]");
  plot_Tallone_sx.getXAxis().setAxisLabelText("Time");
  
  plot_Superiore_dx= new GPlot(this);
  plot_Superiore_dx.setPos(795,0);
  plot_Superiore_dx.setOuterDim(500,700/2-20);
  plot_Superiore_dx.setTitleText("Superiore destro");
  plot_Superiore_dx.getYAxis().setAxisLabelText("Capacitance[pf]");
  plot_Superiore_dx.getXAxis().setAxisLabelText("Time");
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  img = loadImage("piede.jpg");
  img_start = loadImage("inizio.png");
  img_superiore_dx = loadImage("superioredx.jpg");
  img_superiore_sx = loadImage("superioresx.jpg");
  img_tallone_dx = loadImage("tallonedx.jpg");
  img_tallone_sx = loadImage("tallonesx.jpg"); 
  img_calibrazione = loadImage("calibrazione.png"); 
  
}

void draw(){
   noStroke();  
  if(flag_start==0){    
    image(img_start,0,0);
  }  
  if(flag_start==1){
      tempo_trascorso=millis()-reference;
      tempo_trascorso2 = millis() - reference2;
      if(tempo_trascorso2 >= 1000){
        reference2 = millis();
        counter = counter - 1;
      if(counter == 0){
          counter = 5;
        }
      }
    if(tempo_trascorso<5000){
      surface.setSize(1579,883);
      image(img_superiore_dx,0,0);
      text(counter,870,680);
      textSize(100);
      fill(0);      
    }
    else if(tempo_trascorso<10000 & tempo_trascorso>=5000){
      surface.setSize(1579,883);
      image(img_superiore_sx,0,0);
      text(counter,870,680);
      textSize(100);
      fill(0);
    }
    else if(tempo_trascorso<15000 & tempo_trascorso>=10000){
      surface.setSize(1148,647);
      image(img_tallone_dx,0,0);
      text(counter,720,460);
      textSize(100);
      fill(0);
    }
    else if(tempo_trascorso<20000 & tempo_trascorso>=15000){
      surface.setSize(1148,647);
      image(img_tallone_sx,0,0);
      text(counter,720,450);
      textSize(100);
      fill(0);
    }
    else if(tempo_trascorso<25000 & tempo_trascorso>=20000){
      surface.setSize(1087,641);
      image(img_calibrazione,0,0);
      text(counter,490,530);
      textSize(150);
      fill(0);
    }
    else{
      flag_calibrazione=0;
    }
  }
  
  if(flag_calibrazione==0 & flag_analysis==0){
    surface.setSize(1350, 720);
    image(img, 500, 0);
    shapeMode(CENTER);
    calibra(x_Tallone_sx); 
    R_Tallone_sx=R;
    G_Tallone_sx=G;
    B_Tallone_sx=B;
    fill(R_Tallone_sx,G_Tallone_sx,B_Tallone_sx);
    ellipse(600, 520, x_Tallone_sx,x_Tallone_sx);
    if(x_Tallone_sx<datain_Tallone_sx){
    x_Tallone_sx++;}
    if(x_Tallone_sx>datain_Tallone_sx){
    x_Tallone_sx--;}
    calibra(x_Tallone_dx); 
    R_Tallone_dx=R;
    G_Tallone_dx=G;
    B_Tallone_dx=B;
    fill(R_Tallone_dx,G_Tallone_dx,B_Tallone_dx);
    ellipse(700, 520, x_Tallone_dx,x_Tallone_dx);
    if(x_Tallone_dx<datain_Tallone_dx){
    x_Tallone_dx++;}
    if(x_Tallone_dx>datain_Tallone_dx){
    x_Tallone_dx--;}
    calibra(x_Superiore_sx); 
    R_Superiore_sx=R;
    G_Superiore_sx=G;
    B_Superiore_sx=B;
    fill(R_Superiore_sx,G_Superiore_sx,B_Superiore_sx);
    ellipse(580, 200, x_Superiore_sx,x_Superiore_sx);
    if(x_Superiore_sx<datain_Superiore_sx){
    x_Superiore_sx++;}
    if(x_Superiore_sx>datain_Superiore_sx){
    x_Superiore_sx--;}  
    calibra(x_Superiore_dx); 
    R_Superiore_dx=R;
    G_Superiore_dx=G;
    B_Superiore_dx=B;
    fill(R_Superiore_dx,G_Superiore_dx,B_Superiore_dx);
    ellipse(700, 200, x_Superiore_dx,x_Superiore_dx);
    if(x_Superiore_dx<datain_Superiore_dx){
    x_Superiore_dx++;}
    if(x_Superiore_dx>datain_Superiore_dx){
    x_Superiore_dx--;}
    
    if(flag_draw_Tallone_dx==1){
       flag_draw_Tallone_dx=0;
       plot_Tallone_dx.setPoints(points_Tallone_dx);
       plot_Tallone_dx.defaultDraw();
     }
     if(flag_draw_Tallone_sx==1){
       flag_draw_Tallone_sx=0;
       plot_Tallone_sx.setPoints(points_Tallone_sx);
       plot_Tallone_sx.defaultDraw();
     }
     if(flag_draw_Superiore_sx==1){
       flag_draw_Superiore_sx=0;
       plot_Superiore_sx.setPoints(points_Superiore_sx);
       plot_Superiore_sx.defaultDraw();
     }
     if(flag_draw_Superiore_dx==1){
       flag_draw_Superiore_dx=0;
       plot_Superiore_dx.setPoints(points_Superiore_dx);
       plot_Superiore_dx.defaultDraw();
     }
        
     if (flag_button==1){     
        fill(0);
        ellipse(x_cop, y_cop, 15,15);
      }      
      noFill();
      rectMode(CORNER);
      strokeWeight(4);
      stroke(0);
      rect(x_button,y_button,w_button,h_button);
      fill(0);
      text("Visualize COP",x_button+10,y_button+30);
      textSize(20);
      
      noFill();
      rectMode(CORNER);
      strokeWeight(4);
      stroke(0);
      rect(x_button+w_button,y_button,w_button,h_button);
      fill(0);
      text("COP Analysis",x_button+w_button+15,y_button+30);
      textSize(20);
  }
    if(flag_analysis==1){
      if(millis()-reference_analysis>10000){
        background(255);
        surface.setSize(1000,720);
        image(img, 0, 0);
        plot_stabilo_x.setPoints(points_stabilo_x);
  
        plot_stabilo_x.defaultDraw();
        plot_stabilo_y.setPoints(points_stabilo_y);
        plot_stabilo_y.defaultDraw();
        
        
        for(int i=0; i<COP_x.length ; i++){
          
          if(i< (COP_x.length-1)){
            if(flag_lunghezza_tracciato==0){
              float x_old=(COP_x[i]-500)/295*9;
              float y_old=25-(COP_y[i]/648*25);
              float x_new=(COP_x[i+1]-500)/295*9;
              float y_new=25-(COP_y[i+1]/648*25);
              lunghezza_tracciato=lunghezza_tracciato+sqrt(pow(x_new-x_old,2)+pow(y_new-y_old,2));
            }
            stroke(0);
            strokeWeight(1);
            line(COP_x[i]-500,COP_y[i],COP_x[i+1]-500,COP_y[i+1]); // rimuovo 500 perchè calibro COP nella nuova figura
          }
        }
        flag_lunghezza_tracciato=1;
        fill(0);
        text("Lunghezza del tracciato:"+int(lunghezza_tracciato)+"cm",10,660);
        text("ROMx:"+ nf((COP_x_max-COP_x_min),0,2) +"cm",10,680);
        text("ROMy:"+ nf((COP_y_max-COP_y_min),0,2) +"cm",10,700);      
      }
      else{
        surface.setSize(600,200);
        background(0);
        fill(255);
        text("Attendere 10 secondi stando fermi sulla soletta",70,100);
      }             
 }
}
    

void mousePressed() {
  
  if (mouseX >= x_button && mouseX <= x_button+w_button && 
      mouseY >= y_button && mouseY <= y_button+h_button) {
    flag_button=1;
  }
  else if (mouseX >= x_button+w_button && mouseX <= x_button+2*w_button && 
      mouseY >= y_button && mouseY <= y_button+h_button) {
    flag_analysis=1;
    reference_analysis=millis();
  }
  else if(flag_analysis==1){
    flag_analysis=0;
    flag_button=0;
  }
  else {
  flag_button=0;
  }  
}

void serialEvent( Serial myPort) { //function called when a data is available on the serial port
  datai = myPort.readString(); 
  if (datai != null) {
    datai = trim(datai);
    println(datai);
  }
  if(flag_Tallone_dx==1){
    points_Tallone_dx.add(counter_Tallone_dx,float(datai));
    counter_Tallone_dx++;
    if(flag_calibrazione==1 & flag_start==1){
      if(tempo_trascorso<25000 & tempo_trascorso>=20000){
        if(float(datai)<min_Tallone_dx){
         min_Tallone_dx=float(datai);
        }
      }
      if(float(datai)>max_Tallone_dx){
         max_Tallone_dx=float(datai);
      }
    }
    else{
      datain_Tallone_dx=100/(max_Tallone_dx-min_Tallone_dx)*(float(datai)-min_Tallone_dx);
    }
    if(counter_Tallone_dx>=n_max){
      points_Tallone_dx.remove(0);
    }
    flag_draw_Tallone_dx=1;
  }
  if(flag_Tallone_sx==1){
    points_Tallone_sx.add(counter_Tallone_sx,float(datai));
    counter_Tallone_sx++;
    if(flag_calibrazione==1 & flag_start==1){
      if(tempo_trascorso<25000 & tempo_trascorso>=20000){
        if(float(datai)<min_Tallone_sx){
         min_Tallone_sx=float(datai);
        }
      }
      if(float(datai)>max_Tallone_sx){
         max_Tallone_sx=float(datai);
      }
    }
    else{
      datain_Tallone_sx=100/(max_Tallone_sx-min_Tallone_sx)*(float(datai)-min_Tallone_sx);
    }
    if(counter_Tallone_sx>=n_max){
      points_Tallone_sx.remove(0);
    }
    flag_draw_Tallone_sx=1;
    
  }
  if(datai.equals("Tallone_dx:")==true){
    flag_Tallone_dx=1;
  }
  else{
    flag_Tallone_dx=0;
  }
  if(datai.equals("Tallone_sx:")==true){
    flag_Tallone_sx=1;
  }
  else{
    flag_Tallone_sx=0;
  }
  if(flag_Superiore_sx==1){
    points_Superiore_sx.add(counter_Superiore_sx,float(datai));
    counter_Superiore_sx++;
    if(flag_calibrazione==1 & flag_start==1){
      if(tempo_trascorso<25000 & tempo_trascorso>=20000){
        if(float(datai)<min_Superiore_sx){
         min_Superiore_sx=float(datai);
        }
      }
      if(float(datai)>max_Superiore_sx){
         max_Superiore_sx=float(datai);
      }
    }
    else{
      datain_Superiore_sx=100/(max_Superiore_sx-min_Superiore_sx)*(float(datai)-min_Superiore_sx);
    }
    if(counter_Superiore_sx>=n_max){
      points_Superiore_sx.remove(0);
    }
    flag_draw_Superiore_sx=1;
    
  }
  if(datai.equals("Superiore_sx:")==true){
    flag_Superiore_sx=1;
  }
  else{
    flag_Superiore_sx=0;
  }
  if(flag_Superiore_dx==1){
    points_Superiore_dx.add(counter_Superiore_dx,float(datai));
    counter_Superiore_dx++;
    if(flag_calibrazione==1 & flag_start==1){
      if(tempo_trascorso<25000 & tempo_trascorso>=20000){
        if(float(datai)<min_Superiore_dx){
         min_Superiore_dx=float(datai);
        }
      }
      if(float(datai)>max_Superiore_dx){
         max_Superiore_dx=float(datai);
      }
    }
    else{
      datain_Superiore_dx=100/(max_Superiore_dx-min_Superiore_dx)*(float(datai)-min_Superiore_dx);
    }
    if(counter_Superiore_dx>=n_max){
      points_Superiore_dx.remove(0);
    }
    
    flag_draw_Superiore_dx=1;
  }
  
  if(datai.equals("Superiore_dx:")==true){
    flag_Superiore_dx=1;
  }
  else{
    flag_Superiore_dx=0;
  }
  
   d1=datain_Tallone_dx/(datain_Tallone_dx+datain_Tallone_sx+datain_Superiore_dx+datain_Superiore_sx);
   d2=datain_Tallone_sx/(datain_Tallone_dx+datain_Tallone_sx+datain_Superiore_dx+datain_Superiore_sx);
   d3=datain_Superiore_dx/(datain_Tallone_dx+datain_Tallone_sx+datain_Superiore_dx+datain_Superiore_sx);
   d4=datain_Superiore_sx/(datain_Tallone_dx+datain_Tallone_sx+datain_Superiore_dx+datain_Superiore_sx);
     
   x_cop = (xtd*d1+xts*d2+xsd*d3+xss*d4);
   y_cop= (ytd*d1+yts*d2+ysd*d3+yss*d4); 
   if(millis()-reference_analysis<10000 & flag_analysis==1){
     
      float x_new=(x_cop-500)/295*9;
      float y_new=25-(y_cop/648*25);
     
      points_stabilo_x.add(counter_stabilo_x,x_new); // 9cm
      points_stabilo_y.add(counter_stabilo_y,y_new); // 25cm e la y va dall'alto vs basso quindi 25cm- 
      COP_x=append(COP_x,x_cop);
      COP_y=append(COP_y,y_cop);
      counter_stabilo_x++;
      counter_stabilo_y++;
      if(x_new>COP_x_max){
          COP_x_max=x_new;
       }
       if(x_new<=COP_x_min){
          COP_x_min=x_new;
       }
       if(y_new>COP_y_max){
          COP_y_max=y_new;
       }
       if(y_new<=COP_y_min){
          COP_y_min=y_new;
       }
     }
   
   
}

void calibra(float x){
  if(x<100/3 && x >0){
    R=0;
    G=0;
    B=255;
  }
  else if(x >100/3*2){    
    R=255;
    G=0;
    B=0;
  }
  else if(x<100/3*2 && x >100/3){
    R=255;
    G=255;
    B=0;
  } 
}

void keyPressed() { 
  if (key == ENTER ) {
    surface.setLocation(150,50);
    reference=millis();
    reference2 = reference;
   flag_start=1;
  } 
 
}
