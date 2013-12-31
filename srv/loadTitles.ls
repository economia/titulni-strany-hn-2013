require! {
    fs
    http
    async
}
(err, data) <~ fs.readFile "#__dirname/../data/meta.json"
get-article-title = (id, cb) ->
    (res) <~ http.get "http://ssl.ihned.cz/site/api/cs/articles/detail?id=#{id}"
    data = ""
    res.on \data ->
        data += it
    <~ res.on \end
    d = JSON.parse data
    cb null, d.title
i = 0
name-article = (cover, cb) ->
    console.log "#{i++} / #{data.length}"
    (err, links) <~ async.mapSeries cover.links, (link, cb) ->
        id = link.match /\/[a-z][0-9]-([0-9]{6,})-/ .1
        (err, title) <~ get-article-title id
        cb null, {link, title}
    cover.links = links
    cb!
data = JSON.parse data
<~ async.eachSeries data, name-article
<~ fs.writeFile "#__dirname/../data/meta_named.json", JSON.stringify data, " ", 2
