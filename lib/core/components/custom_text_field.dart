import 'package:flutter/material.dart';
import '../style/app_text_style/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String> validator;
  final bool obsecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool isMulti;
  final bool autofocus;
  final bool enabled;
  final String? errorText;
  final String label;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;
  final bool? isDroped;
  final VoidCallback? onDrop;
  final bool isArabic;

  const CustomTextField({super.key, 
    this.controller,
    required this.validator,
    this.onDrop,
    this.keyboardType = TextInputType.text,
    this.obsecure = false,
    this.isDroped = false,
    this.onTap,
    this.hint,
    this.isMulti = false,
    this.readOnly = false,
    this.autofocus = false,
    this.errorText,
    required this.label,
    this.suffix,
    this.prefix,
    this.enabled = true,
    this.onEditingCompleted,
    this.onChanged,
    this.isArabic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment:
            (isArabic) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.darkGreyStyle(size: 14),
            textDirection: (isArabic) ? TextDirection.rtl : TextDirection.ltr,
          ),
          const SizedBox(
            height: 10,
          ),
          (!isDroped!)
              ? TextFormField(
                  onChanged: onChanged,
                  keyboardType: keyboardType,
                  controller: controller,
                  enabled: enabled,

                  readOnly: readOnly,
                  textDirection:
                      (isArabic) ? TextDirection.rtl : TextDirection.ltr,
                  style: (enabled) ? null : AppTextStyle.greyStyle(size: 14),
                  decoration: InputDecoration(
                    errorMaxLines: 7,
                    hintText: hint,
                    hintStyle: AppTextStyle.darkGreyStyle(size: 12),
                    hintTextDirection:
                        (isArabic) ? TextDirection.rtl : TextDirection.ltr,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    return validator(value);
                  },
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: (!isArabic)
                        ? [
                            (hint != null)
                                ? Text(hint!,
                                    style: AppTextStyle.darkGreyStyle())
                                : Container(),
                            IconButton(
                                onPressed: () {
                                  if (onDrop != null) onDrop!();
                                },
                                icon: const Icon(Icons.keyboard_arrow_down))
                          ]
                        : [
                            IconButton(
                                onPressed: () {
                                  if (onDrop != null) onDrop!();
                                },
                                icon: const Icon(Icons.keyboard_arrow_down)),
                            (hint != null)
                                ? Text(hint!,
                                    style: AppTextStyle.darkGreyStyle())
                                : Container(),
                          ],
                  ),
                )
        ],
      ),
    );
  }
}
