import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_app/blocs/comment_bloc.dart';
import 'package:infinite_list_app/events/comment_events.dart';
import 'infinite_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        // create: (context) {
        //   final commentBloc = CommentBloc();
        //   commentBloc.add(CommentFetchedEvent());
        //   return commentBloc;
        // },
        create: (context) => CommentBloc()..add(CommentFetchedEvent()),
        child: InfiniteList(),
      )
    );
  }
}