const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)



    //zad 4 MR

    db.collection('people').mapReduce(
        function () {
            emit(this.nationality, { weight: this.weight, height: this.height } )
        },
        function (key, values) {
            let avgBmi = 0
            let maxBmi = 0
            let minBmi = 0
            for (var i = 0; i < values.length; i++) {
                heightTo2 = (parseFloat(values[i].height) / 100) * (parseFloat(values[i].height) / 100)
                bmi = parseFloat(values[i].weight) / heightTo2
                avgBmi += bmi
                if (bmi > maxBmi) maxBmi = bmi
                if (i == 0) minBmi = maxBmi
                if (minBmi > bmi) minBmi = bmi
            }
            return {
                avgBmi: avgBmi / values.length,
                maxBmi,
                minBmi
            }
        },
        { out: 'zad4MR' }
    );


    setTimeout(function () {
        db.collection('zad4MR').find({}).toArray((error, result) => { console.log(result) });
    }, 2000);


    })
    



