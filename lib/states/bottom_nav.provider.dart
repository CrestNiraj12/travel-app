import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/constants/constant.dart';

final bottomNavProvider = StateProvider<int>((ref) => Screens.home);
final pageController = PageController();
