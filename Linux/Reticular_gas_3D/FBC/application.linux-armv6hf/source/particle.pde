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
  
  void show()
  {
    
    /*Drawing a sphere of color c_part and radus r in the current position of the particle*/
   
    fill(c_part);
    noStroke();
    lights();
    translate(px,py,pz);
    sphere(r);
    translate(-px,-py,-pz);
    
    
    
  }

void update(int self){
  
     /*Generating a random number to set a random direction for the particle*/
     int dir = int(random(1,7));
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
   int controllo(float nx, float ny, float nz, int self){
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
   float dist(Particle p1, Particle p2)
   {
       return sqrt((p1.px-p2.px)*(p1.px-p2.px)+(p1.py-p2.py)*(p1.py-p2.py)+(p1.pz-p2.pz)*(p1.pz-p2.pz));
     
   }
}
