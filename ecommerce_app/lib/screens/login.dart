
import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/network/auth.dart';
import 'package:ecommerce_app/provider/admin_mode.dart';
import 'package:ecommerce_app/screens/admin_home.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  var auth = Auth();

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? adminPass = '112233';

  bool keepLogin=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 49.0,bottom: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height*.2,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/icons/buy.png'),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            child: Text(
                              'Buy it',
                              style: TextStyle(
                                  fontFamily: 'P',
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                    },
                    controller: emailController,
                    cursorColor: backGroundColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      prefix: Icon(Icons.email,color: backGroundColor,),
                      hintText: '  Enter your email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                    },
                    controller: passwordController,
                    cursorColor: backGroundColor,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      prefix: Icon(Icons.lock,color: backGroundColor,),
                      hintText: '  Enter your password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Keep Login',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23
                      ),),
                      Checkbox(
                        value: keepLogin,
                        onChanged: (value){
                          setState(() {
                            keepLogin = value!;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: (){
                       // Navigator.of(context).pushAndRemoveUntil(
                       //     MaterialPageRoute(builder: (context) =>
                       //        HomeScreen()), (
                       //     Route<dynamic> route) => true);
                      valid();
                      if(keepLogin == true){
                       keepUserLogin();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width*.4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadiusDirectional.circular(20),
                      ),
                      child: Text(
                        'Login',
                        style: mainStyle(),

                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\' have any account?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              RegisterScreen()), (Route<dynamic> route) => true);
                        },
                        child: Text(
                          'Register',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              Provider.of<AdminMode>(context,listen: false).changeAdmin(true);
                              print(Provider.of<AdminMode>(context,listen: false).changeAdmin(true));
                            });
                          },
                          child: Text(
                            'I\'am a Admin',
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context,listen: false).isAdmin? backGroundColor : Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              Provider.of<AdminMode>(context,listen: false).changeAdmin(false);
                              print(Provider.of<AdminMode>(context,listen: false).changeAdmin(false));
                            });
                          },
                          child: Text(
                            'I\'am a user',
                            style: TextStyle(
                                color: Provider.of<AdminMode>(context,listen: false).isAdmin? Colors.white: backGroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void valid()async{
    formKey.currentState!.save();
    if(formKey.currentState!.validate() == true) {
      if (passwordController.text == adminPass) {
        print(passwordController);
        try {
         await auth.signIn(passwordController.text, emailController.text);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  AdminHome()), (
              Route<dynamic> route) => true);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
              snack(Colors.red, 'Some Error'));
        }
      }
      else {
        try {
          await auth.signIn(passwordController.text, emailController.text);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  HomeScreen()), (
              Route<dynamic> route) => true);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
              snack(Colors.red, "Some Error"));
        }
      }
    }
  }

   keepUserLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, keepLogin);
   }
}
