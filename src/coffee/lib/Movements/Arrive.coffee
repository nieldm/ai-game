#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class Arrive extends Phaser.Sprite
        constructor: (character, target, maxAcceleration, maxSpeed, targetRadius, slowRadius) ->
            @character = character
            @target = target
            @maxAcceleration = maxAcceleration
            @maxSpeed = maxSpeed
            @targetRadius = targetRadius
            @slowRadius = slowRadius
            @timeToTarget = 0.5

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            direction = Phaser.Point.subtract @target.position, @character.position
            distance = direction.getMagnitude()

            if distance < @targetRadius
                return null

            if distance > @slowRadius
                targetSpeed = @maxSpeed
            else
                targetSpeed = @maxSpeed * distance / @slowRadius

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

    Arrive
