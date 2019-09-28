import 'package:flutter/material.dart';
import 'package:list_search/search_results.dart';
import 'models/data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSearchBarActive = false;
  TextEditingController searchBarTextController;

  List<Data> searchResultData = [];
  List<Data> initialData = [];

  @override
  void initState() {
    super.initState();
    searchBarTextController = TextEditingController();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButtonPressed,
      child: Scaffold(
        appBar: _getCustomAppBar(),
        body: _getBody(),
      ),
    );
  }

/// This method displays a custom App bar that contains both Search bar and App bar and switches between them as needed.
  Widget _getCustomAppBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: isSearchBarActive ? showSearchBar() : showAppBar());
  }

/// This method displays the App bar with a Title and Search icon Button
  Widget showAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              toggleSearchBar(true);
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

/// Handles Back button tap i.e.
/// When the Search Bar is visible, on Backbutton tap it wont exit the application but closes the search bar
/// When  the search bar is Hidden, On back button tap it will exit the application.
  Future<bool> handleBackButtonPressed() async {
    if (isSearchBarActive) {
      toggleSearchBar(false);
      return false;
    } else
      return true;
  }

/// Acts as a method to toggle the visibility of the Search Bar (show/hide)
  void toggleSearchBar(bool status) {
    searchResultData.clear();
    setState(() {
      if (!status) searchBarTextController = TextEditingController();
      isSearchBarActive = status;
    });
  }

/// Displays the search Bar with a TextField inside it.
  Widget showSearchBar() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          height: 56,
          child: TextField(
            controller: searchBarTextController,
            onChanged: onSearchBarTextChanged,
            style: TextStyle(color: Colors.white),
            autofocus: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(top: 20, left: 20),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              hintText: "Start Typing here...",
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  toggleSearchBar(false);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

/// Implements the Text Search inside the list when user types inside the Text Field.
  void onSearchBarTextChanged(String textToBeSearched) {
    searchResultData = initialData
        .where(
          (data) => data.title.toLowerCase().contains(
                textToBeSearched.toLowerCase(),
              ),
        )
        .toList();

    setState(() {});
  }

/// Displays the Results (List Items)
  Widget showResults(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListData(
          data[index].title,
          data[index].subTitle,
        );
      },
    );
  }

/// The Body that a user sees.
  Widget _getBody() {
    if (isSearchBarActive && searchResultData.isNotEmpty)
      return showResults(searchResultData);
    else if (searchResultData.isEmpty && isSearchBarActive && searchBarTextController.text.isNotEmpty)
      return showNoResultsFoundWidget();
    else
      return showResults(initialData);
  }

/// loadData() is a sample method that loads sample data into the list (initialData variable)
  void loadData() {
    initialData = [
      Data('sample', "sample meaning1"),
      Data('house', "Place to stay"),
      Data('vehicle', "thing to travel"),
      Data('mobile', "communication instrument"),
      Data('Other', "Other"),
    ];
    setState(() {});
  }

/// Shows No results Found Message when there is no relevant data.
  Widget showNoResultsFoundWidget() {
    return Center(
      child: Text(
        "No Results Found",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
