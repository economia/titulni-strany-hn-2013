(err, data) <~ d3.json "../data/meta.json"
tags_assoc = {}
data.forEach ->
    it.tags = it.events ++ it.people ++ it.entities
    it.tags.forEach (tag) ->
        tags_assoc[tag] = (tags_assoc[tag] + 1) || 1
tags = []
for tag, count of tags_assoc
    tags.push {tag, count}
tags.sort (a, b) -> b.count - a.count

leftMenu = new LeftMenu do
    d3.select ".leftMenu"
    tags

frontPages = new FrontPages do
    d3.select \.frontPages
    data
