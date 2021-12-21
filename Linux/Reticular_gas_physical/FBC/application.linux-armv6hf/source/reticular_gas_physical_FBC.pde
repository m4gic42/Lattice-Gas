
/*
This script is a simulation of a reticular gas in fixed boundary conditions.
The parameters are:
r: radius of a singular particle of the gas;
v: velocity of a singular particle of the gas;
dens: density of particles in the grid;

Hit 'r' on the keyboard to record frames of the simulation in /output directory
*/


float dens=0.4;
ArrayList<Particle> Gas;
color c_part=  #FFFFFF ; //Color of a particle
color c_back=   #e3e9e9  ; //Color of the background
boolean record=false;
int r=10;
float v=5;

void setup(){
  size(800,800);   //Bulding a canvas width x height
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

void keyPressed(){
  if(key == 'r' || key =='R'){
    record = !record;
  }
  
}

void draw()
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


  
  
