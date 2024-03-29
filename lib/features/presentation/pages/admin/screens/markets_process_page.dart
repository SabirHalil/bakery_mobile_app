import 'package:bakery_app/features/data/models/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/global_variables.dart';
import '../../../widgets/custom_product_process_dialog.dart';
import '../../../widgets/empty_content.dart';
import '../../../widgets/error_animation.dart';
import '../../../widgets/loading_indicator.dart';
import '../bloc/markets_process/markets_process_bloc.dart';

class MarketsProcessPage extends StatefulWidget {
  static const String routeName = "markets-process-page";

  const MarketsProcessPage({super.key});

  @override
  State<MarketsProcessPage> createState() => _MarketsProcessPageState();
}

enum Filters { all, justActive }

class _MarketsProcessPageState extends State<MarketsProcessPage> {
  Filters? _filters = Filters.all;
  List<MarketModel> marketList = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _buildAppbar(),
          body: _buildBody(),
        ));
  }

  _buildAppbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'Market işlemleri',
        style: TextStyle(color: Colors.white),
      ),
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
        ],
      ),
    );
  }

  _buildBody() {
    return TabBarView(children: [
      _getMarkets(),
      Icon(Icons.directions_transit),
    ]);
  }

  _getMarkets() {
    context.read<MarketsProcessBloc>().add(GetMarketsProcesssRequested());
    return BlocBuilder<MarketsProcessBloc, MarketsProcessState>(
        builder: ((context, state) {
      if (state is MarketsProcessSuccess) {
        if (_filters == Filters.justActive) {
          marketList = state.marketsProcessList!
              .where((market) => market.isActive)
              .toList();
        } else {
          marketList = state.marketsProcessList!;
        }
      }

      return switch (state) {
        MarketsProcessLoading() => const LoadingIndicator(),
        MarketsProcessFailure() => const ErrorAnimation(),
        MarketsProcessSuccess() => marketList.isEmpty
            ? const EmptyContent()
            : Column(
                children: [
                  ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(children: [
                            Radio<Filters>(
                              activeColor: GlobalVariables.secondaryColor,
                              value: Filters.all,
                              groupValue: _filters,
                              onChanged: (Filters? value) {
                                setState(() {
                                  _filters = value;
                                });
                              },
                            ),
                            const Expanded(child: Text('Hepsi'))
                          ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(children: [
                            Radio<Filters>(
                              activeColor: GlobalVariables.secondaryColor,
                              value: Filters.justActive,
                              groupValue: _filters,
                              onChanged: (Filters? value) {
                                setState(() {
                                  _filters = value;
                                });
                              },
                            ),
                            const Expanded(child: Text('Aktif'))
                          ]),
                        ),
                      ],
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: GlobalVariables.secondaryColorLight,
                      child: IconButton(
                          onPressed: () => _marketDialog(null), icon: const Icon(Icons.add)),
                    ),
                  ),
                  Expanded(
               
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: ListView.builder(
                        itemCount: marketList.length,
                        itemBuilder: (context, index) {
                          return Material(
                            child: ListTile(
                              tileColor: index.isOdd
                                  ? GlobalVariables.oddItemColor
                                  : GlobalVariables.evenItemColor,
                              title: Text(marketList[index].name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _marketDialog(marketList[index]);
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: GlobalVariables.secondaryColor,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: marketList[index].isActive
                                        ? Colors.green
                                        : Colors.red,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      };
    }));
  }

  _marketDialog(MarketModel? market) {
    TextEditingController nameController = TextEditingController();
    if (market != null) {
      nameController.text = market.name.toString();
    }
    String title = market != null ? "Market Güncelleme" : "Market Ekleme";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomProductProcessDialog(
              title: title,
              nameController: nameController,
              onSave: (status, name, number) {
                if (market != null) {
                  if (status == market.isActive && name == market.name) {
                    return;
                  }
                  context.read<MarketsProcessBloc>().add(
                      UpdateMarketsProcessRequested(
                          market: MarketModel(
                              id: market.id, name: name, isActive: status)));
                } else {
                   context.read<MarketsProcessBloc>().add(
                      AddMarketsProcessRequested(
                          market: MarketModel(
                              id: 0, name: name, isActive: status)));
                }
              },
              status: market?.isActive ?? true);
        });
  }
}
