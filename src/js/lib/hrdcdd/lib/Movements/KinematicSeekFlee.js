var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'KinematicSteeringOutput'], function(Phaser, KinematicSteeringOutput) {
  var KinematicSeekFlee;
  KinematicSeekFlee = (function(_super) {
    __extends(KinematicSeekFlee, _super);

    function KinematicSeekFlee(character, target, speed, seek) {
      this.character = character;
      this.target = target;
      this.maxSpeed = speed;
      this.seek = seek;
    }

    KinematicSeekFlee.prototype.getSteering = function() {
      var steering;
      steering = new KinematicSteeringOutput();
      if (this.seek) {
        Phaser.Point.subtract(this.target.position, this.character.position, steering.velocity);
        steering.velocity.normalize();
        steering.velocity.multiply(this.maxSpeed, this.maxSpeed);
      } else {
        Phaser.Point.subtract(this.character.position, this.target.position, steering.velocity);
        steering.velocity.normalize();
        steering.velocity.multiply(this.maxSpeed, this.maxSpeed);
      }
      steering.rotation = 0;
      return steering;
    };

    return KinematicSeekFlee;

  })(Phaser.Sprite);
  return KinematicSeekFlee;
});
