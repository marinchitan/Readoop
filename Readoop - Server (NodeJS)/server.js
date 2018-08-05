var express = require('express')
var mongoClient = require('mongodb').MongoClient
var app = express()
var bodyParser = require('body-parser')
var mongoDB

mongoClient.connect('mongodb://localhost:27017/redoopdb', { useNewUrlParser: true }, function (err, client) {
  	if (err) {
  		throw err 
	} else {
		mongoDB = client.db('redoopdb')
		console.log("Connecting to MongoDB")
	}
  
  
})

app.use(bodyParser.json({limit: '200mb'})) //Payload limit


app.get('/requests', function (req, res) {
  mongoDB.collection('request').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})

app.get('/writingComments', function (req, res) {
  mongoDB.collection('writingComment').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})

app.get('/bookRates', function (req, res) {
  mongoDB.collection('bookRate').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})

app.get('/posts', function (req, res) {
  mongoDB.collection('post').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})


app.get('/writings', function (req, res) {
  mongoDB.collection('writing').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})

app.get('/users', function (req, res) {
  mongoDB.collection('user').find().toArray(function (err, result) {
    if (err) throw err
    res.json(result)
  })
})





app.post('/requests', function (req, res) {
  mongoDB.collection('request').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting request');
      else
        res.send('Success inserting request');
  })
})

app.post('/writingComments', function (req, res) {
  mongoDB.collection('writingComment').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting writingComment');
      else
        res.send('Success inserting writingComment');
  })
  console.log(req.body)
})

app.post('/bookRates', function (req, res) {
  mongoDB.collection('bookRate').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting request');
      else
        res.send('Success inserting request');
  })
})

app.post('/posts', function (req, res) {
  mongoDB.collection('post').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting request');
      else
        res.send('Success inserting request');
  })
})

app.post('/writings', function (req, res) {
  mongoDB.collection('writing').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting request');
      else
        res.send('Success inserting request');
  })
})

app.post('/users', function (req, res) {
  mongoDB.collection('user').insert(req.body, function (err, result) {
      if (err)
         res.send('Error inserting request');
      else
        res.send('Success inserting request');
  })
})




app.delete('/requests', function (req, res) {
	mongoDB.collection('request').remove(req.body, function (err,result) {
		if (err)
         res.send('Error deleting request');
      else
        res.send('Success deleting request');
	})
	console.log(req.body)
})




console.log("Server running...")

app.listen(3000)
