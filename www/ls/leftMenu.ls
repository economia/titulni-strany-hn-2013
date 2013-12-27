window.LeftMenu = class LeftMenu
    (@parentElement) ->
        secondaryHeaders = @parentElement.selectAll " h2"
            ..on \mousedown ->
                d3.event.preventDefault!
            ..on \click ->
                @className = if @className == "active" then "" else "active"
