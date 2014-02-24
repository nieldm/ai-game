requirejs.config({
  baseUrl: 'js',
  paths: {
    Phaser: 'lib/phaser',
    math: 'lib/math.min',
    MainState: 'hrdcdd/lib/MainState'
  }
});

define(['Phaser', 'math', 'MainState'], function(Phaser, math, MainState) {
  this.game = new Phaser.Game(600, 800, Phaser.CANVAS, 'aigame-game');
  return this.game.state.add('main', new MainState, true);
});
