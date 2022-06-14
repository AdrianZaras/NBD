const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)


    //zad2 agregacja 
    db.collection('people').aggregate([{
        $project: { credit: 1 }
    },{
        $unwind: { path: "$credit" }
    },{
        $group: {
            _id: "$credit.currency",
            suma: { $sum: { $toDouble: "$credit.balance"}}
        }
    }
    ]).toArray((error, result) => { console.log(result) })


    })
    



