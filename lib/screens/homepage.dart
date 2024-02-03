import 'package:boycotpp_app/screens/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List foundBrand = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foundBrand = data;
  }

  void checkBrand(String keyword) {
    List results = [];
    if (keyword.isEmpty) {
      results = data;
    } else {
      results = foundBrand
          .where((element) =>
              element["name"].toLowerCase().startsWith(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundBrand = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Boycott App",
            style: TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(labelColor: Colors.white, tabs: [
            Tab(
              text: "Search Brand",
              icon: Icon(Icons.search),
            ),
            Tab(
              text: "Dua For Plaestenians",
              icon: Icon(Icons.favorite),
            )
          ]),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // const Padding(
                //   padding:
                //       EdgeInsets.only(top: 20, bottom: 20, right: 8, left: 8),
                //   child: Text(
                //     "Assala-mu-Alikum! Dear Brothers and Sisters",
                //     style: TextStyle(fontSize: 16),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController,
                    onChanged: (value) => checkBrand(value),
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black)),
                      labelText: "Search..",
                      labelStyle: const TextStyle(color: Colors.black),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: foundBrand.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                leading: Text(
                                  "${index + 1}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                title: Text(
                                  foundBrand[index]["name"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ));
                      }),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Expanded(
                  child:
                      SfPdfViewer.asset("assets/Duas for Palestine (1).pdf")),
            ],
          )
        ]),
      ),
    );
  }
}
