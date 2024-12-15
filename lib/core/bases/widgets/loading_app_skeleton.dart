part of '_widgets.dart';

class LoadingAppSkeleton extends StatelessWidget {
  const LoadingAppSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // box
                  Shimmer.fromColors(
                    baseColor: themeProvider.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    highlightColor: themeProvider.isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Text
                  Shimmer.fromColors(
                    baseColor: themeProvider.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    highlightColor: themeProvider.isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(left: 16, top: 8, right: 50),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: themeProvider.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    highlightColor: themeProvider.isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(left: 16, top: 8, right: 120),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: themeProvider.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    highlightColor: themeProvider.isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                      margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Body box
                  Shimmer.fromColors(
                    baseColor: themeProvider.isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    highlightColor: themeProvider.isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade400,
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom navigation bar
          Shimmer.fromColors(
            baseColor: themeProvider.isDarkMode
                ? Colors.grey.shade700
                : Colors.grey.shade300,
            highlightColor: themeProvider.isDarkMode
                ? Colors.grey.shade900
                : Colors.grey.shade400,
            child: Container(
              height: 50,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
