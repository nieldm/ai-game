#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class VelocityMatch extends Phaser.Sprite
        constructor: (character, target, maxAcceleration) ->
            @character = character
            @target = target
            @maxAcceleration = maxAcceleration
            @timeToTarget = 0.5

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            steering.linear = Phaser.Point.subtract @target.velocity, @character.velocity
            steering.linear.divide @timeToTarget, @timeToTarget

            if steering.linear.getMagnitude() > @maxAcceleration
                steering.linear.normalize()
                steering.linear.multiply @maxAcceleration, @maxAcceleration

            steering.angular = 0
            return steering

    VelocityMatch
