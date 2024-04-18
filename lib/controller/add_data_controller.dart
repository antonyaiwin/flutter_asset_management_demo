import 'package:flutter/material.dart';
import 'package:flutter_asset_management/controller/home_screen_controller.dart';
import 'package:flutter_asset_management/model/asset_model.dart';
import 'package:provider/provider.dart';

class AddDataController extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController serialNoController = TextEditingController();
  TextEditingController otherInfoController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isAvailable = true;
  final AssetModel? asset;
  List<String> assetTypeList = [
    'Motor Vehicle',
    'Laptop',
    'Property',
    'House',
    'Other',
  ];
  String? selectedAssetType;

  AddDataController({this.asset}) {
    if (asset != null) {
      titleController.text = asset!.title;
      descriptionController.text = asset!.description;
      serialNoController.text = asset!.serialNumber;
      otherInfoController.text = asset!.otherInfo;
      isAvailable = asset!.isAvailable;
      selectedAssetType = asset!.assetType;
    }
  }

  void isAvailableChanged(bool value) {
    isAvailable = value;
    notifyListeners();
  }

  addDataToDb(BuildContext context) async {
    if (asset == null) {
      await context.read<HomeScreenController>().addData(
            AssetModel(
              title: titleController.text,
              description: descriptionController.text,
              serialNumber: serialNoController.text,
              assetType: selectedAssetType!,
              isAvailable: isAvailable,
              otherInfo: otherInfoController.text,
            ),
          );
    } else {
      await context.read<HomeScreenController>().updateData(
            AssetModel(
              id: asset!.id,
              title: titleController.text,
              description: descriptionController.text,
              serialNumber: serialNoController.text,
              assetType: selectedAssetType!,
              isAvailable: isAvailable,
              otherInfo: otherInfoController.text,
            ),
          );
    }
  }
}
