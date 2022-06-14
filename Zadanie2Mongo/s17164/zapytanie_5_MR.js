const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)




    //zad 5 MR

    db.collection('people').mapReduce(
        function () {
            for (var i = 0; i < this.credit.length; i++) {
                emit(this.credit[i].currency, parseFloat(this.credit[i].balance))
            }
        },
        function (key, values) {
            let sumBalance = Array.sum(values) 
            let avgBalance = sumBalance / values.length

            return {
                sumBalance, avgBalance
            }
        },
        {
            query: {
                sex: 'Female',
                nationality: 'Poland'
            },
            out: 'zad5MR' 
        },
    );

    setTimeout(function () {
        db.collection('zad5MR').find({}).toArray((error, result) => { console.log(result) });
    }, 2000);


    })
    



