var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js', '/js/lib/hrdcdd/lib/Movements/KinematicSeekFlee.js'], function(Phaser, KinematicSteeringOutput, KinematicSeekFlee) {
  var Kinematic;
  Kinematic = (function(_super) {
    __extends(Kinematic, _super);

    function Kinematic(game, x, y, sprite, time, behavior) {
      this.game = game;
      this.steering = new KinematicSteeringOutput();
      this.time = time;
      Phaser.Sprite.call(this, game, x, y, sprite);
      this.anchor.setTo(0.5, 0.5);
      this.graphics = new Phaser.Graphics(this.game, 0, 0);
      this.line = this.game.add.graphics(0, 0);
      window.graphics = this.graphics;
      window.game = this.game;
      window.line = this.line;
      window.world = this.world;
      window.Phaser = Phaser;
      window.sprite = this;
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
      if (this.target != null) {
        this.seekFlee = new KinematicSeekFlee(this, this.target, 0.1, true);
        this.steering = this.seekFlee.getSteering();
      }
      if (this.steering != null) {
        this.steering.velocity = this.steering.velocity.multiply(this.time, this.time);
        Phaser.Point.add(this.steering.velocity, this.world, this.world);
        return this.render();
      }
    };

    Kinematic.prototype.render = function() {
      this.rotation = Phaser.Math.angleBetween(this.x, this.y, this.world.x, this.world.y);
      this.angle = this.angle + 90;
      this.x = this.world.x;
      this.y = this.world.y;
      if (!this.inCamera) {
        this.line.clear();
        this.x = 0;
        return this.y = 0;
      }
    };

    return Kinematic;

  })(Phaser.Sprite);
  return Kinematic;
});
