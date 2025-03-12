import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Views/home_screen.dart';
import '../Views/chat_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final username = state.extra as String?; // Lấy username từ HomeScreen
        if (username == null || username.isEmpty) {
          return HomeScreen(); // neu k co username -> back ve home
        }
        return ChatScreen(username: username); // Chuyển đến chatscreen
      },
    ),
  ],
);
