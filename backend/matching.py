from flask import Flask, request, jsonify
import numpy as np
from scipy.spatial.distance import euclidean

app = Flask(__name__)

def optimize_teams_from_multiline_string(input_str, team_size):
    lines = input_str.strip().splitlines()
    names = []
    skills_list = []

    for line in lines:
        tokens = [token.strip() for token in line.split(',')]
        if len(tokens) < 2:
            continue 
        
        name = tokens[0]
        names.append(name)
        try:
            skills = [int(token) for token in tokens[1:] if 1 <= int(token) <= 5]
        except ValueError:
            return {"error": f"Invalid skill value in {name}'s data."}

        skills_list.append(skills)
    
    skill_matrix = np.array(skills_list)
    num_participants = skill_matrix.shape[0]
    num_teams = num_participants // team_size
    teams = [[] for _ in range(num_teams)]
    remaining = list(range(num_participants))
    seeds = []

    first_seed = remaining.pop(0)
    seeds.append(first_seed)

    for _ in range(1, num_teams):
        best_candidate = max(remaining, key=lambda c: min(euclidean(skill_matrix[c], skill_matrix[s]) for s in seeds))
        seeds.append(best_candidate)
        remaining.remove(best_candidate)

    for i, seed in enumerate(seeds):
        teams[i].append(seed)

    while any(len(team) < team_size for team in teams) and remaining:
        for i in range(num_teams):
            if len(teams[i]) < team_size and remaining:
                team_vector = np.mean(skill_matrix[teams[i]], axis=0)
                best_candidate = max(remaining, key=lambda c: euclidean(skill_matrix[c], team_vector))
                teams[i].append(best_candidate)
                remaining.remove(best_candidate)

    if remaining:
        teams.append(remaining)

    team_dicts = [{"team": i + 1, "members": [names[idx] for idx in team]} for i, team in enumerate(teams)]
    return team_dicts

@app.route('/generate_teams', methods=['POST'])
def generate_teams():
    try:
        data = request.get_json()
        input_str = data.get("input_str", "")
        team_size = data.get("team_size", 5)
        
        if not input_str or not isinstance(team_size, int) or team_size <= 0:
            return jsonify({"error": "Invalid input"}), 400
        
        teams = optimize_teams_from_multiline_string(input_str, team_size)
        return jsonify(teams)
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
