requirejs.config 
  baseUrl: 'js'
  paths:
    Phaser:   'lib/phaser'
    math:  'lib/math.min'
    MainState: 'lib/hrdcdd/lib/MainState'

define ['Phaser', 'math', 'MainState'], (Phaser, math, MainState) ->
    @game = new Phaser.Game 480, 600, Phaser.AUTO, 'aigame-game'
    @game.state.add 'main', new MainState, true
