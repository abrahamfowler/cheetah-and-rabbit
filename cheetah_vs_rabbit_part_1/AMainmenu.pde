

/*
Controls: Click where you want to go. p or P pauses the game.

 The goal is to reach the green square, while avoiding the hunting cheetah . There are some obstacles, indicating squares that cannot be visited.
The hunting plredators have different strategies. The first one follows you around. It goes where you go. The second one is an Cheetah that always tries to go between you and the goal. The third one tries to cut off posible escape routes. Its position depends on that of the other Predators. Together they form a coordinated team.
All Predators use A* for path finding. Path finding is performed on the squares (the grid), and is therefore quick enough to allow recalculation of the path in real time. Cost between horizontally or vertically adjacent squares is 1 and sqrt(2) for diagonally adjacent squares. The heuristic uses the euclidean distance. 


*/

import java.util.Iterator;

// constants
final int NUM_OBSTACLES = 3;
final int OBSTACLE_SPRITES = 4;
final double Rabbit_SPEED = 2.0;

final double Cheetah_SPEED = 1.1;
final double ROUTE_CUTTER_SPEED = 1.0;
final int SCREEN_SIZE_X = 640;
final int SCREEN_SIZE_Y = 480;
final int WORLD_SIZE_X = 640;
final int WORLD_SIZE_Y = 480;
final int GRID_SIZE_X = 32;
final int GRID_SIZE_Y = 24;
final int WALKABLE_COLOR = #FFD700;
final int NON_WALKABLE_COLOR = #FF1000;

// images
final String WORLD_IMAGE = "Background.jpg";
final String OBSTACLE_IMAGE = "obstacle.png";
final String Rabbit_IMAGE = "Rabbit.png";

final String Predator_Cheetah_IMAGE = "Predator_Cheetah.png";
final String Predator_ROUTE_CUTTER_IMAGE = "Predator_route_cutter.png";
final String CLICK_TO_PLAY_IMAGE = "click_to_play.png";
final String YOU_WON_IMAGE = "you_won.png";
final String YOU_LOST_IMAGE = "you_lost.png";

// objects
World world;
View view;
Principle Principle;
ArrayList<Obstacle> obstacles;
Rabbit Rabbit;
ArrayList<Predator> Predators;
// the next two lists contain the objects of the world to be drawn.
// the difference between the two is that animations can expire.
ArrayList<Design> Designs; 
ArrayList<Animation> animations;

// control flow
final int PLAYING = 0;
final int PAUSED = 1;
final int WON = 2;
final int LOST = 3;
int state;

// text images
PImage clickToPlay;
PImage youWon;
PImage youLost;


/**
one time init
**/
void setup() {
  
  size(SCREEN_SIZE_X, SCREEN_SIZE_Y);
  background(0);
  imageMode(CORNER);
  
  // create the world
  PImage worldImage = loadImage(WORLD_IMAGE);
  world = new World(WORLD_SIZE_X, WORLD_SIZE_Y, GRID_SIZE_X, GRID_SIZE_Y, worldImage);
   
  // create the View
  view = new View(world);
 
  // create the obstacles
  PImage obstacleImage = loadImage(OBSTACLE_IMAGE); // http://www.widgetworx.com/spritelib/
  int spriteNumber = OBSTACLE_SPRITES;
  int spriteWidth = obstacleImage.width / spriteNumber;
  PImage[] obstacleSprites = new PImage[spriteNumber];
  for (int i = 0; i < spriteNumber; i++) {
    obstacleSprites[i] = obstacleImage.get(i * spriteWidth, 0, spriteWidth, obstacleImage.height);
  }
  obstacles = new ArrayList<Obstacle>();
  for (int i = 0; i < NUM_OBSTACLES; i++) {
    Obstacle obstacle = new Obstacle(null, obstacleSprites, world); // position will be assigned later, so set it to null for the time being
    obstacles.add(obstacle);
  }
 
  // load textImages
  clickToPlay = loadImage(CLICK_TO_PLAY_IMAGE);
  youWon = loadImage(YOU_WON_IMAGE);
  youLost = loadImage(YOU_LOST_IMAGE);
 
  // load and init objects that have to be initialized again for each new game
  load();
  
}

