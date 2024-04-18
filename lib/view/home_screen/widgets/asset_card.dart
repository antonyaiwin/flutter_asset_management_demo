import 'package:flutter/material.dart';
import 'package:flutter_asset_management/controller/add_data_controller.dart';
import 'package:flutter_asset_management/controller/home_screen_controller.dart';
import 'package:flutter_asset_management/view/add_asset_screen/add_asset_screen.dart';
import 'package:provider/provider.dart';

import '../../../model/asset_model.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.asset,
  });
  final AssetModel asset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 214, 154),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  asset.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(asset.assetType),
              ),
            ],
          ),
          Text(asset.description),
          Text('Serial No: ${asset.serialNumber}'),
          if (asset.otherInfo.isNotEmpty)
            Text('Other Info: ${asset.otherInfo}'),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: asset.isAvailable ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  asset.isAvailable ? 'Available' : 'Not Available',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => AddDataController(asset: asset),
                          child: const AddAssetScreen(),
                        ),
                      ));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.read<HomeScreenController>().deleteData(asset);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
