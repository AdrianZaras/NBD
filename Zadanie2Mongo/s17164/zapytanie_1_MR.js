const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)



    //zad1 MR

    db.collection('people').mapReduce(
        function () {
            emit(this.sex, { weight: this.weight, height: this.height });
        },
        function (key, values) {
            let sumWeight = 0.0;
            let sumHeight = 0.0;
            for (var i = 0; i < values.length; i++) {
                sumWeight +=  parseFloat(values[i].weight);
                sumHeight +=  parseFloat(values[i].height);
            }

            return {
                avgWeight: sumWeight / values.length,
                avgHeight: sumHeight / values.length
            };
        },
        { out: 'zad1MR' }
    );
    setTimeout(function () {db.collection('zad1MR').find({}).toArray((error, result) => { console.log(result) });}, 2000);

    

    })
    