/**
load and init objects that have to be loaded for each new game
**/
void load() {
  
  // create the Principle and tell the world about them
  Principle = new Principle(world);
  world.registerPrinciple(Principle);
  
  // position obstacles
  world.positionObstacles(obstacles);
  
  // create the Rabbit and tell the world about it
  PImage RabbitImage = loadImage(Rabbit_IMAGE);
  Rabbit = new Rabbit(Principle.generateRabbitStart(), Rabbit_SPEED, RabbitImage, world);
  world.registerRabbit(Rabbit);
  
  // create the Predators and tell the world about them
  Predators = new ArrayList<Predator>();
 
  // Cheetah
  PImage CheetahImage = loadImage(Predator_Cheetah_IMAGE);
  Cheetah Cheetah = new Cheetah(Principle.generatePredatorStart(Rabbit), Cheetah_SPEED, CheetahImage, world);
  Predators.add(Cheetah);
  // square
  //PImage routeCutterImage = loadImage(Predator_ROUTE_CUTTER_IMAGE);
  //RouteCutter routeCutter = new RouteCutter(Principle.generatePredatorStart(Rabbit), ROUTE_CUTTER_SPEED, routeCutterImage, world);
  //Predators.add(routeCutter);
  // tell world
  world.registerPredators(Predators);
  
  // create Design list
  Designs = new ArrayList<Design>();
  
  // put Designs in list
  Designs.add(world);
  Designs.add(Principle);
  for (Obstacle obstacle : obstacles) {
    Designs.add(obstacle);
  }
  Designs.add(Rabbit);
  for (Predator Predator : Predators) {
    Designs.add(Predator);
  }
  
  // create animation list
  animations = new ArrayList<Animation>();
  
  // set state
  state = PAUSED;
  
}

/**
main loop
**/
void draw() {

  // do stuff
  if (state == PLAYING) {
    Rabbit.doSomething();
    // we're nice and check for winning conditions first
    if (Principle.checkWon()) {
      state = WON;
    }
    else {
      // only move the enemies if the player has not won
      for (Predator Predator : Predators) {
        Predator.doSomething();
      }    
      // check if a Predator caught the player
      if (Principle.checkLost()) {
        state = LOST;
      }
    }
  }

  // draw stuff
  
  // clear buffer
  background(0);

  // Designs
  for (Design Design : Designs) {

    Design.draw(view);
  }  

  // animations  
  Iterator<Animation> animationIterator = animations.iterator();
  while (animationIterator.hasNext()) {
    Animation animation = animationIterator.next();
    animation.draw(view);
    // animation objects die after their animation has ended
    if (animation.hasExpired()) {
      animationIterator.remove();
    }
  }
 
  // text
  if (state != PLAYING) {
    imageMode(CENTER);
    image(clickToPlay, SCREEN_SIZE_X / 2, SCREEN_SIZE_Y / 2);
    if (state == WON) {
      image(youWon, SCREEN_SIZE_X / 2, SCREEN_SIZE_Y / 2 );
    }
    else if (state == LOST) {
      image(youLost, SCREEN_SIZE_X / 2, SCREEN_SIZE_Y / 2);
    }
  }

}

/**
mouse clicked event
**/
void mouseClicked() {

  // if we are not currently playing, a mouse click starts the game
  if (state != PLAYING) {
    // if we just finished a game, load a new one
    if (state != PAUSED) {
      load();
    }
    state = PLAYING;
  }
  // otherwise, the click tells the Rabbit where to go
  else {
    int colour;
    CoordinateInt gridPosition = view.gridPosition(new CoordinateInt(mouseX, mouseY));
    // we can only go to walkable squares. different colors for the clicking animation help the player
    if (world.isWalkable(gridPosition)) {
      colour = WALKABLE_COLOR;
      Rabbit.setDestination(gridPosition);
    }
    else {
      colour = NON_WALKABLE_COLOR;
    }
    animations.add(new PathwayAnimation(gridPosition, world.getTileSize(), colour));
  }

}

/**
key pressed event
**/
void keyPressed() {
  if (key == 'p' || key == 'P') {
    state = PAUSED;
  }
}
