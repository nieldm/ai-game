var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'Kinematic', 'Player', 'WayPointTarget'], function(Phaser, Kinematic, Player, WayPointTarget) {
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
      if (this.game.scaleToFit) {
        this.game.stage.scaleMode = Phaser.StageScaleMode.SHOW_ALL;
        this.game.stage.scale.setShowAll();
        this.game.stage.scale.refresh();
      }
      this.debug = new Phaser.Utils.Debug(this.game);
      this.wpTarget = new WayPointTarget(this.game, 150, 150, 'star');
      this.game.add.existing(this.wpTarget);
      this.player = new Player(this.game, 200, 200, 'baddie');
      this.player.animations.add('left', [0, 1], 10, true);
      this.player.animations.add('right', [2, 3], 10, true);
      this.game.add.existing(this.player);
      this.dude = new Kinematic(this.game, 400, 400, 'dude', 1, 'arriveDyn', [
        {
          position: 'left',
          lineColor: 0x00FF00
        }
      ]);
      this.dude.setTarget(this.wpTarget);
      this.dude.create();
      this.other_dude = new Kinematic(this.game, 400, 400, 'dude', 1, 'pursueDel', [
        {
          position: 'right',
          lineColor: 0x0000FF
        }
      ]);
      this.other_dude.setTarget(this.dude);
      return this.other_dude.create();
    };

    MainState.prototype.update = function() {};

    MainState.prototype.render = function() {
      this.debug.renderSpriteBody(this.dude);
      this.debug.renderSpriteInfo(this.dude, 32, 32, "#ffffff");
      this.game.debug.renderPointer(this.game.input.mousePointer);
      return this.game.debug.renderPointer(this.game.input.pointer1);
    };

    return MainState;

  })(Phaser.State);
  return MainState;
});
