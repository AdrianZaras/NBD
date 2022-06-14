const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {

    const db = client.db(dbname)



    //zad3
    db.collection('people').findOne({ sex: "Female", nationality: "China" }).then(function (result) {console.log(result)})
















    })
    



