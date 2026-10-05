// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/pages/home.dart';
// import 'package:my_notebook/user/pages/register/regitster.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});


//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   bool isPasswordVisible = false;

  
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     Future<void> loginUser() async {
//       try {
//         final res = await ApiServices().loginApi(
//           emailController.text,
//           passwordController.text,
//         );

//         print(res);

//         // Login successful
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Home()),
//         );
//       } catch (e) {
//         print(e);
//         // Error show
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }

//     @override
//     void dispose(){
//       emailController.dispose();
//       passwordController.dispose();
//       super.dispose();
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.06),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: height * 0.05),

//                 // 🔵 Logo
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 20,
//                         color: Colors.black12,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: ClipOval(
//                     child: Image.network(
//                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYvFySBZqQl9cpe0WOVFBgs8WhJqS7huXACg&s",
//                       width: width * 0.28,
//                       height: width * 0.28,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: height * 0.04),

//                 // 🔵 Title
//                 Text(
//                   "Welcome Back 👋",
//                   style: TextStyle(
//                     fontSize: width * 0.065,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black54,
//                   ),
//                 ),

//                 SizedBox(height: 5),

//                 Text(
//                   "Login to your account",
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),

//                 SizedBox(height: height * 0.04),

//                 // 🔵 Card Container
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 15,
//                         color: Colors.black12,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // 🔵 Email
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email_outlined),
//                           hintText: "Email",
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           contentPadding: EdgeInsets.symmetric(vertical: 16),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 15),

//                       // // 🔵 Password
//                       // TextField(
//                       //   obscureText: true,
//                       //   controller: passwordController,
//                       //   decoration: InputDecoration(
//                       //     prefixIcon: Icon(Icons.lock_outline),
//                       //     hintText: "Password",
//                       //     filled: true,
//                       //     fillColor: Colors.grey[100],
//                       //     contentPadding: EdgeInsets.symmetric(vertical: 16),
//                       //     border: OutlineInputBorder(
//                       //       borderRadius: BorderRadius.circular(12),
//                       //       borderSide: BorderSide.none,
//                       //     ),
//                       //   ),
//                       // ),


//                        TextField(
//                         controller: passwordController,
//                         obscureText: !isPasswordVisible,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.lock_outline),
//                           hintText: "Password",
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 isPasswordVisible = !isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 25),

//                       // 🔵 Login Button
//                       Container(
//                         width: double.infinity,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: LinearGradient(
//                             colors: [Colors.blue, Colors.blueAccent],
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.blue.withOpacity(0.4),
//                               blurRadius: 10,
//                               offset: Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: ElevatedButton(
//                           onPressed: loginUser,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // SizedBox(height: 25),

//                 // Text("- Or sign in with -",
//                 //     style: TextStyle(color: Colors.grey[600])),

//                 // SizedBox(height: 15),

//                 // // 🔵 Social Buttons
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     socialBox(Icons.g_mobiledata),
//                 //     SizedBox(width: 20),
//                 //     socialBox(Icons.facebook),
//                 //   ],
//                 // ),
//                 SizedBox(height: 30),

//                 // 🔵 Signup Text with Navigation
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account? ",
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                     GestureDetector(
//                       // onTap: () {
//                       // 👉 Navigation to Register Page
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => RegisterPage(),
//                       //   ),
//                       // );
//                       // },
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Regitster()),
//                         );
//                       },

//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: height * 0.05),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔵 Social Box Widget
//   Widget socialBox(IconData icon) {
//     return Container(
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
//       ),
//       child: Icon(icon, size: 30),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/register/regitster.dart';
import 'package:my_notebook/user/root_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> loginUser() async {
    FocusScope.of(context).unfocus();

    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage("Please enter email and password");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final res = await ApiServices().loginApi(
        emailController.text.trim(),
        passwordController.text,
      );

      debugPrint("LOGIN RESPONSE: $res");

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (res["success"] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RootPage(),
          ),
        );
      } else {
        _showMessage(
          res["message"]?.toString() ?? "Login failed",
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        e.toString().replaceFirst("Exception: ", ""),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary.withOpacity(0.10),
                      border: Border.all(
                        color: colorScheme.primary.withOpacity(0.20),
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYvFySBZqQl9cpe0WOVFBgs8WhJqS7huXACg&s",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.menu_book_rounded,
                            size: 42,
                            color: colorScheme.primary,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Title
                  Text(
                    "Welcome Back 👋",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Login to continue to My Notebook",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withOpacity(0.65),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Login Card
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.dividerColor.withOpacity(0.12),
                      ),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 25,
                                offset: const Offset(0, 8),
                              ),
                            ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Email
                        Text(
                          "Email",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                            ),
                            filled: true,
                            fillColor: theme.inputDecorationTheme.fillColor ??
                                (isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.grey.withOpacity(0.07)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Password
                        Text(
                          "Password",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!isLoading) {
                              loginUser();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible =
                                      !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                            filled: true,
                            fillColor: theme.inputDecorationTheme.fillColor ??
                                (isDark
                                    ? Colors.white.withOpacity(0.05)
                                    : Colors.grey.withOpacity(0.07)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 26),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              disabledBackgroundColor:
                                  colorScheme.primary.withOpacity(0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: 23,
                                    height: 23,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: colorScheme.onPrimary,
                                    ),
                                  )
                                : const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.65),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Regitster(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}