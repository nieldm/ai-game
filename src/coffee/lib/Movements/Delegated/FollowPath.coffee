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
    class FollowPath extends Phaser.Sprite
        constructor: (character, maxAcceleration, maxPrediction, currentPos, path) ->
          @character = character
          @maxPrediction = maxPrediction
          @maxAcceleration = maxAcceleration
#          @Seek = new Seek character, target, maxAcceleration

          @currentPos = currentPos
          @pathOffset = new Phaser.Point 1, 1
          @path = path


        getSteering: () ->

          predictVelocity = new Phaser.Point @character.velocity.x, @character.velocity.y
          futurePos = Phaser.Point.add @character.position, predictVelocity.multiply @maxPrediction, @maxPrediction

          currentParam = @path.getParam(futurePos, @currentPos)

          if currentParam?
            targetParam = currentParam

            target = [
              position: targetParam
            ]

            delSeek = new Seek @character, target[0], @maxAcceleration

            delSeek.getSteering()
          else
            null


#
#
#
#          steering = new KinematicSteeringOutput()
#
#          direction = Phaser.Point.subtract @target.position, @character.position
#          distance  = direction.getMagnitude()
#
#          speed = @character.velocity.getMagnitude()
#
#          if speed <= (distance / @maxPrediction)
#              prediction = @maxPrediction
#          else
#              prediction = distance / speed
#
#          @Seek.target.position = Phaser.Point.add @Seek.target.position, @target.velocity.multiply prediction, prediction

#          return @Seek.getSteering()

    FollowPath
