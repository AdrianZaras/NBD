const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)



    //zad 3 MR 

    db.collection('people').mapReduce(
        function () {
            emit(this.job, 1);
        },
        function (key, values) {
            return 1 ;
        },
        { out: 'zad3MR' }
    );


    setTimeout(function () {
        db.collection('zad3MR').find({}).toArray((error, result) => { console.log(result) });
    }, 2000);



    })
    



