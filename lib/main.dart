// import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_app/home_screen.dart';
// import 'package:furniture_app/store_details.dart';
// import 'package:furniture_app/models/store_item_model.dart';
import 'package:furniture_app/utilities/app_textstyle.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furniture App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const FurniturePage(),
    );
  }
}

class FurniturePage extends HookWidget {
  const FurniturePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ?final furnitureList = useState(furnitureItems);
    final tc = useTextEditingController();
    final focusNode = useFocusNode();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      height: 40,
                      width: 40,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      "assets/logos/store logo.jfif",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: tc,
                      textCapitalization: TextCapitalization.sentences,
                      // keyboardAppearance: Brightness.light,
                      autocorrect: true,
                      onTapOutside: (event) {
                        focusNode.unfocus();
                      },
                      focusNode: focusNode,
                      onChanged: (value) {
                        // furnitureList.value = furnitureItems
                        //     .where((element) => element.name
                        //         .toLowerCase()
                        //         .contains(value.toLowerCase()))
                        //     .toList();
                      },
                      style: medium12(context),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        hintText: "What are you looking for...",
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey[900]!,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey[900]!,
                            width: 0.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey[900]!,
                            width: 0.5,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey[900]!,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey[900]!,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTabController(
                length: 4, // Number of tabs
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelPadding: const EdgeInsets.all(0),
                        splashBorderRadius: BorderRadius.circular(10),
                        labelColor: Colors.red,
                        labelStyle:
                            medium11(context).copyWith(color: Colors.red),
                        dividerColor: Colors.grey[300],

                        isScrollable: false, // Makes the tab bar scrollable
                        tabs: [
                          Tab(
                            child: Center(
                              child: Text(
                                "New Stocks",
                                style: medium13(context),
                              ),
                            ),
                          ),
                          Tab(
                              child: Text(
                            "New Stocks",
                            style: medium13(context),
                          )),
                          Tab(
                              child: Text(
                            "Sale",
                            style: medium13(context),
                          )),
                          Tab(
                              child: Text(
                            "Most Ordered",
                            style: medium13(context),
                          )),
                        ],
                      ),
                      // Container to constrain the height of TabBarView
                      const Expanded(
                        // Adjust the height based on content
                        child: TabBarView(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: HomeScreen(),
                              ),
                            ),
                            Center(child: Text("Items Details")),
                            Center(child: Text("Items on Sale")),
                            Center(child: Text("Most Ordered Items")),
                          ],
                        ),
                      ),
                      // ButtonsTabBar(
                      //     // Customize the appearance and behavior of the tab bar
                      //     backgroundColor: Colors.transparent,
                      //     unselectedBackgroundColor: Colors.transparent,
                      //     labelSpacing: 10,
                      //     borderWidth: 0,
                      //     labelStyle: medium16(context),
                      //     unselectedLabelStyle: medium16(context),
                      //     // Add your tabs here
                      //     tabs: const [
                      //       Tab(
                      //         child: Text("Trending"),
                      //       ),
                      //       Tab(
                      //         child: Text("Most Ordered"),
                      //       ),
                      //       Tab(
                      //         child: Text("Favorites"),
                      //       ),
                      //       Tab(
                      //         child: Text("Most Liked"),
                      //       )
                      //     ]),
                      // const Expanded(
                      //   child: TabBarView(
                      //     children: [
                      //       Center(
                      //         child: Icon(Icons.directions_car),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_transit),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_bike),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_car),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
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
