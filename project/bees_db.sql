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
@left_right, @date_of_birth, @player_position, @height, @weight, player_number1, player_number2)
SET 
games_played = NULLIF(@games_played,''),
left_right = NULLIF(@left_right,''),
date_of_birth = NULLIF(@date_of_birth,''),
player_position = NULLIF(@player_position,''),
height = NULLIF(@height,''),
weight = NULLIF(@weight,'');

SELECT * FROM players;

CREATE TABLE goals (
	goal_id VARCHAR(50) PRIMARY KEY NOT NULL,
    fk_goal_gameid VARCHAR(50) NOT NULL,
    goal_time TIME,
    fk_goal_player VARCHAR(50) NOT NULL,
    fk_goal_assist_player1 VARCHAR(50) NULL,
    fk_goal_assist_player2 VARCHAR(50) DEFAULT NULL,
    FOREIGN KEY (fk_goal_gameid) REFERENCES games(game_id),
    FOREIGN KEY (fk_goal_player) REFERENCES players(player_id),
    FOREIGN KEY (fk_goal_assist_player1) REFERENCES players(player_id)#,
    #FOREIGN KEY (fk_goal_assist_player2) REFERENCES players(player_id)
);

DROP TABLE goals;
LOAD DATA INFILE 'C:/tmp/goals.csv'
INTO TABLE goals 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(goal_id, fk_goal_gameid, goal_time, fk_goal_player, @vfk_goal_assist_player1, @vfk_goal_assist_player2)
SET 
fk_goal_assist_player1 = NULLIF(@vfk_goal_assist_player1,'')#,
#fk_goal_assist_player2 = NULLIF(@vfk_goal_assist_player2,'')
;
SELECT * FROM goals;

UPDATE goals
SET fk_goal_assist_player2 = NULL
WHERE fk_goal_assist_player2 = '';

UPDATE goals
SET fk_goal_assist_player1 = 'p9'
WHERE fk_goal_assist_player1 = 'hellohello';

ALTER TABLE goals
ADD CONSTRAINT fk_goals_players_assist_player2
FOREIGN KEY (fk_goal_assist_player2)
REFERENCES players(player_id);

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

# Write a function

# Query with subquery to calculate highest scorers per games played
SELECT 
	COUNT(g.goal_id) total_goals, 
    (COUNT(g.goal_id))/players.games_played total_goals_per_games, 
    g.fk_goal_player, 
    players.games_played, 
    players.player_name 
FROM goals g
INNER JOIN players ON g.fk_goal_player = players.player_id
GROUP BY g.fk_goal_player ORDER BY total_goals_per_games DESC;

SELECT 
	COUNT(g.goal_id) total_assists, 
    (COUNT(g.goal_id))/players.games_played total_goals_per_games, 
    g.fk_goal_assist_player1, 
    players.games_played, 
    players.player_name 
FROM goals g
INNER JOIN players ON g.fk_goal_player = players.player_id
GROUP BY g.fk_goal_assist_player1 ORDER BY total_goals_per_games DESC;

SELECT * FROM players;
SELECT * FROM goals;


# Write a procedure to return table of standings on certain date

# Create a trigger

# Create an event

