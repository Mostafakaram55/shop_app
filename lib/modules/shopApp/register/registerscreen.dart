


import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/regestercubit.dart';
import 'package:shop_app/cubit/registerstates.dart';
import 'package:shop_app/modules/shoplayaout/shoplayout.dart';
import 'package:shop_app/shared/end_pointes.dart';
import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shared/shear.dart';


class Register extends StatelessWidget {
  var namController=TextEditingController();
  var emilController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
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
          return  Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[50],
              backwardsCompatibility: false,
              systemOverlayStyle:SystemUiOverlayStyle(
                statusBarColor: Colors.blueGrey[50],
                statusBarIconBrightness: Brightness.dark,
              ),
              leading:IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'rout1');
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,

                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key:formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Singing to Continue',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,

                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onFieldSubmitted: (value){
                              if(formKey.currentState.validate()){

                              }
                            },
                            validator: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Please enter your name ';
                              }
                              return null;
                            },
                            controller: namController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onFieldSubmitted: (value){
                              if(formKey.currentState.validate()){

                              }
                            },
                            validator: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Please enter your emile ';
                              }
                              return null;
                            },
                            controller: emilController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              onFieldSubmitted: (value){
                                if(formKey.currentState.validate()){

                                }
                              },
                              validator: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return 'The password is not secure ';
                                }
                                return null;
                              },
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                              )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              onFieldSubmitted: (value){
                                if(formKey.currentState.validate()){

                                }
                              },
                              validator: (String value)
                              {
                                if(value.isEmpty)
                                {
                                  return 'Please enter your phone ';
                                }
                                return null;
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                              )
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                'Sing up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Spacer(),
                              ConditionalBuilder(
                                condition: state is! ShopRegisterLoadingState,
                                builder: (context)=> Container(
                                    width: 85,
                                    height: 50,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.indigoAccent[400],
                                      ),
                                      child: MaterialButton(
                                        onPressed: (){
                                          if(formKey.currentState.validate()){
                                            ShopRegisterCubit.get(context).userRegister(
                                              name: namController.text,
                                              email: emilController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                ),
                                fallback: (context)=>Center(child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'or login using scocial media',
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.indigoAccent[400],
                                child: Text(
                                  'F',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: Text(
                                    'G+',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
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
