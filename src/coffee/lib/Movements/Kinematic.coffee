#Base class for Kinematic Movements

define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'
        ]
        , (
            Phaser,
            KinematicSteeringOutput
        ) ->
    class Kinematic extends Phaser.Sprite
        constructor: (game, x, y, sprite, time, behavior) ->

            #Save the game enviromente as an atributte
            @game = game
            @steering = new KinematicSteeringOutput()
            @time = time

            #Make the sprite
            Phaser.Sprite.call @, game, x, y, sprite

            #Put the center at the middle of the sprite
            @anchor.setTo 0.5, 0.5

            @create()

        getTarget: () ->
            @target

        setTarget: (target) ->
            @target = target

        create: ->
            @game.add.existing @
            @frame = 4

        update: ->
            @steering.velocity.setTo 3, -1

            if @steering?
                Phaser.Point.add @steering.velocity.multiply(@time, @time), @center, @center

            @x = @center.x
            @y = @center.y
            @rotation = Phaser.Math.angleBetween @center.x, @center.y, @center.x + @steering.velocity.x, @center.y + @steering.velocity.y

    Kinematic
