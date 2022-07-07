import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/shoplayaout/shoplayout.dart';

import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class Order extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessAddOrderState){
          Fluttertoast.showToast(
            msg: 'It was added successfully',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add in cart',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic
              ),
            ),
            backwardsCompatibility: false,
            systemOverlayStyle:SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children:
                    [
                      Text(
                        ' pleas Enter data',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16
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
                        controller: nameController,
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
                            return 'Please enter City ';
                          }
                          return null;
                        },
                        controller: cityController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'City',
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
                              return ' Please enter region';
                            }
                            return null;
                          },
                          controller: regionController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: ' Region',
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
                              return 'Please enter  Details ';
                            }
                            return null;
                          },
                          controller: detailsController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Details',
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
                              return 'Please enter Notes ';
                            }
                            return null;
                          },
                          controller: notesController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Notes',
                            labelStyle: TextStyle(
                                color: Colors.grey
                            ),
                          )
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Colors.indigoAccent[400],
                                Colors.lightBlueAccent[400],
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                        child: MaterialButton(
                          //color: Colors.indigoAccent,
                          onPressed:(){
                            if(formKey.currentState.validate()){
                              yoracubit.get(context).addAddress(
                                  name: nameController.text,
                                  city: cityController.text,
                                  region: regionController.text,
                                  details: detailsController.text,
                                  notes: nameController.text
                              );
                              yoracubit.get(context).getDataHome();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopLayout()));
                            }else{
                              print('Null');
                            }
                          },
                          child: Text(
                            'ADD',
                            style: TextStyle(
                                color: Colors.white
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
      },
    );
  }
}
