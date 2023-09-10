import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomeSearchSection extends StatelessWidget {
  final VoidCallback onFilter;
  final ValueChanged<String?>? onSearch;

  const HomeSearchSection({
    super.key,
    required this.onFilter,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FormBuilder(
              child: FormBuilderTextField(
                onSubmitted: onSearch,
                name: 'search',
                decoration: InputDecoration(
                  label: Text('form.search'.tr()),
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          const SizedBox(width: 25.0),
          ElevatedButton(
            onPressed: onFilter,
            style: ElevatedButton.styleFrom(
              maximumSize: const Size(50, 50),
              minimumSize: const Size(50, 50),
              padding: const EdgeInsets.all(0),
            ),
            child: const Icon(Icons.tune, size: 25.0),
          ),
        ],
      ),
    );
  }
}
