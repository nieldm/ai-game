define [
            'Phaser',
            'Kinematic',
            'Player',
            'WayPointTarget',
        ]
        , (Phaser, Kinematic, Player, WayPointTarget) ->
    class MainState extends Phaser.State
        constructor: -> super

        preload: ->
            @game.load.image 'star', 'assets/star.png'
            @game.load.spritesheet 'dude', 'assets/dude.png', 32, 48
            @game.load.spritesheet 'baddie', 'assets/baddie.png', 32, 32

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

            @dude = new Kinematic @game, 400, 400, 'dude', 1, 'arriveDyn', [position: 'left', lineColor: 0x00FF00]
            @dude.setTarget(@wpTarget)
            @dude.create()

            @other_dude = new Kinematic @game, 400, 400, 'dude', 1, 'pursueDel', [position: 'right', lineColor: 0x0000FF]
            @other_dude.setTarget(@dude)
            @other_dude.create()

        update: ->
            #@player.update()

        render: ->
            @debug.renderSpriteBody @dude
            @debug.renderSpriteInfo @dude, 32, 32, "#ffffff"
            #@game.debug.renderPointer(@game.input.mousePointer);
            #@game.debug.renderPointer(@game.input.pointer1);

    MainState
