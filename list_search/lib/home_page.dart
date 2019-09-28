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

  Widget _getCustomAppBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: isSearchBarActive ? showSearchBar() : showAppBar());
  }

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

  Future<bool> handleBackButtonPressed() async {
    if (isSearchBarActive) {
      toggleSearchBar(false);
      return false;
    } else
      return true;
  }

  void toggleSearchBar(bool status) {
    setState(() {
      if (!status) searchBarTextController.text = "";
      isSearchBarActive = status;
    });
  }

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

  Widget _getBody() {
    return searchResultData.isEmpty
        ? showResults(initialData)
        : showResults(searchResultData);
  }

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
}
