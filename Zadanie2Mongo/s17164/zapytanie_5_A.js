const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)


    //zad 5 agregacja 
    db.collection('people').aggregate([{
        $match: { nationality: "Poland", sex: "Female" }},{
        $unwind: {path: "$credit"}},{
        $group: {
            _id: "$credit.currency",
            sumBalance: { $sum: { $toDouble: "$credit.balance" } },
            avgBalance: { $avg: { $toDouble: "$credit.balance" }}
        }
    }]).toArray((error, result) => { console.log(result) })
    




    })
    



