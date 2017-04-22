# Cheetah and Rabbit Game

# Part 1

The task at hand was to create a game in which we had two entities - those being a cheetah and a rabbit. The aim of the game was to simulate a real life hunting experience in which the cheetah would chase down the rabbit and ‘eat’ it. You should be able to control the rabbit, and the cheetah would use artificial intelligence to locate the rabbit and block it from getting to it’s target and/or hunt it down. The way in which we achieved this was by applying an algorithm to the cheetah which enabled it to track the position of the rabbit and respond accordingly. In part one of the programme, we decided to use a Manhattan distance A* related algorithm to choose the cheetahs movements. This stopped it from chasing the rabbit but allowed it to intercept the rabbit on the way to it’s destination. This formula states that the distance of the sum of the all the Xi values minus the Yi values increasing through increments of i up to n will equate to the distance calculated.
 
The Manhattan distance function computes the distance that would be traveled to get from one data point to the other if a grid-like path is followed. The Manhattan distance between two items is the sum of the differences of their corresponding components. (1) It does this by using the formula:

<img width="455" alt="screen shot 2017-04-22 at 11 37 15" src="https://cloud.githubusercontent.com/assets/22246185/25303769/741325f6-2751-11e7-9453-d8a4a22a91c9.png">

This formula states that the distance of the sum of the all the Xi values minus the Yi values increasing through increments of 'i' up to 'n' will equate to the distance calculated.

<img width="736" alt="screen shot 2017-04-22 at 11 37 34" src="https://cloud.githubusercontent.com/assets/22246185/25303835/b33805b6-2752-11e7-9d8b-f5196df4b716.png">

These are the lines of code in our coursework that incorporate the formula where x1 and y1 equal the coordinates of the rabbit respectively. And where x2 and y2 equal the corresponding values of the closest borough.

<img width="664" alt="screen shot 2017-04-22 at 11 37 43" src="https://cloud.githubusercontent.com/assets/22246185/25303840/df2126b2-2752-11e7-8a47-03acdcf528f1.png">

This is a print screen of our game and as you can see the cheetah will position itself in between the Rabbit and its destination using Manhattan distance. The red curve in between them is the general path that the cheetah would take dependant on where the user decides to position the rabbit.

Although not visible, the user can only position the rabbit in a set space on the screen. The user cannot choose any single position as the terrain is made of up a ‘hidden’ grid. Therefore, only values on that grid are acceptable when moving the rabbit. This was achieved using vectors to create individual ‘tiles’ each with their own set of x and y coordinates. The grid understands the ‘empty’ positions and the ‘taken’ positions. This means that if the user was to click on a ‘taken’ position the click would turn red. The taken positions in this case being the obstacles. Which are highlighted in the print screen above. The grid was constructed using an array list and so were the obstacles. This allowed us to make the game as large and as difficult as we pleased by just changing the variables in those lists.

Making the grid was the first thing we decided to do as it made it easier for us to implement the algorithms. The vector tile based system enabled us to gather coordinates in a simple and effective way. We found this to be one of the strong points of our work as a non-tile based approach would’ve, although been more fluid, much more difficult to execute.

