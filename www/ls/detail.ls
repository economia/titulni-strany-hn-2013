window.Detail = class Detail
    (@parentElement) ->
        @img = @parentElement.select \img
        @date = @parentElement.select \h1
        @links = @parentElement.select \ul
        @parentElement.select \.close .on \click @~hide
        @parentElement.select \.bg .on \click @~hide

    display: (page) ->
        @date.html @getDate page
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


    getDate: (page) ->
        day = parseInt page.file.substr 2, 2
        month = switch page.file.substr 0, 2
        | "01" => "ledna"
        | "02" => "února"
        | "03" => "března"
        | "04" => "dubna"
        | "05" => "května"
        | "06" => "června"
        | "07" => "července"
        | "08" => "srpna"
        | "09" => "září"
        | "10" => "října"
        | "11" => "listopadu"
        | "12" => "prosince"
        "#day. #month 2013"
