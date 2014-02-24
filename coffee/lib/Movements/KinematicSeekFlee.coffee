#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class KinematicSeekFlee extends Phaser.Sprite
        constructor: (character, target, speed, seek) ->
            @character = character
            @target = target
            @maxSpeed = speed
            @seek = seek

        getSteering: () ->
            steering = new KinematicSteeringOutput()
            if @seek
                Phaser.Point.subtract @target.position, @character.position, steering.velocity
                steering.velocity.normalize()
                steering.velocity.multiply(@maxSpeed, @maxSpeed)
            else
                Phaser.Point.subtract @character.position, @target.position, steering.velocity
                steering.velocity.normalize()
                steering.velocity.multiply(@maxSpeed, @maxSpeed)

            steering.rotation = 0
            return steering

    KinematicSeekFlee
