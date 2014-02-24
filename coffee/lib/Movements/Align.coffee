#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class Align extends Phaser.Sprite
        constructor: (character, target, maxAngularAcceleration, maxRotation, targetRadius, slowRadius) ->
            @character = character
            @target = target
            @maxAngularAcceleration = maxAngularAcceleration
            @maxRotation = maxRotation
            @targetRadius = targetRadius
            @slowRadius = slowRadius
            @timeToTarget = 0.5

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            rotation = @target.orientation - @character.orientation
            rotation = Phaser.Math.mapLinear rotation, -@maxRotation, @maxRotation, -Math.PI, Math.PI
            rotationSize = Math.abs rotation

            if rotationSize < @targetRadius
                return null

            if rotationSize > @slowRadius
                targetRotation = @maxRotation
            else
                targetRotation = @maxRotation * rotationSize / @slowRadius

            targetRotation *= rotation / rotationSize

            steering.angular = targetRotation - @character.rotation
            steering.angular /= @timeToTarget

            angularAcceleration = Math.abs steering.angular
            if angularAcceleration > @maxAngularAcceleration
                steering.angular /= angularAcceleration
                steering.angular *= @maxAngularAcceleration

            steering.linear.setTo 0,0
            return steering

    Align
