part of '_widgets.dart';

class ErrorWarningSection extends StatelessWidget {
  const ErrorWarningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.redAccent,
            ),
            SizedBox(height: 20),
            Text(
              'Failed to load data. Please swipe down to reload',
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