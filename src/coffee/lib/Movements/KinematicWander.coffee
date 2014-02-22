#Base class for Kinematic Movements

define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class KinematicWander extends Phaser.Sprite
        constructor: (character, speed, rotation) ->
            @character = character
            @maxSpeed = speed
            @maxRotation = rotation

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            orientationVector = new Phaser.Point()
            orientationVector.x = Math.cos @character.rotation
            orientationVector.y = Math.sin @character.rotation

            steering.velocity = orientationVector.multiply @maxSpeed, @maxSpeed

            steering.rotation = Math.random() - Math.random()
            steering.rotation *= @maxRotation

            return steering

    KinematicWander
