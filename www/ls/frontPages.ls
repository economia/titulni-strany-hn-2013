months =
    "--"
    "ledna"
    "února"
    "března"
    "dubna"
    "května"
    "června"
    "července"
    "srpna"
    "září"
    "října"
    "listopadd"
    "prosince"
window.FrontPages = class FrontPages
    firstRun: yes
    (@parentElement, @scrollElement, @detail, @data) ->
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
        @detail.allData = data
        sel = @parentElement.selectAll "div.page.active"
            .data data, (.file)
        for datum, index in data
            datum.index = index
        sel.enter!append \div
                ..attr \class "page active fadingIn"
                ..style "width" "#{width}px"
                ..style "height" "#{height}px"
                ..append "img"
                    ..attr \src '../data/thumb/loading.png'
                    ..attr \data-echo ->
                        src = it.file.replace ".pdf" ".jpg"
                        "../data/thumb/#src"
                    ..attr \width "#{width}px"
                    ..attr \height "#{height}px"
                ..append \span
                    ..html ->
                        month = parseInt do
                            it.file.substr 0, 2
                            10
                        day = parseInt do
                            it.file.substr 2, 2
                            10
                        "#{day}. #{months[month]}"
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
        if @firstRun
            @firstRun = no
            Echo.init do
                offset: 300
                throttle: 250
                target: document.querySelector '.frontPages'
        else
            Echo.rescan!
            setTimeout Echo.rescan, 400
            setTimeout Echo.rescan, 810
        @scrollElement.0.0.scrollTop = 0


