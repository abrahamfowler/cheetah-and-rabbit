

public class Cheetah extends Predator {
  
  /**
  Constructor
  **/
  public Cheetah(CoordinateInt position, Double speed, PImage image, World world) {
    super(position, speed, image, world);
  }
  
  /**
  Go to where the Rabbit is
  **/
  protected void calculateDestination() {
    this.setDestination(this.getWorld().positionToGrid(this.getWorld().getRabbit().getPosition()));
    
  }
}
