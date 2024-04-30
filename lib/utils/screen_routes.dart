import 'package:flutter/material.dart';
import 'package:reexam2/screen/bookmark/view/bookmark_screen.dart';
import 'package:reexam2/screen/home/view/home_screen.dart';
import 'package:reexam2/screen/recipe/view/recipe_screen.dart';
import 'package:reexam2/screen/splash/view/splash_screen.dart';

Map<String,WidgetBuilder>screen_routes={
  '/':(context) => const SplashScreen(),
  'home':(context) => const HomeScreen(),
  'recipe':(context) => const RecipeScreen(),
  'bookmark':(context) => const BookmarkScreen(),
};