/**
Class that implements the Principle of the game
**/
public class Principle implements Design {
  
  private final int _GOAL_COLOR = #00FF00;
  private final int _GOAL_ALPHA_HIGH = 250;
  private final int _GOAL_ALPHA_LOW = 20;
    
  private World _world;
  private CoordinateInt _goal;
  private int _alpha;
  private int _alphaStep;
  
  /**
  Constructor
  **/
  public Principle(World world) {
    _world = world;
    _alpha = _GOAL_ALPHA_HIGH;
    _alphaStep = -1;
    generateGoal();
  }
  
  /**
  Place the goal
  **/
  private void generateGoal() {
    // goal is a random location on the last column
    int x = _world.getGridSize().getX() - 1;
    int y = (int) random(_world.getGridSize().getY());
    _goal = new CoordinateInt(x, y);
  }
  
  /**
  Place the Rabbit
  **/
  public CoordinateInt generateRabbitStart() {
     // Rabbit start is a random location on the first column
    int y = (int) random(_world.getGridSize().getY());
    return new CoordinateInt(0, y);
  }
  
  /**
  Place a Predator
  **/
  public CoordinateInt generatePredatorStart(Rabbit Rabbit) {
    // Predators start int the center top or center bottom, opposite to where the Rabbit is
    CoordinateInt start;
    // loop to make sure the Predator's position is walkable
    do { 
      int x = (int) (_world.getGridSize().getX() / 2) + (int) random(_world.getGridSize().getX() / 4 + 1) - (int) (_world.getGridSize().getX() / 8);
      int y = (int) random(_world.getGridSize().getY() / 8 + 1);
      // see if the Rabbit is in the top half and put Predators in botton half in that case
      if (_world.positionToGrid(Rabbit.getPosition()).getY() < _world.getGridSize().getY() / 2) {
        y = _world.getGridSize().getY() - 1 - y;
      }
      start = new CoordinateInt(x, y);
    } while (!_world.isWalkable(start));
        
    return start;
  }
  
  /**
  Place an obstacle
  **/
  public CoordinateInt generateObstaclePosition() {
     // obstacles are placed on random positions except the first and last column
     CoordinateInt position;
     // loop to prevent assigning two obstacles to the same grid position
     do {
       int x = (int) random(_world.getGridSize().getX() - 2) + 1;
       int y = (int) random(_world.getGridSize().getY());
       position = new CoordinateInt(x, y); 
     } while (!_world.isWalkable(position));
     
     return position;
  }
  
  /**
  Draw the goal. It is a flashing green square
  **/
  public void draw(View view) {
    // alpha varies between two boundaries. it goes back and forth
    if (_alpha >= _GOAL_ALPHA_HIGH) {
      _alphaStep = -4;
    }
    else if (_alpha <= _GOAL_ALPHA_LOW) {
      _alphaStep = 4;
    }
    _alpha += _alphaStep;
    
    // draw the goal tile
    imageMode(CORNER);
    CoordinateInt position = view.convert(_goal);
    noStroke();
    fill(_GOAL_COLOR, _alpha);
    rect(position.getX(), position.getY(), view.convert(_world.getTileSize()).getX(), view.convert(_world.getTileSize()).getY());
  }
  
  /**
  Check winning condition, i.e. the Rabbit has reached the goal.
  Position is checked against the grid.
  **/
  public boolean checkWon() {
    return _world.positionToGrid(_world.getRabbit().getPosition()).equals(_goal);
  }
  
  /**
  Check losing condition, i.e. a Predator has caught the Rabbit.
  Position is checked against the grid.
  **/
  public boolean checkLost() {
    CoordinateInt RabbitPosition = _world.positionToGrid(_world.getRabbit().getPosition());
    for (Predator Predator : _world.getPredators()) {
      if (_world.positionToGrid(Predator.getPosition()).equals(RabbitPosition)) {
        return true;
      } 
    }
    return false;
  }
  
  /**
  Goal getter
  **/
  public CoordinateInt getGoal() {
    return _goal;
  }
}
