import 'package:flutter/material.dart';
import 'package:flutter_asset_management/controller/add_data_controller.dart';
import 'package:provider/provider.dart';

class AddAssetScreen extends StatelessWidget {
  const AddAssetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Assets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: context.read<AddDataController>().formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: context.read<AddDataController>().titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:
                      context.read<AddDataController>().descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:
                      context.read<AddDataController>().serialNoController,
                  decoration: const InputDecoration(labelText: 'Serial Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a serial number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: context.read<AddDataController>().selectedAssetType,
                  decoration:
                      const InputDecoration(label: Text('Select a type')),
                  items: context
                      .read<AddDataController>()
                      .assetTypeList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    context.read<AddDataController>().selectedAssetType = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type';
                    } else {
                      return null;
                    }
                  },
                ),
                Consumer<AddDataController>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        RadioListTile(
                          value: true,
                          groupValue:
                              context.read<AddDataController>().isAvailable,
                          onChanged: (value) {
                            context
                                .read<AddDataController>()
                                .isAvailableChanged(value!);
                          },
                          title: const Text('Available'),
                        ),
                        RadioListTile(
                          value: false,
                          groupValue:
                              context.read<AddDataController>().isAvailable,
                          onChanged: (value) {
                            context
                                .read<AddDataController>()
                                .isAvailableChanged(value!);
                          },
                          title: const Text('Not Available'),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller:
                      context.read<AddDataController>().otherInfoController,
                  decoration:
                      const InputDecoration(labelText: 'Other Information'),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    if (context
                        .read<AddDataController>()
                        .formKey
                        .currentState!
                        .validate()) {
                      await context
                          .read<AddDataController>()
                          .addDataToDb(context);
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              context.read<AddDataController>().asset == null
                                  ? 'Data added Successfully'
                                  : 'Data edited successfully.')));
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        context.read<AddDataController>().asset == null
                            ? 'Add Asset'
                            : 'Save Asset',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
