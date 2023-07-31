import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/search/cubit/cubit.dart';
import 'package:social_app/social_app/search/cubit/states.dart';

class SearchScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
var searchTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (context,state){
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange.shade100,
              elevation: 0.0,
              leading: Icon(Icons.arrow_back,color: Colors.orange.shade500,),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: searchTextController,
                      onFieldSubmitted: (text){
                        ShopSearchCubit.get(context).search(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search_outlined)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Search Text Must Not be Empty';
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    if(state is ShopSearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(state is ShopSearchSucessgState)
                      Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildItem(ShopSearchCubit.get(context).searchModel!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: ShopSearchCubit.get(context).searchModel!.data!.data!.length),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
