import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SkincareRecommendation {
  final String name;
  final String skinType;
  final String type;
  final List<String> symptoms;

  SkincareRecommendation({
    required this.name,
    required this.skinType,
    required this.type,
    required this.symptoms,
  });

  factory SkincareRecommendation.fromJson(Map<String, dynamic> json) {
    return SkincareRecommendation(
      name: json['Name'],
      skinType: json['SkinType'],
      type: json['Type'],
      symptoms: json['Symptoms'] != null ? List<String>.from(json['Symptoms'].split(',')) : [],
    );
  }
}

class RecommendationLogic {
  Future<List<SkincareRecommendation>> loadRecommendations() async {
    final String response = await rootBundle.loadString('assets/product_data.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => SkincareRecommendation.fromJson(item)).toList();
  }

  List<SkincareRecommendation> matchProducts(String skinType, List<String> userSymptoms, List<SkincareRecommendation> recommendations) {
    final skinTypeFiltered = recommendations.where((rec) => rec.skinType == skinType).toList();
    final Map<String, String> matchedProducts = {};

    for (var rec in skinTypeFiltered) {
      final matchScore = rec.symptoms.where((symptom) => userSymptoms.contains(symptom)).length;
      if (matchScore > 0) {
        if (!matchedProducts.containsKey(rec.type) || matchScore > matchedProducts[rec.type]!.length) {
          matchedProducts[rec.type] = rec.name;
        }
      }
    }

    return matchedProducts.entries.map((entry) => SkincareRecommendation(name: entry.value, skinType: skinType, type: entry.key, symptoms: [])).toList();
  }

  String formatRecommendations(List<SkincareRecommendation> matchedProducts, String skinType) {
    if (matchedProducts.isEmpty) {
      return "Couldn't find any matching products.";
    }

    final recommendations = ["Based on your $skinType skin type and symptoms, here are some recommended products:"];
    for (var rec in matchedProducts) {
      recommendations.add("- ${rec.type}: ${rec.name}");
    }
    return recommendations.join("\n");
  }
}
