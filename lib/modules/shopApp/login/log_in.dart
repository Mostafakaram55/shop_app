import 'package:bordered_text/bordered_text.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_App/login_model.dart';
import 'package:shop_app/modules/shopApp/register/registerscreen.dart';
import 'package:shop_app/modules/shoplayaout/shoplayout.dart';

import 'package:shop_app/shared/end_pointes.dart';

import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shared/shear.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword=true;

  IconData suffix=  Icons.visibility;

  LoginModel model;

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopLoginStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState)
          {
            if(state.model.status)
            {
              Shared.saveData(key: 'token', value:state.model.data.token).then((value){
                token=state.model.data.token;
                print('Save token');
                 navigateAndFinishI(context,ShopLayout());
                 Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              });
            } else
              {
              print(state.model.message);
              Fluttertoast.showToast(
                  msg: state.model.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
              );
             }
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor:Colors.white,
            body:Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Center(
                            child: Image(
                              width: 200,
                              height: 200,
                              image: AssetImage('imag/lolo.png'),
                            )
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children:
                          [
                            Text(
                              ' Login ',
                              style: TextStyle(
                                  color: Colors.indigoAccent[400],
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                                'to your Account'
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Material(
                          elevation: 10,
                          shadowColor: Colors.white,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.indigoAccent[400],
                                ),
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white,width: 1.7)
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white,width: 1.7)
                                ),
                                filled: true,
                                fillColor: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Material(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: TextFormField(
                            obscureText: isPassword,
                            onFieldSubmitted: (value)
                            {
                              if(formKey.currentState.validate())
                              {
                                //ShopCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            validator: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Please enter your password ';
                              }
                              return null;
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.indigoAccent[400],
                                ),
                                suffixIcon: IconButton(
                                  color: Colors.black,
                                  onPressed: (){
                                    setState(() {
                                      isPassword=!isPassword;
                                    });
                                  },
                                  icon: isPassword?Icon(
                                    Icons.visibility_sharp,
                                    color: Colors.black87,
                                  ):Icon(
                                    Icons.visibility_off,
                                    color: Colors.black87,
                                  ),
                                ),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white,width: 1.7)
                                ),
                                focusedBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: Colors.white,width: 1.7)
                                ),
                                filled: true,
                                fillColor: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.indigoAccent[400],
                          ),
                          child: ConditionalBuilder(
                            condition:state is! ShopLoginLoadingState,
                            builder:(context)=>Center(
                              child: MaterialButton
                                (
                                  height: 40,
                                   elevation: 8,
                                    minWidth: double.infinity,
                                     onPressed: ()
                                     {
                                      if (formKey.currentState.validate())
                                      {
                                        ShopCubit.get(context).userLogin
                                          (
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                      },
                                     child: Text(
                                      'LOGIN',
                                     style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                   ),
                                ),
                              ),
                            ),
                            fallback:(context)=>Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                              'Or sign in with.'
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Container(
                              width: 100,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                child: MaterialButton(
                                  onPressed: (){},
                                  child: Center(
                                    child:Text(
                                      'google',
                                      style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color:Colors.white
                                    )
                                  ),
                                ),
                            ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueAccent,
                                ),
                                child: MaterialButton(
                                  child: Center(
                                    child:Text(
                                        'facebook',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color:Colors.white
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                                'Don\'t have an account ?'
                            ),
                            TextButton(onPressed: ()
                            {
                              Navigator.pushNamed(context, 'rout2');
                            },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.indigoAccent[400]
                                  ),
                                )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




