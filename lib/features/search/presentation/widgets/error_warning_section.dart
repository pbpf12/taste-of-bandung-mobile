part of '_widgets.dart';

class ErrorWarningSection extends StatelessWidget {
  const ErrorWarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 7),
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 20),
            const Text(
              '''Failed to load data\nPlease swipe down to reload''',
              style: TextStyle(
                fontSize: 18,
                color: Colors.redAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}