/**
The Rabbit who must flee from the Predators
**/
public class Rabbit extends Entity {
  
  /**
  Constructor
  **/  
  public Rabbit(CoordinateInt position, Double speed, PImage image, World world) {
    super(position, speed, image, world);
  }
  
  /**
  A Rabbit only moves, since his destination is defined by the player through mouse clicks
  **/
  public void doSomething() {
    move();
  }
  
}
