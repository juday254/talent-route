CREATE DATABASE talentroute;
USE talentroute;    

CREATE TABLE opportunities(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
description TEXT,
location VARCHAR(255),
university VARCHAR(255),
requirements TEXT,
application_link VARCHAR(255)
);

CREATE TABLE talents(
    email VARCHAR(255) PRIMARY KEY,
    fullname VARCHAR(255) NOT NULL,
    sport VARCHAR(50),
    dob DATE,
    phone VARCHAR(20),
    highest_achievement TEXT,
    education_level VARCHAR(50)
);

CREATE TABLE wishlist(
id INT AUTO_INCREMENT PRIMARY KEY,
talent_email VARCHAR(255),
opportunity_id INT,
status ENUM('interested', 'applied', 'rejected','successful') DEFAULT 'interested',
FOREIGN KEY (talent_email) REFERENCES talents(email) ,
FOREIGN KEY (opportunity_id) REFERENCES opportunities(id)
);

CREATE TABLE refferals(
id INT AUTO_INCREMENT PRIMARY KEY,
talent_email VARCHAR(255),
referee_name VARCHAR(255),
referee_email VARCHAR(255),
referee_phone VARCHAR(20),
relationship VARCHAR(255),
description TEXT,
attachment_url VARCHAR(255),
FOREIGN KEY (talent_email) REFERENCES talents(email)
);


USE talentroute;

-- ==========================================
-- 1. SEED DATA FOR TABLE: talents
-- ==========================================
INSERT INTO talents (email, fullname, sport, dob, phone, highest_achievement, education_level) VALUES
('brian.omondi@gmail.com', 'Brian Omondi', 'Football', '2004-05-14', '+254711223344', 'Top scorer in Chapa Dimba na Safaricom regional finals', 'High School'),
('faith.chepngetich@yahoo.com', 'Faith Chepngetich', 'Athletics', '2005-08-22', '+254722334455', 'Gold medal in 1500m at East Africa Secondary School Games', 'High School'),
('emmanuel.kiprop@outlook.com', 'Emmanuel Kiprop', 'Athletics', '2003-11-02', '+254733445566', 'Represented Kenya in World U20 Athletics Championships', 'Undergraduate'),
('mercy.wambui@gmail.com', 'Mercy Wambui', 'Basketball', '2004-01-30', '+254744556677', 'MVP at the Kajiado County Secondary Schools Basketball finals', 'High School'),
('kevin.otieno@hotmail.com', 'Kevin Otieno', 'Rugby', '2002-07-19', '+254755667788', 'Called up to the Kenya 7s (Shujaa) academy squad', 'Undergraduate'),
('stacy.mwende@gmail.com', 'Stacy Mwende', 'Volleyball', '2005-03-12', '+254766778899', 'Best Setter award at national school games', 'High School'),
('david.ndwiga@yahoo.com', 'David Ndwiga', 'Football', '2003-09-25', '+254777889900', 'Played for FKF Premier League youth side', 'Undergraduate'),
('amina.ali@gmail.com', 'Amina Ali', 'Hockey', '2004-12-05', '+254788990011', 'Captain of the national high school champions team', 'High School'),
('victor.kamau@gmail.com', 'Victor Kamau', 'Rugby', '2005-02-17', '+254799001122', 'Part of the Mwamba RFC youth development program', 'High School'),
('joyce.atieno@outlook.com', 'Joyce Atieno', 'Basketball', '2002-10-10', '+254712345678', 'Led KPA youth team to regional club victory', 'Undergraduate');


