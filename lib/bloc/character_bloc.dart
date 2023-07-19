import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:machinetest/model/charcter_model.dart';
import 'package:machinetest/services/api_service.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  List<Result> characterList = [];
      bool isLoading = false;


  CharacterBloc() : super(CharacterInitial()) {
    on<FetchCharacters>((event, emit) async {
      final Stream<List<Result>> characterStream =
          ApiService.getCharacters(event.pageNumber);

      await for (characterList in characterStream) {
        emit(DisplayCharacters(characterList));
      }
      // log(characterList.toString());
    });
    on<LoadMoreData>((event, emit) async {
  bool isLoading = false;
  if (!isLoading ) {
    isLoading = true;
    event.pageNumber++;

    final Stream<List<Result>> characterStream =
        ApiService.getCharacters(event.pageNumber);
    await for (List<Result> moreCharacters in characterStream) {
      if (moreCharacters.isNotEmpty) {
        isLoading = false;
        characterList.addAll(moreCharacters);
        emit(DisplayCharacters(characterList));
        log(characterList.toString());
      } else {
        isLoading = false;
        break;
      }
    }
  }
});
  }
}
