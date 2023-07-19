import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machinetest/model/charcter_model.dart';

class ApiService {
  static Future<RickyMortyCharacters> getCharacters() async {
    final response = await http
        .get(Uri.parse('https://rickandmortyapi.com/api/character/?page=1'));
    if (response.statusCode == 200) {
      RickyMortyCharacters characters =
          RickyMortyCharacters.fromJson(json.decode(response.body));
      log(characters.results[0].name.toString());
      return characters;
    } else {
      throw Text('error fetching data');
    }
  }
}
