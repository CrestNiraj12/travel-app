import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);
final pageController = PageController();
