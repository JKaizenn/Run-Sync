import os
import json
import google.generativeai as genai
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Access the Google API key from the environment variables
api_key = os.getenv("GOOGLE_API_KEY")

if not api_key:
    raise ValueError("No GOOGLE_API_KEY found in environment variables")

# Configure the generative AI model with the API key
genai.configure(api_key=api_key)
model = genai.GenerativeModel(model_name="gemini-1.5-flash")

# Path to the folder containing images
image_folder = r'C:\Users\ferna\Documents\GitHub\Run-Sync\run_sync\machine_learning\treadmill_pictures'

# Ensure the folder exists
if not os.path.exists(image_folder):
    raise ValueError(f"The folder '{image_folder}' does not exist.")

# Dictionary to store the results
results = {}

# Iterate through all files in the folder
for filename in os.listdir(image_folder):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.bmp', '.tiff')):
        # Construct the full file path
        file_path = os.path.join(image_folder, filename)
        
        try:
            # Upload the image and start a chat session
            chat_session = model.start_chat(
                history=[
                    {
                        "role": "user",
                        "parts": [genai.upload_file(file_path, mime_type="image/jpeg")],
                    }
                ]
            )

            # Send a message to the chat session
            response = chat_session.send_message("What is the speed and time of the treadmill?")
            
            # Print the entire response object to inspect its structure
            print(f"\nResponse object for {filename}: {response}")
            print(f"Available attributes in response: {dir(response)}")
            
            # Extract the response content
            response_content = ""
            if hasattr(response, 'content') and response.content:
                response_content = response.content
            elif hasattr(response, 'message') and response.message:
                response_content = response.message
            elif hasattr(response, 'text') and response.text:
                response_content = response.text
            else:
                print(f"Response for {filename} does not have 'content', 'message', or 'text' attribute.")
                continue
            
            # Debugging: Print the response content
            print(f"Response content for {filename}: {response_content}")
            
            # Assuming the response content contains the time and distance in a specific format
            # You may need to adjust the parsing logic based on the actual response format
            time = None
            distance = None
            for line in response_content.split('\n'):
                if 'time' in line.lower():
                    time = line.split(':')[-1].strip()
                if 'distance' in line.lower():
                    distance = line.split(':')[-1].strip()
            
            # Debugging: Print the extracted time and distance
            print(f"Extracted time for {filename}: {time}")
            print(f"Extracted distance for {filename}: {distance}")
            
            # Store the extracted information in the results dictionary
            if time and distance:
                results[filename] = {'time': time, 'distance': distance}
            else:
                print(f"Could not extract time and distance for {filename}")
        
        except Exception as e:
            print(f"An error occurred while processing {filename}: {e}")

# Debugging: Print the results dictionary before saving to JSON
print(f"Results dictionary: {results}")

# Save the results to a JSON file
output_file = r'C:\Users\ferna\Documents\GitHub\Run-Sync\run_sync\machine_learning\results.json'
try:
    with open(output_file, 'w') as f:
        json.dump(results, f, indent=4)
    print(f"Results saved to {output_file}")
except Exception as e:
    print(f"An error occurred while saving the results to JSON: {e}")