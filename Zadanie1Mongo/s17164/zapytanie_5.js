const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)

    //zad5
    db.collection('people').find({weight:{$gte:"68",$lt:"71.5"}}).toArray((error, result) => {console.log(result)})


    })
    



