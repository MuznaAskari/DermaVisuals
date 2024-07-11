import 'package:flutter/material.dart';
import 'recommendation_page.dart'; // Make sure this file exists and is correctly implemented.
import 'recommendation_logic.dart'; // This should contain your logic for generating recommendations.
import 'package:google_fonts/google_fonts.dart';


class SkinTypeQuizPage extends StatefulWidget {
  @override
  _SkinTypeQuizPageState createState() => _SkinTypeQuizPageState();
}

class _SkinTypeQuizPageState extends State<SkinTypeQuizPage> {
  int questionIndex = 0;
  int totalScore = 0;
  String? _selectedSkinType;
  List<String> _selectedSymptoms = [];

  List<Map<String, Object>> questions = [
    {
      'questionText': 'How does your skin feel after washing your face?',
      'answers': [
        {'text': 'Tight and dry', 'score': 1, 'symptoms': ['None']},
        {'text': 'Comfortable, no tightness', 'score': 2, 'symptoms': ['None']},
        {'text': 'Oily or greasy', 'score': 3, 'symptoms': ['Oily']},
        {'text': 'Itchy or red', 'score': 4, 'symptoms': ['Irritating']},
      ],
    },
    {
      'questionText': 'How often do you experience breakouts?',
      'answers': [
        {'text': 'Rarely', 'score': 1, 'symptoms': ['None']},
        {'text': 'Occasionally', 'score': 2, 'symptoms': ['None']},
        {'text': 'Frequently', 'score': 3, 'symptoms': ['Acne Trigger']},
        {'text': 'All the time', 'score': 4, 'symptoms': ['Acne Trigger']},
      ],
    },
    {
      'questionText': 'How does your skin react to new products?',
      'answers': [
        {'text': 'No reaction', 'score': 1, 'symptoms': ['None']},
        {'text': 'Slight irritation', 'score': 2, 'symptoms': ['Irritating']},
        {'text': 'Redness and breakouts', 'score': 3, 'symptoms': ['Irritating', 'Acne Trigger']},
        {'text': 'Severe allergic reactions', 'score': 4, 'symptoms': ['Irritating']},
      ],
    },
    {
      'questionText': 'How would you describe the size of your pores?',
      'answers': [
        {'text': 'Very small, barely visible', 'score': 1, 'symptoms': ['None']},
        {'text': 'Medium-sized, visible but not prominent', 'score': 2, 'symptoms': ['None']},
        {'text': 'Large, very visible', 'score': 3, 'symptoms': ['Reduces Large Pores']},
        {'text': 'Very large, extremely noticeable', 'score': 4, 'symptoms': ['Reduces Large Pores']},
      ],
    },
    {
      'questionText': 'Do you have any specific skin concerns?',
      'answers': [
        {'text': 'Dryness', 'score': 1, 'symptoms': ['Drying']},
        {'text': 'Oily skin', 'score': 2, 'symptoms': ['Oily']},
        {'text': 'Redness', 'score': 3, 'symptoms': ['Irritating']},
        {'text': 'Acne', 'score': 4, 'symptoms': ['Acne Trigger']},
        {'text': 'Dark spots', 'score': 5, 'symptoms': ['Dark Spots']},
        {'text': 'Aging (fine lines, wrinkles)', 'score': 6, 'symptoms': ['Anti-Aging']},
      ],
    },
    {
      'questionText': 'How does your skin feel throughout the day?',
      'answers': [
        {'text': 'Dry and flaky', 'score': 1, 'symptoms': ['Drying']},
        {'text': 'Balanced', 'score': 2, 'symptoms': ['None']},
        {'text': 'Shiny and oily', 'score': 3, 'symptoms': ['Oily']},
        {'text': 'Red and irritated', 'score': 4, 'symptoms': ['Irritating']},
      ],
    },
    {
      'questionText': 'Do you have sensitive skin that gets easily irritated?',
      'answers': [
        {'text': 'Yes', 'score': 1, 'symptoms': ['Sensitive']},
        {'text': 'No', 'score': 2, 'symptoms': ['None']},
      ],
    },
    {
      'questionText': 'Do you experience redness or rosacea?',
      'answers': [
        {'text': 'Yes', 'score': 1, 'symptoms': ['Irritating', 'Rosacea']},
        {'text': 'No', 'score': 2, 'symptoms': ['None']},
      ],
    },
    {
      'questionText': 'Do you have eczema or any other skin conditions?',
      'answers': [
        {'text': 'Yes', 'score': 1, 'symptoms': ['Eczema']},
        {'text': 'No', 'score': 2, 'symptoms': ['None']},
      ],
    },
    {
      'questionText': 'How concerned are you about anti-aging (wrinkles, fine lines)?',
      'answers': [
        {'text': 'Not concerned', 'score': 1, 'symptoms': ['None']},
        {'text': 'Slightly concerned', 'score': 2, 'symptoms': ['None']},
        {'text': 'Very concerned', 'score': 3, 'symptoms': ['Anti-Aging']},
      ],
    },
    {
      'questionText': 'How much sun exposure do you get daily?',
      'answers': [
        {'text': 'Less than 30 minutes', 'score': 1, 'symptoms': ['None']},
        {'text': '30 minutes to 1 hour', 'score': 2, 'symptoms': ['None']},
        {'text': '1 to 2 hours', 'score': 3, 'symptoms': ['None']},
        {'text': 'More than 2 hours', 'score': 4, 'symptoms': ['Anti-Aging']},
      ],
    },
    {
      'questionText': 'How often do you wear makeup?',
      'answers': [
        {'text': 'Never', 'score': 1, 'symptoms': ['None']},
        {'text': 'Occasionally', 'score': 2, 'symptoms': ['None']},
        {'text': 'Frequently', 'score': 3, 'symptoms': ['None']},
        {'text': 'Always', 'score': 4, 'symptoms': ['Acne Fighting']},
      ],
    },
    {
      'questionText': 'How would you describe your diet?',
      'answers': [
        {'text': 'Balanced and healthy', 'score': 1, 'symptoms': ['None']},
        {'text': 'Somewhat healthy', 'score': 2, 'symptoms': ['None']},
        {'text': 'Not very healthy', 'score': 3, 'symptoms': ['Anti-Aging']},
      ],
    },
    {
      'questionText': 'Do you prefer products with natural ingredients?',
      'answers': [
        {'text': 'Yes', 'score': 1, 'symptoms': ['None']},
        {'text': 'No', 'score': 2, 'symptoms': ['None']},
        {'text': 'Indifferent', 'score': 3, 'symptoms': ['Anti-Aging']},
      ],
    },
    {
      'questionText': 'Do you have any allergies to specific skincare ingredients?',
      'answers': [
        {'text': 'Yes (please specify)', 'score': 1, 'symptoms': ['None']},
        {'text': 'No', 'score': 2, 'symptoms': ['Anti-Aging']},
      ],
    },
  ];


