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
            if @game.scaleToFit
                @game.stage.scaleMode = Phaser.StageScaleMode.SHOW_ALL
                @game.stage.scale.setShowAll()
                @game.stage.scale.refresh()

            @debug = new Phaser.Utils.Debug(@game)

            @wpTarget  = new WayPointTarget @game, 150, 150, 'star'
            @game.add.existing @wpTarget

            @player = new Player @game, 200, 200, 'baddie'
            @player.animations.add 'left', [0, 1], 10, true
            @player.animations.add 'right', [2, 3], 10, true

            @game.add.existing @player

            @dude = new Kinematic @game, 400, 400, 'dude', 1, 'arriveDynamic'
            @dude.setTarget(@wpTarget)
            @dude.create()

        update: ->
            #@player.update()

        render: ->
            @debug.renderSpriteBody @dude
            @debug.renderSpriteInfo @dude, 32, 32, "#ffffff"
            @game.debug.renderPointer(@game.input.mousePointer);
            @game.debug.renderPointer(@game.input.pointer1);

    MainState
