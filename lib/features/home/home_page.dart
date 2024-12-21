import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';
import 'models/dish_model.dart';
import 'package:provider/provider.dart';
import '../../../core/themes/color/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DishesLanding> dishes = [];
  bool isLoading = true;
  final TextEditingController _suggestionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/landing/json/'));
      if (response.statusCode == 200) {
        setState(() {
          dishes = dishesLandingFromJson(response.body);
          dishes.sort((a, b) {
            double ratingA = double.tryParse(a.fields.averageRating ?? '0') ?? 0;
            double ratingB = double.tryParse(b.fields.averageRating ?? '0') ?? 0;
            return ratingB.compareTo(ratingA);
          });
          dishes = dishes.take(3).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load dishes');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching dishes: $error');
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  Future<void> submitSuggestion(int userId, String suggestionMessage) async {
    try {
      final request = CookieRequest();
      final response = await request.postJson(
        "http://127.0.0.1:8000/landing/create-suggestion-flutter/",
        jsonEncode(<String, String>{
            'suggestionMessage': suggestionMessage
          // TODO: Sesuaikan field data sesuai dengan aplikasimu
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Suggestion submitted successfully!')),
        );
        _suggestionController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit suggestion.')),
        );
      }
    } catch (e) {
      print('Error submitting suggestion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
   

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode
                ? [Colors.brown.shade400, Colors.brown.shade900]
                : [Colors.yellow.shade100, Colors.orange.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
  
            children: [
              const SizedBox(height: 40),
              Text(
                "${getGreeting()}, User 👋",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade100
                      : Colors.brown.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Discover amazing dishes and top picks for today:",
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade400
                      : Colors.brown.shade500,
                ),
              ),
              const SizedBox(height: 16),

              // Top Categories Carousel
              Text(
                "Explore Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade200
                      : Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryCard('Seafood', Icons.restaurant),
                    _buildCategoryCard('Desserts', Icons.cake),
                    _buildCategoryCard('Fast Food', Icons.fastfood),
                    _buildCategoryCard('Beverages', Icons.local_drink),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Top Dishes Section
              Text(
                "Top Dishes of the Day",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade200
                      : Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : dishes.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dishes.length,
                            itemBuilder: (context, index) {
                              final dish = dishes[index].fields;
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 16.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 8.0,
                                  color: themeProvider.isDarkMode
                                      ? Colors.brown.shade200
                                      : Colors.amber.shade50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                        child: Image.network(
                                          dish.image,
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dish.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: themeProvider.isDarkMode
                                                    ? Colors.brown.shade800
                                                    : Colors.brown.shade700,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Rating: ${dish.averageRating ?? "N/A"}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: themeProvider.isDarkMode
                                                    ? Colors.grey.shade700
                                                    : Colors.brown.shade500,
                                              ),
                                            ),
                                            Text(
                                              'Price: \$${dish.price}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: themeProvider.isDarkMode
                                                    ? Colors.grey.shade700
                                                    : Colors.brown.shade500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No dishes available",
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.brown.shade500,
                              ),
                            ),
                          ),
              ),

              const SizedBox(height: 16),

              // Food Tips Section
              Text(
                "Did You Know?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade200
                      : Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Eating a variety of colors in your diet can provide a range of nutrients for optimal health!",
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade400
                      : Colors.brown.shade500,
                ),
              ),
              const SizedBox(height: 16),

              // Suggestion Form Section
              Text(
                "Have Suggestions?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Colors.grey.shade200
                      : Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _suggestionController,
                decoration: InputDecoration(
                  labelText: 'Your Suggestion',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  fillColor: themeProvider.isDarkMode
                      ? Colors.brown.shade200
                      : Colors.white,
                  filled: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  final suggestion = _suggestionController.text;
                  if (suggestion.isNotEmpty) {
                    submitSuggestion(1, suggestion); // Example user ID
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Suggestion cannot be empty.')),
                    );
                  }
                },
                child: Text('Submit Suggestion'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        color: Colors.orange.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.brown.shade700),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
