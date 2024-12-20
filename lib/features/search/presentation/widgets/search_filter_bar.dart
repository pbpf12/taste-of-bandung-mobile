part of '_widgets.dart';

class SearchFilterBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onTap;
  const SearchFilterBar({
    required this.onChanged,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
              ? Colors.grey : Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.search,
                color: themeProvider.isDarkMode
                  ? Colors.grey.shade800 : Colors.grey.shade700,
                size: 30,
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  cursorColor: themeProvider.isDarkMode
                    ? Colors.white
                    : Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Products',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade900)
                  ),
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.filter_alt_rounded,
                  color: themeProvider.isDarkMode
                    ? Colors.grey.shade800 : Colors.grey.shade700,
                  size: 25,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}