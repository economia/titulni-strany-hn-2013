Echo.init do
    offset: 300
    throttle: 250
    target: document.querySelector '.frontPages'
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
dds = for tag of dds_assoc => {tag}
tags.sort (a, b) -> b.count - a.count

detail = new Detail d3.select \.detail

frontPages = new FrontPages do
    d3.select ".frontPages .content"
    detail
    data

leftMenu = new LeftMenu do
    d3.select ".leftMenu"
    frontPages
    tags
    dds
