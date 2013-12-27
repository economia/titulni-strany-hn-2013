window.Detail = class Detail
    (@parentElement) ->
        @img = @parentElement.select \img
        @links = @parentElement.select \ul
        @parentElement.select \.close .on \click @~hide

    display: (page) ->
        @parentElement.classed \active yes
        @img.attr \src "../data/full/#{page.file.replace '.pdf' '.png'}"
        @links.selectAll \li .remove!
        @links.selectAll \li
            .data page.links
            .enter!append \li
                ..append \a
                    ..html -> it
                    ..attr \href -> it
                    ..attr \target \_top

    hide: ->
        @parentElement.classed \active no
