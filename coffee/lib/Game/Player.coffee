define [
            'Phaser'
        ]
        , (
            Phaser
        ) ->
    class Player extends Phaser.Sprite
        constructor: (game, x, y, sprite) ->

            @game = game

            Phaser.Sprite.call @, game, x, y, sprite

            @cursors = @game.input.keyboard.createCursorKeys()
            @spacebar = @game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR

        create: ->

        update: ->
            @body.velocity.x = 0
            @body.velocity.y = 0

            if @cursors.left.isDown
                @body.velocity.x = -150
                @animations.play 'left'
            if @cursors.right.isDown
                @body.velocity.x = 150
                @animations.play 'right'
            if @cursors.up.isDown
                @body.velocity.y = -150
            if @cursors.down.isDown
                @body.velocity.y = 150

        Player
