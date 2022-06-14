const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)

    //zad11
    db.collection('people').updateMany({ job: "Editor" }, { $unset: { email: "" }}, function (error, result) {
        if (error) {
            console.log(error);
        } else {
            console.log(String("modifiedCount="+result.modifiedCount))
        }
    }) 
	})
    



