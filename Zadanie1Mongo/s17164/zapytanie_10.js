const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)


    //zad10
    db.collection('people').updateMany({ "first_name": "Antonio" }, { $set: { "hobby": "pingpong" } }, function (error, result) {
         if (error) {
            console.log(error);
         } else {
            console.log(String("modifiedCount=" + result.modifiedCount))
         }
    })

    })
    



