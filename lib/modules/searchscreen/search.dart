import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:shop_app/shared/shear.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class Search extends StatelessWidget {
  var searshController=TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Search',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          body: Form(
            key:formKey,
            child: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onFieldSubmitted: (text){
                      yoracubit.get(context).Searsh(text);
                    },
                    controller:searshController,
                    decoration:InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        labelText: 'Search'
                    ),
                    keyboardType:TextInputType.text,
                    validator:(String value){
                      if(value.isEmpty){
                        return 'Search must not be empty ';
                      }
                      return null;
                    } ,

                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if(state is SearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                if(state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=> BuildProduactList(yoracubit.get(context).search.data.data[index],context),
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 3,
                    ),
                    itemCount:yoracubit.get(context).search.data.data.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
