import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/shop_cubit/cubit.dart';
import 'package:social_app/social_app/shop_cubit/states.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var formKey = GlobalKey<FormState>();

   XFile? imageFile;


XFile? image;
  var emailController = TextEditingController();

  var phoneController = TextEditingController();

 // String image ='';
  bool? _loading;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var shopUserModel = ShopCubit.get(context).userData;
        nameController.text = shopUserModel!.data!.name!;
        emailController.text = shopUserModel!.data!.email!;
        phoneController.text = shopUserModel!.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userData != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateProfileStates)
                    const LinearProgressIndicator(),
                  Center(
                    child: Stack(
                        children: [
                      CircleAvatar(
                        radius:80,
                        backgroundColor: Colors.white60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage: imageFile ==null? const AssetImage('images/user.png',)as ImageProvider: FileImage(File(imageFile!.path)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: InkWell(
                          onTap: (){
                            showModalBottomSheet(context: context, builder: (builder)=> bottomSheet());
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              ),
                          ),
                        ),

                        ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name Must not be Empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be Emty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be Emty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).UpdateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: const Text('UPDATE')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          SignOut(context);
                        },
                        child: const Text('LOG OUT')),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          const Text('Choose Profile Photo ',style: TextStyle(fontSize: 20),),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed: (){
                takePhoto(ImageSource.camera);
              }, icon: const Icon(Icons.camera_alt), label: const Text('Camera')),
              const SizedBox(width: 20,),
              ElevatedButton.icon(onPressed: (){
                takePhoto(ImageSource.gallery);
              }, icon: const Icon(Icons.image), label: const Text('Gallery ')),
            ],
          )
        ],
      ),
    );
  }
  void takePhoto(ImageSource source) async {
    final XFile? pickedFile= await _picker.pickImage(source:source );
    setState(() {
      imageFile= pickedFile ;
    });
  }
}
