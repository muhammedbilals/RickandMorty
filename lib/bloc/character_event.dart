part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

// ignore: must_be_immutable
class FetchCharacters extends CharacterEvent {
  int pageNumber;
  FetchCharacters(this.pageNumber);
}

// ignore: must_be_immutable
class LoadMoreData extends CharacterEvent {
  int pageNumber;

  LoadMoreData(this.pageNumber);
}