-- ==========================================
-- 2. SEED DATA FOR TABLE: opportunities
-- ==========================================
INSERT INTO opportunities (title, description, location, university, requirements, application_link) VALUES
('Athletics Track & Field Scholarship', 'Full athletic scholarship for elite mid-distance runners.', 'Oregon, USA', 'University of Oregon', 'Sub 3:45 for 1500m (Men), Sub 4:10 (Women), High school certificate with C+ minimum.', 'https://goducks.com/sports/scholarships'),
('Elite Basketball Talent Program', 'Sports scholarship covering tuition, housing, and training kits.', 'Nairobi, Kenya', 'United States International University (USIU-A)', 'Must have played in the national secondary school finals or local league. KCSE C+ and above.', 'https://usiu.ac.ke/sports-scholarships'),
('Collegiate Rugby Scholarship', 'Opportunity to join a premier rugby program with partial academic funding.', 'Texas, USA', 'Lindenwood University', 'Video highlights of regional/national matches, reference letter from a certified coach, SAT score of 1050+.', 'https://lindenwoodlions.com/apply'),
('High-Performance Football Scouting', 'Full tuition scholarship for exceptionally talented midfielders and forwards.', 'Strathmore, Kenya', 'Strathmore University', 'KCSE grade B- and above, trial attendance required, provincial level experience.', 'https://strathmore.edu/sports-scholarship'),
('NCAA Division 1 Soccer Scholarship', 'Full ride soccer scholarship for international student-athletes.', 'South Carolina, USA', 'Clemson University', 'NCAA Eligibility Center clearance, TOEFL/IELTS pass, highlight reel.', 'https://clemsontigers.com/soccer-recruitment'),
('Full Track & Field Athletic Grant', 'Sponsorship targeting high-potential sprinters and long-distance runners.', 'Texas, USA', 'Texas A&M University', 'IAAF junior rankings or equivalent national times, GPA conversion equivalent to 3.0+.', 'https://12thman.com/athletic-scholarships'),
('National Volleyball League Talent Hunt', 'Sports tuition waiver and monthly stipend for top volleyball setters and blockers.', 'Nairobi, Kenya', 'Kenyatta University', 'KCSE C+ minimum, participation in KVF national national youth tournaments.', 'https://ku.ac.ke/sports'),
('Elite Field Hockey Academic-Athletic Grant', 'Scholarship for outstanding female hockey players.', 'Birmingham, UK', 'University of Birmingham', 'A-level equivalent or KCSE B, video portfolio, national youth team caps preferred.', 'https://sportandfitness.bham.ac.uk/scholarships'),
('College Rugby Development Scholarship', 'Scholarship aiming to develop international rugby talent in the US collegiate system.', 'California, USA', 'Saint Marys College of California', 'High school graduate, recommendation from national rugby federation (KRU), physical fitness test pass.', 'https://stmarys-ca.edu/rugby-recruits'),
('Vanguard Basketball Sports Scholarship', 'Full athletic waiver for dominant centers and point guards.', 'Nairobi, Kenya', 'Strathmore University', 'KCSE C+ and above, elite level high school statistics, mandatory physical tryouts.', 'https://strathmore.edu/vanguard-sports');


-- ==========================================
-- 3. SEED DATA FOR TABLE: wishlist
-- ==========================================
INSERT INTO wishlist (talent_email, opportunity_id, status) VALUES
('brian.omondi@gmail.com', 4, 'applied'),
('brian.omondi@gmail.com', 5, 'interested'),
('faith.chepngetich@yahoo.com', 1, 'successful'),
('faith.chepngetich@yahoo.com', 6, 'applied'),
('emmanuel.kiprop@outlook.com', 1, 'applied'),
('mercy.wambui@gmail.com', 2, 'interested'),
('kevin.otieno@hotmail.com', 3, 'successful'),
('stacy.mwende@gmail.com', 7, 'interested'),
('david.ndwiga@yahoo.com', 4, 'rejected'),
('joyce.atieno@outlook.com', 10, 'applied');


