define ['Phaser'], (Phaser) ->
    class KinematicSteeringOutput
        constructor: () ->
            @linear = new Phaser.Point 0, 0
            @angular = 0
            @velocity = new Phaser.Point 0, 0
            @rotation = 0
            @dynamic = false

    KinematicSteeringOutput
