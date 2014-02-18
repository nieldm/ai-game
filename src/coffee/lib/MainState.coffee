define [
            'Phaser',
            '/js/lib/hrdcdd/lib/Movements/Kinematic.js',
            '/js/lib/hrdcdd/lib/Game/Player.js',
            '/js/lib/hrdcdd/lib/Game/WayPointTarget.js',
        ]
        , (Phaser, Kinematic, Player, WayPointTarget) ->
    class MainState extends Phaser.State
        constructor: -> super

        preload: ->
            @game.load.image 'star', '/assets/star.png'
            @game.load.spritesheet 'dude', '/assets/dude.png', 32, 48
            @game.load.spritesheet 'baddie', '/assets/baddie.png', 32, 32

        create: ->
            @debug = new Phaser.Utils.Debug(@game)

            @wpTarget  = new WayPointTarget @game, 10, 10, 'star'
            @game.add.existing @wpTarget

            @player = new Player @game, 200, 200, 'baddie'
            @player.animations.add 'left', [0, 1], 10, true
            @player.animations.add 'right', [2, 3], 10, true

            @game.add.existing @player

            @dude = new Kinematic @game, @game.world.centerX/2, @game.world.centerY/2, 'dude', 1, 'wander'
            @dude.setTarget(@wpTarget)
            @dude.create()

        update: ->
            #@player.update()

        render: ->
            @debug.renderSpriteBody @dude
            @debug.renderSpriteInfo @wpTarget, 32, 32, "#ffffff"
            @game.debug.renderPointer(@game.input.mousePointer);
            @game.debug.renderPointer(@game.input.pointer1);

    MainState
