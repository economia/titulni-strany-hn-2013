window.LeftMenu = class LeftMenu
    (@parentElement, tags, dds) ->
        secondaryHeaders = @parentElement.selectAll "h2"
            ..on \mousedown ->
                d3.event.preventDefault!
            ..on \click ->
                @className = if @className == "active" then "" else "active"
        topics = @parentElement.select "ul.topics"
            ..selectAll "li"
                .data tags
                .enter!append \li
                    ..html -> "#{it.tag} (#{it.count})"
        ddsList = @parentElement.select "ul.dds"
            ..selectAll "li"
                .data dds
                .enter!append \li
                    ..html -> it
