const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3000;
const dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '08KEMBOIchepro#&',
    database: 'talentroute'
});
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
dbConnection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database');
});
app.get('/', (req, res) => {
    res.render('index.ejs');
})
app.get("/opportunities", (req, res) => {
    res.render('opportunities.ejs');
})
app.get("/talents", (req, res) => {
    dbConnection.query('SELECT * FROM talents', (err, talents) => {
        if (err) {
            return res.status(500).send('Error fetching talents from the database');
        }
        res.render('talents.ejs', { talents });
    });
})
app.get("/contact", (req, res) => {

    res.render('contact.ejs');
})
app.get("/registertalent", (req, res) => {
    res.render('registertalent.ejs');
})
app.use(express.urlencoded({ extended: true })) // to read form data

app.post("/registertalent", (req, res) => {
    const { email, fullname, sport, dob, phone, highest_achievement, education_level } = req.body;
    
    dbConnection.query(
        'INSERT INTO talents (email, fullname, sport, dob, phone, highest_achievement, education_level) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [email, fullname, sport, dob, phone, highest_achievement, education_level],
        (err, result) => {
            if (err) {
                return res.status(500).send('Error registering talent');
            }
            res.send('Registered successfully!');
        }
    );
});

// Show the add opportunity form
app.get('/addopportunity', (req, res) => {
    res.render('addopportunity.ejs');
});

// Save the opportunity to the database
app.post('/addopportunity', (req, res) => {
    const { title, description, location, university, requirements, application_link } = req.body;

    dbConnection.query(
        'INSERT INTO opportunities (title, description, location, university, requirements, application_link) VALUES (?, ?, ?, ?, ?, ?)',
        [title, description, location, university, requirements, application_link],
        (err, result) => {
            if (err) {
                return res.status(500).send('Error posting opportunity');
            }
            res.redirect('/opportunities');
        }
    );
});


app.listen(3000, () => {
    console.log('Server is running on port 3000');
});