
import 'package:conditional_builder/conditional_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/order/order.dart';
import 'package:shop_app/modules/orders/ordes_screens.dart';
import 'package:shop_app/modules/searchscreen/search.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';
class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            actions: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  ConditionalBuilder(
                    condition: yoracubit.get(context).cartModel!=null,
                    builder: (context)=>CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 10,
                      child: Text(
                        yoracubit.get(context).cartModel.data.cartItem.length.toString(),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    fallback: (context)=>CircularProgressIndicator(),
                  ),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CartScreen();
                    }));
                  }, icon: Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'rout4');
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )
              ),
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersScreen()));
                    yoracubit.get(context).getOrders();
                  },
                  icon: Icon(
                    Icons.done_all_outlined,
                    color: Colors.white,
                  )
              ),
            ],
            title: Row(
              children: [
                Text(
                    'Y',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30
                  ),
                ),
                Text(
                    'o',
                  style: TextStyle(
                      color: Colors.lightBlueAccent
                  ),
                ),
                Text(
                    'R',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                Text('a',style: TextStyle(
                    color: Colors.lightBlueAccent
                ),),

              ],
            ),
          ),
           body:  yoracubit.get(context).screens[yoracubit.get(context).currentPage],
           bottomNavigationBar:CurvedNavigationBar(
           animationDuration: Duration(
            milliseconds: 250,
           ),
           height: 50,
               backgroundColor: Colors.white,
           color: Colors.indigoAccent[400],
            index: yoracubit.get(context).currentPage,
            onTap: (index)
             {
              yoracubit.get(context).changePage(index);
             },
            items:
            [
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Icon(
                Icons.category,
                color: Colors.white,

              ),
              Icon(
                Icons.favorite,
                color: Colors.white,

              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
            ]

        ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigoAccent[400],
            onPressed: (){
              Navigator.pushNamed(context, 'rout6');
            },
            child: Icon(
              Icons.support_agent_outlined,
              color: Colors.white
            ),
          ),
        );
      },
    );
  }
}
