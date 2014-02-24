#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput',
            'Seek'
        ]
        , (
            Phaser,
            KinematicSteeringOutput,
            Seek
        ) ->
    class Pursue extends Phaser.Sprite
        constructor: (character, target, maxAcceleration, maxPrediction) ->
            @character = character
            @target = target
            @maxPrediction = maxPrediction
            @Seek = new Seek character, target, maxAcceleration

        getSteering: () ->
            steering = new KinematicSteeringOutput()

            direction = Phaser.Point.subtract @target.position, @character.position
            distance  = direction.getMagnitude()

            speed = @character.velocity.getMagnitude()

            if speed <= (distance / @maxPrediction)
                prediction = @maxPrediction
            else
                prediction = distance / speed

            @Seek.target.position = Phaser.Point.add @Seek.target.position, @target.velocity.multiply prediction, prediction

            return @Seek.getSteering()

    Pursue
