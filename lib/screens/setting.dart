import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/bloc/homeBloc.dart';
import 'package:flutter_shop/bloc/home_states.dart';
import 'package:flutter_shop/screens/register/register_bloc.dart';

class Settings extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          emailController.text = cubit.getUserData!.data!.email.toString();
          phoneController.text = cubit.getUserData!.data!.phone.toString();
          nameController.text = cubit.getUserData!.data!.name.toString();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20)),
                      label: Text("Email"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20)),
                      label: Text("Name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20)),
                      label: Text("Phone"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.singOut(context);
                        },
                        child: Text("Logout"),
                      )),
                ),

              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
