var express = require('express'),
    fs = require('fs'),
    path = require('path');

function getInfo(filename) {
  var myInfo = { }

  var title = filename.split("/")
  myInfo.title = title[title.length - 2];

  var data = fs.readFileSync(path.join(__dirname,filename), {encoding: 'utf-8'})
  var n1 = data.indexOf('.listen(') + 8;
  var n2 = data.indexOf(',', n1);
  port = data.substr(n1, n2 - n1 )
  myInfo.port = port;

  return myInfo;
}

function dirTree(startPath, info) {
    var filter = "index.js"
    if (!fs.existsSync(startPath)){
        console.log("no dir ",startPath);
        return;
    }

    var files=fs.readdirSync(startPath);
    for(var i=0;i<files.length;i++){
        var filename=path.join(startPath,files[i]);
        var stat = fs.lstatSync(filename);
        if (stat.isDirectory()){
           if (files[i] != "node_modules") {
            info = dirTree(filename, info);
           }
        }
        else if (filename.indexOf(filter)>=0) {
          if (Array.isArray(info.nodes)) {
            info.nodes.push(getInfo(filename))
          } else {
            info.nodes = [getInfo(filename)]
          }
        };
    };

   return info;
};

var handlebars = require('handlebars');
var app = express();

var data = { };
data.title = "MyNodes";

  if (module.parent == undefined) { 
    data = dirTree('root', data);
  }
  data.body = process.argv[2];

app.get('/', function (req, res) {
  app.use('/', express.static(path.join(__dirname, 'root')));
  data.host = res.req.headers.host.split(":")[0]

  fs.readFile('index.html', 'utf-8', function(error, source){
    handlebars.registerHelper('custom_title', function(title){
      return title;
    })

    var template = handlebars.compile(source);
    var html = template(data);

  res.send(html)
  })
});
app.listen(80, function () {
  console.log('Index app listening on port 80!');
});
