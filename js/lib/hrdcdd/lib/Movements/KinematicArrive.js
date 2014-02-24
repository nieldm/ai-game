var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'], function(Phaser, KinematicSteeringOutput) {
  var KinematicArrive;
  KinematicArrive = (function(_super) {
    __extends(KinematicArrive, _super);

    function KinematicArrive(character, target, speed, radius, time) {
      this.character = character;
      this.target = target;
      this.maxSpeed = speed;
      this.radius = radius;
      this.time = time;
    }

    KinematicArrive.prototype.getSteering = function() {
      var steering;
      steering = new KinematicSteeringOutput();
      Phaser.Point.subtract(this.target.position, this.character.position, steering.velocity);
      if (steering.velocity.getMagnitude() < this.radius) {
        return null;
      }
      steering.velocity.divide(this.time, this.time);
      if (steering.velocity.getMagnitude() > this.maxSpeed) {
        steering.velocity.normalize();
        steering.velocity.multiply(this.maxSpeed, this.maxSpeed);
      }
      steering.rotation = this.getNewOrientation(this.character.rotation, steering.velocity);
      return steering;
    };

    KinematicArrive.prototype.getNewOrientation = function(currentOrientation, velocity) {
      if (velocity.getMagnitude() > 0) {
        return Math.atan2(-velocity.x, velocity.y);
      } else {
        return currentOrientation;
      }
    };

    return KinematicArrive;

  })(Phaser.Sprite);
  return KinematicArrive;
});
