from flask import Flask, jsonify
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app)  # This will allow cross-origin requests from your frontend

DATABASE_URL = "postgresql://postgres:sush18@localhost:5432/DQML_Project"

@app.route('/average-ratings', methods=['GET'])
def get_average_ratings():
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()
    cursor.execute("""
        SELECT g.name, AVG(c.rating) as average_rating
        FROM games g
        JOIN critic c ON g.id = c.fk_game_id
        GROUP BY g.name
        LIMIT 5;
    """)
    ratings = cursor.fetchall()
    cursor.close()
    conn.close()
    # Format the results into a list of dictionaries for JSON response
    results = [{"name": name, "average_rating": float(average_rating)} for name, average_rating in ratings]
    return jsonify(results)

@app.route('/game-hardware', methods=['GET'])
def get_game_hardware():
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()
    cursor.execute("""
            SELECT DISTINCT ON (g.price)
        g.name AS Game_Name,
        g.price,
        g.platform,
        nh.operacional_system,
        nh.processor,
        nh.memory,
        nh.graphics
    FROM
        games g
    JOIN
        necessary_hardware nh ON g.id = nh.fk_game_id
    ORDER BY 
        g.price DESC
    LIMIT 1;
    """)
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify([{
        'name': result[0],
        'price': result[1],
        'platform': result[2],
        'operational_system': result[3],
        'processor': result[4],
        'memory': result[5],
        'graphics': result[6]
    } for result in results])


@app.route('/most-followed-twitter', methods=['GET'])
def most_followed_twitter():
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()
    cursor.execute("SELECT username, followers FROM twitter_account ORDER BY followers DESC LIMIT 5")
    accounts = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify([{'username': account[0], 'followers': account[1]} for account in accounts])

@app.route('/top-authors', methods=['GET'])
def get_top_authors():
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()
    cursor.execute("""
        SELECT author, COUNT(*) as comment_count
        FROM author_comment
        GROUP BY author
        ORDER BY comment_count DESC
        LIMIT 3;
    """)
    top_authors = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify([{'author': author[0], 'comment_count': author[1]} for author in top_authors])

if __name__ == '__main__':
    app.run(debug=True)
