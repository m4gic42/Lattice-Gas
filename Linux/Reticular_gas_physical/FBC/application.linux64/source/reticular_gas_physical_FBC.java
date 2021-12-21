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

public class reticular_gas_physical_FBC extends PApplet {


/*
This script is a simulation of a reticular gas in fixed boundary conditions.
The parameters are:
r: radius of a singular particle of the gas;
v: velocity of a singular particle of the gas;
dens: density of particles in the grid;

Hit 'r' on the keyboard to record frames of the simulation in /output directory
*/


float dens=0.4f;
ArrayList<Particle> Gas;
int c_part=  0xffFFFFFF ; //Color of a particle
int c_back=   0xffe3e9e9  ; //Color of the background
boolean record=false;
int r=10;
float v=5;

public void setup(){
     //Bulding a canvas width x height
  Gas = new ArrayList<Particle>(); //Creating an array of particles called Gas
  
  
  /*The loops navigate the grid and fill it with particles*/
  for(int x=2*r;x<width-r;x+=2*r)
  {
    for(int y=2*r;y<height-r;y+=2*r){
      
     /*Generator of particles in random positions based the density value*/
     float rand=random(1);
      if(rand<dens){
      Particle temp = new Particle(x,y);
      Gas.add(temp);

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
  background(c_back);
  for(int i = 0; i< Gas.size(); i++){
    
    
    Particle p=Gas.get(i); //Getting the current particle
    p.show(); //drawing the current particle on the grid
    p.update(i); //moving the particle
    Gas.set(i,p); //updating the list of particles with the new position
    
  }
  

  if (record) {
     saveFrame("output/gr_####.png"); 
  }

  
}


  
  
/*This class represents a single particle 
It contains the two coordinates of the particle in the grid.
*/



class Particle {
   float px;
   float py;
   
   /*object constructor*/
   
   Particle(float x,float y) {
       px=x;
       py=y; 
   }
  
  public void show()
  {
    /*Drawing a circle of color c_part and radus r in the current position of the particle*/
     fill(c_part);
     //noStroke();
     ellipse(px,py,2*r,2*r);  
  }


   public void update(int self){
     
     
     /*Generating a random number to set a random direction for the particle*/
     float dir = random(1);
     if(dir<=0.25f)
     {
       /*If it isn't near the border it can move*/
       if(px>v+r)
       {
         
         /*If the position to the left is empy it can move*/
         if(controllo(px-v,py,self)!=1 )
         {
           px-=v;

         }
       }

     }
    if(dir>0.75f)
     {      
       if(px<width-v-r){
         
         /*If the position to the right is empy it can move*/
         if(controllo(px+v,py,self)!=  1 )
         {

           px+=v;

         }
       }       

     }
    if(dir>0.5f && dir<0.75f)
     {
   
       if(py>v+r){
         
       /*If the position over is empy it can move*/       
         if(controllo(px,py-v,self)!= 1 )
         {

           py-=v;

         }
       }      

     }
     if(dir>0.25f && dir<0.5f)
     {
       if(py<height-v-r){
         
       /*If the position below is empy it can move*/       
         if(controllo(px,py+v,self)!=  1 )
         {

           py+=v;

         }
       }     


     }
     
   
   }
   
   
   /*This funcion controls if the particle is bumping into another particle*/
   public int controllo(float nx, float ny,float self){
      Particle temp= new Particle(nx,ny);
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
       return sqrt((p1.px-p2.px)*(p1.px-p2.px)+(p1.py-p2.py)*(p1.py-p2.py));
     
   }
}
  public void settings() {  size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "reticular_gas_physical_FBC" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
