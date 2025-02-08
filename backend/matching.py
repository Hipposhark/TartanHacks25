import numpy as np
from scipy.spatial.distance import euclidean

def optimize_teams(skill_matrix, num_teams):
    num_participants = skill_matrix.shape[0]
    team_size = num_participants // num_teams
    
    teams = [[] for _ in range(num_teams)]
    remaining = list(range(num_participants))
    seeds = []
    first_seed = remaining.pop(0)
    seeds.append(first_seed)

    for _ in range(1, num_teams):
        best_candidate = None
        best_distance = -1
        for candidate in remaining:
            dist = min(euclidean(skill_matrix[candidate], skill_matrix[seed]) for seed in seeds)
            if dist > best_distance:
                best_distance = dist
                best_candidate = candidate
        seeds.append(best_candidate)
        remaining.remove(best_candidate)
    
    for i, seed in enumerate(seeds):
        teams[i].append(seed)
    

    while any(len(team) < team_size for team in teams) and remaining:
        for i in range(num_teams):
            if len(teams[i]) < team_size:
                team_vector = np.mean(skill_matrix[teams[i]], axis=0)
                best_candidate = None
                best_distance = -1
                for candidate in remaining:
                    dist = euclidean(skill_matrix[candidate], team_vector)
                    if dist > best_distance:
                        best_distance = dist
                        best_candidate = candidate
                teams[i].append(best_candidate)
                remaining.remove(best_candidate)
                if not remaining:
                    break
    
    if remaining:
        teams.append(remaining)
    
    return teams

if __name__ == "__main__":
    np.random.seed(42)
    
    num_participants = 30
    num_skills = 8
    skill_matrix = np.random.randint(1, 10, size=(num_participants, num_skills))
    
    num_teams = 6
    teams = optimize_teams(skill_matrix, num_teams)
    
    for i, team in enumerate(teams):
        print(f"Team {i+1}: Participants {team}")