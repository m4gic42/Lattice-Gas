
/*
This script is a simulation of a reticular gas in periodic boundary conditions.
In this model a pixel represent a particle and the controls of their movement
is based only on the color of pixel in the canvas.
The single parameter is the density of on pixel.

Hit 'r' on the keyboard to record frames of the simulation in /output directory
*/

float dens=0.02;
ArrayList<Particle> Gas;
color c_part=    #467ca5   ; //Color of a particle
color c_back=   #e3e9e9  ; //Color of the background
boolean record=false;


void setup(){
  size(800,500); //Bulding a canvas width x height
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
void keyPressed(){
  if(key == 'r' || key =='R'){
    record = !record;
  }
  
}

void draw()
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

int Xi(int x, int y)
{
    return x+y*width;
}
  
  
  
