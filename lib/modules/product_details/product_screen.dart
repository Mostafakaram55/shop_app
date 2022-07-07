import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_App/homemodel.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class ProductScreen extends StatelessWidget {

  int id;

  ProductScreen(this.id);
HomeModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>yoracubit()..getProductDetails(id: id),
      child: BlocConsumer<yoracubit,ShopStates>(
        listener: (context,state){},
          builder: (context,state){
          yoracubit cubit = yoracubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                systemOverlayStyle:SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              body: ConditionalBuilder(
                 condition: cubit.productDetailModel!=null,
                 builder: (context)=>SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          height: 200,
                          width: double.infinity,
                          child:Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image(
                              image:NetworkImage(
                                cubit.productDetailModel.data.images.last,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          //alignment: AlignmentDirectional.center,
                          clipBehavior: Clip.antiAlias,
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigoAccent[400],
                                  Colors.lightBlueAccent[400],
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                          child:  Padding(
                            padding: const EdgeInsets.all(15),
                            child:  Text(
                                cubit.productDetailModel.data.name,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         SingleChildScrollView(
                           child: Column(
                             children: [
                               Text(cubit.productDetailModel.data.description),
                             ],
                           ),
                         ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                          //alignment: AlignmentDirectional.center,
                          clipBehavior: Clip.antiAlias,
                          width: 230,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigoAccent[400],
                                  Colors.lightBlueAccent[400],
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )),
                          child:  Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                                children: [
                                  Text(
                                    'Price:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(cubit.productDetailModel.data.price.toString()),
                                ]
                            ),
                          ),

                        ),
                        ]
                    ),
                  ),
                 ),
                 fallback: (context){
                  return Center(child: CircularProgressIndicator());
                },
            ),

            );
          },

      ),
    );
  }
}
