import os
import google.generativeai as genai
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Configure the genai library with the API key
genai.configure(api_key=os.environ["GOOGLE_API_KEY"])
model = genai.GenerationModel(model_name="gemini-1.5-flash")

chat_session = model.start_chat_session(
    history=[
        {
            "role": "user",
            "parts": [genai.upload_file("2.png", mime_type="image/jpeg")],
        }
    ]
)

response = chat_session.send_message("What's the time and distance from the treadmills")
print(response.message)