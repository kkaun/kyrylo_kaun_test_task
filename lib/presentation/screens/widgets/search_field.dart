import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final void Function(String) onEdit;
  final void Function() onClear;

  const SearchField({Key? key, required this.onEdit, required this.onClear}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSearchField();
  }

  TextField _buildSearchField() {
    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      onChanged: (value) {
        if (value.length > 3) {
          widget.onEdit(value);
        }
      },
      onSubmitted: (value) {
        if (value.length <= 3) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Please enter at least 4 characters')));
        }
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.text = '';
                widget.onClear();
              });
            },
          ),
          hintText: 'Search...',
          border: InputBorder.none),
    );
  }
}
