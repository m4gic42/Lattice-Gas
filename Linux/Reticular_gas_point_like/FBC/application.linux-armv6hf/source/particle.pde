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
     
     float dir = random(1);
     if(dir<0.25)
     {
       /*If it isn't near the border it can move*/
       if(px!=0){
         
         /*checking if the next pixel is occupated*/
         
         if(pixels[Xi(px-1,py)]!=  c_part )
         {
         /*Moving the particle to the left*/
           pixels[Xi(px,py)]=c_back;
           px--;
           pixels[Xi(px,py)]=  c_part;
         }
       }
       
     }
     else if(dir>0.75)
     {
       if(px!=width-1){
         if(pixels[Xi(px+1,py)]!=  c_part )
         {
         /*Moving the particle to the right*/
           pixels[Xi(px,py)]=c_back;
           px++;
           pixels[Xi(px,py)]=  c_part ;
         }
       }       
       
     }
     else if(dir>0.5)
     {
       if(py!=0){
         if(pixels[Xi(px,py-1)]!=  c_part )
         {
         /*Moving the particle up */
           pixels[Xi(px,py)]=c_back;
           py--;
           pixels[Xi(px,py)]=  c_part ;
         }
       }      
       
     }
     else
     {
       if(py!=height-1){
         if(pixels[Xi(px,py+1)]!=  c_part )
         {
         /*Moving the particle down */           
           pixels[Xi(px,py)]=c_back;
           py++;
           pixels[Xi(px,py)]= c_part ;
         }
       }     
       
     }
     
   
   

   }
}
