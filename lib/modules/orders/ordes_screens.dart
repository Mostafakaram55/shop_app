
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_App/ordersmodel.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=yoracubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Orders',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition:yoracubit.get(context).ordersModel!=null ,
            builder: (context)=>ListView.separated(
              padding: EdgeInsets.all(15.0),
              itemBuilder: (context,index)=>Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          'date : ${cubit.ordersModel.data.ordersDetails[index].date}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                           'total :${cubit.ordersModel.data.ordersDetails[index].total.toString()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children:[
                          IconButton(
                            onPressed: (){
                              yoracubit.get(context).cancelOrder(id: yoracubit.get(context).ordersModel.data.ordersDetails[index].id);
                              yoracubit.get(context).getOrders();
                            },
                            icon: Icon(
                              Icons.delete_forever_rounded
                            ),
                          ),
                          Text(
                         cubit.ordersModel.data.ordersDetails[index].status,
                         style: TextStyle(color: yoracubit.get(context).ordersModel.data.ordersDetails[index].status=="New"?Colors.indigoAccent:Colors.red),
                       )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context,index)=>SizedBox(
                height: 10,
              ),
              itemCount: yoracubit.get(context).ordersModel.data.ordersDetails.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

}
