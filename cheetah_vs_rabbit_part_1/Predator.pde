import pathfinder.*;
import java.util.LinkedList;

/**
Parent class for all the Predators
**/
public abstract class Predator extends Entity {
  
  private GraphSearch_Astar _aStar;
  
  /**
  Constructor. Initializes A*
  **/
  public Predator(CoordinateInt position, Double speed, PImage image, World world) {
    super(position, speed, image, world);
    _aStar = new GraphSearch_Astar(world.getGraph());
  }
  
  /**
  Main loop for Predators. First, calculate the destination, which is different depending on the strategy the Predator uses.
  Then apply A* to find a path to the destination. Next, go towards the closest node on the path.
  **/
  public void doSomething() {
    // have the child calculate the destination
    calculateDestination();
    
    // execute A* to get the next node on the path to the destination
    CoordinateInt gridPosition = this.getWorld().positionToGrid(this.getPosition()); 
    int from = gridPosition.getY() * this.getWorld().getGridSize().getX() + gridPosition.getX();
    int to = this.getDestination().getY() * this.getWorld().getGridSize().getX() + this.getDestination().getX();
    // don't do anything if we are already at the destination. the A* library does not seem to like this
    if (from == to) {
      return;
    }

    // the search can throw a null pointer exception. we have no path in that case, so the Predator can't move. we simply exit the method.
    LinkedList<GraphNode> nodes;
    try {
      nodes = _aStar.search(from, to);
    }
    catch (NullPointerException e) {
      return;
    }
    
    // try to reach the second element in the list (if it exists). the first one is our current position
    if (nodes.pollFirst() != null) {
      GraphNode next = nodes.pollFirst();
      if (next != null) {
        // calculate x and y from the node id
        int x = next.id() % this.getWorld().getGridSize().getX();
        int y = next.id() / this.getWorld().getGridSize().getX();
        // set the destination as the next node
        this.setDestination(new CoordinateInt(x, y));
        // move the Predator
        move();
      }
    }
  }
  
  /**
  Method to find the destination of a Predator. It will depend on the Predator's strategy.
  **/
  protected abstract void calculateDestination();
  
}

/*Put node_start in the OPEN list with f(node_start) = h(node_start) (initialization)
 2 while the OPEN list is not empty {
 3 Take from the open list the node node_current with the lowest
 4 f(node_current) = g(node_current) + h(node_current)
 5 if node_current is node_goal we have found the solution; break
 6 Generate each state node_successor that come after node_current
 7 for each node_successor of node_current {
 8 Set successor_current_cost = g(node_current) + w(node_current, node_successor)
 9 if node_successor is in the OPEN list {
 10 if g(node_successor) ≤ successor_current_cost continue (to line 20)
 11 } else if node_successor is in the CLOSED list {
 12 if g(node_successor) ≤ successor_current_cost continue (to line 20)
 13 Move node_successor from the CLOSED list to the OPEN list
 14 } else {
 15 Add node_successor to the OPEN list
 16 Set h(node_successor) to be the heuristic distance to node_goal
 17 }
 18 Set g(node_successor) = successor_current_cost
 19 Set the parent of node_successor to node_current
 20 }
 21 Add node_current to the CLOSED list
 22 }
 23 if(node_current != node_goal) exit with error (the OPEN list is empty)*/
