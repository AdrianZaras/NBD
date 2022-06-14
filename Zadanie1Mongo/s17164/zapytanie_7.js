const mongoClient = require('mongodb').MongoClient

const url = 'mongodb://127.0.0.1:27017'
const dbname = 'nbd'

mongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
}, (error, client) => {
    const db = client.db(dbname)


    //zad7
    db.collection('people').insert([{
        sex: "Male",
        first_name: "Adrian",
        last_name: "Zaras",
        job: "Student",
        email: "s17164@pjwstk.edu.pl",
        location: {
            city: "Siedlce",
            address: { streetname: "Wiejska", streetnumber: "260" }
        },
        description: "Nescio Latine: sed sum vir bonus. Nescio quid ita intrare in translators Latine. Per Lukasz Banach",
        height: "174.40",
        weight: "80.50",
        birth_date: "1995-10-18T16:49:00Z",
        nationality: "Poland",
        credit: [{
            type: "visa-electron",
            number: "0000666611110000699",
            currency: "EUR",
            balance: "57.06"
        }, {
           type: "mastercard",
           number: "0000555577770000699",
           currency: "PLN",
           balance: "100.06"
        }]
    }],
        function (error, result) {
            if (error) {
                console.log(error);
            } else {
                console.log(result.ops)
            }
    });
    })
    



