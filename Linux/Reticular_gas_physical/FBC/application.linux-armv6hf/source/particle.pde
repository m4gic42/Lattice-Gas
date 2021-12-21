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
     float dir = random(1);
     if(dir<=0.25)
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
    if(dir>0.75)
     {      
       if(px<width-v-r){
         
         /*If the position to the right is empy it can move*/
         if(controllo(px+v,py,self)!=  1 )
         {

           px+=v;

         }
       }       

     }
    if(dir>0.5 && dir<0.75)
     {
   
       if(py>v+r){
         
       /*If the position over is empy it can move*/       
         if(controllo(px,py-v,self)!= 1 )
         {

           py-=v;

         }
       }      

     }
     if(dir>0.25 && dir<0.5)
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
