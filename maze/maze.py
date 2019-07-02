import json
import requests
from retrying import retry

# Four cardinal direction of movements.
DIRS = [[1, 0], [-1, 0], [0, -1], [0, 1]]        
CHECK_CELL_URL_TEMPLATE = ('https://maze.coda.io/maze/'
                           '{0}/check?x={1}&y={2}')

# Retry limit on server error
RETRIES = 3
SERVER_ERROR_CODE = 500

class Maze(object):
    '''Represents a maze. Serves as a proxy of the maze that is
    stored on the server.
    
    Maintains local cache for each check result.
    '''
    def __init__(self, json):
        self.id = json['id']
        self.height = json['height']
        self.width = json['width']
        self.cache = {}

    def __repr__(self):
        debug_map = ''
        for x in range(self.height):
            row = []
            for y in range(self.width):
                if (x, y) not in self.cache:
                    row.append('-')
                else:
                    row.append('1' if self.cache[x, y] else '0')
            debug_map += '\n' + ' '.join(row)
        return 'id: {0}, height: {1}, width: {2}\ncache: {3}'.format(
            self.id, self.height, self.width, debug_map)

    def log(self, msg, *kargs):
        print(msg.format(*kargs))

    def check(self, x, y):
        ''' Returns True if the given coordinate is valid and
        is avilable in the maze.
        
        Raises IOError if the maze server is unavailable.
        '''
        if (x < 0 or x >= self.height or y < 0 or y >= self.width):
            return False
        
        @retry(stop_max_attempt_number=RETRIES)
        def checkServer(x, y):
            self.log('Checking server for: {0}', (x, y))
            r = requests.get(CHECK_CELL_URL_TEMPLATE.format(self.id, x, y))
            self.log('Response: {0}', r)
            if r.status_code >= SERVER_ERROR_CODE:
                raise IOError('Server Error: %s' % r)
            return r.ok

        if (x, y) not in self.cache:
            self.cache[x, y] = checkServer(x, y)

        return self.cache[x, y]

class MazeSolver(object):
    ''' Solves the maze using simple DFS.
    '''
    def __init__(self, maze):
        self.maze = maze
        self.visited = set()

    def _solve(self, x=0, y=0):
        ''' Internal helper method. Returns a path from the given
        coordinate to the bottom right corner (destination) of the maze. 
        If no such path exits, returns an empty list.
        '''
        if not self.maze.check(x, y) or (x, y) in self.visited:
            return []
        
        self.visited.add((x, y))

        if (x == self.maze.height - 1
            and y == self.maze.width - 1):
            return [(x, y)]
        
        for dx, dy in DIRS:
            next_path = self._solve(x+dx, y+dy)
            if next_path:
                return [(x, y)] + next_path
            
        self.visited.remove((x,y))
        return []

    def solve(self):
        ''' Returns a path from the top-left corner (source) to
        the bottom-right corner (destination). 
        If no such path exists, returns an empty list.
        '''
        return [{'x': x, 'y': y} for x, y in self._solve()]

if __name__ == '__main__':
    r = requests.post('https://maze.coda.io/maze', {})
    r.raise_for_status()
    maze = Maze(r.json())
    path = MazeSolver(maze).solve()
    print('Solving maze with id: %s' % maze.id)
    print ('Ordered set of moves: %s' % path)
    # Uncomment to get a visual view of the explored maze.
    # print('Maze: %s' % maze)
    print ('Submitting answer to server...')
    r = requests.post('https://maze.coda.io/maze/{0}/solve'.format(maze.id),
                      json.dumps(path))
    if r.ok:
        print('Success!')
    else:
        print('Wrong Answer!')
        
