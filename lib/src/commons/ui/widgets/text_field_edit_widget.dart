import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants_utils.dart' show AppConstantsUtils;
import '../../../utils/text_config.dart' show TextConfig;

class TextFieldEditWidget extends StatefulWidget {
  final String? title;
  final String? hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final bool bold;
  final bool titleBold;
  final Color? borderColor;
  final Color? blocColor;
  final Color? indicationTextColor;
  final Function? onChange;
  final Function? onSave;
  final Function? validator;
  final String? obscureCharacter;
  final bool? obscure;
  final String? errorText;
  final String? indicationText;
  final bool tagError;
  final Widget? leftIcon;
  final bool withEraser;
  final bool readOnly;
  final bool withTitleWhenTexting;
  final TextInputAction? textInputAction;
  final Color? inputColor;
  final bool withRadius;
  final int contentFontSize;
  final FontWeight indicatorFontWeight;
  final FontWeight contentFontWeight;
  final bool withTitlePadding;
  final TextAlign textAlign;
  final FocusNode? focusNode;

  const TextFieldEditWidget({
    super.key,
    this.title,
    this.hint,
    required this.controller,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
    this.bold = false,
    this.titleBold = false,
    this.borderColor,
    this.indicationTextColor,
    this.onChange,
    this.onSave,
    this.validator,
    this.obscureCharacter = '•',
    this.obscure = false,
    this.errorText,
    this.indicationText,
    this.tagError = false,
    this.leftIcon,
    this.withEraser = false,
    this.readOnly = false,
    this.withTitleWhenTexting = true,
    this.textInputAction,
    this.blocColor,
    this.inputColor,
    this.withRadius = true,
    this.contentFontSize = 14,
    this.indicatorFontWeight = FontWeight.bold,
    this.contentFontWeight = FontWeight.bold,
    this.withTitlePadding = false,
    this.textAlign = TextAlign.start,
    this.focusNode,
  });

  @override
  State<TextFieldEditWidget> createState() => _TextFieldEditWidgetState();
}

class _TextFieldEditWidgetState extends State<TextFieldEditWidget> {
  bool _isTexting = false;
  bool _hidden = false;
  final FocusNode _focusNode = FocusNode(
    canRequestFocus: false,
    descendantsAreFocusable: false,
  );

  @override
  void initState() {
    super.initState();
    _hidden = widget.obscure!;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isTexting = true;
        });
      } else {
        setState(() {
          _isTexting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          const SizedBox(height: AppConstantsUtils.widgetSpacingSmall),
          Text(
            widget.title!,
            style: TextConfig.getSimpleTextStyle(widget.titleBold,
                size: AppConstantsUtils.subTitleSize),
          ).paddingSymmetric(
              horizontal: widget.withTitlePadding
                  ? AppConstantsUtils.scaffoldHPadding
                  : 0.0),
          const SizedBox(height: AppConstantsUtils.widgetSpacingSmall),
        ],
        if (_isTexting &&
            widget.hint != null &&
            widget.hint!.isNotEmpty &&
            widget.withTitleWhenTexting) ...[
          Text(
            widget.hint!,
            style: TextConfig.getSimpleTextStyle(widget.titleBold),
          ).paddingSymmetric(
              horizontal: widget.withTitlePadding
                  ? AppConstantsUtils.scaffoldHPadding
                  : 0.0),
          const SizedBox(height: AppConstantsUtils.widgetSpacingSmall),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          widget.withRadius ? AppConstantsUtils.radius : 0),
                      color: widget.inputColor ??
                          Theme.of(context).colorScheme.surface,
                    ),
                    child: TextFormField(
                      controller: widget.controller,
                      keyboardType: widget.keyboardType ?? TextInputType.text,
                      style: TextConfig.getSimpleTextStyle(widget.bold,
                          size: widget.contentFontSize,
                          fontWeight: widget.contentFontWeight),
                      textInputAction: widget.textInputAction,
                      minLines: widget.minLines,
                      maxLines: widget.maxLines,
                      readOnly: widget.readOnly,
                      textAlign: widget.textAlign,
                      scrollPadding: const EdgeInsets.all(00.0),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hint,
                        fillColor: Colors.blue,
                        focusColor: Colors.black12,
                        labelStyle: TextConfig.getSimpleTextStyle(
                          widget.titleBold,
                          color: Theme.of(context).hintColor,
                        ),
                        errorStyle: TextConfig.getSimpleTextStyle(
                          widget.titleBold,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        hintStyle: TextConfig.getSimpleTextStyle(
                          widget.titleBold,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      focusNode: widget.focusNode ?? _focusNode,
                      obscureText: _hidden,
                      onTap: () {},
                      onChanged: (value) {
                        if (widget.onChange != null) widget.onChange!(value);
                      },
                      validator: (value) {
                        if (widget.validator != null) {
                          return widget.validator!(value);
                        } else {
                          return null;
                        }
                      },
                      onEditingComplete: () {
                        widget.focusNode?.unfocus(); 
                        _focusNode.unfocus();
                        if (widget.onSave != null) widget.onSave!();
                      },
                    ),
                  ),
                  if (widget.indicationText != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      widget.indicationText!,
                      style: TextConfig.getSimpleTextStyle(
                        widget.titleBold,
                        size: AppConstantsUtils.smallSize,
                        fontWeight: widget.indicatorFontWeight,
                        color: widget.indicationTextColor,
                      ),
                    ).paddingSymmetric(
                        horizontal: widget.withTitlePadding
                            ? AppConstantsUtils.scaffoldHPadding
                            : 0.0),
                  ],
                  if (widget.tagError && widget.errorText != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      widget.errorText!,
                      style: TextConfig.getSimpleTextStyle(
                        true,
                        size: AppConstantsUtils.smallSize,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ).paddingSymmetric(
                        horizontal: widget.withTitlePadding
                            ? AppConstantsUtils.scaffoldHPadding
                            : 0.0),
                  ]
                ],
              ),
            ),
            if ((widget.withEraser && _focusNode.hasFocus))
              if (!widget.obscure!)
                InkWell(
                  onTap: () {
                    widget.controller.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                          widget.withRadius ? BorderRadius.circular(4) : null,
                    ),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                )
              else
                InkWell(
                  onTap: () {
                    setState(() {
                      _hidden = !_hidden;
                    });
                  },
                  child: _hidden
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
          ],
        ).paddingSymmetric(
            horizontal: widget.withTitlePadding
                ? AppConstantsUtils.containerHPadding
                : 0.0),
      ],
    );
  }
}