-- ==========================================
-- 4. SEED DATA FOR TABLE: refferals (Referrals)
-- ==========================================
INSERT INTO refferals (talent_email, referee_name, referee_email, referee_phone, relationship, description, attachment_url) VALUES
('brian.omondi@gmail.com', 'Coach Peter Okumu', 'peter.okumu@fkf.co.ke', '+254722111222', 'High School Coach', 'Brian is a disciplined striker with an eye for goal. Highly recommended.', 'https://talentroute.com/docs/ref_brian.pdf'),
('faith.chepngetich@yahoo.com', 'Colm Connell', 'colm.oconnell@itaten.com', '+254733222333', 'Club Mentor / Coach', 'Faith has world-class endurance and a brilliant tactical mind for the 1500m.', 'https://talentroute.com/docs/ref_faith.pdf'),
('emmanuel.kiprop@outlook.com', 'Jane Jackson', 'j.jackson@athleticskenya.or.ke', '+254711555666', 'National Scout', 'Emmanuel performed exceptionally well during the world U20 trials in Nairobi.', 'https://talentroute.com/docs/ref_emmanuel.pdf'),
('mercy.wambui@gmail.com', 'Teacher Agnes Mwangi', 'amwangi@kajiadohigh.ac.ke', '+254722888999', 'Games Teacher', 'Mercy led our school team to the regionals. Excellent leadership skills.', 'https://talentroute.com/docs/ref_mercy.pdf'),
('kevin.otieno@hotmail.com', 'Paul Murunga', 'pmurunga@kru.co.ke', '+254733999000', 'Academy Director', 'Kevin has explosive speed and fits perfectly into the modern sevens style.', 'https://talentroute.com/docs/ref_kevin.pdf'),
('stacy.mwende@gmail.com', 'Coach David Lungaho', 'lungaho@kvf.co.ke', '+254721444555', 'Club Coach', 'Stacy shows maturity beyond her years as a volleyball setter.', 'https://talentroute.com/docs/ref_stacy.pdf'),
('david.ndwiga@yahoo.com', 'John Kamau', 'jkamau@postabrands.co.ke', '+254734666777', 'Youth Team Coach', 'David is a solid winger with great cross accuracy.', 'https://talentroute.com/docs/ref_david.pdf'),
('amina.ali@gmail.com', 'Fatma Hussein', 'f.hussein@khf.co.ke', '+254712777888', 'School Principal', 'Amina balances her academic brilliance perfectly with her hockey captaincy.', 'https://talentroute.com/docs/ref_amina.pdf'),
('victor.kamau@gmail.com', 'Humphrey Kayange', 'h.kayange@shujaa.co.ke', '+254722000111', 'Rugby Consultant', 'Victor is a promising forward with immense physical presence and work rate.', 'https://talentroute.com/docs/ref_victor.pdf'),
('joyce.atieno@outlook.com', 'Anthony Ojukwu', 'aojukwu@kpa.co.ke', '+254733111444', 'Head Coach', 'Joyce is local league material already. Ready for college basketball intensity.', 'https://talentroute.com/docs/ref_joyce.pdf');



 select fullname, sport,phone from talents;

 select fullname, sport,phone from talents where sport = "hockey";

 select count(email) from talents;

 select count(email) from talents where sport = "rugby";


select * from opportunities where requirements like "%kcse%";


-- // count how many talets have appliet to opportunity number 1
select count(*) from wishlist where opportunity_id = 1 and status = "interested";


-- Which sports have the highest number of registered talents?
SELECT 
    sport, 
    COUNT(*) AS total_players 
FROM talents
GROUP BY sport
ORDER BY total_players DESC;

-- What is the success rate of applications for opportunities?
SELECT 
    status,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM wishlist WHERE status != 'interested'), 2) AS percentage
FROM wishlist
WHERE status != 'interested'
GROUP BY status;

-- Which universities or locations are generating the most interest?
SELECT 
    o.university,
    o.location,
    COUNT(w.id) AS total_saved_or_applied
FROM opportunities o
JOIN wishlist w ON o.id = w.opportunity_id
GROUP BY o.id, o.university, o.location
ORDER BY total_saved_or_applied DESC
LIMIT 5;

-- Who are the top players with verified referrals and active applications?

SELECT 
    t.fullname,
    t.sport,
    COUNT(DISTINCT r.id) AS total_referrals,
    COUNT(DISTINCT CASE WHEN w.status = 'applied' THEN w.id END) AS active_applications
FROM talents t
LEFT JOIN refferals r ON t.email = r.talent_email
LEFT JOIN wishlist w ON t.email = w.talent_email
GROUP BY t.email, t.fullname, t.sport
HAVING total_referrals > 0 AND active_applications > 0
ORDER BY active_applications DESC, total_referrals DESC;    

-- What is the current age distribution of the talent pool?

SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) < 18 THEN 'Under 18'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 18 AND 21 THEN '18-21 Years'
        WHEN TIMESTAMPDIFF(YEAR, dob, CURDATE()) BETWEEN 22 AND 25 THEN '22-25 Years'
        ELSE 'Over 25'
    END AS age_group,
    COUNT(*) AS total_talents
FROM talents
GROUP BY age_group
ORDER BY age_group;


-- ASSIGNEMNT - SQL JOINS