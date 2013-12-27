leftMenu = new LeftMenu d3.select ".leftMenu"
(err, data) <~ d3.json "../data/meta.json"
console.log data
frontPages = new FrontPages do
    d3.select \.frontPages
    data
