#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class KinematicArrive extends Phaser.Sprite
        constructor: (character, target, speed, radius, time) ->
            @character = character
            @target = target
            @maxSpeed = speed
            @radius = radius
            @time = time

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            Phaser.Point.subtract @target.position, @character.position, steering.velocity

            if steering.velocity.getMagnitude() < @radius
                return null

            steering.velocity.divide @time, @time

            if steering.velocity.getMagnitude() > @maxSpeed
                steering.velocity.normalize()
                steering.velocity.multiply @maxSpeed, @maxSpeed

            #@character.rotation = @getNewOrientation @character.rotation, steering.velocity
            steering.rotation = @getNewOrientation @character.rotation, steering.velocity

            #steering.rotation = 0
            return steering

        getNewOrientation: (currentOrientation, velocity) ->
            if velocity.getMagnitude() > 0
                return Math.atan2(-velocity.x, velocity.y)
            else
                return currentOrientation

    KinematicArrive
