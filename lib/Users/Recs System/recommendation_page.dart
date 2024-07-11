import 'package:flutter/material.dart';
import 'recommendation_logic.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendationPage extends StatefulWidget {
  final String skinType;
  final List<String> symptoms;

  RecommendationPage({required this.skinType, required this.symptoms});

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  late Future<List<SkincareRecommendation>> _recommendationsFuture;

  @override
  void initState() {
    super.initState();
    _recommendationsFuture = RecommendationLogic().loadRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login-background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: FutureBuilder<List<SkincareRecommendation>>(
              future: _recommendationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recommendations found.'));
                } else {
                  final recommendations = RecommendationLogic().matchProducts(
                    widget.skinType,
                    widget.symptoms,
                    snapshot.data!,
                  );
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9), // Beige color inside the box
                      border: Border.all(color: Colors.brown[800]!, width: 3), // Dark brown border
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Based on your ${widget.skinType} skin type and symptoms, here are some recommended products:",
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(250, 253, 173, 114), // Brown color
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        ...recommendations.map((rec) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "* ${rec.type}: ",
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[800],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  rec.name,
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
