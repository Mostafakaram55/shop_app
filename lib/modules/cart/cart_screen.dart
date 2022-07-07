import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/modules/order/order.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        yoracubit cubit = yoracubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('My Cart',style: TextStyle(color: Colors.white),),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: cubit.cartModel.data.cartItem.length!=0,
            builder: (context) => ListView.separated(
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: cubit.cartModel.data.cartItem[index]
                                .productDetails.image,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 3,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.indigoAccent[400],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.cartModel.data.cartItem[index]
                                    .productDetails.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${cubit.cartModel.data.cartItem[index].productDetails.price} EGP'),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            cubit.counter(
                                              id: cubit.cartModel.data
                                                  .cartItem[index].id,
                                              quantity: cubit
                                                      .cartModel
                                                      .data
                                                      .cartItem[index]
                                                      .quantity -=
                                                  1,
                                            );
                                            yoracubit.get(context).getCart();
                                          },
                                          child: Icon(Icons.remove)),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(cubit.cartModel.data
                                          .cartItem[index].quantity
                                          .toString()),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            cubit.counter(
                                              id: cubit.cartModel.data
                                                  .cartItem[index].id,
                                              quantity: cubit
                                                  .cartModel
                                                  .data
                                                  .cartItem[index]
                                                  .quantity +=
                                                  1,
                                            );
                                            yoracubit.get(context).getCart();
                                          },
                                          child: Icon(Icons.add)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: cubit.cartModel.data.cartItem.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 15.0,
                );
              },
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 30,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(15.0),
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price:'),
                      Text('${yoracubit.get(context).cartModel.data.total} EGP'),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: MediaQuery.of(context).size.width,
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
                     child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Order();
                          }));
                          },
                            child: Text(
                              'Checkout',
                           style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
