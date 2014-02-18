#Base class for Kinematic Movements

define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'
            '/js/lib/hrdcdd/lib/Movements/KinematicSeekFlee.js'
        ]
        , (
            Phaser,
            KinematicSteeringOutput,
            KinematicSeekFlee
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

            #Create a graphics to draw thigs for debugging
            @graphics = new Phaser.Graphics @game, 0, 0
            @line = @game.add.graphics 0, 0

            #Testing!
            window.graphics = @graphics
            window.game = @game
            window.line = @line
            window.world = @world
            window.Phaser = Phaser
            window.sprite = @

        getTarget: () ->
            @target

        setTarget: (target) ->
            @target = target

        create: ->
            @game.add.existing @
            @frame = 4

        update: ->
            if @target?
                @seekFlee = new KinematicSeekFlee @, @target, 0.1, true
                @steering = @seekFlee.getSteering()

            if @steering?
                @steering.velocity = @steering.velocity.multiply(@time, @time)
                Phaser.Point.add @steering.velocity, @world, @world
                @render()


        render: ->
            #@line.beginFill 0xFF0000
            #@line.lineStyle 1, 0xff0000, 1
            #@line.moveTo @x, @y
            #@line.lineTo @world.x, @world.y
            #@line.endFill()

            #Get the angle to the next position of the Agent
            @rotation = Phaser.Math.angleBetween @x, @y, @world.x, @world.y

            #Fix the angle
            @angle = @angle + 90

            @x = @world.x
            @y = @world.y
            if !@inCamera
                @line.clear()
                @x = 0
                @y = 0

    Kinematic
