import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
      ),
      home: const MyHomePage(title: "Restaurant d'Axel"),
    );
  }
}

class Dish {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const Dish({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, List<Dish>> menuData = {
    'Formules': const [
      Dish(
        name: 'Formule Midi',
        description: 'Entrée + Plat ou Plat + Dessert',
        price: 15.90,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Formule Gourmande',
        description: 'Entrée + Plat + Dessert',
        price: 22.50,
        imageUrl:
        'https://picsum.photos/400',
      ),
    ],
    'Entrées': const [
      Dish(
        name: 'Salade César',
        description: 'Poulet, parmesan, croûtons, sauce maison',
        price: 8.50,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Soupe du jour',
        description: 'Légumes de saison',
        price: 6.20,
        imageUrl:
        'https://picsum.photos/400',
      ),
    ],
    'Plats': const [
      Dish(
        name: 'Burger Maison',
        description: 'Bœuf, cheddar, frites',
        price: 13.90,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Pâtes Carbonara',
        description: '',
        price: 12.50,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Poulet Rôti',
        description: 'Avec frites',
        price: 14.20,
        imageUrl:
        'https://picsum.photos/400',
      ),
    ],
    'Desserts': const [
      Dish(
        name: 'Tiramisu',
        description: 'Chocolat',
        price: 5.90,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Fondant au chocolat',
        description: 'Cœur coulant, crème anglaise',
        price: 6.50,
        imageUrl:
        'https://picsum.photos/400',
      ),
    ],
    'Boissons': const [
      Dish(
        name: 'Eau minérale',
        description: 'Plate',
        price: 2.50,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Soda',
        description: 'Coca',
        price: 3.20,
        imageUrl:
        'https://picsum.photos/400',
      ),
      Dish(
        name: 'Café',
        description: 'Expresso',
        price: 2.00,
        imageUrl:
        'https://picsum.photos/400',
      ),
    ],
  };

  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = menuData.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final dishes = menuData[selectedCategory] ?? const <Dish>[];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Zone de sélection des catégories
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: menuData.keys.map((cat) {
                final bool isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = cat);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cat,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            // ListView.builder plus performante sur des liste fixes
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return DishCard(dish: dish);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DishCard extends StatelessWidget {
  final Dish dish;
  const DishCard({super.key, required this.dish});

  // Widget d'affichage d'un plat
  @override
  Widget build(BuildContext context) {
    // Taille de l'image qui peut varier selon la taille de l'écran (Paysage ou Potrait)
    final double imageSize =
    MediaQuery.of(context).size.width < 400 ? 90 : 110;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      //Zone des informations du plat
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                dish.imageUrl,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    width: imageSize,
                    height: imageSize,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dish.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${dish.price.toStringAsFixed(2)} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
