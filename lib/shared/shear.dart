

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/shopApp/login/log_in.dart';
import 'package:shop_app/modules/shoplayaout/shoplayout.dart';
import 'package:shop_app/shared/local/sharedpref.dart';
import 'package:shop_app/shooCupit/shopcupit.dart';
void navigateAndFinish(context,widget)=>Navigator.pushNamedAndRemoveUntil(context, 'rout1', (Route<dynamic>route) => false);

void navigateAndFinishI(context,widget)=>Navigator.pushNamedAndRemoveUntil(context,'rout3', (Route<dynamic>route) => false);
//يعني روح والغي اللي فاااات

void submit(BuildContext context ){
  Shared.saveData(key: 'OnBoarding', value: true).then((value){
    if(value){
      navigateAndFinish(
        context,
        LogIn(),
      );
    }
  });
}

void Clic(BuildContext context){
  Shared.saveData(key: 'OnBoarding', value: true).then((value){
    if(value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogIn()), (route) => false);
    }
  });

}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }

}
Widget BuildProduactList(model,context)=> Padding(
  padding: const EdgeInsets.all(10),
  child: Container(
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
        [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
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
                        if( model.discount!=0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.lightBlueAccent,
                            child: Text(
                              'DISCOUNT',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.indigoAccent[400],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(model.discount!=0)
                      Text(
                        model.oldPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      height: 10,
                      child: RatingBar.builder(
                        itemSize: 15,
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.lightBlueAccent,
                          size: 5,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: (){
                          yoracubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: yoracubit.get(context).favorites[model.id]? Colors.pink:Colors.grey,
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 14,
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);






