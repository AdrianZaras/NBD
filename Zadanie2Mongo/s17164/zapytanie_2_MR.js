const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)



    //zad2 MR

    db.collection('people').mapReduce(
        function () {
            for (var i = 0; i < this.credit.length; i++) {
                emit(this.credit[i].currency, parseFloat(this.credit[i].balance))
            }
        },
        function (key, values) {
            return Array.sum(values) ;
        },
        { out: 'zad2MR' }
    );

    setTimeout(function () {
        db.collection('zad2MR').find({}).toArray((error, result) => { console.log(result) });
    }, 2000);



    })
    



