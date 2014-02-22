define [
            'Phaser'
        ]
        , (
            Phaser
        ) ->
    class WayPointTarget extends Phaser.Sprite
        constructor: (game, x, y, sprite) ->

            @game = game

            Phaser.Sprite.call @, game, x, y, sprite

            @anchor.setTo 0.5, 0.5

        create: ->

        update: ->
            if @game.input.mousePointer.isDown
                @x = @game.input.mousePointer.x
                @y = @game.input.mousePointer.y
            if @game.input.pointer1.isDown
                @x = @game.input.pointer1.x
                @y = @game.input.pointer1.y

        WayPointTarget
