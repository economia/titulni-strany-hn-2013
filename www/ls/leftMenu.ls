window.LeftMenu = class LeftMenu
    (@parentElement, frontPages, tags, tags_categories, dds) ->
        secondaryHeaders = @parentElement.selectAll "h2"
            ..on \mousedown ->
                d3.event.preventDefault!
            ..on \click ->
                @className = if @className == "active" then "" else "active"
        topics = @parentElement.select "ul.topics"
            ..selectAll "li"
                .data tags
                .enter!append \li
                    ..html -> "#{it.tag}"
        ddsList = @parentElement.select "ul.dds"
            ..selectAll "li"
                .data dds
                .enter!append \li
                    ..html (.tag)
        for category, {arr} of tags_categories
            @parentElement.select "ul.#category"
                ..selectAll \li
                    .data arr
                    .enter!append \li
                        ..html (.tag)
        allItems = @parentElement.selectAll "li"
            ..on \click ->
                | @className == "active"
                    @className = ""
                    cancel.classed \active no
                    frontPages.update!
                | otherwise
                    allItems.classed \active no
                    cancel.classed \active yes
                    @className = "active"
                    frontPages.update it.tag
        cancel = d3.select \ul.cancel
            ..on \click ->
                allItems.classed \active no
                cancel.classed \active no
                frontPages.update!
