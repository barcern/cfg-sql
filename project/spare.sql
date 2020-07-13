
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

# Query with subquery - worst nationalities per games played



