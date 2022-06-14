const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)

    //zad6
    db.collection('people').aggregate([{ $match: { "birth_date": { $gte: (new Date("2000-01-01T00:00:00.00Z")).toISOString() } } }, { $project: { "first_name": 1, "last_name": 1, "location": { "city": 1 }, _id: 0 } } ]).toArray((error, result) => {console.log(result)})

    })
    