  void answerQuestion(int score, List<String> symptoms) {
    totalScore += score;
    _selectedSymptoms.addAll(symptoms);

    setState(() {
      questionIndex++;
    });
  }

  String getSkinType() {
    if (totalScore <= 10) {
      return 'Dry';
    } else if (totalScore <= 30) {
      return 'Oily';
    } else if (totalScore <= 40) {
      return 'Combination';
    } else {
      return 'Sensitive';
    }
  }

  String getRecommendedRoutine(String skinType) {
    switch (skinType) {
      case 'Dry':
        return 'Use a moisturizing cleanser and hydrating serums.';
      case 'Oily':
        return 'Choose oil-free cleansers and lightweight, non-comedogenic moisturizers.';
      case 'Sensitive':
        return 'Avoid harsh ingredients, opt for fragrance-free products.';
      case 'Combination':
        return 'Use products formulated to balance oily and dry areas of your skin.';
      default:
        return 'Unable to determine recommended routine.';
    }
  }

  double calculateProgress() {
    return (questionIndex + 1) / questions.length;
  }

  void viewRecommendations() {
    String skinType = getSkinType();
    List<String> symptoms = _selectedSymptoms.where((symptom) => symptom != 'None').toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendationPage(
          skinType: skinType,
          symptoms: symptoms,
          // symptoms: _selectedSymptoms,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('./assets/login-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: questionIndex < questions.length
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: Text(
                          questions[questionIndex]['questionText']
                          as String,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 22,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: (questions[questionIndex]['answers']
                        as List<Map<String, Object>>)
                            .map((answer) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => answerQuestion(
                                    answer['score'] as int,
                                    answer['symptoms'] as List<String>),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    answer['text'] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                      250, 255, 215, 186),
                                  foregroundColor: Colors.brown,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: Colors.brown, width: 2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your skin type is',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          color: Colors.brown,
                        ),
                      ),
                      Text(
                        '${getSkinType()}',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.brown, width: 2),
                        ),
                        child: Text(
                          getRecommendedRoutine(getSkinType()),
                          style: TextStyle(
                              fontSize: 18, color: Colors.brown),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: viewRecommendations,
                        child: Text(
                          'View Personalized Skincare Routine',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            LinearProgressIndicator(
              value: calculateProgress(),
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
