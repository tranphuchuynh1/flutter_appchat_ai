import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'Bloc/chat_bloc.dart';
import 'router.dart'; //

void main() {
  runApp(
    BlocProvider(
      create: (context) => ChatBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    ),
  );
}
