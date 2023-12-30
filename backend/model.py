from flask import Flask, request, jsonify, send_file 
import google.generativeai as genai
import re
from gtts import gTTS
import os
import requests

from flask import Flask, request, jsonify
import requests
from PIL import Image
import io
import base64

from flask_cors import CORS, cross_origin
import json

app = Flask(__name__)
app.config['CORS_HEADERS'] = 'Content-Type'


# Replace with your Google AI Studio API key
GOOGLE_AI_STUDIO = "AIzaSyAo8rIkKbS-bFHTYIUESCKBIBxYBl7la6U"
genai.configure(api_key=GOOGLE_AI_STUDIO)

# Set up the model
generation_config = {
    "temperature": 0.9,
    "top_p": 1,
    "top_k": 1,
    "max_output_tokens": 2048,
}

safety_settings = [
    {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "block_none"},
    {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "block_none"},
    {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "block_none"},
    {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "block_none"},
]

model = genai.GenerativeModel(
    model_name="gemini-pro",
    generation_config=generation_config,
    safety_settings=safety_settings,
)




def regex(text):
    english = text
    print(english)

    _ , english = english.split("**Story:**"); 
    english = english.strip()

    print(english)

    en_story , en_quizs_value = english.split("**Quiz 1:**")
    en_story = en_story.strip()
    en_quizs, en_value = en_quizs_value.split("**Values:**")

    en_qz_1,en_quizs = en_quizs.split("**Quiz 2:**")
    en_qz_2 , en_qz_3 = en_quizs.split("**Quiz 3:**")
    en_qz_1 = en_qz_1.strip().split("\n")
    en_qz_2 = en_qz_2.strip().split("\n")
    en_qz_3 = en_qz_3.strip().split("\n")

    en_story = en_story.split("\n")


    # remove empty string
    a = []
    for i in en_qz_1:
        if i and i.lower().find("answer") == -1: a.append(i) 
    en_qz_1 = a

    a = []
    for i in en_qz_2:
        if i and i.lower().find("answer") == -1: a.append(i) 
    en_qz_2 = a

    a = []
    for i in en_qz_3:
        if i and i.lower().find("answer") == -1: a.append(i) 
    en_qz_3 = a
    en_qz = [en_qz_1,en_qz_2,en_qz_3]


    en_value = en_value.strip().split("\n") # removes stuff that is not usefull
    a = []
    for i in en_value:
        if i: a.append(i.strip())
    en_value = a

    a = []
    for i in en_story:
        if i: a.append(i)
    en_story = a

    return {
        "en-story" : en_story,
        "en-qz": en_qz,
        "en-value": en_value,
    }


def generate_content(prompt):
    prompt_parts = [
        "i want you to generate a Kids stories",
        "add 3 Quizes where the correct anwer is always b",
        "generate a small value out of that story",
        "make it less than 500 words of story",
        "you have to make seperation using **Story** **Quiz 1:** **Quiz 2:** **Quiz 3:** **Values:**",
        "the theme is about:", prompt
    ]

    response = model.generate_content(prompt_parts)

    return response.text



my_text = ""

@app.route('/generate', methods=['POST'])
@cross_origin()
def generate():
    try:
        data =  request.json
        prompt_parts = data['prompt']

        result = generate_content(prompt_parts)
        sections = regex(result)

        return jsonify({'result': sections})
    except Exception as e:
        print(e)
        print(request.headers.get('Content-Type'))
        return jsonify({'error': str(e)}), 500




API_URL = "https://api-inference.huggingface.co/models/furusu/SSD-1B-anime"
HEADERS = {"Authorization": "Bearer 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"}

def query(payload):
    response = requests.post(API_URL, headers=HEADERS, json=payload)
    return response.status_code, response.content

@app.route('/generate_image', methods=['POST'])
@cross_origin()
def generate_image():
    try:
        data = request.json
        prompt = data['prompt']
        caption = data['caption']

        status,data = query({"inputs": prompt})
        image_base64 = ""

        print("            " + str(status))
        if status == 200:
            print("posting: ", status,data)
            # Access the image with PIL.Image
            image = Image.open(io.BytesIO(data))

            # Convert the image to base64
            buffered = io.BytesIO()
            image.save(buffered, format="JPEG")
            image_base64 = base64.b64encode(buffered.getvalue()).decode('utf-8')
        else:
            status,data = query({"inputs": caption})
            print("posting: ", status,data)
            # Access the image with PIL.Image
            image = Image.open(io.BytesIO(data))

            # Convert the image to base64
            buffered = io.BytesIO()
            image.save(buffered, format="JPEG")
            image_base64 = base64.b64encode(buffered.getvalue()).decode('utf-8')


        # Return the image in the JSON response
        return jsonify({
            'image': image_base64
        })

    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500




API_URL = "https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-large"
headers = {"Authorization": f"Bearer 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"}


def img_caption(img_base64):
    img_base64 = img_base64.encode()
    content = base64.b64decode(img_base64)    
    print("caption: ...")
    response = requests.post(API_URL, headers=headers, data=content)
    return response.json()


@app.route('/generate_story_from_image', methods=['POST'])
@cross_origin()
def generate_story_from_img():
    try:
        data = request.json
        img = data['img-data']
        caption = img_caption(img)
        print(caption)
        result = generate_content(caption[0]["generated_text"])
        sections = regex(result)

        return jsonify({'result': sections})
    except Exception as e:
        print(e)
        return jsonify({'error': str(e)}), 500    


if __name__ == '__main__':
    app.run(debug=True,host="0.0.0.0")


