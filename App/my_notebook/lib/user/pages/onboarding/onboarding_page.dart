import 'package:flutter/material.dart';
// import 'package:my_notebook/user/pages/home.dart';
import 'package:my_notebook/user/pages/login/login.dart';
import 'package:my_notebook/user/pages/splash/splash_screen.dart';
// import 'package:my_notebook/user/root_page.dart';
// import 'package:my_notebook/user/pages/login/login.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "https://static.vecteezy.com/system/resources/thumbnails/068/979/801/small_2x/flat-cartoon-illustration-of-boy-or-man-sitting-at-desk-and-writing-in-notebook-with-books-study-work-planning-or-journaling-process-education-learning-productivity-creativity-visuals-vector.jpg",
      "title": "Keep Your Ideas Safe",
      "description":
          "Write down your ideas, thoughts and important information in one place.",
    },
    {
      "image": "https://static.vecteezy.com/system/resources/previews/024/744/027/non_2x/learning-notebook-from-education-icon-isolated-vector.jpg",
      "title": "Organize Your Notes",
      "description":
          "Create topics and organize your notes so you can easily find them whenever you need.",
    },
    {
      "image": "https://cdn.vectorstock.com/i/500p/47/94/cute-brain-studying-vector-64404794.jpg",
      "title": "Your Knowledge, Anywhere",
      "description":
          "Access your notes anytime and keep your important knowledge with you.",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO:
      // Replace this with your Login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPlaceholder(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 10,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Color(0xFF4E4DE7),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  final data = onboardingData[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Column(
                      children: [

                        const SizedBox(height: 15),

                        // Image
                        Expanded(
                          flex: 5,
                          child: Image.network(
                            data["image"]!,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Title
                        Text(
                          data["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF252525),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Description
                        Text(
                          data["description"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 25),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) {
                  final bool isSelected = currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    height: 8,
                    width: isSelected ? 25 : 8,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4E4DE7)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Next / Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context, 
                        MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E4DE7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    currentPage == onboardingData.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}


// Temporary Login Page
// Baad me isko tumhare actual LoginPage se replace karenge.
class LoginPlaceholder extends StatelessWidget {
  const LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Login Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}