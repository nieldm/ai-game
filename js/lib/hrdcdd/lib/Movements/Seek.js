var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'], function(Phaser, KinematicSteeringOutput) {
  var Seek;
  Seek = (function(_super) {
    __extends(Seek, _super);

    function Seek(character, target, maxAcceleration, seek) {
      if (seek == null) {
        seek = true;
      }
      this.character = character;
      this.target = target;
      this.maxAcceleration = maxAcceleration;
      this.seek = seek;
    }

    Seek.prototype.getSteering = function() {
      var steering;
      steering = new KinematicSteeringOutput();
      if (this.seek) {
        steering.linear = Phaser.Point.subtract(this.target.position, this.character.position);
      } else {
        steering.linear = Phaser.Point.subtract(this.character.position, this.target.position);
      }
      steering.linear.normalize();
      steering.linear.multiply(this.maxAcceleration, this.maxAcceleration);
      steering.angular = 0;
      return steering;
    };

    return Seek;

  })(Phaser.Sprite);
  return Seek;
});
