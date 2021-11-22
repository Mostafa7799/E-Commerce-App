
import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/network/auth.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var formKey = GlobalKey<FormState>();

  var auth = Auth();


  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
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
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                    },
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                    },
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: nameController,
                    cursorColor: backGroundColor,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This Field is required';
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      prefix: Icon(Icons.person,color: backGroundColor,),
                      hintText: '  Enter your Name',
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  Builder(
                    builder: (context) => InkWell(
                      onTap: (){
                          if(formKey.currentState!.validate() == true) {
                            auth.signUp(
                                passwordController.text, emailController.text)
                                .then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) =>
                                      LoginScreen()), (
                                  Route<dynamic> route) => true);
                              print(emailController.text);
                            }).catchError((e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  snack(Colors.red, e.message));
                            });
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
                          'Register Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
