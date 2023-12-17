import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List<Album>> fetchAlbumList() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    final albums = jsonDecode(response.body);
    return (albums as List<dynamic>)
        .map((dynamic album) => Album.fromJson(album as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to Load List Album');
  }
}

Future<ChukNorris> fetchChuckNorris() async {
  final response = await http.get(
    Uri.parse('https://api.chucknorris.io/jokes/random'),
  );

  if (response.statusCode == 200) {
    return ChukNorris.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load chuck norris.');
  }
}

Future<List<Cat>> fetchRandomCat() async {
  final response = await http.get(
    Uri.parse('https://api.thecatapi.com/v1/images/search'),
  );

  if (response.statusCode == 200) {
    final cats = jsonDecode(response.body);
    return (cats as List<dynamic>)
        .map((dynamic cat) => Cat.fromJson(cat as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load cat.');
  }
}

Future<List<Cat>> fetchTenRandomCat() async {
  final response = await http.get(
    Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
  );

  if (response.statusCode == 200) {
    final cats = jsonDecode(response.body);
    return (cats as List<dynamic>)
        .map((dynamic cat) => Cat.fromJson(cat as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load cat.');
  }
}

Future<List<Course>> fetchCourses() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:1337/api/courses'),
  );

  if (response.statusCode == 200) {
    final courses = jsonDecode(response.body)['data'];
    return (courses as List<dynamic>)
        .map(
            (dynamic course) => Course.fromJson(course as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load courses.');
  }
}

class ChukNorris {
  final String id;
  final String value;
  final String iconUrl;

  ChukNorris({
    required this.id,
    required this.value,
    required this.iconUrl,
  });

  factory ChukNorris.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'value': String value,
        'icon_url': String iconUrl,
      } =>
        ChukNorris(
          id: id,
          value: value,
          iconUrl: iconUrl,
        ),
      _ => throw const FormatException('Failed to load chu.'),
    };
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class Cat {
  final String id;
  final String url;
  final int width;
  final int height;

  const Cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'url': String url,
        'width': int width,
        'height': int height,
      } =>
        Cat(
          id: id,
          url: url,
          width: width,
          height: height,
        ),
      _ => throw const FormatException('Failed to load cat.'),
    };
  }
}

class Course {
  int? id;
  Attributes? attributes;

  Course({this.id, this.attributes});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? name;
  String? description;
  String? releaseDate;
  bool? onSale;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Attributes(
      {this.name,
      this.description,
      this.releaseDate,
      this.onSale,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    releaseDate = json['release_date'];
    onSale = json['onSale'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['release_date'] = this.releaseDate;
    data['onSale'] = this.onSale;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late Future<Album> futureAlbum;
  // late Future<ChukNorris> futureChuckNorris;
  // late Future<List<Album>> futureAlbumList;
  // late Future<List<Cat>> futureRandomCat;
  late Future<List<Cat>> futureTenRandomCat;
  late Future<List<Course>> futureCourses;

  @override
  void initState() {
    super.initState();
    // futureAlbum = fetchAlbum();
    // futureChuckNorris = fetchChuckNorris();
    // futureAlbumList = fetchAlbumList();
    // futureRandomCat = futureRandomCat();
    futureTenRandomCat = fetchTenRandomCat();
    futureCourses = fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Course>>(
            future: fetchCourses(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text(snapshot.data![index].attributes!.name!),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
