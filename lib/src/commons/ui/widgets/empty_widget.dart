import 'package:flutter/material.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../utils/text_config.dart' show TextConfig;


class EmptyWidget extends StatelessWidget {

  final String title;
  final String? subtitle;
  final IconData? iconData;

  const EmptyWidget({ 
    super.key,
    required this.title,
    this.subtitle,
    this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(iconData != null)
          Icon(iconData, size: 100),
        Text(title,
          textAlign: TextAlign.center,
          style: TextConfig.getSimpleTextStyle(true, size: AppConstantsUtils.subTitleSize),
        ),
        if(subtitle != null)...[
          Text(subtitle ?? '',
            textAlign: TextAlign.center,
            style: TextConfig.getSimpleTextStyle(
              true,
              fontStyle: FontStyle.normal,
              color: Colors.grey.withValues(alpha: .9),
            ),
          ),
        ],
      ],
    );
  }
}