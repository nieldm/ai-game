define ['Phaser', '/js/lib/hrdcdd/lib/Movements/Kinematic.js'], (Phaser, Kinematic) ->
    class MainState extends Phaser.State
        constructor: -> super

        preload: ->
            @game.load.spritesheet 'dude', '/assets/dude.png', 32, 48

        create: ->
            dude = new Kinematic @game, @game.world.centerX/2, @game.world.centerY/2, 'dude', 1, 'wander'

        update: ->

        render: ->

    MainState
