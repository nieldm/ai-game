#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class Seek extends Phaser.Sprite
        constructor: (character, target, maxAcceleration, seek = true) ->
            @character = character
            @target = target
            @maxAcceleration = maxAcceleration
            @seek = seek

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            if @seek
                steering.linear = Phaser.Point.subtract @target.position, @character.position
            else
                steering.linear = Phaser.Point.subtract @character.position, @target.position

            steering.linear.normalize()
            steering.linear.multiply @maxAcceleration, @maxAcceleration

            steering.angular = 0

            return steering

    Seek
