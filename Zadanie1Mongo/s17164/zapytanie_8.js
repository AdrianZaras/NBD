const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)

    //zad8
    db.collection('people').deleteMany({ height: { $gt: "190" } }, function (error, result) {
        if (error) {
            console.log(error);
        } else {
            console.log(String(result.deletedCount))
        }
    })

    })
    



