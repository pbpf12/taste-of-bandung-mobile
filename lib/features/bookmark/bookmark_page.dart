import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tasteofbandung/features/prodetail/prodetail_screen.dart';
import '../../core/environments/_environments.dart';
import 'package/../models/bookmark_model.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  Future<BookmarkEntry> fetchBookmarks(CookieRequest request) async {
    final response =
        await request.get('http://${EndPoints().myBaseUrl}/last_activities/');

    // Check for authentication errors
    if (response.containsKey('error') &&
        response['error'] == 'User not authenticated') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated. Please log in.')),
      );
      // Return an empty BookmarkEntry if unauthenticated
      return BookmarkEntry(bookmarks: []);
    }

    return BookmarkEntry.fromJson(response);
  }

  Future<void> deleteBookmark(CookieRequest request, int bookmarkId) async {
    final response = await request.post(
      'http://${EndPoints().myBaseUrl}/delete_bookmark/',
      {'id': bookmarkId.toString()},
    );
    if (response['status'] == 'Bookmark deleted successfully') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bookmark deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete bookmark')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(color: Color.fromARGB(255, 255, 249, 196)), // AppBar text color
        ),
        backgroundColor: const Color.fromARGB(255, 93, 64, 55),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 162, 102, 70)), // AppBar icon color
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFB845),
              Color(0xFFFFC966),
              Color(0xFFFFD57A),
              Color(0xFFFFE38E),
              Color(0xFFFFF0A1),
              Color(0xFFFFEB84),
              Color(0xFFFFF7C2),
            ],
          ),
        ),
        child: FutureBuilder<BookmarkEntry>(
          future: fetchBookmarks(request),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.bookmarks.isEmpty) {
              return const Center(
                child: Text(
                  'No bookmarks available.',
                  style: TextStyle(fontSize: 18.0, color: Colors.red),
                ),
              );
            } else {
              final bookmarks = snapshot.data!.bookmarks;
              return ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = bookmarks[index];
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => ProdetailScreen(dishId: bookmark.dishId)));
                      // reload the future builder to get the latest update (there is a possible chance of user removing the bookmarked dish)
                      setState(() {});
                    },
                    child: Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: const Color.fromARGB(255, 175, 124, 97),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Color.fromARGB(255, 255, 249, 196), width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        title: Text(
                          bookmark.dishName,
                          style: const TextStyle(color: Color.fromARGB(255, 255, 249, 196)),
                        ),
                        subtitle: Text(
                          bookmark.restaurantName,
                          style: const TextStyle(color: Color.fromARGB(255, 255, 249, 196)),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await deleteBookmark(request, bookmark.id);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}