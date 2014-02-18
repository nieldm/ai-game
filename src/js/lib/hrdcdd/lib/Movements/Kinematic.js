var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'], function(Phaser, KinematicSteeringOutput) {
  var Kinematic;
  Kinematic = (function(_super) {
    __extends(Kinematic, _super);

    function Kinematic(game, x, y, sprite, time, behavior) {
      this.game = game;
      this.steering = new KinematicSteeringOutput();
      this.time = time;
      Phaser.Sprite.call(this, game, x, y, sprite);
      this.anchor.setTo(0.5, 0.5);
      this.create();
    }

    Kinematic.prototype.getTarget = function() {
      return this.target;
    };

    Kinematic.prototype.setTarget = function(target) {
      return this.target = target;
    };

    Kinematic.prototype.create = function() {
      this.game.add.existing(this);
      return this.frame = 4;
    };

    Kinematic.prototype.update = function() {
      this.steering.velocity.setTo(3, -1);
      if (this.steering != null) {
        Phaser.Point.add(this.steering.velocity.multiply(this.time, this.time), this.center, this.center);
      }
      this.x = this.center.x;
      this.y = this.center.y;
      return this.rotation = Phaser.Math.angleBetween(this.center.x, this.center.y, this.center.x + this.steering.velocity.x, this.center.y + this.steering.velocity.y);
    };

    return Kinematic;

  })(Phaser.Sprite);
  return Kinematic;
});
