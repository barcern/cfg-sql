CREATE DATABASE bees;

USE bees;

# Create tables
CREATE TABLE teams (
	team_id VARCHAR(50) PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    team_location VARCHAR(50)
);

LOAD DATA INFILE 'C:/tmp/teams.csv'
INTO TABLE teams 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM teams;

CREATE TABLE games (
	game_id VARCHAR(50) NOT NULL PRIMARY KEY,
    game_date DATE,
    fk_bees VARCHAR(50),
    fk_team2 VARCHAR(50),
    bees_shots INT,
    team2_shots INT,
    bees_goals INT,
    team2_goals INT,
    bees_penalties INT,
    team2_penalties INT,
    home_away VARCHAR(50),
    FOREIGN KEY (fk_bees) REFERENCES teams(team_id),
    FOREIGN KEY (fk_team2) REFERENCES teams(team_id)
);

LOAD DATA INFILE 'C:/tmp/games.csv'
INTO TABLE games 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM games;

CREATE TABLE players (
	player_id VARCHAR(50) PRIMARY KEY NOT NULL,
    fk_team_player VARCHAR(50),
    nationality VARCHAR(50),
    player_name VARCHAR(50) NOT NULL,
    games_played INT,
    left_right VARCHAR(50),
    date_of_birth DATE,
    age INT,
    player_position VARCHAR(50),
    height INT,
    weight INT,
    player_number1 VARCHAR(50),
    player_number2 VARCHAR(50),
    FOREIGN KEY (fk_team_player) REFERENCES teams(team_id)
);

DROP TABLE players;

SET sql_mode = "";

LOAD DATA INFILE 'C:/tmp/players.csv'
INTO TABLE players 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(player_id, fk_team_player, nationality, player_name, @games_played, 
@left_right, @date_of_birth, @age, @player_position, @height, @weight, player_number1, player_number2)
SET 
games_played = NULLIF(@games_played,''),
left_right = NULLIF(@left_right,''),
date_of_birth = NULLIF(@date_of_birth,''),
age = NULLIF(@age,''),
player_position = NULLIF(@player_position,''),
height = NULLIF(@height,''),
weight = NULLIF(@weight,'');

SELECT * FROM players;

CREATE TABLE goals (
	goal_id VARCHAR(50) PRIMARY KEY NOT NULL,
    fk_goal_gameid VARCHAR(50) NOT NULL,
    #goal_time TIME,
    fk_goal_player VARCHAR(50) NOT NULL,
    #fk_goal_assist VARCHAR(50) NULL,
    fk_goal_assist_player1 VARCHAR(50) NULL,
    fk_goal_assist_player2 VARCHAR(50) DEFAULT NULL,
    goal_time TIME,
    FOREIGN KEY (fk_goal_gameid) REFERENCES games(game_id),
    FOREIGN KEY (fk_goal_player) REFERENCES players(player_id),
    #FOREIGN KEY (fk_goal_assist) REFERENCES players(player_id)#,
    FOREIGN KEY (fk_goal_assist_player1) REFERENCES players(player_id),
    FOREIGN KEY (fk_goal_assist_player2) REFERENCES players(player_id)
);

DROP TABLE goals;
LOAD DATA INFILE 'C:/tmp/goals.csv'
INTO TABLE goals 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
#(goal_id, fk_goal_gameid, fk_goal_player, @vfk_goal_assist, goal_time)
#SET 
#fk_goal_assist = NULLIF(@vfk_goal_assist,'')
(goal_id, fk_goal_gameid, fk_goal_player, @vfk_goal_assist_player1, @vfk_goal_assist_player2, goal_time)
SET 
fk_goal_assist_player1 = NULLIF(@vfk_goal_assist_player1,''),
fk_goal_assist_player2 = NULLIF(@vfk_goal_assist_player2,'')
;
SELECT * FROM goals;




CREATE TABLE standings (
	comp_day VARCHAR(50) PRIMARY KEY NOT NULL,
    comp_date DATE NOT NULL,
    t1 INT,
    t2 INT,
    t3 INT,
    t4 INT,
    t5 INT,
    t6 INT,
    t7 INT,
    t8 INT,
    t9 INT,
    t10 INT
);

DROP TABLE standings;

LOAD DATA INFILE 'C:/tmp/standings.csv'
INTO TABLE standings 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM standings;

CREATE TABLE penalties (
	penalty_id VARCHAR(50) PRIMARY KEY NOT NULL,
    fk_penalty_game VARCHAR(50),
    fk_penalty_player VARCHAR(50),
    length INT,
    penalty_type VARCHAR(50),
    penalty_time TIME,
    goal_scored VARCHAR(50),
    FOREIGN KEY (fk_penalty_game) REFERENCES games(game_id),
    FOREIGN KEY (fk_penalty_player) REFERENCES players(player_id)
);

DROP TABLE penalties;

LOAD DATA INFILE 'C:/tmp/penalties.csv'
INTO TABLE penalties 
FIELDS TERMINATED BY '	' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM penalties;

