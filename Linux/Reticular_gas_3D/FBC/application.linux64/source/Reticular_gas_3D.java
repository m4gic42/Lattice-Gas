import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Reticular_gas_3D extends PApplet {


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



float dens=0.2f;
ArrayList<Particle> Gas;
int c_part=  0xffFFFFFF ; //Color of a particle
int c_back=   0xffe3e9e9  ; //Color of the background
boolean record=false;
int r=4;
float v=0.7f;

/*Starting angles of the box*/
float anglex=-PI/16; 
float angley=PI/8;



float mx=0;
float my=0;

int l=100;

float zoom=50000; //Parameter used to set the starting zoom


public void setup(){


  //Bulding a canvas width x height
  
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

public void keyPressed(){
  if(key == 'r' || key =='R'){
    record = !record;
  }
  
}

public void draw()
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
       angley-=0.1f; 
   }
    else if(mouseX>8+mx){
       angley+=0.1f; 
    }
    
  if(mouseY<my-8){
      anglex+=0.1f; 
    }
    else if(mouseY>my+8){
       anglex-=0.1f; 
 
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
public void draw_box()
{
  stroke(0);
  noFill();
  box(l);  
}
  
  
 
/*This function changes the zoom based on the rotation of the mouse wheel*/
  
public void mouseWheel(MouseEvent event){
  zoom-=1000*event.getCount();
}
/*This class represents a single particle 
It contains three coordinates of the particle in the box.
*/


class Particle {
   float px;
   float py;
   float pz;
   
   /*object constructor*/

   Particle(float x,float y,float z) {
       px=x;
       py=y; 
       pz=z;
   }
  
  public void show()
  {
    
    /*Drawing a sphere of color c_part and radus r in the current position of the particle*/
   
    fill(c_part);
    noStroke();
    lights();
    translate(px,py,pz);
    sphere(r);
    translate(-px,-py,-pz);
    
    
    
  }

public void update(int self){
  
     /*Generating a random number to set a random direction for the particle*/
     int dir = PApplet.parseInt(random(1,7));
     if(dir==1)
     {
       /*If it isn't near the border it can move*/
       if(px>v+r+(width-l)/2){
         
         /*If the position to the left is empy it can move*/
         if(controllo(px-v,py,pz,self)!=1 )
         {
           px-=v;

         }
       }
  
     }
    if(dir==2)
     {
       if(px<-v-r+(width+l)/2){
         
         /*If the position to the right is empy it can move*/
         if(controllo(px+v,py,pz,self)!=  1 )
         {

           px+=v;

         }
       }       

    }
    if(dir==3)
     {
       if(py>v+r+(height-l)/2){
         
       /*If the position over is empy it can move*/       
         if(controllo(px,py-v,pz,self)!= 1 )
         {

           py-=v;

         }
       }      

     }
     if(dir==4)
     {
       
       /*If the position below is empy it can move*/       
       if(py<-v-r+(height+l)/2){
         if(controllo(px,py+v,pz,self)!=  1 )
         {

           py+=v;

         }
       }     

     }
     if(dir==5)
     {
       if(pz>-l/2+r+v){
         
         /*If the position behind is empty it can move*/
         if(controllo(px,py,pz-v,self)!=  1 )
         {

           pz-=v;

         }
       }     

     }
      if(dir==6)
     {
       if(pz<l/2-r-v){
         
          /*If the position forward is empty it can move*/        
         if(controllo(px,py,pz+v,self)!=  1 )
         {

           pz+=v;

         }
       }     

     }
              


   }
   
   
   /*This funcion controls if the particle is bumping into another particle*/
   public int controllo(float nx, float ny, float nz, int self){
      Particle temp= new Particle(nx,ny,nz);
      for(int i=0; i<Gas.size();i++)
      {
         /*The funcion doesn't control the particle itself*/       
        if(i!=self){
         if(dist(Gas.get(i),temp)<=2*r) //If the distance between the two particles is less than 2r they are colliding
         {
            return 1;
         }
        }
      }
     
     return 0;
   }
   
   /*This funcion calculates the distance between two particles*/   
   public float dist(Particle p1, Particle p2)
   {
       return sqrt((p1.px-p2.px)*(p1.px-p2.px)+(p1.py-p2.py)*(p1.py-p2.py)+(p1.pz-p2.pz)*(p1.pz-p2.pz));
     
   }
}
  public void settings() {  size(800, 800, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Reticular_gas_3D" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
