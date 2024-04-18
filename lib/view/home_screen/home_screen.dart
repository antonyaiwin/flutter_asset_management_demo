import 'package:flutter/material.dart';
import 'package:flutter_asset_management/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../controller/add_data_controller.dart';
import '../add_asset_screen/add_asset_screen.dart';
import 'widgets/asset_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeScreenController>().initDB();
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text('Assets'),
      ),
      body: Consumer<HomeScreenController>(
        builder: (context, value, child) {
          if (value.assetList.isEmpty) {
            return const Center(
              child: Text('No data Found'),
            );
          } else {}
          return ListView.separated(
            padding: const EdgeInsets.all(8).copyWith(bottom: 100),
            itemBuilder: (context, index) {
              return AssetCard(
                asset: value.assetList[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: value.assetList.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (BuildContext context) => AddDataController(),
                child: const AddAssetScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
