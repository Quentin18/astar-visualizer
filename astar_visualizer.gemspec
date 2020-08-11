Gem::Specification.new do |s|
  s.name        = 'astar_visualizer'
  s.version     = '0.0.1'
  s.license     = 'MIT'
  s.summary     = 'A* pathfinding visualizer using Gosu'
  s.description = <<-DESCRIPTION
    A* Visualizer is an interactive application to visualize
    the A* pathfinding algorithm in a grid with obstacles.
    It uses the Gosu game development library.
  DESCRIPTION
  s.author      = 'Quentin Deschamps'
  s.email       = 'quentindeschamps18@gmail.com'
  s.homepage    = 'https://github.com/Quentin18/astar-visualizer'

  s.add_runtime_dependency 'gosu', '~> 0.15.2'
  s.require_paths = ['lib']
  s.files = [
    'bin/astar-visualizer',
    'lib/astar_visualizer.rb',
    'lib/astar_visualizer/astar.rb',
    'lib/astar_visualizer/grid.rb',
    'lib/astar_visualizer/node.rb',
    'LICENSE',
    'README.md',
    'astar_visualizer.gemspec'
  ]

  s.bindir = 'bin'
  s.executables << 'astar-visualizer'

  s.rdoc_options = ['--main', 'README.md']
  s.extra_rdoc_files = ['LICENSE', 'README.md']

  s.post_install_message = 'Thanks for installing! Run this command: astar-visualizer'
end
