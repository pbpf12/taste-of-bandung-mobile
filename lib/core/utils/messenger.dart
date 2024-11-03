part of '_utils.dart';

class SuccessMessenger {
  SuccessMessenger(this.message);

  final String message;

  void show(BuildContext context) {
    Flushbar<void>(
      icon: Container(
        width: 22,
        height: 22,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF27AE60),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(milliseconds: 1800),
      backgroundColor: const Color(0xFFD4EFDF),
      messageText: Text(
        message.toString(),
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}

class WarningMessenger {
  WarningMessenger(this.message);

  final String message;

  void show(BuildContext context) {
    final theme = Theme.of(context);
    Flushbar<void>(
      icon: Icon(
        Icons.info,
        color: theme.secondaryHeaderColor,
        size: 22,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(milliseconds: 1800),
      backgroundColor: const Color(0xFFFDF0CC),
      messageText: Text(
        message.toString(),
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}

class ErrorMessenger {
  ErrorMessenger(this.message);

  final String message;

  void show(BuildContext context) {
    final theme = Theme.of(context);
    Flushbar<void>(
      icon: Icon(
        Icons.error,
        color: theme.colorScheme.error,
        size: 22,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 60, 8, 8),
      borderRadius: BorderRadius.circular(8),
      duration: const Duration(milliseconds: 1800),
      backgroundColor: const Color(0xFFFFE0E0),
      messageText: Text(
        message.toString(),
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ).show(context);
  }
}
