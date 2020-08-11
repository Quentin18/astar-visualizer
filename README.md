# A* Visualizer

**A* Visualizer** is an interactive application to visualize the
[A* pathfinding algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm)
in a grid with obstacles. The heuristic function used is the
[Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry).

It uses the [Gosu](https://github.com/gosu/gosu) game development library.

![Demo](https://github.com/Quentin18/astar-visualizer/blob/master/img/demo.png)

## Install
To install this ruby gem, use the `gem` command:
```
gem install astar_visualizer
```

## Usage
To launch the A* Visualizer, use this command:
```
astar-visualizer
```

You can also use the `irb` environment:
```ruby
require astar_visualizer
AStar.new.show
```

It will open a window with a grid. Then:

1. Left click on a node to choose the start node.
2. Left click on another node to choose the end node.
3. Left click on nodes to put obstacles. Right click on them if you want to remove them.
4. Press *ENTER* to launch the A* algorithm. If a path is found, the path is colored in yellow and the visited nodes in cyan.
5. Press *SUPPR* to clear the window.

## Links
- GitHub: https://github.com/Quentin18/astar-visualizer
- RubyGems: https://rubygems.org/gems/astar_visualizer

## Author
[Quentin Deschamps](mailto:quentindeschamps18@gmail.com)

## License
[MIT](https://choosealicense.com/licenses/mit/)