I used a linked list to implement the A* algorithm. This was done by using a grid to perform our path calculations. Within the boundaries of the grid, it initialises the pathfinder by putting (f(node_start) = (h(node_start)) in the open list. While the list is not empty, a graph search to search for the next neighbouring node with the lowest (g) cost was used. If the current node is equal to our goal node then break, because the cheetah has caught the rabbit. This will take you onto a separate page telling you that you have lost. If not, then we generate each node that comes after the current node, known as the successor node. For each of those we set the successor node’s cost, and continue to add it to the open list. The difference between an open list and a closed list is:

- State
- Open: not yet explored 
- Closed: explored

Linked lists will take two arguments: a pointer to the first node in the list, and the value for which we are searching. The function will return a node to the list structure containing the correct data, or it will return NULL if the value wasn’t found.

All in all, we believe that part one of our cheetah vs rabbit game is an accurate simulation of a real world experience as the cheetah uses its own intelligence to intercept the rabbit on the path to it’s destination. It not only executes well but looks and feels like an enjoyable and well presented game. Be that the animations used (2)(3) or the ‘you lost’/’you won’ pages. It gives it the overall feel that we didn’t just do the bare minimum to create this game. A short coming of our programme is the fact that dependant on where the rabbit spawns and where its destination is (both random y values on polar sides of the x spectrum), it could be one straight line from the rabbit to go to the destination thus not giving the cheetah a chance to get into its position in time to stop it. This is something that we tried to fix in part 2 of our coursework.

# Part 2

The second task at hand was to further develop our first game, using our own intuition and creativity to add a personal touch to our project. As well as this we were instructed to print out the rabbit’s path after the game has ended, something which we were unfortunately unable to do. We imported the path finder library from Processing libraries to allow our pathfinding to run. We again used the vector grid system to set up our background.

We have used a two to three dimensional vector, specifically a Euclidean (also known as geometric) vector. Since a vector is an entity that has both magnitude and direction. The datatype, however, stores the components of the vector (x,y for 2D, and x,y,z for 3D). The magnitude and direction can be accessed via the methods magnitude and heading.

you will see PVector used to describe a position, velocity, or acceleration. For example, in our game we have to take into consideration a rabbit moving across the screen, at any given instant it has a position (a vector that points from the origin to its location), a velocity (the rate at which the object's position changes per time unit, expressed as a vector), and acceleration (the rate at which the object's velocity changes per time unit, expressed as a vector).

Our first addition to the game was to increase the number of obstacles. This tackled one of our main issues in the first half of the project as it prevented the likelihood of a straight path from rabbit to destination. Therefore, giving more time for the cheetah to get into place. With more obstacles, we needed to make sure our collision detection was correct so we used Booleans and if statements.

Another idea we applied to our game was the addition of a second cheetah. This was to increase the difficulty level slightly and give the player something else to consider. The advantage of adding a second cheetah was that we could give it a different algorithm to use, thus adding a different dimension to the game altogether. With the second cheetah, we wanted it to chase the rabbit everywhere it went. At first we considered the Greedy Search algorithm because we thought that it would give the effect of a really hungry cheetah eager to catch its prey, but after implementing it we realised it was too quick to catch the rabbit and took out the playable aspect of the game - making it boring and unreasonable. We then decided that an A* Search algorithm could give us the movements we were looking for.

This was implememented by calculating the destination between the starting point and the destination which refers to the rabbit and cheetah. Then, I implemented a graph search that double-checks if the whole grid has been searched. After that, I created an open list which scans the whole grid and lists all the places the rabbit hasn’t been to and allows the predator to make a move. The open list gets all the nodes surrounding the rabbit and picks the smallest one for the predator to target. After applying the open list, we were able to execute the A* search to get the next node to lead the cheetah to its destination.

After adding the second cheetah I thought that I could try to make it reflect real life a little more. I tried to add another dynamic by bringing a third cheetah into the mix. This is because cheetahs in real life hunt in packs. This third cheetah would again, have to use a different search algorithm to give the user optimum things to focus on. The third would use a similar algorithm to the first (Manhattan Distance). I used the Euclidean distance. This, like using the Manhattan distance, calculates the distance between two items using the sum of the differences of their corresponding values. However, instead of using horizontal and vertical distances, it calculates the diagonal distance via Pythagoras’ theorem. The sum of the vertical distance squared and the horizontal distance squared equates to the squared distance of the diagonal axis. The formula is: A2 + B2 = C2. They both function in the same way but having both stops the rabbit from moving horizontally, vertically and diagonally. This makes the game much harder for the user and decreases the likelihood of winning greatly.

<img width="794" alt="screen shot 2017-04-22 at 11 55 32" src="https://cloud.githubusercontent.com/assets/22246185/25303976/912b002e-2755-11e7-85a5-d6d4e5a18856.png">

This is a print screen of part two of our game. It is evident that there are clearly many more obstacles than in the part one of the coursework, obstructing a straight path from rabbit to destination. You can also clearly see that one cheetah is headed directly towards the rabbit (using the A* Search Algorithm) whereas the other two are positioning themselves using the Euclidean distance and Manhattan distance to try and block the rabbit from reaching its destination alive.

<img width="697" alt="screen shot 2017-04-22 at 11 55 40" src="https://cloud.githubusercontent.com/assets/22246185/25303986/ca6f3224-2755-11e7-8c48-afe3292e4358.png">

This is a print screen of our you lost page. A feature that doesn’t add to the game but gives it a more professional look.
The way our classes connect is that they use inheritance to extend from one another – such as Predator being a superclass to all the cheetah classes. We used things such as mousePressed to allow the user to move the rabbit instead of keypressed as it allowed the user to decide exactly where on the map they wished to move to.

I believe that if I had more time, I would’ve implemented a ‘rewards’ system that enabled the rabbit to pick up a carrot on screen which would give it an extra life. I didn’t manage to use stacks and queues because we were unsure of how to implement it correctly using processing but found processing an easier language to accomplish the rests of the game. The addition of two more cheetahs that all think differently was definitely a plus in our game and it’s probably the thing we’re proudest of. The look and feel of the game as well as the algorithms used makes it an all around refined game.

Bibliography:
(1) -
http://www.improvedoutcomes.com/docs/WebSiteDocs/Clustering/Clustering_Para meters/Manhattan_Distance_Metric.html
Used a couple of lines from this website to better explain the use of the Manhattan distance. The formula was also obtained from the same website.
(2) - http://www.reinerstilesets.de
This was the site we used to obtain the sprites for our rabbit and cheetah.
(3) - http://gmc.yoyogames.com/index.php?showtopic=569407 We used this site to get our background image
(4) - http://www.spriters-resource.com/playstation/breathoffire3/sheet/40440/ This site was used to obtain the sprites for our obstacles.
