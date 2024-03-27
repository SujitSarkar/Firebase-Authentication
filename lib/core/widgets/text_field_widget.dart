import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_color.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.onTap,
      this.obscure = false,
      this.readOnly = false,
      this.required = false,
      this.textInputType,
      this.textCapitalization,
      this.textAlign = TextAlign.left,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixColor,
      this.prefixColor,
      this.maxLine,
      this.minLine,
      this.validationErrorMessage,
      this.maxLength,
      this.suffixOnTap,
      this.prefixOnTap,
      this.onChanged,
      this.onEditingComplete,
      this.contentPadding,
      this.focusNode});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Color? prefixColor;
  final TextAlign? textAlign;
  final bool obscure;
  final bool required;
  final bool readOnly;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final String? validationErrorMessage;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? suffixOnTap;
  final Function()? prefixOnTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      validator: (val) => !widget.required || val != null && val.isNotEmpty
          ? null
          : "${widget.labelText} can't be empty",
      controller: widget.controller,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
      },
      maxLength: widget.maxLength,
      onEditingComplete: widget.onEditingComplete,
      readOnly: widget.readOnly,
      obscureText: widget.obscure ? _obscure : false,
      keyboardType: widget.textInputType ?? TextInputType.text,
      textCapitalization:
          widget.textCapitalization ?? TextCapitalization.none,
      maxLines: widget.maxLine ?? 1,
      minLines: widget.minLine ?? 1,
      textAlign: widget.textAlign!,
      style: TextStyle(
          color: AppColor.textColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp),
      decoration: InputDecoration(
          errorText: widget.validationErrorMessage,
          alignLabelWithHint: true,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldUnderlineColor,width: 2.sp)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldUnderlineColor,width: 2.sp)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldUnderlineColor,width: 2.sp)),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.errorColor,width: 2.sp)),
          isDense: true,
          contentPadding: widget.contentPadding ?? EdgeInsets.only(top: 12.w,right: 12.w,bottom: 12.w),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: widget.hintText,
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintStyle: TextStyle(
              color: const Color(0xffB5B5B5),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp),
          labelStyle: TextStyle(
              color: AppColor.textFieldHintColor,
              fontSize: 16.sp),
          prefixIcon: widget.prefixIcon != null
              ? InkWell(
                  onTap: widget.prefixOnTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w, left: 10.w),
                    child: Icon(widget.prefixIcon,
                        size: 20.sp,
                        color: widget.prefixColor ?? AppColor.primaryColor),
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints.loose(size),
          prefixIconConstraints: BoxConstraints.loose(size),
          suffixIcon: widget.obscure
              ? InkWell(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                        _obscure
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        size: 20.sp,
                        color: widget.suffixColor ?? AppColor.textFieldHintColor),
                  ),
                )
              : InkWell(
                  onTap: widget.suffixOnTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(widget.suffixIcon, size: 28.sp),
                  ),
                )),
    );
  }
}
