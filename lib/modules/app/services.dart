import 'package:flutter/material.dart';
import 'package:solo_api/common.dart';

Future<bool?> updateApiFolder(
  BuildContext context,
  Realm realm, {
  APIFolder? folder,
}) {
  return showActionDialog<bool>(
    context: context,
    dismissWithEsc: true,
    builder: (context) {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController(text: folder?.name);
      return ContentDialog(
        title: Text(folder == null ? 'Add a project' : 'Update project name'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormTextBox(
                controller: controller,
                placeholder: 'Project name',
                validator: (value) {
                  if (emptyString(value)) {
                    return 'The name is required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final value = controller.text.trim();
                realm.write(() {
                  if (folder != null) {
                    folder.name = value;
                  } else {
                    realm.add(
                      APIFolder(ObjectId(), value),
                    );
                  }
                });
                Navigator.of(context).pop(true);
              }
            },
            child: Text(folder == null ? 'Create' : 'Update'),
          )
        ],
      );
    },
  );
}
