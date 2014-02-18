requirejs.config({
  baseUrl: 'js',
  paths: {
    Phaser: 'lib/phaser',
    math: 'lib/math.min',
    MainState: 'lib/hrdcdd/lib/MainState'
  }
});

define(['Phaser', 'math', 'MainState'], function(Phaser, math, MainState) {
  this.game = new Phaser.Game(480, 600, Phaser.AUTO, 'aigame-game');
  return this.game.state.add('main', new MainState, true);
});
