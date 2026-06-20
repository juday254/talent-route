const express = require('express');
const mysql = require('mysql2');
const session = require('express-session');
const bcrypt = require('bcrypt');
const app = express();
const port = 3000;
const dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '08KEMBOIchepro#&',
    database: 'talentroute'
});

app.use(express.static('public'));
app.use(session({
    secret: 'talentroute123',
    resave: false,
    saveUninitialized: false
}));
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
    dbConnection.query('SELECT * FROM opportunities', (err, opportunities) => {
        if (err) {
            return res.status(500).send('Error fetching opportunities');
        }
        res.render('opportunities.ejs', { opportunities, user: req.session.user });
    });
});

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
app.use(express.urlencoded({ extended: true })) 

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
      if (!req.session.user || req.session.user.role !== 'institution') {
        return res.redirect('/institution/login');
    }
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
app.post('/deleteopportunity', (req, res) => {
    if (!req.session.user || req.session.user.role !== 'institution') {
        return res.redirect('/institution/login');
    }
    const { id } = req.body;

    dbConnection.query('DELETE FROM wishlist WHERE opportunity_id = ?', [id], (err) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Error deleting related wishlist entries');
        }

        dbConnection.query('DELETE FROM opportunities WHERE id = ?', [id], (err) => {
            if (err) {
                console.log(err);
                return res.status(500).send('Error deleting opportunity');
            }
            res.redirect('/opportunities');
        });
    });
});
app.post('/deletetalent', (req, res) => {
    const { email } = req.body;

    dbConnection.query('DELETE FROM wishlist WHERE talent_email = ?', [email], (err) => {
        if (err) {
            console.log(err);
            return res.status(500).send('Error deleting related wishlist entries');
        }

        dbConnection.query('DELETE FROM refferals WHERE talent_email = ?', [email], (err) => {
            if (err) {
                console.log(err);
                return res.status(500).send('Error deleting related referrals');
            }

            dbConnection.query('DELETE FROM talents WHERE email = ?', [email], (err) => {
                if (err) {
                    console.log(err);
                    return res.status(500).send('Error deleting talent');
                }
                res.redirect('/talents');
            });
        });
    });
});
//
// Show signup page
app.get('/signup', (req, res) => {
    res.render('signup.ejs');
});

// Handle signup
app.post('/signup', (req, res) => {
    const { fullname, email, password, sport, dob, phone, highest_achievement, education_level } = req.body;

    // Hash the password
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) return res.status(500).send('Error creating account');

        dbConnection.query(
            'INSERT INTO talents (fullname, email, password, sport, dob, phone, highest_achievement, education_level) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            [fullname, email, hashedPassword, sport, dob, phone, highest_achievement, education_level],
            (err, result) => {
                if (err) {
                    console.log(err);
                    return res.status(500).send('Error registering talent');
                }
                res.redirect('/login');
            }
        );
    });
});

// Show login page
app.get('/login', (req, res) => {
    res.render('login.ejs');
});

// Handle login
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    dbConnection.query('SELECT * FROM talents WHERE email = ?', [email], (err, results) => {
        if (err) return res.status(500).send('Error logging in');

        // Check if user exists
        if (results.length === 0) {
            return res.render('login.ejs', { error: 'Invalid email or password' });
        }

        const talent = results[0];

        // Compare password with hashed password
        bcrypt.compare(password, talent.password, (err, match) => {
            if (err || !match) {
                return res.render('login.ejs', { error: 'Invalid email or password' });
            }

            // Save user to session
            req.session.user = {
                email: talent.email,
                fullname: talent.fullname
            };

            res.redirect('/talents');
        });
    });
});

// Logout
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});
// Show institution signup page
app.get('/institution/signup', (req, res) => {
    res.render('institution_signup.ejs');
});

// Handle institution signup
app.post('/institution/signup', (req, res) => {
    const { name, email, password, location } = req.body;

    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) return res.status(500).send('Error creating account');

        dbConnection.query(
            'INSERT INTO institutions (name, email, password, location) VALUES (?, ?, ?, ?)',
            [name, email, hashedPassword, location],
            (err, result) => {
                if (err) {
                    console.log(err);
                    return res.status(500).send('Error registering institution');
                }
                res.redirect('/institution/login');
            }
        );
    });
});

// Show institution login page
app.get('/institution/login', (req, res) => {
    res.render('institution_login.ejs');
});

// Handle institution login
app.post('/institution/login', (req, res) => {
    const { email, password } = req.body;

    dbConnection.query('SELECT * FROM institutions WHERE email = ?', [email], (err, results) => {
        if (err) return res.status(500).send('Error logging in');

        if (results.length === 0) {
            return res.render('institution_login.ejs', { error: 'Invalid email or password' });
        }

        const institution = results[0];

        bcrypt.compare(password, institution.password, (err, match) => {
            if (err || !match) {
                return res.render('institution_login.ejs', { error: 'Invalid email or password' });
            }

            // Save institution to session with role
            req.session.user = {
                id: institution.id,
                name: institution.name,
                email: institution.email,
                role: 'institution'
            };

            res.redirect('/opportunities');
        });
    });
});

// Institution logout
app.get('/institution/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/institution/login');
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});