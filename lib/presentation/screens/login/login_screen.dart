import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/presentation/widgets/default_text_form_field.dart';
import 'package:movies_app/presentation/widgets/language_switcher.dart';


class LoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  bool isEnglish=true;

  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // resizeToAvoidBottomInset:true,
        body:  Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Center(
                  child:
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height:50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextFormField(hintText:'Email',
                  controller: emailController,
                    prefixIconImage: 'email_icon',
                    validator: (value){
                    if(value==null||value.length<5)
                    {  return'Invalid Email';}
                    else
                      {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTextFormField(hintText: 'Password',
                  prefixIconImage:'password_icon',
                  controller: passwordController,
                  validator: (value){
                    if(value==null||value.length<8)
                      {
                        return'Password must be at least 8 characters';
                      }
                    else
                      {
                        return null;
                      }
                  },
                    isPassword: true,
                  ),
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child:Text('Forget Password?',style:
                      Theme.of(context).textTheme.titleSmall!.copyWith(color:AppColors.yellowPrimaryColor),),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                SizedBox(width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(onPressed: (){}, child:
                    Text('Login',style:Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.blackPrimaryColor),),
                      style: ElevatedButton.styleFrom(backgroundColor:AppColors.yellowPrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account?"),
                    TextButton(onPressed: (){}, child:Text('Create One',style:
                    Theme.of(context).textTheme.titleSmall!.copyWith(color:AppColors.yellowPrimaryColor),),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(children: [
                  Expanded(
                    child: Divider(color: AppColors.yellowPrimaryColor,
                      thickness: 1,
                      indent:50,
                    endIndent: 10,),
                  ),
                  Text('OR',style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.yellowPrimaryColor),),
                  Expanded(
                    child: Divider(color: AppColors.yellowPrimaryColor,
                      thickness: 1,
                      indent: 10,
                      endIndent:50,),
                  ),
                ],),
            SizedBox(height:16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(onPressed: (){}, child:
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset('assets/icons/google_icon.svg'),
                      SizedBox(width:8 ,),
                      Text('Login With Google',style:Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.blackPrimaryColor),),
                    ],
                  ),
                    style: ElevatedButton.styleFrom(backgroundColor:AppColors.yellowPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  ),
                ),
                SizedBox(height: 16,),
            LanguageSwitcher()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
