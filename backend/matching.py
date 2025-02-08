import numpy as np
from scipy.spatial.distance import euclidean

# def optimize_teams(skill_matrix, team_size):
#     num_participants = skill_matrix.shape[0]
#     num_teams = num_participants // team_size  #  Calculate number of teams dynamically
    
#     teams = [[] for _ in range(num_teams)]
#     remaining = list(range(num_participants))
#     seeds = []
    
#     # Select initial seeds for teams
#     first_seed = remaining.pop(0)
#     seeds.append(first_seed)

#     for _ in range(1, num_teams):
#         best_candidate = None
#         best_distance = -1
#         for candidate in remaining:
#             dist = min(euclidean(skill_matrix[candidate], skill_matrix[seed]) for seed in seeds)
#             if dist > best_distance:
#                 best_distance = dist
#                 best_candidate = candidate
#         seeds.append(best_candidate)
#         remaining.remove(best_candidate)
    
#     # Assign each seed to a team
#     for i, seed in enumerate(seeds):
#         teams[i].append(seed)

#     # Assign remaining participants using balanced distribution
#     while any(len(team) < team_size for team in teams) and remaining:
#         for i in range(num_teams):
#             if len(teams[i]) < team_size:
#                 team_vector = np.mean(skill_matrix[teams[i]], axis=0)
#                 best_candidate = None
#                 best_distance = -1
#                 for candidate in remaining:
#                     dist = euclidean(skill_matrix[candidate], team_vector)
#                     if dist > best_distance:
#                         best_distance = dist
#                         best_candidate = candidate
#                 teams[i].append(best_candidate)
#                 remaining.remove(best_candidate)
#                 if not remaining:
#                     break
    
#     if remaining:
#         teams.append(remaining)
    
#     return teams

# if __name__ == "__main__":
#     np.random.seed(42)

#     num_participants = 30
#     num_skills = 8
#     team_size = 5  #  Instead of specifying the number of teams, specify the team size
#     skill_matrix = np.random.randint(1, 10, size=(num_participants, num_skills))

#     teams = optimize_teams(skill_matrix, team_size)

#     for i, team in enumerate(teams):
#         print(f"Team {i+1}: Participants {team}")

import numpy as np
from scipy.spatial.distance import euclidean

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
            skills = []
            for token in tokens[1:]:
                value = int(token)
                if value < 1 or value > 5:
                    raise ValueError(f"Skill value {value} for participant '{name}' is out of the allowed range (1-5).")
                skills.append(value)
        except ValueError as e:
            raise ValueError(f"Error parsing skills for '{name}': {e}")
        skills_list.append(skills)
    
    # Build the skill matrix.
    skill_matrix = np.array(skills_list)
    num_participants = skill_matrix.shape[0]
    
    num_teams = num_participants // team_size
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

    team_dicts = []
    for i, team in enumerate(teams, start=1):
        team_names = [names[idx] for idx in team]
        team_dict = {"team": i, "members": team_names}
        team_dicts.append(team_dict)
    
    return team_dicts

if __name__ == "__main__":
    input_data = """participant1, 1, 2, 3, 4, 5, 3, 2, 1
participant2, 2, 3, 4, 5, 1, 2, 3, 4
participant3, 3, 4, 5, 1, 2, 3, 4, 5
participant4, 4, 5, 1, 2, 3, 4, 5, 1
participant5, 5, 1, 2, 3, 4, 5, 1, 2
participant6, 1, 2, 3, 4, 5, 1, 2, 3
participant7, 2, 3, 4, 5, 1, 2, 3, 4
participant8, 3, 4, 5, 1, 2, 3, 4, 5
participant9, 4, 5, 1, 2, 3, 4, 5, 1
participant10, 5, 1, 2, 3, 4, 5, 1, 2
participant11, 1, 2, 3, 4, 5, 3, 2, 1
participant12, 2, 3, 4, 5, 1, 2, 3, 4
participant13, 3, 4, 5, 1, 2, 3, 4, 5
participant14, 4, 5, 1, 2, 3, 4, 5, 1
participant15, 5, 1, 2, 3, 4, 5, 1, 2"""

    team_size = 5
    teams_list = optimize_teams_from_multiline_string(input_data, team_size)
    print(teams_list)
