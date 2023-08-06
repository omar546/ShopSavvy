import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,automaticallyImplyLeading: true,showBrand: false,),
      body: Center(child: Text('searchScreen')),
    );
  }
}
