part of 'character_bloc.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {
  CharacterInitial();
}

// ignore: must_be_immutable
class DisplayCharacters extends CharacterState {
  List<Result> characterList;
  DisplayCharacters(this.characterList);
}
