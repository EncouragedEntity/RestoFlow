import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc.dart';
import '../../events/auth_event.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});
  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            context.read<AuthBloc>().add(AuthSignOutEvent());
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Color(0xFF755DC1),
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 56,
                  child: TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF393939),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF837E93),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xFF9F7BFF),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: _passController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xFF837E93),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 56,
                      child: TextField(
                        controller: _repassController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Confirm password',
                          hintStyle: TextStyle(
                            color: Color(0xFF837E93),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF837E93),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: 329,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO register event
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9F7BFF),
                      ),
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF837E93),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 2.5,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthWantToLogInEvent());
                      },
                      child: const Text(
                        'Log In ',
                        style: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
