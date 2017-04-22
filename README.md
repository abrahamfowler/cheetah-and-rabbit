# Cheetah and Rabbit Game

The task at hand was to create a game in which we had two entities - those being a cheetah and a rabbit. The aim of the game was to simulate a real life hunting experience in which the cheetah would chase down the rabbit and ‘eat’ it. You should be able to control the rabbit, and the cheetah would use artificial intelligence to locate the rabbit and block it from getting to it’s target and/or hunt it down. The way in which we achieved this was by applying an algorithm to the cheetah which enabled it to track the position of the rabbit and respond accordingly. In part one of the programme, we decided to use a Manhattan distance A* related algorithm to choose the cheetahs movements. This stopped it from chasing the rabbit but allowed it to intercept the rabbit on the way to it’s destination. This formula states that the distance of the sum of the all the Xi values minus the Yi values increasing through increments of i up to n will equate to the distance calculated.
 
The Manhattan distance function computes the distance that would be traveled to get from one data point to the other if a grid-like path is followed. The Manhattan distance between two items is the sum of the differences of their corresponding components. (1) It does this by using the formula:

<img width="455" alt="screen shot 2017-04-22 at 11 37 15" src="https://cloud.githubusercontent.com/assets/22246185/25303769/741325f6-2751-11e7-9453-d8a4a22a91c9.png">

This formula states that the distance of the sum of the all the Xi values minus the Yi values increasing through increments of 'i' up to 'n' will equate to the distance calculated.

<img width="736" alt="screen shot 2017-04-22 at 11 37 34" src="https://cloud.githubusercontent.com/assets/22246185/25303835/b33805b6-2752-11e7-9d8b-f5196df4b716.png">



