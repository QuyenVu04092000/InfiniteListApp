import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_app/events/comment_events.dart';
import 'package:infinite_list_app/services/services.dart';
import 'package:infinite_list_app/states/comment_states.dart';

import '../models/comment.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final NUMBER_OF_COMMENTS_PER_PAGE = 20;
  @override
  CommentBloc():super(CommentStateInitial());
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    try{
      final hasReachedEndOfOnePage = (state is CommentStateSuccess && (state as CommentStateSuccess).hasReachedEnd);
      if(event is CommentFetchedEvent && !hasReachedEndOfOnePage){
        if(state is CommentStateInitial) {
          final List<Comment> comments = await getCommentsFromApi(0, NUMBER_OF_COMMENTS_PER_PAGE);
          yield CommentStateSuccess(
            hasReachedEnd: false,
            comments: comments,
          );
        } else if(state is CommentStateSuccess) {
          final currentState = state as CommentStateSuccess;
          int finalIndexOfCurrentPage = currentState.comments.length;
          final comments = await getCommentsFromApi(finalIndexOfCurrentPage, NUMBER_OF_COMMENTS_PER_PAGE);
          if(comments.isEmpty){
            yield (state as CommentStateSuccess).cloneWith(hasReachedEnd: true) ;
          } else {
            yield CommentStateSuccess(
                comments: currentState.comments + comments,
                hasReachedEnd: false
            );
          }
        }
      } else{

      }
    }catch(exception){
      yield CommentStateFailure();
    }
  }
}