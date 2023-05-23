import 'dart:convert';
import 'package:api_basic/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'package:api_basic/models/recipe.api.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.http('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    // Add an HTTP request using the created URI
    // var response = await http.get(uri);

    // if (response.statusCode == 200) {
    //   // Parse the response body
    //   var data = json.decode(response.body);

    //   // Process the data and convert it into a list of Recipe objects
    //   List<Recipe> recipes =
    //       List<Recipe>.from(data['recipes'].map((x) => Recipe.fromJson(x)));

    //   return recipes; // Return the list of recipes
    // } else {
    //   throw Exception(
    //       'Failed to load recipes'); // Throw an exception if the request fails
    // }

    Map data = jsonDecode(response.body);
    List _temp = [];
    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(_temp);
  }
}
