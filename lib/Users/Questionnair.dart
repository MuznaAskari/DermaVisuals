import 'package:flutter/material.dart';
import 'package:DermaVisuals/Components/appbar.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  int currentQuestionIndex = 0;

  List<Question> questions = [
    Question(
        text: "Which most likely describes the look of your pores?",
        options: ["Large and visible all over", "Large or visible and only visible in T-zone", "Medium sized all over", "Small, not easily noticeable"],
        optionValue: ["Oily", "Combination", "Normal", "Dry"]
    ),
    Question(
        text: "When does your skin look red?",
        options: ["Whenever and wherever I use new products", "Sometime but only around my cheeks", "Anytime I have blemishes", "Very often"],
        optionValue: ["Sensitive","Non-Sensitive", "Non-Sensitive", "Sensitive"]
    ),
    Question(
        text: "How would you describe the shine of your skin?",
        options: ["Over all shiny","Shiny in my T-zone, but dull on my cheeks", "I get more stinging than shine","Dull everywhere"],
        optionValue: ["Oily","Combination","Sensitive","Dry"]
    ),
    Question(
        text: "In the afternoon my skin needs:",
        options: ["Blotting or powder all over", "A refreshing spritz of facial spray", "Blotting or powdering on the forehead, nose, and/or chin.", "Thorough moisturizing"],
        optionValue: ["Oily","Normal","Combination", "Dry"]
    ),
    Question(
        text: "How does your skin feel after you wash your face?",
        options: ["Itchy and little bit dry", "Face becomes oily after sometime", " Stripped of moisture", "Clean and great in my T-zone, but my cheeks are a little bit dried out."],
        optionValue: ["Dry","Oily","Normal", "Combination"]
    ),
    Question(
        text: "Pick the one that best describes your skin's relationship with pimples and blackheads.",
        options: ["They often occur", "My skin is too flaky and tight", "Mainly occurs on my T-zone and not on my cheeks", "My blemishes are more likely to be broken capillaries or rashes."],
        optionValue: ["Oily", "Dry", "Combination", "Normal"]
    ),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Questionnair bg.png'), // Replace with your image path
              fit: BoxFit.cover, // Adjust the BoxFit property as needed
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text(
                    "Skin Type Quiz",
                  style: GoogleFonts.alkatra(
                    color: Color(0xFFA86A44),
                    fontSize: 50,
                  ),
                ),
                Questions(questions[currentQuestionIndex].text,questions[currentQuestionIndex].options,questions[currentQuestionIndex].options ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          if(currentQuestionIndex != 0) {
                            setState(() {
                              currentQuestionIndex=currentQuestionIndex-1;
                            });
                          } else{
                            setState(() {
                              currentQuestionIndex == 0;
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.yellow[50],
                          ),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        onTap: (){
                          if(currentQuestionIndex < questions.length)
                          { setState(() {
                            currentQuestionIndex = currentQuestionIndex+1;
                          });}else{
                            setState(() {
                              currentQuestionIndex = questions.length ;
                            });
                          }

                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.yellow[50],
                          ),
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  ),
                )


              ],
            ),
          ),
        ),

    ),
    );
  }
  Widget Questions(String Question,List<String> options, List<String> optionValue){
    int oilyPoints = 0;
    int normalPoints = 0;
    int dryPoints = 0;
    int combinationPoints = 0;
    int sensitivePoints = 0;
    String skinType = "";
    if (oilyPoints >= normalPoints &&
        oilyPoints >= dryPoints &&
        oilyPoints >= combinationPoints &&
        oilyPoints >= sensitivePoints) {
      skinType = "Your skin is oily";
    }  if (normalPoints >= oilyPoints &&
        normalPoints >= dryPoints &&
        normalPoints >= combinationPoints &&
        normalPoints >= sensitivePoints) {
      skinType = "Your skin is normal";
    }  if (dryPoints >= oilyPoints &&
        dryPoints >= normalPoints &&
        dryPoints >= combinationPoints &&
        dryPoints >= sensitivePoints) {
      skinType = "Your skin is dry";
    }  if (combinationPoints >= oilyPoints &&
        combinationPoints >= normalPoints &&
        combinationPoints >= dryPoints &&
        combinationPoints >= sensitivePoints) {
      skinType = "You have combination skin";
    } if(sensitivePoints > 1) {
      skinType = "You have sensitive skin";
    }
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                Question,
                style: GoogleFonts.alkatra(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: ()
                            {
                              if(currentQuestionIndex < options.length) {
                                if (optionValue[currentQuestionIndex] ==
                                    "Oily") {
                                  setState(() {
                                    oilyPoints++;
                                  });;
                                } else if (optionValue[currentQuestionIndex] ==
                                    "Dry") {
                                  setState(() {
                                    dryPoints++;
                                  });
                                } else if (optionValue[currentQuestionIndex] ==
                                    "Normal") {
                                  setState(() {
                                    normalPoints++;
                                  });
                                } else if (optionValue[currentQuestionIndex] ==
                                    "Combination") {
                                  setState(() {
                                    combinationPoints++;
                                  });
                                } else if (optionValue[currentQuestionIndex] ==
                                    "Sensitive") {
                                  setState(() {
                                    sensitivePoints++;
                                  });
                                }

                                // Move to the next question
                                setState(() {
                                  currentQuestionIndex =
                                      currentQuestionIndex + 1;
                                });
                              }else{
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AlertDialog(
                            title: Text("Skin Type"),
                            content: Text(skinType),
                            actions: [
                            TextButton(
                            onPressed: () {
                            // Close the dialog and reset the questionnaire
                            Navigator.of(context).pop();
                            setState(() {
                            currentQuestionIndex = 0;
                            oilyPoints = 0;
                            normalPoints = 0;
                            dryPoints = 0;
                            combinationPoints = 0;
                            sensitivePoints = 0;
                            });
                            },
                            child: Text("OK"),
                            ),
                            ],
                            );});
                              }
                              // if (currentQuestionIndex < 5) {
                              //   // Update points based on selected option
                              //   if (optionValue[currentQuestionIndex] ==
                              //       "Oily") {
                              //     oilyPoints++;
                              //   } else if (optionValue[currentQuestionIndex] ==
                              //       "Dry") {
                              //     dryPoints++;
                              //   } else if (optionValue[currentQuestionIndex] ==
                              //       "Normal") {
                              //     normalPoints++;
                              //   } else if (optionValue[currentQuestionIndex] ==
                              //       "Combination") {
                              //     combinationPoints++;
                              //   } else if (optionValue[currentQuestionIndex] ==
                              //       "Sensitive") {
                              //     sensitivePoints++;
                              //   }
                              //
                              //   // Move to the next question
                              //   setState(() {
                              //     currentQuestionIndex =
                              //         currentQuestionIndex + 1;
                              //   });
                              // } if (currentQuestionIndex == 6) {
                              //   // Handle the end of the questionnaire
                              //   // (your existing logic for determining skin type)
                              //
                              //   // Display the result
                              //   String skinType = "";
                              //   if (oilyPoints >= normalPoints &&
                              //       oilyPoints >= dryPoints &&
                              //       oilyPoints >= combinationPoints &&
                              //       oilyPoints >= sensitivePoints) {
                              //     skinType = "Your skin is oily";
                              //   } else if (normalPoints >= oilyPoints &&
                              //       normalPoints >= dryPoints &&
                              //       normalPoints >= combinationPoints &&
                              //       normalPoints >= sensitivePoints) {
                              //     skinType = "Your skin is normal";
                              //   } else if (dryPoints >= oilyPoints &&
                              //       dryPoints >= normalPoints &&
                              //       dryPoints >= combinationPoints &&
                              //       dryPoints >= sensitivePoints) {
                              //     skinType = "Your skin is dry";
                              //   } else if (combinationPoints >= oilyPoints &&
                              //       combinationPoints >= normalPoints &&
                              //       combinationPoints >= dryPoints &&
                              //       combinationPoints >= sensitivePoints) {
                              //     skinType = "You have combination skin";
                              //   } else {
                              //     skinType = "You have sensitive skin";
                              //   }
                              //
                              //   // Display the result
                              //   showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //         title: Text("Skin Type"),
                              //         content: Text(skinType),
                              //         actions: [
                              //           TextButton(
                              //             onPressed: () {
                              //               // Close the dialog and reset the questionnaire
                              //               Navigator.of(context).pop();
                              //               setState(() {
                              //                 currentQuestionIndex = 0;
                              //                 // Reset your points or any other variables if needed
                              //               });
                              //             },
                              //             child: Text("OK"),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   );
                              // }
                            },
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    options[index],
                                    style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

              ),

                ]
    ),
    )
    );
                        }
                  }

class Question {
  final String text;
  final List<String> options;
  final List<String> optionValue;

  Question({required this.text, required this.options,required this.optionValue});
}
