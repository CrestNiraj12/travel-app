import 'package:flutter/foundation.dart';

class Recomend with ChangeNotifier {
  final String id;
  final String place;
  final String country;
  final String imageUrl;
  final String description;
  final String location;
  Recomend({
    required this.id,
    required this.place,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.location,
  });
}

class Recomends with ChangeNotifier {
  List<Recomend> _items = [
    Recomend(
      id: "1",
      place: "Boudhanath Stupa",
      country: "Nepal",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Boudhanath_Stupa-IMG_7048.jpg/1280px-Boudhanath_Stupa-IMG_7048.jpg",
      description:
          "Bouddha (Nepali: बौद्धनाथ; Nepal bhasa: खास्ति चैत्य; Standard Tibetan: བྱ་རུང་ཁ་ཤོར།, romanized: Jarung Khashor, Wylie: bya rung kha shor), also known as Boudhanath, Khasti Chaitya and Khāsa Chaitya is a stupa in Kathmandu, Nepal.[2] Located about 11 km (6.8 mi) from the center and northeastern outskirts of Kathmandu, its massive mandala makes it one of the largest spherical stupas in Nepal[3] and the world.",
      location: "Bouddha, Kathmandu",
    ),
  ];

  List<Recomend> get items {
    return [..._items];
  }

  Recomend findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }
}
