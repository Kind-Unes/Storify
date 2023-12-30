let questions =[
    {
        question:"question 01:",
        answers:[
            {text:"answer01" , correct: false},
            {text:"answer02" , correct: false},
            {text:"answer03" , correct: true},
        ] 
    },
    {
        question:"question 02:",
        answers:[
            {text:"answer01" , correct: false},
            {text:"answer02" , correct: false},
            {text:"answer03" , correct: true},
        ] 
    },
    {
        question:"question 03:",
        answers:[
            {text:"answer01" , correct: false},
            {text:"answer02" , correct: false},
            {text:"answer03" , correct: true},
        ] 
    },
  
 ];

 const questionelement= document.getElementById("q1");
 const answerbutton= document.getElementById("an");
 const nextbutton= document.getElementById("next");
 const newstory= document.getElementById("newstory");

 let score= 0;
 let currentquestionindex=0;

 function startquiz(){
    score=0;
    currentquestionindex=0;
    nextbutton.innerHTML="Next";
    showquestion();
 }

 function showquestion(){
    resetstate();
    let currentquestion=questions[currentquestionindex];
    let questionNo=currentquestionindex + 1;
    questionelement.innerHTML=questionNo + ". " + currentquestion.question;
    
    currentquestion.answers.forEach(answer => {
     const button = document.createElement("button");
     button.innerHTML = answer.text; 
     button.classList.add("btn");
     answerbutton.appendChild(button);
     if(answer.correct){
        button.dataset.correct=answer.correct;
     }
     button.addEventListener("click",selectanswer)

    });
 }


 startquiz();
 

 function resetstate(){
    nextbutton.style.display="none";
    while (answerbutton.firstChild) {
        answerbutton.removeChild(answerbutton.firstChild);
    }
 }


function selectanswer(e){
    const selectebtn =e.target;
    const iscorrect = selectebtn.dataset.correct === "true";
    if(iscorrect){
        selectebtn.classList.add("correct");
        score++;
    }else{
        selectebtn.classList.add("incorrect");
    }
    Array.from(answerbutton.children).forEach(button =>{
        if(button.dataset.correct === "true"){
            button.classList.add("correct");
        }
        button.disabled =true;
    });
    nextbutton.style.display="block";
}
 function showscore(){
    resetstate();
    questionelement.innerHTML = `Your scored ${score} out of ${questions.length}!`;
    newstory.innerHTML='Create another story';
    newstory.style.display="block";
    answerbutton.style.display="block";
    const newStoryLink = document.createElement("a");
    newStoryLink.href = "#st"; 
    newStoryLink.innerHTML = "Create another story";
    newStoryLink.id = "newstory";
    document.body.appendChild(newStoryLink);
   const newStory = document.getElementById("newstory"); 
 }
 function handlenextbutton(){
    currentquestionindex++;
    if(currentquestionindex < questions.length){
        showquestion();
    }else{
        showscore();
    }
 }

 nextbutton.addEventListener("click",()=>{
    if(currentquestionindex<questions.length){
        handlenextbutton();
    }else{
        startquiz();
    }
 });




const inputbox = document.getElementById("input-box");

const story_box = document.getElementById("story2");


const example_output ={
    "result": {
        "en-qz": [
            [
                "What was the color of the butterfly's wings?",
                "(A) Red and green",
                "(B) Blue and orange",
                "(C) Yellow and purple"
            ],
            [
                "What did Lily do after she lost sight of the butterfly?",
                "(A) She went home and cried",
                "(B) She sat down on a mossy rock",
                "(C) She ran away from the meadow"
            ],
            [
                "What did Lily learn from the butterfly?",
                "(A) To be afraid of challenges",
                "(B) To be resilient and never give up",
                "(C) To catch butterflies"
            ]
        ],
        "en-story": [
            "Once upon a time, in a vibrant village nestled amidst rolling hills, lived a little girl named Lily. Her days were filled with laughter and happiness as she explored the wonders of the natural world. One sunny morning, as Lily skipped through a lush meadow, she stumbled upon a tiny creature. It was a beautiful butterfly, its wings adorned with vibrant hues of blue and orange.",
            "Lily was mesmerized by the butterfly's delicate beauty. She watched in awe as it fluttered among the wildflowers, its wings shimmering in the sunlight. She reached out gently to touch it, but the butterfly quickly fluttered away. Lily chased after it, determined to catch a glimpse of its enchanting wings.",
            "After a while, Lily realized she had lost sight of the butterfly. She sat down on a mossy rock, feeling disappointed. Suddenly, she heard a gentle voice.",
            "\"Don't worry, Lily,\" the voice said. \"The butterfly will return.\"",
            "Lily looked up and saw a wise old owl perched on a nearby branch.",
            "\"How do you know?\" Lily asked.",
            "\"Because butterflies are creatures of resilience,\" the owl replied. \"They may face challenges, but they always find a way to persevere.\"",
            "Lily took the owl's words to heart. She realized that she too could be resilient like the butterfly. She decided to search for the butterfly again, determined not to give up.",
            "As she searched, Lily encountered various obstacles. She had to cross a babbling brook, climb over a rocky hill, and navigate through a dense forest. But she never gave up. She persevered through each challenge, inspired by the butterfly's resilience.",
            "Finally, Lily found the butterfly resting on a leaf. It was just as beautiful as she remembered. Lily smiled, knowing that she had learned a valuable lesson about resilience and the importance of never giving up on her dreams."
        ],
        "en-value": [
            "Resilience: Lily persevered through challenges, inspired by the butterfly's resilience.",
            "Determination: Lily was determined to find the butterfly again, even after facing obstacles.",
            "Appreciation of nature: Lily appreciated the beauty of the natural world and the creatures that inhabited it."
        ]
    }
}

const server_url = "http://192.168.167.156:5000";

async function generate_img(prompt,idx)  {
    const resp = await fetch(server_url+"/generate_image",{
        method: "POST", 
        mode: "cors",
        headers: {
            "Content-Type": "application/json",
        },        
        body : JSON.stringify({"prompt" : prompt}),
    });

    const data = await resp.json();
    document.getElementById("img-number-"+String(idx)).src = "data:image/png;base64,"+data["image"];
}



async function create()  {
    const resp = await fetch(server_url+"/generate",{
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        mode: "cors",
        headers: {
            "Content-Type": "application/json",

        },        
        body : JSON.stringify({"prompt" : inputbox.value}),
    });

    const data = await resp.json();
    let p_elem = document.createElement("p");
    for (let i = 0; i < data["result"]["en-story"].length; i++) {
        p_elem.innerHTML += data["result"]["en-story"][i];
    }
    story_box.appendChild(p_elem);

    for (let i = 0; i < Math.min(data["result"]["en-story"].length,3); i++) {
        generate_img(data["result"]["en-story"][i],i);
    }

    questions = [];
    let quizs =  data["result"]["en-qz"];
    for (let i = 0; i < quizs.length; i++) {
        q = {
            question:quizs[i][0],
            answers:[
                {text:quizs[i][1] , correct: false},
                {text:quizs[i][2] , correct: true},
                {text:quizs[i][3] , correct: false},
            ] 
        }
        questions.push(q);
    }

 startquiz();

    let p = document.createElement("p");
    for (let i = 0; i < data["result"]["en-value"].length; i++) {
        p.innerHTML += data["result"]["en-value"][i];
    }
    document.getElementById("value").appendChild(p);


}

