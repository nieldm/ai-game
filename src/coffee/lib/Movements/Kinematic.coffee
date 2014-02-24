#Base class for Kinematic Movements

define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js'
            '/js/lib/hrdcdd/lib/Movements/KinematicSeekFlee.js'
            '/js/lib/hrdcdd/lib/Movements/KinematicArrive.js'
            '/js/lib/hrdcdd/lib/Movements/KinematicWander.js'
            '/js/lib/hrdcdd/lib/Movements/Seek.js'
            '/js/lib/hrdcdd/lib/Movements/Arrive.js'
            '/js/lib/hrdcdd/lib/Movements/Align.js'
        ]
        , (
            Phaser,
            KinematicSteeringOutput,
            KinematicSeekFlee,
            KinematicArrive,
            KinematicWander,
            Seek,
            Arrive,
            Align
        ) ->
    class Kinematic extends Phaser.Sprite
        constructor: (game, x, y, sprite, time, behavior, log = false, logPos = 'left') ->

            @steering = new KinematicSteeringOutput()

            #Save the game enviromente as an atributte
            @game = game
            @timeNow = () -> Math.floor(@game.time.time / 1000) % 60
            @time = 1
            @behavior = behavior
            @wanderCounter = 0
            @wanderReset = 50
            @maxSpeed = 4
            @log = log
            @logPos = logPos

            @velocity = new Phaser.Point()
            @position = @world
            @orientation = 0

            #Make the sprite
            Phaser.Sprite.call @, game, x, y, sprite

            #Put the center at the middle of the sprite
            @anchor.setTo 0.5, 0.5

            #Create a graphics to draw thigs for debugging
            @graphics = new Phaser.Graphics @game, 0, 0
            @line = @game.add.graphics 0, 0

            #Testing!
            if @log == true
                window.graphics = @graphics
                window.game = @game
                window.line = @line
                window.world = @world
                window.Phaser = Phaser
                window.sprite = @
                window.time = @time

        getTarget: () ->
            @target

        setTarget: (target) ->
            @target = target

        create: ->
            @game.add.existing @
            @frame = 4
            text = "niel's Game"
            style = { font: "11 Arial", fill: "#ff0044", align: "left" }
            if @log == true
                if @logPos == 'left'
                    @logger = @game.add.text @game.world.centerX-300, @game.world.centerY-100, text, style
                else
                    @logger = @game.add.text @game.world.centerX, @game.world.centerY-100, text, style

        update: ->
            if @target?
                switch @behavior
                    when 'seek' then @movement = new KinematicSeekFlee @, @target, 0.1, true
                    when 'flee' then @movement = new KinematicSeekFlee @, @target, 0.1, false
                    when 'arrive' then @movement = new KinematicArrive @, @target, 1, 25, 1.25
                    when 'wander' then @movement = new KinematicWander @, 6, 2
                    when 'seekDynamic' then @movement = new Seek @, @target, 2
                    when 'fleeDynamic' then @movement = new Seek @, @target, 2, false
                    when 'arriveDynamic' then @movement = new Arrive @, @target, 2, @maxSpeed, 10, 300
                    when 'alignDynamic' then @movement = new Align @, @target, 10, 4, 10, 300
                if @movement?
                    @newSteering = @movement.getSteering()
                if @newSteering?
                    @steering = @newSteering
                    #@steering.linear = if @steering.velocity? then @steering.velocity else @steering.linear
                    #@steering.angular = if @steering.rotation? then @steering.rotation else @steering.angular
                else
                    @velocity.setTo 0, 0
                    @line.clear()


            if @steering?
                #console.clear()


                @position = Phaser.Point.add @position, @velocity.multiply @time, @time
                @orientation += @rotation * @time

                if @steering.velocity.x != 0 and @steering.velocity.y != 0
                    @velocity = @steering.velocity
                else
                    @velocity = Phaser.Point.add @velocity, @steering.linear.multiply @time, @time

                if @steering.rotation != 0
                    @rotation = @steering.rotation
                else
                    @rotation += @steering.angular * @time

                if @velocity.getMagnitude() > @maxSpeed
                    @velocity.normalize()
                    @velocity.multiply @maxSpeed, @maxSpeed

                if @log == true
                    window.movement = @movement
                    log = "steering linear x:#{@steering.linear.x} y:#{@steering.linear.y}"
                    log += "\nsteering angular #{@steering.angular}"
                    log += "\nsteering velocity x:#{@steering.velocity.x} y:#{@steering.velocity.y}"
                    log += "\nsteering rotation #{@steering.rotation}"
                    log += "\nposition x:#{@position.x} y:#{@position.y}"
                    log += "\nvelocity x:#{@velocity.x} y:#{@velocity.y}"
                    log += "\norientation: #{@orientation}"
                    log += "\nrotation: #{@rotation}"
                    log += "\nposition magnitude: #{@position.getMagnitude()}"
                    @logger.setText log
                @render()

        render: ->
            @line.beginFill 0xFF0000
            @line.lineStyle 1, 0xff0000, 1
            @line.moveTo @x, @y
            @line.lineTo @position.x, @position.y
            @line.endFill()

            @x = @position.x
            @y = @position.y

            if !@inCamera
                @line.clear()
                @x = 400
                @y = 400

    Kinematic
