part of '_widgets.dart';

class FilterQuery {
  String category;
  String sortBy;
  String priceMax;
  String priceMin;

  FilterQuery({
    required this.category,
    required this.sortBy,
    required this.priceMin,
    required this.priceMax,
  });
}

class FilterDialog extends StatefulWidget {
  final FilterQuery query;

  const FilterDialog({
    required this.query, 
    super.key
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late FilterQuery query;
  String selectedSort = '';
  String selectedCategory = '';
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  bool isPriceRangeError = false;

  @override
  void initState(){
    query = widget.query;

    selectedSort = query.sortBy;
    selectedCategory = query.category;
    minPriceController.text = query.priceMin.toString();
    maxPriceController.text = query.priceMax.toString();
    minPriceController.addListener(() {
      query.priceMin = minPriceController.text;});
    maxPriceController.addListener(() {
      query.priceMax = maxPriceController.text;});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Dialog(
      backgroundColor: themeProvider.isDarkMode
        ? Colors.grey.shade900 : Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.white)
      ),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20, right: 20,
            bottom: 20, top: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Options',
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                        ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.cancel),
                  )
                ],
              ),
              const SizedBox(height: 25),

              Text(
                'Sort By',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                    ? Colors.white : Colors.black
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.isDarkMode
                      ? Colors.white : Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSort,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSort = newValue!;
                        query.sortBy = selectedSort;
                      });
                    },
                    isExpanded: true,
                    items: <String>['', 'cheapest', 'most_expensive']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value == ""
                            ? "~~~~~~~"
                            : value
                              .replaceAll('_', ' ')
                              .split(' ')
                              .map((word) => word[0].toUpperCase() + word.substring(1))
                              .join(' '),
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                               ? Colors.white : Colors.black
                            ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Category',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                    ? Colors.white : Colors.black
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<String>(
                    value: '',
                    groupValue: selectedCategory,
                    activeColor: Colors.brown,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                        query.category = selectedCategory;
                      });
                    },
                  ),
                  Text('~Both~', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: themeProvider.isDarkMode
                        ? Colors.white : Colors.black
                    ),
                  ),
                  Radio<String>(
                    value: '1',
                    groupValue: selectedCategory,
                    activeColor: Colors.brown,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                        query.category = selectedCategory;
                      });
                    },
                  ),
                  Text(
                    'Food',
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                        ? Colors.white : Colors.black
                    ),
                  ),
                  Radio<String>(
                    value: '2',
                    groupValue: selectedCategory,
                    activeColor: Colors.brown,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                        query.category = selectedCategory;
                      });
                    },
                  ),
                  Text(
                    'Drink',
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                            ? Colors.white : Colors.black),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                'Price Range',
                style: TextStyle(
                  color: themeProvider.isDarkMode
                    ? Colors.white : Colors.black
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: minPriceController,
                      cursorColor: themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Min Price',
                        labelStyle: TextStyle(
                          color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black
                          )
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, 
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: maxPriceController,
                      cursorColor: themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Max Price',
                        labelStyle: TextStyle(
                          color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: isPriceRangeError
                            ? Colors.red
                            : themeProvider.isDarkMode
                              ? Colors.white : Colors.black)
                        ),
                        
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, 
                      ],
                    ),
                  ),
                ],
              ),
              if (isPriceRangeError == true)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Min Price < Max Price',
                      style: TextStyle(
                        color: Colors.red),
                    ),
                  ],
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (query.priceMax != "" && query.priceMin != "") {
                    if (num.tryParse(query.priceMax)! 
                          > num.tryParse(query.priceMin)!) {
                      Navigator.pop(context, query);
                    } else {setState(() {isPriceRangeError = true;});}
                  } else {
                    Navigator.pop(context, query);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: themeProvider.isDarkMode
                      ? Colors.brown.shade900 : Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text(
                  'SEARCH',
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                      ? null : Colors.amber.shade50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
