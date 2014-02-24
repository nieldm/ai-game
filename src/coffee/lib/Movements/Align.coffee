#Base class for Kinematic Movements

define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'
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
            #direction = Phaser.Point.subtract @target.position, @character.position
            #distance = direction.getMagnitude()

            targetRotation *= rotation / rotationSize

            steering.angular = targetRotation - @character.rotation
            steering.angular /= @timeToTarget

            angularAcceleration = Math.abs steering.angular
            if angularAcceleration > @maxAngularAcceleration
                steering.angular /= angularAcceleration
                steering.angular *= @maxAngularAcceleration

            steering.linear.setTo 0,0
            return steering


            targetVelocity = direction
            targetVelocity.normalize()
            targetVelocity.multiply targetSpeed, targetSpeed

            #steering.linear = Phaser.Point.substract targetVelocity, @character.velocity
            steering.linear.x = targetVelocity.x - @character.velocity.x
            steering.linear.y = targetVelocity.y - @character.velocity.y
            steering.linear.divide @timeToTarget, @timeToTarget

            if steering.linear.getMagnitude() > @maxAcceleration
                steering.linear.normalize()
                steering.linear.multiply @maxAcceleration, @maxAcceleration

            steering.angular = 0
            return steering

    Align
