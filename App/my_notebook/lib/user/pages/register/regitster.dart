



// import 'package:flutter/material.dart';
// import 'package:my_notebook/services/api_services.dart';
// import 'package:my_notebook/user/pages/login/login.dart';

// class Regitster extends StatefulWidget {
//   const Regitster({super.key});

//   @override
//   State<Regitster> createState() => _RegitsterState();
// }

// class _RegitsterState extends State<Regitster> {
//   late final TextEditingController firstNameController;
//   late final TextEditingController lastNameController;
//   late final TextEditingController emailController;
//   late final TextEditingController passwordController;

//   bool isPasswordVisible = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();

//     firstNameController = TextEditingController();
//     lastNameController = TextEditingController();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   Future<void> registerUser() async {
//     FocusScope.of(context).unfocus();

//     if (firstNameController.text.trim().isEmpty ||
//         lastNameController.text.trim().isEmpty ||
//         emailController.text.trim().isEmpty ||
//         passwordController.text.isEmpty) {
//       _showMessage("Please fill all fields");
//       return;
//     }

//     if (passwordController.text.length < 6) {
//       _showMessage("Password must be at least 6 characters");
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final res = await ApiServices().RegisterAPI(
//         firstNameController.text.trim(),
//         lastNameController.text.trim(),
//         emailController.text.trim(),
//         passwordController.text,
//       );

//       debugPrint("REGISTER RESPONSE: $res");

//       if (!mounted) return;

//       setState(() {
//         isLoading = false;
//       });

//       if (res["success"] == true) {
//         _showMessage("Registration successful");

//         await Future.delayed(const Duration(milliseconds: 700));

//         if (!mounted) return;

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const LoginPage(),
//           ),
//         );
//       } else {
//         _showMessage(
//           res["message"]?.toString() ?? "Registration failed",
//         );
//       }
//     } catch (e) {
//       if (!mounted) return;

//       setState(() {
//         isLoading = false;
//       });

//       _showMessage(
//         e.toString().replaceFirst("Exception: ", ""),
//       );
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 24,
//               vertical: 30,
//             ),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 500,
//               ),
//               child: Column(
//                 children: [
//                   // Logo
//                   Container(
//                     width: 92,
//                     height: 92,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: colorScheme.primary.withOpacity(0.10),
//                       border: Border.all(
//                         color: colorScheme.primary.withOpacity(0.20),
//                         width: 1,
//                       ),
//                     ),
//                     child: ClipOval(
//                       child: Image.network(
//                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYvFySBZqQl9cpe0WOVFBgs8WhJqS7huXACg&s",
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Icon(
//                             Icons.menu_book_rounded,
//                             size: 42,
//                             color: colorScheme.primary,
//                           );
//                         },
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 28),

//                   // Title
//                   Text(
//                     "Create Account 🚀",
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.headlineSmall?.copyWith(
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: -0.5,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Text(
//                     "Register to get started with My Notebook",
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.textTheme.bodyMedium?.color
//                           ?.withOpacity(0.65),
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // Form Card
//                   Container(
//                     padding: const EdgeInsets.all(22),
//                     decoration: BoxDecoration(
//                       color: theme.cardColor,
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(
//                         color: theme.dividerColor.withOpacity(0.12),
//                       ),
//                       boxShadow: isDark
//                           ? []
//                           : [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.06),
//                                 blurRadius: 25,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Create your account",
//                           style: theme.textTheme.titleLarge?.copyWith(
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // First + Last Name
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildTextField(
//                                 context: context,
//                                 controller: firstNameController,
//                                 hintText: "First Name",
//                                 icon: Icons.person_outline_rounded,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: _buildTextField(
//                                 context: context,
//                                 controller: lastNameController,
//                                 hintText: "Last Name",
//                                 icon: Icons.person_outline_rounded,
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 18),

//                         // Email
//                         _buildTextField(
//                           context: context,
//                           controller: emailController,
//                           hintText: "Email",
//                           icon: Icons.email_outlined,
//                           keyboardType: TextInputType.emailAddress,
//                           textInputAction: TextInputAction.next,
//                         ),

//                         const SizedBox(height: 18),

//                         // Password
//                         TextField(
//                           controller: passwordController,
//                           obscureText: !isPasswordVisible,
//                           textInputAction: TextInputAction.done,
//                           onSubmitted: (_) {
//                             if (!isLoading) {
//                               registerUser();
//                             }
//                           },
//                           decoration: InputDecoration(
//                             hintText: "Password",
//                             prefixIcon: const Icon(
//                               Icons.lock_outline_rounded,
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isPasswordVisible =
//                                       !isPasswordVisible;
//                                 });
//                               },
//                               icon: Icon(
//                                 isPasswordVisible
//                                     ? Icons.visibility_rounded
//                                     : Icons.visibility_off_rounded,
//                               ),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 theme.inputDecorationTheme.fillColor ??
//                                     (isDark
//                                         ? Colors.white.withOpacity(0.05)
//                                         : Colors.grey.withOpacity(0.07)),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(14),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(14),
//                               borderSide: BorderSide.none,
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(14),
//                               borderSide: BorderSide(
//                                 color: colorScheme.primary,
//                                 width: 1.5,
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 26),

//                         // Register Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 54,
//                           child: ElevatedButton(
//                             onPressed: isLoading ? null : registerUser,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: colorScheme.primary,
//                               foregroundColor: colorScheme.onPrimary,
//                               disabledBackgroundColor:
//                                   colorScheme.primary.withOpacity(0.5),
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                             ),
//                             child: isLoading
//                                 ? SizedBox(
//                                     width: 23,
//                                     height: 23,
//                                     child: CircularProgressIndicator(
//                                       strokeWidth: 2.5,
//                                       color: colorScheme.onPrimary,
//                                     ),
//                                   )
//                                 : const Text(
//                                     "Create Account",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // Login Navigation
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account? ",
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: theme.textTheme.bodyMedium?.color
//                               ?.withOpacity(0.65),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const LoginPage(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             color: colorScheme.primary,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required BuildContext context,
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     TextInputType? keyboardType,
//     TextInputAction? textInputAction,
//   }) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final isDark = theme.brightness == Brightness.dark;

//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       textInputAction: textInputAction,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: Icon(icon),
//         filled: true,
//         fillColor: theme.inputDecorationTheme.fillColor ??
//             (isDark
//                 ? Colors.white.withOpacity(0.05)
//                 : Colors.grey.withOpacity(0.07)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(
//             color: colorScheme.primary,
//             width: 1.5,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_notebook/services/api_services.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'dart:math';

class Regitster extends StatefulWidget {
  const Regitster({super.key});

  @override
  State<Regitster> createState() => _RegitsterState();
}

class _RegitsterState extends State<Regitster>
    with SingleTickerProviderStateMixin {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController otpController;

  late final AnimationController shakeController;
  late final Animation<double> shakeAnimation;

  bool isPasswordVisible = false;
  bool isLoading = false;
  bool showOtp = false;
  bool otpError = false;
  bool otpSuccess = false;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    otpController = TextEditingController();

    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    shakeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: shakeController,
        curve: Curves.elasticIn,
      ),
    );
  }

  // ============================================================
  // REGISTER
  // ============================================================

  Future<void> registerUser() async {
    FocusScope.of(context).unfocus();

    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage("Please fill all fields");
      return;
    }

    // Backend validation requires minimum 8 characters.
    if (passwordController.text.length < 8) {
      _showMessage("Password must be at least 8 characters");
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

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (res["success"] == true) {
        otpController.clear();

        setState(() {
          showOtp = true;
          otpError = false;
          otpSuccess = false;
        });
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

  // ============================================================
  // VERIFY OTP
  // ============================================================

  Future<void> verifyOtp() async {
    FocusScope.of(context).unfocus();

    final otp = otpController.text.trim();

    if (otp.length != 6) {
      _animateWrongOtp();
      return;
    }

    setState(() {
      isLoading = true;
      otpError = false;
    });

    try {
      final res = await ApiServices().verifyRegistrationOTP(
        emailController.text.trim(),
        otp,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      if (res["success"] == true) {
        setState(() {
          otpSuccess = true;
          otpError = false;
        });

        await Future.delayed(
          const Duration(milliseconds: 1400),
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        _animateWrongOtp();
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _animateWrongOtp(
        message: e.toString().replaceFirst("Exception: ", ""),
      );
    }
  }

  void _animateWrongOtp({String? message}) {
    setState(() {
      otpError = true;
      otpSuccess = false;
    });

    shakeController.forward(from: 0);

    if (message != null && message.isNotEmpty) {
      _showMessage(message);
    }
  }

  void _backToRegister() {
    setState(() {
      showOtp = false;
      otpError = false;
      otpSuccess = false;
      otpController.clear();
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

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
    otpController.dispose();
    shakeController.dispose();

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

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

                  Text(
                    showOtp
                        ? "Verify Your Email ✉️"
                        : "Create Account 🚀",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    showOtp
                        ? "Enter the 6-digit code sent to your email"
                        : "Register to get started with My Notebook",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color
                          ?.withOpacity(0.65),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Animated Register / OTP Card
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    reverseDuration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) {
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(0.12, 0),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: showOtp
                        ? _buildOtpWidget(
                            key: const ValueKey("otp"),
                            context: context,
                            theme: theme,
                            colorScheme: colorScheme,
                            isDark: isDark,
                          )
                        : _buildRegisterWidget(
                            key: const ValueKey("register"),
                            context: context,
                            theme: theme,
                            colorScheme: colorScheme,
                            isDark: isDark,
                          ),
                  ),

                  const SizedBox(height: 25),

                  // Login navigation
                  if (!showOtp)
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

  // ============================================================
  // REGISTER FORM WIDGET
  // ============================================================

  Widget _buildRegisterWidget({
    required Key key,
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme colorScheme,
    required bool isDark,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(theme, isDark),
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

          _buildTextField(
            context: context,
            controller: emailController,
            hintText: "Email",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: 18),

          TextField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (!isLoading) registerUser();
            },
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              ),
              filled: true,
              fillColor: _inputFillColor(theme, isDark),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              focusedBorder: _focusedBorder(colorScheme),
            ),
          ),

          const SizedBox(height: 26),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: isLoading ? null : registerUser,
              style: _buttonStyle(colorScheme),
              child: isLoading
                  ? _loadingIndicator(colorScheme)
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
    );
  }

  // ============================================================
  // OTP WIDGET - SAME REGISTER SCREEN
  // ============================================================

  Widget _buildOtpWidget({
    required Key key,
    required BuildContext context,
    required ThemeData theme,
    required ColorScheme colorScheme,
    required bool isDark,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(theme, isDark),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: otpSuccess
                ? Container(
                    key: const ValueKey("success"),
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                      size: 58,
                    ),
                  )
                : Container(
                    key: const ValueKey("email"),
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_read_rounded,
                      color: colorScheme.primary,
                      size: 42,
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              otpSuccess
                  ? "Email Verified!"
                  : "Check your email",
              key: ValueKey(otpSuccess),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: otpSuccess ? Colors.green : null,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            otpSuccess
                ? "Your account has been created successfully."
                : "We sent a 6-digit verification code to",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color
                  ?.withOpacity(0.7),
            ),
          ),

          if (!otpSuccess) ...[
            const SizedBox(height: 6),

            Text(
              emailController.text.trim(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            AnimatedBuilder(
              animation: shakeAnimation,
              builder: (context, child) {
                final offset =
                    sin(shakeAnimation.value * pi * 10) *
                        (1 - shakeAnimation.value) *
                        10;

                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: child,
                );
              },
              child: TextField(
                controller: otpController,
                enabled: !isLoading,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 12,
                ),
                decoration: InputDecoration(
                  hintText: "------",
                  counterText: "",
                  filled: true,
                  fillColor: otpError
                      ? Colors.red.withOpacity(0.06)
                      : _inputFillColor(theme, isDark),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: otpError
                          ? Colors.red
                          : theme.dividerColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: otpError
                          ? Colors.red
                          : theme.dividerColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                      color: otpError
                          ? Colors.red
                          : colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (_) {
                  if (otpError) {
                    setState(() {
                      otpError = false;
                    });
                  }
                },
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: otpError
                  ? Padding(
                      key: const ValueKey("error"),
                      padding: const EdgeInsets.only(top: 8),
                      child: const Text(
                        "Incorrect OTP. Please try again.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox(
                      key: ValueKey("no-error"),
                    ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: isLoading ? null : verifyOtp,
                style: _buttonStyle(colorScheme),
                child: isLoading
                    ? _loadingIndicator(colorScheme)
                    : const Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 16),

            TextButton.icon(
              onPressed: isLoading ? null : _backToRegister,
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text("Back to Register"),
            ),
          ] else ...[
            const SizedBox(height: 20),

            const LinearProgressIndicator(
              color: Colors.green,
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // COMMON UI HELPERS
  // ============================================================

  BoxDecoration _cardDecoration(
    ThemeData theme,
    bool isDark,
  ) {
    return BoxDecoration(
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
    );
  }

  Color _inputFillColor(
    ThemeData theme,
    bool isDark,
  ) {
    return theme.inputDecorationTheme.fillColor ??
        (isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.grey.withOpacity(0.07));
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _focusedBorder(
    ColorScheme colorScheme,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: colorScheme.primary,
        width: 1.5,
      ),
    );
  }

  ButtonStyle _buttonStyle(
    ColorScheme colorScheme,
  ) {
    return ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor:
          colorScheme.primary.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  Widget _loadingIndicator(
    ColorScheme colorScheme,
  ) {
    return SizedBox(
      width: 23,
      height: 23,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: colorScheme.onPrimary,
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
        fillColor: _inputFillColor(theme, isDark),
        border: _inputBorder(),
        enabledBorder: _inputBorder(),
        focusedBorder: _focusedBorder(colorScheme),
      ),
    );
  }
}