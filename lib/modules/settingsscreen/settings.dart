
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/modules/shopApp/login/log_in.dart';
import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shared/shear.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {

  Future<void>openLink(String link)async{
    var urlink=link;
    if(await canLaunch((urlink))){
      await launch (urlink);
    }
    else{
      await launch (urlink);
    }
  }

  var namController=TextEditingController();
  var emilController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessUserDataStates){
          namController.text=state.loginModel.data.name;
          emilController.text=state.loginModel.data.email;
          phoneController.text=state.loginModel.data.phone;
        }
      },
      builder: (context,state){
        var model=yoracubit.get(context).loginModel;
        namController.text=model.data.name;
        emilController.text=model.data.email;
        phoneController.text=model.data.phone;
        return ConditionalBuilder(
          condition: yoracubit.get(context).loginModel!=null,
          builder: (context)=> Scaffold(
              backgroundColor: Colors.indigoAccent[400],
              appBar: AppBar(
                backgroundColor: Colors.indigoAccent[400],
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight:Radius.circular(50),
                    topLeft:Radius.circular(50),
                  ),
                  color: Colors.grey[200],
                ),
                child:Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Stack(
                              alignment:AlignmentDirectional.bottomEnd,
                              children: [
                                CachedNetworkImage(
                                  width: 100,
                                  height: 100,
                                  imageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0WxAubQyY-WaN8W-esXaxi_SfTKpjHYIf9w&usqp=CAU',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                      Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error,color: Colors.indigoAccent[400],),
                                ),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor:Colors.indigo,
                                  child:IconButton(
                                    onPressed: ()
                                    {
                                      yoracubit.get(context).imagee();//يفتح الكاميرة
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30
                                  ),

                                ),
                                SizedBox(
                                  height: 7,
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                        Material(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: TextFormField(
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
                          height: 5,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: TextFormField(
                            validator: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'Please enter your email ';
                              }
                              return null;
                            },
                            controller: emilController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
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
                          height: 5,
                        ),
                        Text(
                          'Phone',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: TextFormField(
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
                        Row(
                          children: [
                            MaterialButton(
                              color: Colors.indigoAccent[400],
                              height: 40,
                              elevation: 8,
                              minWidth: 100,
                              onPressed: ()
                              {
                                Shared.removData(key: 'token').then((value){
                                  if(value){
                                    navigateAndFinish(context, LogIn());
                                  }
                                });
                              },
                              child: Text(
                                'LOGOUT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                              color: Colors.indigoAccent[400],
                              height: 40,
                              elevation: 8,
                              minWidth: 100,
                              onPressed: ()
                              {

                              },
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
