import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/global_variables.dart';

class ProductsProcessPage extends StatefulWidget {
  static const String routeName = "products-process-page";
  const ProductsProcessPage({super.key});

  @override
  State<ProductsProcessPage> createState() => _ProductsProcessPageState();
}

class _ProductsProcessPageState extends State<ProductsProcessPage> {
  int index = -1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GroupButton(
            isRadio: true,
            onSelected: (text, indx, isSelected) {
              setState(() {
                index = indx;
              });
            },
            buttons: const ['hamurhane', 'Pastane', 'Börek', 'Dışardan alınan'],
            options: const GroupButtonOptions(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                groupingType: GroupingType.row,
                direction: Axis.horizontal,
                selectedColor: GlobalVariables.secondaryColor,
                unselectedColor: GlobalVariables.secondaryColorLight),
          ),
        ),
        Expanded(child: _setBodyContent())
      ],
    );
  }

  Widget _setBodyContent() {
    switch (index) {
      case 0:
        return _getDoughFactoryProducts();
      case 1:
        return _getProductsByCategory(1);
      case 2:
        return _getProductsByCategory(2);
      case 3:
        return _getProductsByCategory(3);
    }
    return Center(
         child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Lottie.asset('assets/select_animation.json',
                repeat: true, animate: true),
          ),
    );
  }

  _getDoughFactoryProducts() {
    return const Center(
      child: Text('Dough products'),
    );
  }

  _getProductsByCategory(int categoryId) {
    return const Center(
      child: Text('General Products'),
    );
  }

  _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Fırın Ürünler",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          color: Colors.white,
          itemBuilder: (context) {
            List<PopupMenuItem<String>> items = [];
            items.add(const PopupMenuItem<String>(
              value: 'bread-price',
              child: Text('Ekmek Fiyati'),
            ));
            return items;
          },
          onSelected: (value) {
            if (value == 'bread-price') {}
          },
        ),
      ],
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: GlobalVariables.secondaryColor,
      centerTitle: true,
    );
  }
}
