import 'package:flutter/material.dart';

import '../../../../../core/constants/global_variables.dart';

class MarketsProcessPage extends StatefulWidget {
  static const String routeName = "markets-process-page";

  const MarketsProcessPage({super.key});

  @override
  State<MarketsProcessPage> createState() => _MarketsProcessPageState();
}

class _MarketsProcessPageState extends State<MarketsProcessPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _buildAppbar(),
          body: _buildBody(),
        ));
  }

  _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text('Market işlemleri',style: TextStyle(color: Colors.white),),
      centerTitle: true,
       shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: GlobalVariables.secondaryColor,
      bottom: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            text: 'Marketler',
          ),
          Tab(
            text: 'Sözleşmeler',
          ),
          Tab(
            text: 'Market Ürünleri',
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return const TabBarView(children: [
      Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
    ]);
  }
}
