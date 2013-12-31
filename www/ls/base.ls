(err, data) <~ d3.json "../data/meta_named.json"
dds_assoc = []
tags_categories =
    events:
        assoc: {}
        arr: []
    people:
        assoc: {}
        arr: []
    entities:
        assoc: {}
        arr: []
    months:
        assoc: {}
        arr:
            {tag: "Leden"}
            {tag: "Únor"}
            {tag: "Březen"}
            {tag: "Duben"}
            {tag: "Květen"}
            {tag: "Červen"}
            {tag: "Červenec"}
            {tag: "Srpen"}
            {tag: "Září"}
            {tag: "Říjen"}
            {tag: "Listopad"}
            {tag: "Prosinec"}
data.forEach (cover) ->
    for category in <[events people entities]>
        tag_category = tags_categories[category]
        for tag in cover[category]
            if tag_category['assoc'][tag] is void
                tag_category['assoc'][tag] = 0
            tag_category['assoc'][tag]++
    cover.tags = cover.events ++ cover.people ++ cover.entities
    cover.tags.push switch cover.file.substr 0, 2
        | \01 => "Leden"
        | \02 => "Únor"
        | \03 => "Březen"
        | \04 => "Duben"
        | \05 => "Květen"
        | \06 => "Červen"
        | \07 => "Červenec"
        | \08 => "Srpen"
        | \09 => "Září"
        | \10 => "Říjen"
        | \11 => "Listopad"
        | \12 => "Prosinec"
    if cover.dds
        dds_assoc[cover.dds] = 1
        cover.tags.push cover.dds
for category in <[events people entities]>
    tag_category = tags_categories[category]
    for tag, count of tag_category['assoc']
        tag_category['arr'].push {tag, count}
tag_category['arr'].sort (a, b) -> b.count - a.count
dds = for tag of dds_assoc => {tag}
tags = window.topics.map (tag) -> {tag}
detail = new Detail d3.select \.detail

frontPages = new FrontPages do
    d3.select ".frontPages .content"
    d3.select ".frontPages"
    detail
    data

leftMenu = new LeftMenu do
    d3.select ".leftMenu"
    frontPages
    tags
    tags_categories
    dds
