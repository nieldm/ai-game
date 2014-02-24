var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'KinematicSteeringOutput', 'Seek'], function(Phaser, KinematicSteeringOutput, Seek) {
  var Pursue;
  Pursue = (function(_super) {
    __extends(Pursue, _super);

    function Pursue(character, target, maxAcceleration, maxPrediction) {
      this.character = character;
      this.target = target;
      this.maxPrediction = maxPrediction;
      this.Seek = new Seek(character, target, maxAcceleration);
    }

    Pursue.prototype.getSteering = function() {
      var direction, distance, prediction, speed, steering;
      steering = new KinematicSteeringOutput();
      direction = Phaser.Point.subtract(this.target.position, this.character.position);
      distance = direction.getMagnitude();
      speed = this.character.velocity.getMagnitude();
      if (speed <= (distance / this.maxPrediction)) {
        prediction = this.maxPrediction;
      } else {
        prediction = distance / speed;
      }
      this.Seek.target.position = Phaser.Point.add(this.Seek.target.position, this.target.velocity.multiply(prediction, prediction));
      return this.Seek.getSteering();
    };

    return Pursue;

  })(Phaser.Sprite);
  return Pursue;
});