# Using joins to combine tables
SELECT 
	COUNT(g.goal_id) total_goals, 
    (COUNT(g.goal_id))/p.games_played total_goals_per_games,
    p.games_played, 
    p.player_name 
FROM goals g
INNER JOIN players p ON g.fk_goal_player = p.player_id
GROUP BY g.fk_goal_player 
ORDER BY total_goals_per_games DESC;


# wrong
SELECT 
	COUNT(g.fk_goal_assist_player1),
    COUNT(g.fk_goal_assist_player2),
    (SELECT COUNT(g.fk_goal_assist_player1) FROM goals GROUP BY g.fk_goal_assist_player1) +
	(SELECT COUNT(g.fk_goal_assist_player2) FROM goals GROUP BY g.fk_goal_assist_player2) total_assists, 
    ((SELECT COUNT(g.fk_goal_assist_player1)) +
	(SELECT COUNT(g.fk_goal_assist_player2)))/players.games_played total_assists_per_games,
    g.fk_goal_assist_player1, 
    players.games_played, 
    players.player_name
FROM goals g
INNER JOIN players ON g.fk_goal_assist_player1 = players.player_id
GROUP BY players.player_id
ORDER BY total_assists_per_games DESC;

SELECT COUNT(fk_goal_assist_player2) FROM goals WHERE fk_goal_assist_player2 = 'p5';

SELECT * FROM goals;

# Write a function

DELIMITER //
CREATE FUNCTION goals_period (game_id VARCHAR(50))
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE period1 INT;
    DECLARE period2 INT;
    DECLARE period3 INT;
    DECLARE overtime INT;
    DECLARE overall VARCHAR(50);
    SET period1 = (SELECT COUNT(goal_id) FROM goals WHERE (goal_time <= '00:20:00' AND fk_goal_gameid = game_id));
    SET period2 = (SELECT COUNT(goal_id) FROM goals WHERE (goal_time > '00:20:00' AND goal_time <= '00:40:00' AND fk_goal_gameid = game_id));
    SET period3 = (SELECT COUNT(goal_id) FROM goals WHERE (goal_time > '00:40:00' AND goal_time <= '01:00:00' AND fk_goal_gameid = game_id));
    SET overtime = (SELECT COUNT(goal_id) FROM goals WHERE (goal_time > '01:00:00' AND fk_goal_gameid = game_id));
    SET overall = CONCAT(period1, '-', period2, '-', period3, '-', overtime);
    RETURN(overall);
END //
DELIMITER ;

DROP FUNCTION goals_period;

SELECT goals_period('g10');






# Query with subquery - worst nationalities per games played

SELECT * FROM goals;
SELECT * FROM players;
SELECT * FROM penalties;

# Defence players with total penalty length so far, order from highest to lowest
SELECT p.player_name, SUM(pen.length) total_penalty_length
FROM penalties pen
INNER JOIN players p ON pen.fk_penalty_player = p.player_id
WHERE (fk_penalty_player in (SELECT player_id FROM players WHERE player_position = 'd'))
GROUP BY pen.fk_penalty_player
ORDER BY SUM(pen.length) DESC;

SELECT 
	p.player_position, 
	SUM(pen.length) total_penalty_length,
    COUNT(p.player_position) 
FROM penalties pen
INNER JOIN players p ON pen.fk_penalty_player = p.player_id
GROUP BY p.player_position
ORDER BY SUM(pen.length) DESC;


SELECT * FROM penalties;

CREATE OR REPLACE VIEW vw_penalties AS
SELECT DISTINCT p.player_id, p.player_position, COUNT(*)
FROM players p
INNER JOIN penalties pen ON p.player_id = pen.fk_penalty_player
GROUP BY p.player_position;

SELECT * FROM vw_penalties;

SELECT 
	DISTINCT p.player_position, 
	#SUM(penalties.length) total_penalty_length,
    COUNT(p.player_position)#,
    #(SELECT SUM(length) FROM penalties WHERE fk_penalty_player = 'p5')
FROM players p
LEFT JOIN penalties pen ON pen.fk_penalty_player = p.player_id
GROUP BY p.player_position
#ORDER BY SUM(pen.length) DESC
;

SELECT * FROM players WHERE player_position = 'c';

SELECT fk_penalty_player, SUM(length)
FROM penalties
WHERE (fk_penalty_player in (SELECT player_id FROM players WHERE player_position = 'd'))
GROUP BY fk_penalty_player;


SELECT COUNT(*) FROM players GROUP BY nationality;



