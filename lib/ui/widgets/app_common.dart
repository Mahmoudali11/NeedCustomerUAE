import 'package:flutter/material.dart';

import '../../bl/blocs/theme/app_theme_cubit.dart';
import '../../generated/l10n.dart';

class NameValueText extends StatelessWidget {
  final String name;
  final String? value;

  const NameValueText({
    super.key,
    required this.name,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: AppTheme.paddingMarginES,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: AppTheme.paddingMarginES,
                height: 15,
                width: 2,
                color: AppTheme.mainColor,
              ),
              Text("$name: ", style: textTheme.bodyMedium),
            ],
          ),
          Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
            value ?? "",
            maxLines: 15,
            style: textTheme.bodyMedium,
          ),
              )),
        ],
      ),
    );
  }
}

class Titles extends StatelessWidget {
  final String name;

  const Titles({
    super.key,
    required this.textTheme,
    required this.name,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.paddingMarginS.copyWith(left: 0, right: 0),
      child: Text(
        name,
        style: textTheme.headlineMedium,
      ),
    );
  }
}

class CustomProgressIndicatorL extends StatelessWidget {
  const CustomProgressIndicatorL({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class CustomProgressIndicatorM extends StatelessWidget {
  const CustomProgressIndicatorM({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 3,
          )),
    );
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController search;
  final Function(String? text)? onChange;

  const SearchWidget({
    super.key,
    required this.search,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.paddingMarginM.copyWith(top: 0, bottom: 0),
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(AppTheme.borderRL),
          border: Border.all(color: AppTheme.secondColor)),
      child: TextField(
        controller: search,
        onChanged: onChange,
        decoration:   InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.grey
          ),
          hintText: S.of(context).whatYouWant,
            border: InputBorder.none, suffixIcon: Icon(Icons.search_outlined)),
      ),
    );
  }
}
