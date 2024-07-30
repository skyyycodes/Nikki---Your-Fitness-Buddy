import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/homepage/speech_screen.dart'; // Replace with the actual path to your SpeechScreen file
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// Replace these with the actual imports for your pages
import 'package:gemini_chat_app_tutorial/Doctor Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/chatbot/home_page.dart';
import 'package:gemini_chat_app_tutorial/Episodes Page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Profile page/Profile_page.dart';

class DietPage extends StatefulWidget {
  @override
  _DietPageState createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.list,
    Icons.chat,
    Icons.home,
    Icons.chat_bubble,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic here based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EpisodesPage()), // Replace with your Episodes page
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Replace with your Nikki Chat page
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SpeechScreen()), // Replace with your Home page
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatWithDoctorPage()), // Replace with your Doctor Chat page
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditProfileScreen()), // Replace with your Profile page
        );
        break;
    }
  }

  void _navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpeechScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personalized Diet Plan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            Colors.blue.shade800, // Consistent color with SplashScreen
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.purple.shade600,
              Colors.pink.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Here is your personalized diet from NIKKI to achieve your target calories:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildMealBox(
                      context,
                      'Breakfast',
                      [
                        '|| Oatmeal with Fruits and Nuts ||',
                        '1 cup cooked oats',
                        '1/2 banana, sliced',
                        '1/4 cup berries (blueberries or strawberries)',
                        '1 tablespoon almond or peanut butter',
                        '1 tablespoon chia seeds',
                        '',
                        '|| Beverage ||',
                        '1 cup black coffee or tea (optional)',
                        '1 glass of water',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Morning Snack',
                      [
                        '|| Greek Yogurt Parfait ||',
                        '1 cup Greek yogurt (plain, low-fat)',
                        '1/4 cup granola',
                        '1/4 cup mixed berries',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Lunch',
                      [
                        '|| Grilled Chicken Salad ||',
                        '4 oz grilled chicken breast',
                        '2 cups mixed greens (spinach, kale, lettuce)',
                        '1/2 cup cherry tomatoes',
                        '1/4 avocado, sliced',
                        '1 tablespoon olive oil and balsamic vinegar dressing',
                        '',
                        '|| Whole Grain Bread ||',
                        '1 slice of whole-grain bread or a small whole-wheat pita',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Afternoon Snack',
                      [
                        '|| Hummus and Veggies ||',
                        '1/4 cup hummus',
                        '1 cup sliced vegetables (carrots, bell peppers, cucumbers)',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Dinner',
                      [
                        '|| Baked Salmon with Quinoa and Vegetables ||',
                        '4 oz baked salmon',
                        '1/2 cup cooked quinoa',
                        '1 cup steamed broccoli or asparagus',
                        '1 tablespoon olive oil for drizzling',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Evening Snack/Dessert',
                      [
                        '|| Fruit and Nut Mix ||',
                        '1 small apple or pear',
                        '1/4 cup mixed nuts (almonds, walnuts, pistachios)',
                      ],
                    ),
                    _buildMealBox(
                      context,
                      'Notes',
                      [
                        '|| Hydration ||: Drink plenty of water throughout the day, aiming for at least 8 cups (2 liters).',
                        '|| Portion Sizes ||: Adjust portion sizes according to your specific calorie needs and activity level.',
                        '|| Variety ||: Feel free to swap out similar foods based on your taste preferences or dietary restrictions (e.g., swap chicken for tofu for a vegetarian option).',
                        '|| Cooking Methods ||: Use healthy cooking methods like baking, grilling, steaming, or sautéing.',
                        'Nutritional Breakdown (Approximate)',
                        '|| Carbohydrates ||: ~50-55% of total calories',
                        '|| Proteins ||: ~15-20% of total calories',
                        '|| Fats ||: ~25-30% of total calories',
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToNextPage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors
                      .blue.shade800, // Consistent color with SplashScreen
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor:
            Colors.blue.shade800, // Consistent color with SplashScreen
        activeColor: Colors.white,
        inactiveColor: Colors.grey[700],
        onTap: _onItemTapped,
        splashColor: Colors.blue.shade600,
      ),
    );
  }

  Widget _buildMealBox(BuildContext context, String title, List<String> items) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.blue.shade800, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 5),
          for (var item in items)
            Text(
              item,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
        ],
      ),
    );
  }
}
