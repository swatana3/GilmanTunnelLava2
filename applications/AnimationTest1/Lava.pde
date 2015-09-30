class Lava {
 PShape layer1;
 PShape layer2;
 PShape layer3;
 //float x;
 //float y;
 //float width_shape; //width of shape
 //float height_shape; //height of shape
 
 Lava(PShape layer1, PShape layer2, PShape layer3){ 
    this.layer1 = layer1;
    this.layer2 = layer2;
    this.layer3 = layer3;
 }
  
 //move layers speed_1 = speed of first layer etc
 void moveLayers(float speed_1, float speed_2, float speed_3) {
   layer1.scale(speed_1);
   //println("speed_1 is: "+ speed_1);
   layer2.scale(speed_2);
   layer3.scale(speed_3);
   
    
 }
 //displays the layers 
 void display(){
   background(255);
   shape(layer3, 700, 105, -600, 200);
   shape(layer2, 630, 145, -450, 110);
   shape(layer1, 590, 160, -330, 70);
 }
}