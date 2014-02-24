requirejs.config
  baseUrl: 'js'
  paths:
    Phaser:   'lib/phaser'
    math:  'lib/math.min'
    MainState: 'lib/hrdcdd/lib/MainState'
    Kinematic: 'lib/hrdcdd/lib/Movements/Kinematic'
    Player: 'lib/hrdcdd/lib/Game/Player'
    WayPointTarget: 'lib/hrdcdd/lib/Game/WayPointTarget'
    KinematicSteeringOutput: 'lib/hrdcdd/lib/Movements/KinematicSteeringOutput'
    KinematicSeekFlee: 'lib/hrdcdd/lib/Movements/KinematicSeekFlee'
    KinematicArrive: 'lib/hrdcdd/lib/Movements/KinematicArrive'
    KinematicWander: 'lib/hrdcdd/lib/Movements/KinematicWander'
    Seek: 'lib/hrdcdd/lib/Movements/Seek'
    Arrive: 'lib/hrdcdd/lib/Movements/Arrive'
    Align: 'lib/hrdcdd/lib/Movements/Align'
    VelocityMatch: 'lib/hrdcdd/lib/Movements/VelocityMatch'
    Pursue: 'lib/hrdcdd/lib/Movements/Delegated/Pursue'

define ['Phaser', 'math', 'MainState'], (Phaser, math, MainState) ->
    @game = new Phaser.Game 600, 800, Phaser.CANVAS, 'aigame-game'
    @game.state.add 'main', new MainState, true
