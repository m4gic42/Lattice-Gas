
/*
This script is a simulation of a reticular gas in three dimensional box with fixed boundary conditions.
The parameters are:
r: radius of a singular particle of the gas;
v: velocity of a singular particle of the gas;
dens: density of particles in the grid;
l: size of the box;


You can rotate the box dragging with mouse, and zoom in and out with the mouse wheel.
Hit 'r' on the keyboard to record frames of the simulation in /output directory
*/



float dens=0.2;
ArrayList<Particle> Gas;
color c_part=  #FFFFFF ; //Color of a particle
color c_back=   #e3e9e9  ; //Color of the background
boolean record=false;
int r=4;
float v=0.7;

/*Starting angles of the box*/
float anglex=-PI/16; 
float angley=PI/8;



float mx=0;
float my=0;

int l=100;

float zoom=50000; //Parameter used to set the starting zoom


void setup(){


 size(800, 800, P3D); //Bulding a canvas width x height
  
 /*The next to variables are use to set the first aviable for the particles*/ 
  
 int offsetX=(width-l)/2;
 int offsetY=(height-l)/2;  

  Gas = new ArrayList<Particle>(); //Creating an array of particles called Gas


  /*The loops navigate the box and fill it with particles. 
  The box is created at the senter of the 3D environment*/
 for(int z=r-l/2;z<l/2;z+=2*r)
 {
   for(int x=r+offsetX;x<l+offsetX;x+=2*r)
   { 
   for(int y=r+offsetY;y<l+offsetY;y+=2*r){
     
     /*Generator of particles in random positions based the density value*/   
      float rand=random(1);
      if(rand<dens){
        Particle temp = new Particle(x,y,z);
        Gas.add(temp);
      }

   }
 }
   
   
 }

}

/*Function that controls the recording*/

void keyPressed(){
  if(key == 'r' || key =='R'){
    record = !record;
  }
  
}

void draw()
{

   
/*Translating to the center of the canvas and the zoom normalized with the dimension of the box*/  
  translate(width/2,height/2, zoom/l); 
  
/*Setting the angle of the view*/
  rotateX(anglex);
  rotateY(angley);
  background(100);


/*Control of the rotation based on mouse input*/
  if (mousePressed){
   if(mouseX<mx-8){
       angley-=0.1; 
   }
    else if(mouseX>8+mx){
       angley+=0.1; 
    }
    
  if(mouseY<my-8){
      anglex+=0.1; 
    }
    else if(mouseY>my+8){
       anglex-=0.1; 
 
   }
  
  }
  


  draw_box(); //Drawing the box at the center of the box
  
  translate(-width/2,-height/2, 0); //Detranslate to standard reference
  for(int i = 0; i< Gas.size(); i++){
    
    
    Particle p=Gas.get(i); //Getting the current particle
    p.show(); //drawing the current particle on the grid
    p.update(i); //moving the particle
    Gas.set(i,p); //updating the list of particles with the new position
    

    
  }


  
  if (record) {
     saveFrame("output/gr_####.png"); 
  }
  
  
/*Getting the mouse position used in the rotation control*/  
  mx=mouseX;
  my=mouseY;
}

  
 /*This function creates a transparent box of size l*/
void draw_box()
{
  stroke(0);
  noFill();
  box(l);  
}
  
  
 
/*This function changes the zoom based on the rotation of the mouse wheel*/
  
void mouseWheel(MouseEvent event){
  zoom-=1000*event.getCount();
}
