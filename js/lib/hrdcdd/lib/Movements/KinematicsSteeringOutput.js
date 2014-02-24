define(['Phaser'], function(Phaser) {
  var KinematicSteeringOutput;
  KinematicSteeringOutput = (function() {
    function KinematicSteeringOutput() {
      this.linear = new Phaser.Point(0, 0);
      this.angular = 0;
      this.velocity = null;
      this.rotation = null;
      this.dynamic = false;
    }

    return KinematicSteeringOutput;

  })();
  return KinematicSteeringOutput;
});
