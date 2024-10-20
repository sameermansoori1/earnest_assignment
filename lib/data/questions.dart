void addAnswers(bool i) {
  answers.add(i);
}

void clearAnswers() {
  answers.clear();
}

List<bool> answers = [];

List<Map> questions = [
  {
    "question": "Who was the first President of the United States?",
    "option": [
      "George Washington",
      "Abraham Lincoln",
      "Thomas Jefferson",
      "John Adams"
    ],
    "answer": "George Washington",
    "note": "George Washington was the first President of the United States."
  },
  {
    "question": "Which planet is known as the Red Planet?",
    "option": ["Mars", "Venus", "Jupiter", "Saturn"],
    "answer": "Mars",
    "note": "Mars is known as the Red Planet due to its reddish appearance."
  },
  {
    "question": "Who wrote the play 'Romeo and Juliet'?",
    "option": [
      "William Shakespeare",
      "Charles Dickens",
      "Mark Twain",
      "Leo Tolstoy"
    ],
    "answer": "William Shakespeare",
    "note": "'Romeo and Juliet' was written by William Shakespeare."
  },
  {
    "question": "Which is the largest ocean on Earth?",
    "option": [
      "Atlantic Ocean",
      "Indian Ocean",
      "Pacific Ocean",
      "Southern Ocean"
    ],
    "answer": "Pacific Ocean",
    "note": "The Pacific Ocean is the largest ocean on Earth."
  },
  {
    "question": "Who developed the theory of relativity?",
    "option": [
      "Isaac Newton",
      "Albert Einstein",
      "Galileo Galilei",
      "Nikola Tesla"
    ],
    "answer": "Albert Einstein",
    "note": "Albert Einstein developed the theory of relativity."
  },
  {
    "question": "What is the capital of France?",
    "option": ["Paris", "Berlin", "Madrid", "Rome"],
    "answer": "Paris",
    "note": "Paris is the capital city of France."
  },
  {
    "question": "Which country is known as the Land of the Rising Sun?",
    "option": ["China", "Japan", "South Korea", "India"],
    "answer": "Japan",
    "note": "Japan is known as the Land of the Rising Sun."
  },
  {
    "question": "What is the hardest natural substance on Earth?",
    "option": ["Gold", "Iron", "Diamond", "Platinum"],
    "answer": "Diamond",
    "note": "Diamond is the hardest natural substance on Earth."
  },
  {
    "question": "What is the smallest country in the world by land area?",
    "option": ["Monaco", "Malta", "Vatican City", "San Marino"],
    "answer": "Vatican City",
    "note": "Vatican City is the smallest country in the world by land area."
  },
  {
    "question": "What is the longest river in the world?",
    "option": [
      "Nile River",
      "Amazon River",
      "Yangtze River",
      "Mississippi River"
    ],
    "answer": "Nile River",
    "note": "The Nile River is the longest river in the world."
  }
];
