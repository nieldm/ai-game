define ['Phaser'], (Phaser) ->
    class KinematicSteeringOutput
        constructor: () ->
            @linear = new Phaser.Point(0, 0)
            @angular = 0
            @velocity = null
            @rotation = null
            @dynamic = false

    KinematicSteeringOutput
