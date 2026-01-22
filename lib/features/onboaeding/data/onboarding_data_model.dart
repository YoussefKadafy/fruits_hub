import 'package:flutter/material.dart';

class OnboardingDataModel {
  final String background;
  final String mainImage;
  final Widget heading;
  final String description;

  const OnboardingDataModel({
    required this.background,
    required this.mainImage,
    required this.heading,
    required this.description,
  });
}
