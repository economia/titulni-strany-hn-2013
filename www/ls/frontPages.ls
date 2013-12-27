window.FrontPages = class FrontPages
    (@parentElement, @data) ->
        @update!

    update: ->
        width = 217px
        height = 312px
        margin_x = 20px
        margin_y = 20px
        data = @data
        @parentElement.selectAll "div.page.active"
            .data data
            .enter!append \div
                ..attr \class "page active"
                ..style "width" "#{width}px"
                ..style "height" "#{height}px"
                ..style "left" (d, i) -> "#{i % 3 * (width + margin_x)}px"
                ..style "top" (d, i) -> "#{(Math.floor (i / 3)) * (height + margin_y)}px"
                ..append "img"
                    ..attr \src ->
                        src = it.file.replace ".pdf" ".png"
                        "../data/thumb/#src"
                    ..attr \width "#{width}px"
                    ..attr \height "#{height}px"
