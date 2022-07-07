import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_App/Categoriesmodel.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
import 'package:shop_app/shooCupit/shopstates.dart';

class Categories extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<yoracubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
             children:
             [
               Expanded(
                 child: ListView.separated(
                   physics: BouncingScrollPhysics(),
                   itemBuilder: (context,index)=> Item(yoracubit.get(context).categoriesModel.data.data[index]),
                   separatorBuilder: (context,index)=>SizedBox(
                     height: 5,
                   ),
                   itemCount:yoracubit.get(context).categoriesModel.data.data.length,
                 ),
               ),
             ],
            ),
          ),
        );
      },
    );
  }
  Widget Item(DataModel model)=>  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    child:Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
        [
          CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl:model.image,
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
          SizedBox(
            width: 5,
          ),
          Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios
          )

        ],
      ),
    )
  );
  Widget CItem()=>Column(
    children:
    [
      Container(
        height: 50,
        width: 100,
        color: Colors.lightBlueAccent,
        child: Text(
          'Fashion'
        ),
      ),
    ],
  );
}
