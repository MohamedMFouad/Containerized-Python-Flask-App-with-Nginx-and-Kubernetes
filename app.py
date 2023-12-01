#!/bin/env python3

import os
from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
@app.route("/")
def homepage():
    return render_template("homepage.html", content="Hello world")

@app.route("/api/data")
def api_data():
    data = {"message": "This is the API data endpoint"}
    return jsonify(data)

@app.route("/users")
def users():
    users_list = ["John", "Jane", "Alice"]
    return render_template("users.html", users=users_list)
    
if __name__ == '__main__':
    app.run(
        host=os.getenv('FLASK_IP', '0.0.0.0'),
        port=os.getenv('FLASK_PORT', 5000),
        debug=bool(os.getenv('FLASK_DEBUG', True))
    )
