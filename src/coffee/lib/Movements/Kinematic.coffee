#Base class for Kinematic Movements

define [
            'Phaser',
            'KinematicSteeringOutput'
            'KinematicSeekFlee'
            'KinematicArrive'
            'KinematicWander'
            'Seek'
            'Arrive'
            'Align'
            'VelocityMatch'
            'Pursue'
            'FollowPath'
        ]
        , (
            Phaser,
            KinematicSteeringOutput,
            KinematicSeekFlee,
            KinematicArrive,
            KinematicWander,
            Seek,
            Arrive,
            Align,
            VelocityMatch,
            Pursue,
            FollowPath
        ) ->
    class Kinematic extends Phaser.Sprite
        constructor: (game, x, y, sprite, time, behavior, log = null) ->

            @steering = new KinematicSteeringOutput()

            #Save the game enviromente as an atributte
            @game = game
            @timeNow = () -> Math.floor(@game.time.time / 1000) % 60
            @time = 1
            @behavior = behavior
            @wanderCounter = 0
            @wanderReset = 50
            @maxSpeed = 1
            @log = if log? then true else false
            @logConfig = log[0]

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

        setPath: (path) ->
            @path = path

        create: ->
            @game.add.existing @
            @frame = 4
            text = "niel's Game"
            style = { font: "11 Arial", fill: "#ff0044", align: "left" }
            if @log == true
                if @logConfig.position == 'left'
                    @logger = @game.add.text @game.world.centerX-300, @game.world.centerY-100, text, style
                else
                    @logger = @game.add.text @game.world.centerX, @game.world.centerY-100, text, style

        update: ->
            if @target?
                switch @behavior
                    when 'seek' then @movement = new KinematicSeekFlee @, @target, 0.1, true
                    when 'flee' then @movement = new KinematicSeekFlee @, @target, 0.1, false
                    when 'arrive' then @movement = new KinematicArrive @, @target, 1, 25, 1.25
                    when 'seekDyn' then @movement = new Seek @, @target, 2
                    when 'fleeDyn' then @movement = new Seek @, @target, 2, false
                    when 'arriveDyn' then @movement = new Arrive @, @target, 2, @maxSpeed, 10, 300
                    when 'alignDyn' then @movement = new Align @, @target, 10, 4, 10, 300
                    when 'velocityMatchDyn' then @movement = new VelocityMatch @, @target, 10
                    when 'pursueDel' then @movement = new Pursue @, 0.5, 2
            else
                switch @behavior
                  when 'wander' then @movement = new KinematicWander @, 6, 2
                  when 'followPath'
                    @currentPathPoint = if @curretPathPoint? then @currentPathPoint else null
                    @movement = new FollowPath @, 0.1, 40, @currentPathPoint, @path

            if @movement?
                @newSteering = @movement.getSteering()
            if @newSteering?
                @steering = @newSteering
                #@steering.linear = if @steering.velocity? then @steering.velocity else @steering.linear
                #@steering.angular = if @steering.rotation? then @steering.rotation else @steering.angular
            else
                @velocity.setTo 0, 0


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
            if @log is true
                lineColor = if @logConfig.lineColor? then @logConfig.lineColor else 0xFF0000
                @line.beginFill lineColor
                @line.lineStyle 1, lineColor, 1
                @line.moveTo @x, @y
                @line.lineTo @position.x, @position.y
                @line.endFill()

            @x = @position.x
            @y = @position.y

            #if !@inCamera
                #@line.clear()
                #@x = 400
                #@y = 400
            if @game.time.fps < 40
                @line.clear()

    Kinematic
