define ['Phaser'], (Phaser) ->
    class Path
      constructor: (game, drawer) ->
        @game = game
        @drawer = drawer
        @points = []
        @handles = []
      make: (start, end, precision) ->
        for x in [start..end] by precision
          if x >= 0 and x < 200
            @points.push new Phaser.Point x, x + 2
          if x >= 200 and x < 300
            @points.push new Phaser.Point x, x/3
          if x >= 300
            @points.push new Phaser.Point x, x - 1
        @points
      create: () ->
        for point, key in @points
          handle = @game.add.sprite point.x, point.y, 'star'
          handle.inputEnabled = true
          handle.input.enableDrag true
          if @points[key+1]?
            next = @points[key+1]
            line = new Phaser.Line point.x, point.y, next.x, next.y
          @handles.push [
            handle if handle?
            next if next?
            line if line?
          ]
      update: () ->
        @drawer.clear()
        for handle, key in @handles
          if handle[0]? and @handles[key+1]?
            handle[2].fromSprite handle[0], @handles[key+1][0], true
            lineColor = 0xFF0000
            @drawer.beginFill lineColor
            @drawer.lineStyle 1, lineColor, 1
            @drawer.moveTo handle[2].start.x, handle[2].start.y
            @drawer.lineTo handle[2].end.x, handle[2].end.y
            @drawer.endFill()

      getParam: (futurePos, currrentPos) ->
        intersectPoints = []

        lineColor = 0xFF00F0
        @drawer.beginFill lineColor
        @drawer.lineStyle 1, lineColor, 1
        @drawer.drawCircle futurePos.x, futurePos.y, 4
        @drawer.endFill()

        lineAplha = 0.5
        lineWidth = 0.5
        lineColor = 0x00FF00
        @drawer.beginFill lineColor
        @drawer.lineStyle lineWidth, lineColor, lineAplha
        up = new Phaser.Line futurePos.x, futurePos.y, futurePos.x, 0
        @drawer.moveTo up.start.x, up.start.y
        @drawer.lineTo up.end.x, up.end.y
        @drawer.endFill()

        @drawer.beginFill lineColor
        @drawer.lineStyle lineWidth, lineColor, lineAplha
        right = new Phaser.Line futurePos.x, futurePos.y, @game.world.width, futurePos.y
        @drawer.moveTo right.start.x, right.start.y
        @drawer.lineTo right.end.x, right.end.y
        @drawer.endFill()

        @drawer.beginFill lineColor
        @drawer.lineStyle lineWidth, lineColor, lineAplha
        down = new Phaser.Line futurePos.x, futurePos.y, futurePos.x, @game.world.height
        @drawer.moveTo down.start.x, down.start.y
        @drawer.lineTo down.end.x, down.end.y
        @drawer.endFill()

        @drawer.beginFill lineColor
        @drawer.lineStyle lineWidth, lineColor, lineAplha
        left = new Phaser.Line futurePos.x, futurePos.y, 0, futurePos.y
        @drawer.moveTo left.start.x, left.start.y
        @drawer.lineTo left.end.x, left.end.y
        @drawer.endFill()

        lineColor = 0xF00F00
        @drawer.beginFill lineColor
        @drawer.lineStyle 1, lineColor, 1
        for handle, key in @handles
          if handle[2]?
            interUp = up.intersects(handle[2], true)
            if interUp?
              @drawer.drawCircle interUp.x, interUp.y, 4
              intersectPoints.push [
                up.start
                interUp
                Phaser.Point.distance up.start, interUp
              ]
            interRight = right.intersects(handle[2], true)
            if interRight?
              @drawer.drawCircle interRight.x, interRight.y, 4
              intersectPoints.push [
                right.start
                interRight
                Phaser.Point.distance right.start, interRight
              ]
            interDown = down.intersects(handle[2], true)
            if interDown?
              @drawer.drawCircle interDown.x, interDown.y, 4
              intersectPoints.push [
                down.start
                interDown
                Phaser.Point.distance down.start, interDown
              ]
            interLeft = left.intersects(handle[2], true)
            if interLeft?
              @drawer.drawCircle interLeft.x, interLeft.y, 4
              intersectPoints.push [
                left.start
                interLeft
                Phaser.Point.distance left.start, interLeft
              ]
        @drawer.endFill()

        nearestPoint = []
        nearestPoint.distance = null
        nearestPoint.point = null
        for iPoint in intersectPoints
          if iPoint[2] < nearestPoint.distance or ! nearestPoint.distance?
            nearestPoint.distance = iPoint[2]
            nearestPoint.point = iPoint[1]

        if nearestPoint.point?
          lineColor = 0xFFFF00
          @drawer.beginFill lineColor
          @drawer.lineStyle 1, lineColor, 1
          @drawer.drawCircle nearestPoint.point.x, nearestPoint.point.y, 6
          @drawer.endFill()

        nearestPoint.point


    Path