# Write a procedure to return table of standings on certain date
DELIMITER //
CREATE PROCEDURE show_standings(uptodate DATE)
BEGIN
	DECLARE val1 INT;
    DECLARE val2 INT;
    DECLARE val3 INT;
    DECLARE val4 INT;
    DECLARE val5 INT;
    DECLARE val6 INT;
    DECLARE val7 INT;
    DECLARE val8 INT;
    DECLARE val9 INT;
    DECLARE val10 INT;
    SET val1 = (SELECT SUM(s.t1) FROM standings s WHERE comp_date < uptodate);
    SET val2 = (SELECT SUM(s.t2) FROM standings s WHERE comp_date < uptodate);
    SET val3 = (SELECT SUM(s.t3) FROM standings s WHERE comp_date < uptodate);
    SET val4 = (SELECT SUM(s.t4) FROM standings s WHERE comp_date < uptodate);
    SET val5 = (SELECT SUM(s.t5) FROM standings s WHERE comp_date < uptodate);
    SET val6 = (SELECT SUM(s.t6) FROM standings s WHERE comp_date < uptodate);
    SET val7 = (SELECT SUM(s.t7) FROM standings s WHERE comp_date < uptodate);
    SET val8 = (SELECT SUM(s.t8) FROM standings s WHERE comp_date < uptodate);
    SET val9 = (SELECT SUM(s.t9) FROM standings s WHERE comp_date < uptodate);
    SET val10 = (SELECT SUM(s.t10) FROM standings s WHERE comp_date < uptodate);
    SELECT val1 basingstoke, val2 bracknell, val3 hull, 
    val4 leeds, val5 miltonkeynes, val6 peterborough, 
    val7 raiders, val8 sheffield, val9 swindon, val10 telford;
END //
DELIMITER ;   

SELECT * FROM teams;
DROP procedure show_standings;
CALL show_standings('2019-09-29');
CALL show_standings('2019-11-30');

DELIMITER //
CREATE PROCEDURE show_player_info(player_id VARCHAR(50))
BEGIN
	DECLARE id VARCHAR(50);
    DECLARE fullname VARCHAR(50);
    DECLARE nation VARCHAR(50);
    DECLARE total_games INT;
    DECLARE total_goals INT;
    DECLARE total_assists INT;
    DECLARE total_points INT;
    DECLARE total_penalties INT;
    DECLARE total_penalties_length INT;
    DECLARE penalty_length_per_game FLOAT;
    SET id = player_id;
    SET fullname = (SELECT player_name FROM players WHERE players.player_id = player_id);
    SET nation = (SELECT nationality FROM players WHERE players.player_id = player_id);
    SET total_games = (SELECT games_played FROM players WHERE players.player_id = player_id);
    SET total_goals = (SELECT COUNT(fk_goal_player) FROM goals WHERE goals.fk_goal_player = player_id);
    SET total_assists = (SELECT (SELECT COUNT(fk_goal_assist_player1) FROM goals WHERE goals.fk_goal_assist_player1 = player_id) +
	(SELECT COUNT(fk_goal_assist_player2) FROM goals WHERE goals.fk_goal_assist_player2 = player_id));
    SET total_points = total_goals + total_assists;
    SET total_penalties = (SELECT COUNT(fk_penalty_player) FROM penalties WHERE penalties.fk_penalty_player = player_id);
    SET total_penalties_length = (SELECT SUM(length) FROM penalties WHERE penalties.fk_penalty_player = player_id);
    SET penalty_length_per_game = total_penalties_length/total_games;
    SELECT id, fullname, nation, total_games, total_goals, total_assists, total_points, total_penalties, 
    total_penalties_length, penalty_length_per_game;
END //
DELIMITER ;   

DROP PROCEDURE show_player_info;
SELECT * FROM goals;
SELECT * FROM penalties;
CALL show_player_info('p10');





# Create a trigger








# Create an event

CREATE EVENT event_calculate_age
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
DO
	UPDATE players
    SET age = TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())
    WHERE (MONTH(date_of_birth) = MONTH(CURDATE()) AND DAY(date_of_birth) = DAY(CURDATE()));
    
DROP EVENT event_calculate_age;

SHOW EVENTS FROM bees;

SELECT * FROM players;

# Set to player's real date of birth and age
UPDATE players
SET 
	date_of_birth = '1995-02-10',
	age = 25
WHERE player_id = 'p1';

# Change player's date of birth and age to today's date for testing 
SELECT * FROM players;
UPDATE players
SET 
	date_of_birth = '1995-07-13',
	age = 20
WHERE player_id = 'p1';





# Group by and having
# 
SELECT 
	p.player_name,
    p.age,
    p.player_position,
    SUM(pen.length) total_length,
    p.games_played total_games,
    SUM(pen.length)/p.games_played length_by_games
FROM players p
INNER JOIN penalties pen ON pen.fk_penalty_player = p.player_id
GROUP BY p.player_id
HAVING p.player_position = 'd'
ORDER BY length_by_games DESC;
    
    
# Views

SELECT * FROM players;
SELECT * FROM penalties;

CREATE OR REPLACE VIEW view_detailed_information AS
SELECT p.player_id, p.player_name,
pen.COUNT(fk_penalty_player)
FROM players p
INNER JOIN penalties pen
INNER JOIN goals g
WITH CHECK OPTION;

SELECT * FROM view_detailed_information;

