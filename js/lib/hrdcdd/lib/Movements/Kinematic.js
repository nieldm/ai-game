var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(
    ['Phaser',
        'js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js',
        'js/lib/hrdcdd/lib/Movements/KinematicSeekFlee.js',
        'js/lib/hrdcdd/lib/Movements/KinematicArrive.js',
        'js/lib/hrdcdd/lib/Movements/KinematicWander.js',
        'js/lib/hrdcdd/lib/Movements/Seek.js',
        'js/lib/hrdcdd/lib/Movements/Arrive.js',
        'js/lib/hrdcdd/lib/Movements/Align.js'],
        function(Phaser, KinematicSteeringOutput, KinematicSeekFlee, KinematicArrive, KinematicWander, Seek, Arrive, Align) {
  var Kinematic;
  Kinematic = (function(_super) {
    __extends(Kinematic, _super);

    function Kinematic(game, x, y, sprite, time, behavior, log, logPos) {
      if (log == null) {
        log = false;
      }
      if (logPos == null) {
        logPos = 'left';
      }
      this.steering = new KinematicSteeringOutput();
      this.game = game;
      this.timeNow = function() {
        return Math.floor(this.game.time.time / 1000) % 60;
      };
      this.time = 1;
      this.behavior = behavior;
      this.wanderCounter = 0;
      this.wanderReset = 50;
      this.maxSpeed = 4;
      this.log = log;
      this.logPos = logPos;
      this.velocity = new Phaser.Point();
      this.position = this.world;
      this.orientation = 0;
      Phaser.Sprite.call(this, game, x, y, sprite);
      this.anchor.setTo(0.5, 0.5);
      this.graphics = new Phaser.Graphics(this.game, 0, 0);
      this.line = this.game.add.graphics(0, 0);
      if (this.log === true) {
        window.graphics = this.graphics;
        window.game = this.game;
        window.line = this.line;
        window.world = this.world;
        window.Phaser = Phaser;
        window.sprite = this;
        window.time = this.time;
      }
    }

    Kinematic.prototype.getTarget = function() {
      return this.target;
    };

    Kinematic.prototype.setTarget = function(target) {
      return this.target = target;
    };

    Kinematic.prototype.create = function() {
      var style, text;
      this.game.add.existing(this);
      this.frame = 4;
      text = "niel's Game";
      style = {
        font: "11 Arial",
        fill: "#ff0044",
        align: "left"
      };
      if (this.log === true) {
        if (this.logPos === 'left') {
          return this.logger = this.game.add.text(this.game.world.centerX - 300, this.game.world.centerY - 100, text, style);
        } else {
          return this.logger = this.game.add.text(this.game.world.centerX, this.game.world.centerY - 100, text, style);
        }
      }
    };

    Kinematic.prototype.update = function() {
      var log;
      if (this.target != null) {
        switch (this.behavior) {
          case 'seek':
            this.movement = new KinematicSeekFlee(this, this.target, 0.1, true);
            break;
          case 'flee':
            this.movement = new KinematicSeekFlee(this, this.target, 0.1, false);
            break;
          case 'arrive':
            this.movement = new KinematicArrive(this, this.target, 1, 25, 1.25);
            break;
          case 'wander':
            this.movement = new KinematicWander(this, 6, 2);
            break;
          case 'seekDynamic':
            this.movement = new Seek(this, this.target, 2);
            break;
          case 'fleeDynamic':
            this.movement = new Seek(this, this.target, 2, false);
            break;
          case 'arriveDynamic':
            this.movement = new Arrive(this, this.target, 2, this.maxSpeed, 10, 300);
            break;
          case 'alignDynamic':
            this.movement = new Align(this, this.target, 10, 4, 10, 300);
        }
        if (this.movement != null) {
          this.newSteering = this.movement.getSteering();
        }
        if (this.newSteering != null) {
          this.steering = this.newSteering;
        } else {
          this.velocity.setTo(0, 0);
          this.line.clear();
        }
      }
      if (this.steering != null) {
        this.position = Phaser.Point.add(this.position, this.velocity.multiply(this.time, this.time));
        this.orientation += this.rotation * this.time;
        if (this.steering.velocity.x !== 0 && this.steering.velocity.y !== 0) {
          this.velocity = this.steering.velocity;
        } else {
          this.velocity = Phaser.Point.add(this.velocity, this.steering.linear.multiply(this.time, this.time));
        }
        if (this.steering.rotation !== 0) {
          this.rotation = this.steering.rotation;
        } else {
          this.rotation += this.steering.angular * this.time;
        }
        if (this.velocity.getMagnitude() > this.maxSpeed) {
          this.velocity.normalize();
          this.velocity.multiply(this.maxSpeed, this.maxSpeed);
        }
        if (this.log === true) {
          window.movement = this.movement;
          log = "steering linear x:" + this.steering.linear.x + " y:" + this.steering.linear.y;
          log += "\nsteering angular " + this.steering.angular;
          log += "\nsteering velocity x:" + this.steering.velocity.x + " y:" + this.steering.velocity.y;
          log += "\nsteering rotation " + this.steering.rotation;
          log += "\nposition x:" + this.position.x + " y:" + this.position.y;
          log += "\nvelocity x:" + this.velocity.x + " y:" + this.velocity.y;
          log += "\norientation: " + this.orientation;
          log += "\nrotation: " + this.rotation;
          log += "\nposition magnitude: " + (this.position.getMagnitude());
          this.logger.setText(log);
        }
        return this.render();
      }
    };

    Kinematic.prototype.render = function() {
      this.line.beginFill(0xFF0000);
      this.line.lineStyle(1, 0xff0000, 1);
      this.line.moveTo(this.x, this.y);
      this.line.lineTo(this.position.x, this.position.y);
      this.line.endFill();
      this.x = this.position.x;
      this.y = this.position.y;
      if (!this.inCamera) {
        this.line.clear();
        this.x = 400;
        return this.y = 400;
      }
    };

    return Kinematic;

  })(Phaser.Sprite);
  return Kinematic;
});
