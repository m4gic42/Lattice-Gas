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
  
  void show()
  {
    /*Drawing a circle of color c_part and radus r in the current position of the particle*/
     fill(c_part);
     //noStroke();
     ellipse(px,py,2*r,2*r);
  }


   void update(int self){
     
     /*Generating a random number to set a random direction for the particle*/
     float next_p; //This variable will contain the coordinate of the next position according to periodic boundary conditions
     float dir = random(1);
     if(dir<=0.25)
     {
         next_p=(px+width-v)%width; 
         
         /*If the position to the left is empy it can move*/         
         if(controllo(next_p,py,self)!=1 )
         {
           px-=v;

         }


     }
    if(dir>0.75)
     {
       next_p=(px+v)%width;
       
         /*If the position to the right is empy it can move*/
         if(controllo(next_p,py,self)!=  1 )
         {

           px+=v;

         }
  

     }
    if(dir>0.5 && dir<0.75)
     {
       next_p=(py+height-v)%height;  
       
       /*If the position over is empy it can move*/       
         if(controllo(px,next_p,self)!= 1 )
         {

           py-=v;

         }
   

     }
     if(dir>0.25 && dir<0.5)
     {
       next_p=(py+v)%height;  
    
       /*If the position below is empy it can move*/       
         if(controllo(px,next_p,self)!=  1 )
         {

           py+=v;

         }  

     }
     


   }
   
   
   /*This funcion controls if the particle is bumping into another particle*/
   int controllo(float nx, float ny,float self){
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
   float dist(Particle p1, Particle p2)
   {
       return sqrt((p1.px-p2.px)*(p1.px-p2.px)+(p1.py-p2.py)*(p1.py-p2.py));
     
   }
}
