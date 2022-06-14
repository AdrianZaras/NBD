const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)


    //zad 4 agregacja

    db.collection('people').aggregate([{
        $addFields: { bmi: {
            $divide: [{ $toDouble: "$weight" }, { 
                $multiply: [{ 
                    $divide: [{ $toDouble: "$height" }, 100] },{
                    $divide: [{ $toDouble: "$height" }, 100] }]}]
        }}},{
        $group: {
            _id: "$nationality",
            avgBmi: { $avg: "$bmi" },
            maxBmi: { $max: "$bmi" },
            minBmi: { $min: "$bmi" }
        }}
    ]).toArray((error, result) => { console.log(result) })

    


    })
    



