(err, data) <~ d3.json "../data/meta.json"
tags_assoc = {}
dds_assoc = []
data.forEach ->
    it.tags = it.events ++ it.people ++ it.entities
    it.tags.forEach (tag) ->
        tags_assoc[tag] = (tags_assoc[tag] + 1) || 1
    if it.dds
        dds_assoc[it.dds] = 1
        it.tags.push it.dds
tags = []
for tag, count of tags_assoc
    tags.push {tag, count}
dds = for item of dds_assoc => item
tags.sort (a, b) -> b.count - a.count

leftMenu = new LeftMenu do
    d3.select ".leftMenu"
    tags
    dds

frontPages = new FrontPages do
    d3.select \.frontPages
    data
