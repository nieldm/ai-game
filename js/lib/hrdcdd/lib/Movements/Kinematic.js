var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['Phaser', 'KinematicSteeringOutput', 'KinematicSeekFlee', 'KinematicArrive', 'KinematicWander', 'Seek', 'Arrive', 'Align', 'VelocityMatch', 'Pursue'], function(Phaser, KinematicSteeringOutput, KinematicSeekFlee, KinematicArrive, KinematicWander, Seek, Arrive, Align, VelocityMatch, Pursue) {
  var Kinematic;
  Kinematic = (function(_super) {
    __extends(Kinematic, _super);

    function Kinematic(game, x, y, sprite, time, behavior, log) {
      if (log == null) {
        log = null;
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
      this.log = log != null ? true : false;
      this.logConfig = log[0];
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
        if (this.logConfig.position === 'left') {
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
          case 'seekDyn':
            this.movement = new Seek(this, this.target, 2);
            break;
          case 'fleeDyn':
            this.movement = new Seek(this, this.target, 2, false);
            break;
          case 'arriveDyn':
            this.movement = new Arrive(this, this.target, 2, this.maxSpeed, 10, 300);
            break;
          case 'alignDyn':
            this.movement = new Align(this, this.target, 10, 4, 10, 300);
            break;
          case 'velocityMatchDyn':
            this.movement = new VelocityMatch(this, this.target, 10);
            break;
          case 'pursueDel':
            this.movement = new Pursue(this, this.target, 0.5, 2);
        }
        if (this.movement != null) {
          this.newSteering = this.movement.getSteering();
        }
        if (this.newSteering != null) {
          this.steering = this.newSteering;
        } else {
          this.velocity.setTo(0, 0);
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
      var lineColor;
      if (this.log === true) {
        lineColor = this.logConfig.lineColor != null ? this.logConfig.lineColor : 0xFF0000;
        this.line.beginFill(lineColor);
        this.line.lineStyle(1, lineColor, 1);
        this.line.moveTo(this.x, this.y);
        this.line.lineTo(this.position.x, this.position.y);
        this.line.endFill();
      }
      this.x = this.position.x;
      this.y = this.position.y;
      if (this.game.time.fps < 40) {
        return this.line.clear();
      }
    };

    return Kinematic;

  })(Phaser.Sprite);
  return Kinematic;
});
