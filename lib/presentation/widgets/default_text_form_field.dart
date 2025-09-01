import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  String? prefixIconImage;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String?Function(String?)?validator;
  bool isPassword;

  DefaultTextFormField({
   required this.hintText,
   this.isPassword=false,
   this.validator,
   this.controller,
   this.onChanged,
   this.prefixIconImage
});

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {

late bool isObscure=widget.isPassword;
  @override
  Widget build(BuildContext context) {
   return TextFormField(
controller:widget.controller,
onChanged: widget.onChanged,
     decoration: InputDecoration(hintText: widget.hintText,
     prefixIcon:widget.prefixIconImage==null?null:SvgPicture.asset(
'assets/icons/${widget.prefixIconImage}.svg',
   width: 24,
     height: 24,
       fit: BoxFit.scaleDown,
     ),
     suffixIcon:widget.isPassword?IconButton(onPressed:(){
       isObscure=!isObscure;
       setState(() {});
     } , icon:Icon(isObscure?Icons.visibility_outlined:Icons.visibility_off_outlined,
     ),style: IconButton.styleFrom(foregroundColor:AppColors.whiteColor), ):null,
       focusedBorder:OutlineInputBorder(
         borderRadius: BorderRadius.circular(16),
         borderSide:BorderSide(color:Colors.transparent),
       ),
       enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide:BorderSide(color:Colors.transparent)
       ),
       focusedErrorBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide:BorderSide(color:Colors.transparent)
       ),
       errorBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(16),
           borderSide:BorderSide(color:Colors.transparent)
       ) ,
       border: InputBorder.none,
       fillColor:AppColors.greyColor,
       filled: true
     ),
     validator: widget.validator,
     obscureText: isObscure,
     autovalidateMode: AutovalidateMode.onUserInteraction,
     onTapOutside: (_)=>FocusManager.instance.primaryFocus?.unfocus(),
     cursorColor: AppColors.whiteColor,
     cursorErrorColor: AppColors.redColor,
   );
  }
}
