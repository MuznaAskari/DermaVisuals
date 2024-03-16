import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class SkinTypeQuizPage extends StatefulWidget {
  @override
  _SkinTypeQuizPageState createState() => _SkinTypeQuizPageState();
}

class _SkinTypeQuizPageState extends State<SkinTypeQuizPage> {
  int questionIndex = 0;
  List<Map<String, Object>> questions = [
    {
      'questionText': 'How does your skin typically feel after washing it with a mild cleanser?',
      'answers': [
        {'text': 'Tight and dry', 'score': 1},
        {'text': 'Normal', 'score': 2},
        {'text': 'Oily', 'score': 3},
        {'text': 'Sensitive', 'score': 4},
        {'text': 'Combination of oily and dry', 'score': 5},
      ],
    },
    {
      'questionText': 'Do you notice any shiny or oily areas on your face a few hours after cleansing?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'How often do you experience dryness or tightness in your skin?',
      'answers': [
        {'text': 'Rarely or never', 'score': 1},
        {'text': 'Occasionally', 'score': 2},
        {'text': 'Frequently', 'score': 3},
        {'text': 'Almost always', 'score': 4},
      ],
    },
    {
      'questionText': 'Have you ever experienced redness or irritation after applying certain skincare products?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'Do you tend to develop noticeable pores or blackheads, especially around your nose or T-zone?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'How does your skin react to changes in weather or climate?',
      'answers': [
        {'text': 'Dry and tight', 'score': 1},
        {'text': 'Normal', 'score': 2},
        {'text': 'Oily and sticky', 'score': 3},
        {'text': 'Red and irritated', 'score': 4},
        {'text': 'Some areas oily, some dry', 'score': 5},
      ],
    },
    {
      'questionText': 'Have you ever had issues with excessive shine or oiliness in specific areas of your face?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'Do you have any concerns about sensitivity or reactions to skincare ingredients or environmental factors?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'Have you noticed any fine lines, wrinkles, or signs of aging on your skin?',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 2},
      ],
    },
    {
      'questionText': 'What are your main skincare goals or concerns you would like to address?',
      'answers': [
        {'text': 'Hydration', 'score': 1},
        {'text': 'Oil control', 'score': 2},
        {'text': 'Acne prevention', 'score': 3},
        {'text': 'Anti-aging', 'score': 4},
        {'text': 'Sensitive skin care', 'score': 5},
      ],
    },
  ];

  int totalScore = 0;

  void answerQuestion(int score) {
    totalScore += score;

    setState(() {
      questionIndex++;
    });
  }

  String getSkinType() {
    if (totalScore <= 5) {
      return 'Dry';
    } else if (totalScore <= 10) {
      return 'Normal';
    } else if (totalScore <= 15) {
      return 'Oily';
    } else if (totalScore <= 20) {
      return 'Combination';
    } else {
      return 'Sensitive';
    }
  }

  String getRecommendedRoutine(String skinType) {
    switch (skinType) {
      case 'Dry':
        return 'Use a moisturizing cleanser and hydrating serums.';
      case 'Normal':
        return 'A gentle cleanser and balanced moisturizer will suit you.';
      case 'Oily':
        return 'Choose oil-free cleansers and lightweight, non-comedogenic moisturizers.';
      case 'Sensitive':
        return 'Avoid harsh ingredients, opt for fragrance-free products.';
      case 'Combination':
        return 'Use products specifically formulated for combination skin.';
      default:
        return 'Unable to determine recommended routine.';
    }
  }

  double calculateProgress() {
    return (questionIndex + 1) / questions.length;
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
                          questions[questionIndex]['questionText'] as String,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () =>
                                    answerQuestion(answer['score'] as int),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    answer['text'] as String,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
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
                                    borderRadius:
                                    BorderRadius.circular(10),
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
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        '${getSkinType()}',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontStyle: FontStyle.italic,
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

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Add functionality for the button
                        },
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
                      SizedBox(height: 30), // Add some spacing

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