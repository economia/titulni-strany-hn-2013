window.LeftMenu = class LeftMenu
    (@parentElement, tags) ->
        secondaryHeaders = @parentElement.selectAll "h2"
            ..on \mousedown ->
                d3.event.preventDefault!
            ..on \click ->
                @className = if @className == "active" then "" else "active"
        menu = @parentElement.select "ul.topics"
        menu.selectAll "li"
            .data tags
            .enter!append \li
                ..html -> "#{it.tag} (#{it.count})"
