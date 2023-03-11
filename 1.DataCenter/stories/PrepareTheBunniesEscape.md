Prepare the Bunnies' Escape
===========================

You're awfully close to destroying the LAMBCHOP doomsday device and freeing Commander Lambda's bunny workers, but once they're free of the work duties the bunnies are going to need to escape Lambda's space station via the escape pods as quickly as possible. Unfortunately, the halls of the space station are a maze of corridors and dead ends that will be a deathtrap for the escaping bunnies. Fortunately, Commander Lambda has put you in charge of a remodeling project that will give you the opportunity to make things a little easier for the bunnies. Unfortunately (again), you can't just remove all obstacles between the bunnies and the escape pods - at most you can remove one wall per escape pod path, both to maintain structural integrity of the station and to avoid arousing Commander Lambda's suspicions. 

You have maps of parts of the space station, each starting at a work area exit and ending at the door to an escape pod. The map is represented as a matrix of 0s and 1s, where 0s are passable space and 1s are impassable walls. The door out of the station is at the top left (0,0) and the door into an escape pod is at the bottom right (w-1,h-1). 

Write a function solution(map) that generates the length of the shortest path from the station door to the escape pod, where you are allowed to remove one wall as part of your remodeling plans. The path length is the total number of nodes you pass through, counting both the entrance and exit nodes. The starting and ending positions are always passable (0). The map will always be solvable, though you may or may not need to remove a wall. The height and width of the map can be from 2 to 20. Moves can only be made in cardinal directions; no diagonal moves are allowed.

Languages
=========

To provide a Python solution, edit solution.py
To provide a Java solution, edit Solution.java

Test cases
==========
Your code should pass the following test cases.
Note that it may also be run against hidden test cases not shown here.

-- Python cases --
Input:
solution.solution([[0, 1, 1, 0], [0, 0, 0, 1], [1, 1, 0, 0], [1, 1, 1, 0]])
Output:
    7

Input:
solution.solution([[0, 0, 0, 0, 0, 0], [1, 1, 1, 1, 1, 0], [0, 0, 0, 0, 0, 0], [0, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 0]])
Output:
    11

-- Java cases --
Input:
Solution.solution({{0, 1, 1, 0}, {0, 0, 0, 1}, {1, 1, 0, 0}, {1, 1, 1, 0}})
Output:
    7

Input:
Solution.solution({{0, 0, 0, 0, 0, 0}, {1, 1, 1, 1, 1, 0}, {0, 0, 0, 0, 0, 0}, {0, 1, 1, 1, 1, 1}, {0, 1, 1, 1, 1, 1}, {0, 0, 0, 0, 0, 0}})
Output:
    11


```python
class Station:
    def __init__(self, m):
        self.map = m
        self.width = len(m[0])
        self.height = len(m)

    def get_paths(self, sx, sy):
        # Initialize the board to keep track of the shortest path to each cell
        board = [[None for i in range(self.width)] for i in range(self.height)]

        # Set the starting cell's shortest path to 1
        board[sx][sy] = 1

        # Initialize the queue with the starting cell
        q = [(sx, sy)]

        # Loop through the queue until it's empty
        while len(q) > 0:
            x, y = q.pop(0)

            # Check each neighboring cell
            for i in [(1,0),(-1,0),(0,-1),(0,1)]:
                nx, ny = x + i[0], y + i[1]

                # Check that the neighboring cell is within the bounds of the board
                if 0 <= nx < self.height and 0 <= ny < self.width:

                    # Check if the neighboring cell hasn't been visited yet
                    if board[nx][ny] is None:

                        # Set the shortest path to the neighboring cell to be one more than the current cell
                        board[nx][ny] = board[x][y] + 1

                        # If the neighboring cell is a wall, skip it
                        if self.map[nx][ny] == 1:
                            continue

                        # Add the neighboring cell to the queue to visit later
                        q.append((nx, ny))
                    
        # Return the board with the shortest path to each cell
        return board

def solution(map):
    # Initialize the station with the given map
    station = Station(map)

    # Compute the shortest path from the starting cell to each cell on the board
    start_board = station.get_paths(0, 0)

    # Compute the shortest path from each cell on the board to the ending cell
    end_board = station.get_paths(station.height - 1, station.width - 1)

    # Initialize the minimum path length to infinity
    res = float('inf')

    # Loop through each cell on the board
    for i in range(station.height):
        for j in range(station.width):

            # If the cell is reachable from the starting cell and the ending cell, update the minimum path length
            if start_board[i][j] and end_board[i][j]:
                res = min(start_board[i][j] + end_board[i][j] - 1, res)

    # Return the minimum path length
    return res
```