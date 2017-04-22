/**
Cheetah type Predator. It goes to a point halfway between the Rabbit and the goal.
**/
public class Cheetah extends Predator {
  
  /**
  Constructor
  **/
  public Cheetah(CoordinateInt position, Double speed, PImage image, World world) {
    super(position, speed, image, world);
  }
  
  /**
  Calculate the halfway point between Rabbit and goal.
  **/
  protected void calculateDestination() {
    // try to intercept Rabbit halfway between his current position and the goal
    // calculate half way point
    CoordinateInt Rabbit = this.getWorld().positionToGrid(this.getWorld().getRabbit().getPosition());
    CoordinateInt goal = this.getWorld().getPrinciple().getGoal(); 
    int x = (Rabbit.getX() + goal.getX()) / 2;
    int y = (Rabbit.getY() + goal.getY()) / 2;
    CoordinateInt destination = new CoordinateInt(x, y);
   
    // make sure the destination is walkable. if not, choose a destination closer to the Rabbit.
    // the algorithm ends, because the last destination picked is the position of the Rabbit, which is always walkable
    while (!this.getWorld().isWalkable(destination)) {
      // take a look at which dimension is further away from Rabbit and decrease that one 
      int gradientX = destination.getX() - Rabbit.getX();
      int gradientY = destination.getY() - Rabbit.getY();
      // change x coordinate
      if (abs(gradientX) > abs(gradientY)) {
        int unit = gradientX > 0 ? 1 : -1;
        destination.set(destination.getX() - unit, destination.getY());
      }
      // change y coordinate
      else {
        int unit = gradientY > 0 ? 1 : -1;
        destination.set(destination.getX(), destination.getY() - unit);
      }
    }
    
    this.setDestination(destination);
  }
  
}
