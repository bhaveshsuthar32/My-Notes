// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/pages/login/login.dart';
// // import 'login_page.dart';

// class Regitster extends StatefulWidget {
//   const Regitster({super.key});

//   @override
//   State<Regitster> createState() => _RegitsterState();
// }

// class _RegitsterState extends State<Regitster> {

//   bool isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {

//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     final firstNameController = TextEditingController();
//     final lastNameController = TextEditingController();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     Future<void> regiterUser() async {
//       try {
//         final res = await ApiServices().RegisterAPI(
//           firstNameController.text,
//           lastNameController.text,
//           emailController.text,
//           passwordController.text
//         );

//         print(res);

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
//       } catch (e) {
//         print(e); 
        
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }




//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.06),
//             child: Column(
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

//                 Text(
//                   "Create Account 🚀",
//                   style: TextStyle(
//                     fontSize: width * 0.065,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 SizedBox(height: 5),

//                 Text(
//                   "Register to get started",
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),

//                 SizedBox(height: height * 0.04),

//                 // 🔵 Form Card
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

//                       // 🔵 First + Last Name Row
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               controller: firstNameController,
//                               decoration: InputDecoration(
//                                 hintText: "First Name",
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           SizedBox(width: 10),

//                           Expanded(
//                             child: TextField(
//                               controller: lastNameController,
//                               decoration: InputDecoration(
//                                 hintText: "Last Name",
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SizedBox(height: 15),

//                       // 🔵 Email
//                       TextField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email_outlined),
//                           hintText: "Email",
//                           filled: true,
//                           fillColor: Colors.grey[100],
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 15),

//                       // 🔵 Password with toggle
//                       TextField(
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

//                       // 🔵 Register Button
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
//                           onPressed: regiterUser,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             "Register",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 30),

//                 // 🔵 Login Navigation
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account? "),
//                     GestureDetector(
//                       // onTap: () {
//                       //   // 👉 Login page open
//                       //   // Navigator.push(
//                       //   //   context,
//                       //   //   MaterialPageRoute(
//                       //   //     builder: (context) => LoginPage(),
//                       //   //   ),
//                       //   // );
//                       // },

//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//                       },
//                       child: Text(
//                         "Login",
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
// }



import 'package:flutter/material.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/pages/login/login.dart';

class Regitster extends StatefulWidget {
  const Regitster({super.key});

  @override
  State<Regitster> createState() => _RegitsterState();
}

class _RegitsterState extends State<Regitster> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> registerUser() async {
    FocusScope.of(context).unfocus();

    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    if (passwordController.text.length < 6) {
      _showMessage("Password must be at least 6 characters");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final res = await ApiServices().RegisterAPI(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
      );

      debugPrint("REGISTER RESPONSE: $res");

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (res["success"] == true) {
        _showMessage("Registration successful");

        await Future.delayed(const Duration(milliseconds: 700));

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        _showMessage(
          res["message"]?.toString() ?? "Registration failed",
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
    firstNameController.dispose();
    lastNameController.dispose();
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
                    "Create Account 🚀",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Register to get started with My Notebook",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withOpacity(0.65),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Form Card
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
                          "Create your account",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // First + Last Name
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                context: context,
                                controller: firstNameController,
                                hintText: "First Name",
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                context: context,
                                controller: lastNameController,
                                hintText: "Last Name",
                                icon: Icons.person_outline_rounded,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // Email
                        _buildTextField(
                          context: context,
                          controller: emailController,
                          hintText: "Email",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),

                        const SizedBox(height: 18),

                        // Password
                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            if (!isLoading) {
                              registerUser();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
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
                            fillColor:
                                theme.inputDecorationTheme.fillColor ??
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

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : registerUser,
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
                                    "Create Account",
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

                  // Login Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.65),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
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
    );
  }
}