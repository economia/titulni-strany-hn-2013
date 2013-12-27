window.FrontPages = class FrontPages
    (@parentElement, @detail, @data) ->
        @update!

    update: (term) ->
        width = 217px
        height = 312px
        margin_x = 20px
        margin_y = 20px
        data = if term
            @data.filter ->
                term in it.tags
        else
            @data
        sel = @parentElement.selectAll "div.page.active"
            .data data, (.file)
        for datum, index in data
            datum.index = index
        sel.enter!append \div
                ..attr \class "page active fadingIn"
                ..style "width" "#{width}px"
                ..style "height" "#{height}px"
                ..append "img"
                    ..attr \src ->
                        src = it.file.replace ".pdf" ".png"
                        "../data/thumb/#src"
                    ..attr \width "#{width}px"
                    ..attr \height "#{height}px"
                ..on \click ~> @detail.display it
                ..transition!
                    ..delay 1
                    ..attr \class "page active"
        sel.exit!
            ..attr \class "page fadingOut"
            ..transition!
                ..delay 800
                ..remove!

        @parentElement.selectAll "div.page.active"
            ..style "left" ({index}) -> "#{index % 3 * (width + margin_x)}px"
            ..style "top" ({index}) -> "#{(Math.floor (index / 3)) * (height + margin_y)}px"
        @parentElement.style \height "#{((Math.floor(data.length / 3)) + 1) * ((height + margin_y))}px"
