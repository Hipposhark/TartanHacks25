import openai
import json
import re
import os
import firebase_admin
from firebase_admin import credentials, firestore
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Get OpenAI API key from .env file
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError("Error: OPENAI_API_KEY is not set in the environment.")

# Load Firebase credentials from file
FIREBASE_CREDENTIALS_PATH = "backend/serviceAccountKey.json"

if not os.path.exists(FIREBASE_CREDENTIALS_PATH):
    raise ValueError(f"Error: Firebase credentials file not found at {FIREBASE_CREDENTIALS_PATH}")

cred = credentials.Certificate(FIREBASE_CREDENTIALS_PATH)
firebase_admin.initialize_app(cred)
db = firestore.client()

print("Firebase initialized successfully.")

# Define example prompt
# prompt = "I want teams to be diverse in skill level but have at least one experienced member in each. Each team should have 4-5 members and be balanced in extroverts and introverts. Ensure that every team has a mix of backgrounds and perspectives. Consider physical attributes like height for sports teams."
# prompt = "I need to split up my gym class of 40 into 8 teams of 5 players each for basketball. I want each team to have a variety of skill levels and amount of experience."
prompt = "I am organizing a hackathon and need to form teams of 4-5 members. Each team should have a mix of developers, designers, and project managers. I want to ensure that each team has a balance of experience levels and that there is diversity in terms of background and skills. To make it easier to parse, only closed ended questions where each answer is a scale from 1-5, each number having an appropriate label."

def clean_json_response(response_text):
    """Remove markdown formatting and ensure valid JSON format."""
    response_text = response_text.strip()
    response_text = re.sub(r'^```json', '', response_text, flags=re.MULTILINE)  # Remove opening ```json
    response_text = re.sub(r'```$', '', response_text, flags=re.MULTILINE)  # Remove closing ```
    return response_text.strip()

def generate_criteria_and_questions(prompt):
    system_message = "You are an expert in parsing team formation criteria and generating relevant survey questions. Given a natural language prompt, extract the key team formation constraints and then generate a set of seven multiple-choice survey questions. Frame each question as answerable on a scale from 1 to 5, ensuring that there are always 5 answer choices per question. Make the questions specific to the given situation. Format the output as valid JSON."
    
    client = openai.OpenAI(api_key=OPENAI_API_KEY)
    
    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": f"Extract team formation criteria and generate related survey questions from this prompt: {prompt}"}
            ]
        )
    except openai.NotFoundError:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": f"Extract team formation criteria and generate related survey questions from this prompt: {prompt}"}
            ]
        )
    
    output = response.choices[0].message.content.strip()
    print("Raw Response from OpenAI:", output)  # Debugging line
    
    # Ensure response is not empty
    if not output:
        print("Error: OpenAI returned an empty response.")
        return {"error": "Empty response from OpenAI"}
    
    # Clean and parse JSON response
    cleaned_output = clean_json_response(output)
    
    try:
        parsed_output = json.loads(cleaned_output)
    except json.JSONDecodeError as e:
        print("Error: Response is not valid JSON.", e)
        return {"error": "Invalid JSON response", "raw_output": cleaned_output}
    
    return parsed_output

def save_to_firebase(data):
    """Save generated criteria and questions to Firebase Firestore."""
    doc_ref = db.collection("team_formation").document()
    doc_ref.set(data)
    print("Data successfully saved to Firebase with document ID:", doc_ref.id)

# Generate criteria and questions using AI
parsed_output = generate_criteria_and_questions(prompt)

# Save to Firebase
if "error" not in parsed_output:
    save_to_firebase(parsed_output)

# Print structured JSON output
parsed_json = json.dumps(parsed_output, indent=2)
print(parsed_json)
