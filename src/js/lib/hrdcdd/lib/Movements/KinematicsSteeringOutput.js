define(['Phaser'], function(Phaser) {
  var KinematicSteeringOutput;
  KinematicSteeringOutput = (function() {
    function KinematicSteeringOutput() {
      this.linear = new Phaser.Point(0, 0);
      this.angular = 0;
      this.velocity = new Phaser.Point(0, 0);
      this.rotation = 0;
    }

    return KinematicSteeringOutput;

  })();
  return KinematicSteeringOutput;
});
