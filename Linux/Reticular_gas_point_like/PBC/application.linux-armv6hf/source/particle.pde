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
  

   void update(){
     int next_p; //This variable will contain the coordinate of the next position according to periodic boundary conditions
     float dir = random(1);
     if(dir<0.25)
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
     else if(dir>0.75)
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
     else if(dir>0.5)
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
