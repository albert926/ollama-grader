# =========================
# proxy.py - Python CORS Proxy for Ollama
# =========================
#
# HOW TO RUN:
#   pip install flask flask_cors requests
#   python3 proxy.py
#
# Proxy starts on: http://localhost:8080
# Your HTML will call: http://localhost:8080/grade
#

from flask import Flask, request, jsonify
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)  # Enables Access-Control-Allow-Origin: *

OLLAMA_URL = "http://localhost:11434/api/generate"

@app.post("/grade")
def grade():
    try:
        # Forward request to Ollama
        response = requests.post(OLLAMA_URL, json=request.json)
        return jsonify(response.json())
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    print("Python CORS proxy running at http://localhost:8080")
    app.run(host="0.0.0.0", port=8080)

