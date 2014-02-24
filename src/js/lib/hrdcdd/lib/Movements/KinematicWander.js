var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'KinematicSteeringOutput'], function(Phaser, KinematicSteeringOutput) {
  var KinematicWander;
  KinematicWander = (function(_super) {
    __extends(KinematicWander, _super);

    function KinematicWander(character, speed, rotation) {
      this.character = character;
      this.maxSpeed = speed;
      this.maxRotation = rotation;
    }

    KinematicWander.prototype.getSteering = function() {
      var orientationVector, steering;
      steering = new KinematicSteeringOutput();
      orientationVector = new Phaser.Point();
      orientationVector.x = Math.cos(this.character.rotation);
      orientationVector.y = Math.sin(this.character.rotation);
      steering.velocity = orientationVector.multiply(this.maxSpeed, this.maxSpeed);
      steering.rotation = Math.random() - Math.random();
      steering.rotation *= this.maxRotation;
      return steering;
    };

    return KinematicWander;

  })(Phaser.Sprite);
  return KinematicWander;
});
