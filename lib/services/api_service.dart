import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machinetest/model/charcter_model.dart';

class ApiService {
  static Stream<List<Result>> getCharacters(page) async* {
    int pagenumber = 0;
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=${pagenumber + page}'));
    if (response.statusCode == 200) {
      RickyMortyCharacters characters =
          RickyMortyCharacters.fromJson(json.decode(response.body));
      log(characters.results[0].name.toString());
      yield characters.results;
    } else {
      yield throw const Text('error fetching data');
    }
  }
}
