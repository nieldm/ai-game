var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', '/js/lib/hrdcdd/lib/Movements/Kinematic.js'], function(Phaser, Kinematic) {
  var MainState;
  MainState = (function(_super) {
    __extends(MainState, _super);

    function MainState() {
      MainState.__super__.constructor.apply(this, arguments);
    }

    MainState.prototype.preload = function() {
      return this.game.load.spritesheet('dude', '/assets/dude.png', 32, 48);
    };

    MainState.prototype.create = function() {
      var dude;
      return dude = new Kinematic(this.game, this.game.world.centerX / 2, this.game.world.centerY / 2, 'dude', 1, 'wander');
    };

    MainState.prototype.update = function() {};

    MainState.prototype.render = function() {};

    return MainState;

  })(Phaser.State);
  return MainState;
});
