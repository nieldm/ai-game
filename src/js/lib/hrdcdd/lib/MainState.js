var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', '/js/lib/hrdcdd/lib/Movements/Kinematic.js', '/js/lib/hrdcdd/lib/Game/Player.js', '/js/lib/hrdcdd/lib/Game/WayPointTarget.js'], function(Phaser, Kinematic, Player, WayPointTarget) {
  var MainState;
  MainState = (function(_super) {
    __extends(MainState, _super);

    function MainState() {
      MainState.__super__.constructor.apply(this, arguments);
    }

    MainState.prototype.preload = function() {
      this.game.load.image('star', '/assets/star.png');
      this.game.load.spritesheet('dude', '/assets/dude.png', 32, 48);
      return this.game.load.spritesheet('baddie', '/assets/baddie.png', 32, 32);
    };

    MainState.prototype.create = function() {
      this.debug = new Phaser.Utils.Debug(this.game);
      this.wpTarget = new WayPointTarget(this.game, 10, 10, 'star');
      this.game.add.existing(this.wpTarget);
      this.player = new Player(this.game, 200, 200, 'baddie');
      this.player.animations.add('left', [0, 1], 10, true);
      this.player.animations.add('right', [2, 3], 10, true);
      this.game.add.existing(this.player);
      this.dude = new Kinematic(this.game, this.game.world.centerX / 2, this.game.world.centerY / 2, 'dude', 1, 'wander');
      this.dude.setTarget(this.wpTarget);
      return this.dude.create();
    };

    MainState.prototype.update = function() {};

    MainState.prototype.render = function() {
      this.debug.renderSpriteBody(this.dude);
      this.debug.renderSpriteInfo(this.wpTarget, 32, 32, "#ffffff");
      this.game.debug.renderPointer(this.game.input.mousePointer);
      return this.game.debug.renderPointer(this.game.input.pointer1);
    };

    return MainState;

  })(Phaser.State);
  return MainState;
});
