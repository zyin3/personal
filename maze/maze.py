import requests

DIRS = [[1, 0], [-1, 0], [0, -1], [0, 1]]        
URL_TEMPLATE = ('https://maze.coda.io/maze/'
                '{0}/check?x={1}&y={2}')

class Maze(object):
    def __init__(self, json):
        self.id = json['id']
        self.height = json['height']
        self.width = json['width']
        self.cache = {}

    def __repr__(self):
        cache = ''
        for x in range(self.height):
            row = []
            for y in range(self.width):
                if (x, y) not in self.cache:
                    row.append('-')
                else:
                    row.append('1' if self.cache[x, y] else '0')
            cache += '\n' + ' '.join(row)
        return 'id: {0}, height: {1}, width: {2}\ncache: {3}'.format(
            self.id, self.height, self.width, cache)

    def log(self, msg, *kargs):
        print(msg.format(*kargs))
        
    def check(self, x, y):
        if (x < 0 or x >= self.height or y < 0 or y >= self.width):
            return False
        
        def checkServer(x, y):
            self.log('Checking server for: {0}', (x, y))
            r = requests.get(URL_TEMPLATE.format(self.id, x, y))
            return r.ok

        if (x, y) not in self.cache:
            self.cache[x, y] = checkServer(x, y)

        return self.cache[x, y]

class MazeSolver(object):
    def __init__(self, maze):
        self.maze = maze
        self.visited = set()

    def _solve(self, x=0, y=0):
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
        return [{'x': x, 'y': y} for x, y in self._solve()]

if __name__ == '__main__':

    ans = []
    while not ans:
         r = requests.post('https://maze.coda.io/maze', {})
         maze = Maze(r.json())
         ans = MazeSolver(maze).solve()
         print('Maze: %s' % maze)

    print(maze)
    print(ans)
