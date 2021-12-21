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

public class reticular_gas_point_like_PBC extends PApplet {


/*
This script is a simulation of a reticular gas in periodic boundary conditions.
In this model a pixel represent a particle and the controls of their movement
is based only on the color of pixel in the canvas.
The single parameter is the density of on pixel.

Hit 'r' on the keyboard to record frames of the simulation in /output directory
*/

float dens=0.02f;
ArrayList<Particle> Gas;
int c_part=    0xff467ca5   ; //Color of a particle
int c_back=   0xffe3e9e9  ; //Color of the background
boolean record=false;


public void setup(){
   //Bulding a canvas width x height
  Gas = new ArrayList<Particle>(); //Creating an array of particles called Gas
 
 
 loadPixels();   //This funcion gives acces to pixel manipulation

  /*The loops navigate the grid and fill it with particles*/
  for(int x=0;x<width;x++)
  {
    for(int y=0;y<height;y++){
      

     /*Generator of particles in random positions based the density value*/
     float rand=random(1);
      if(rand<dens){
      Particle temp = new Particle(x,y);
      Gas.add(temp);
      pixels[Xi(x,y)]=  c_part;   //draws a particle 
      }
      else{
       pixels[Xi(x,y)]= c_back;   //draw background
      }
    }

  
  
    updatePixels();


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

  loadPixels();
  for(int i = 0; i< Gas.size(); i++){
      Particle p=Gas.get(i); //Getting the current particle
      p.update(); //moving the particle
      Gas.set(i,p); //updating the list of particles with the new position


  }
  
  
  updatePixels();
  if (record) {
     saveFrame("output/gr_####.png"); 
  }

  
}

/*This funcion returns the index of the grid from x and y*/

public int Xi(int x, int y)
{
    return x+y*width;
}
  
  
  
/*This class represents a single particle 
It contains the two coordinates of the particle in the grid.
*/


class Particle {
   int px;
   int py;

   /*object constructor*/
   Particle(int x,int y) {
       px=x;
       py=y; 
   }
  

   public void update(){
     int next_p; //This variable will contain the coordinate of the next position according to periodic boundary conditions
     float dir = random(1);
     if(dir<0.25f)
     {
         next_p=(px+width-1)%width;  
         
         /*checking if the next pixel is occupated*/
         
         if(pixels[Xi(next_p,py)]!=  c_part )
         {
           
         /*Moving the particle to the left*/           
           pixels[Xi(px,py)]=c_back;
           px=next_p;
           pixels[Xi(px,py)]=  c_part ;
         }
       
       
     }
     else if(dir>0.75f)
     {
       next_p=(px+1)%width; 
         if(pixels[Xi(next_p,py)]!=  c_part )
         {
         /*Moving the particle to the right*/
           pixels[Xi(px,py)]=c_back;
           px=next_p;
           pixels[Xi(px,py)]=  c_part ;
         }
             
       
     }
     else if(dir>0.5f)
     {
       next_p=(py+height-1)%height;    
         if(pixels[Xi(px,next_p)]!=  c_part )
         {
         /*Moving the particle up */
           pixels[Xi(px,py)]=c_back;
           py=next_p;
           pixels[Xi(px,py)]=  c_part ;
         }
            
       
     }
     else
     {
       next_p=(py+1)%height;  
         if(pixels[Xi(px,next_p)]!=  c_part )
         {
         /*Moving the particle down */                     
           pixels[Xi(px,py)]=c_back;
           py=next_p;
           pixels[Xi(px,py)]= c_part ;
         }
           
       
     }
     
   
   

   }
}
  public void settings() {  size(800,500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "reticular_gas_point_like_PBC" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
