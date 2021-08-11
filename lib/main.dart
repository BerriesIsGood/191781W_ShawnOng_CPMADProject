import 'package:flutter/material.dart';
import 'package:project/services/firebaseauth_service.dart';
import 'AboutTab.dart';
import 'WeatherTab.dart';
import 'TimeOfSun.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/weather.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return runApp(ChangeNotifierProvider(child: MyApp(),
  create: (BuildContext context) => ThemeProvider(isDarkMode: prefs.getBool("isDarkTheme") ?? false),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      home: LoginPage(),
    );
  }
}

textFields(String txt, TextEditingController controller){    //Function to create TextFields txt being hintText
  return(
    Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 5.0, left: 30.0, right:30.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blueGrey[300],
          hintText: '$txt',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
        ),
        controller: controller,
      ),
    )
  );
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController fullnameController = TextEditingController();

class _LoginPageState extends State<LoginPage> {      //Login Page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover),
          ),
          child: ListView(
            children: <Widget>[
              Container(    //Logo
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/logo.png")),
                ),
              ),
              textFields('Email', emailController),     //Email TextField
              textFields('Password', passwordController),     //Password TextField

              Padding(    //Login button
                padding: EdgeInsets.only(
                    bottom: 20.0, top: 20.0, left: 40.0, right: 40.0),
                child: FlatButton(
                  onPressed: () async{
                    var reguser = await FirebaseAuthService().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if(reguser != null){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(
                        name: usernameController.text,
                      ),
                      ),
                    );
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  color: Color(0xFF32A8CC),
                  padding:
                      EdgeInsets.symmetric(horizontal: 140.0, vertical: 20.0),
                ),
              ),
              Center(   //Sign up button
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                    ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  color: Color(0xFF32A8CC),
                  padding:
                      EdgeInsets.symmetric(horizontal: 135.0, vertical: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {      //Register Page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/backgroundR.jpg"), fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            Container(    //Logo
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/logo.png")),
              ),
            ),

            textFields('Email', emailController),    //Email TextField
            textFields('Full Name', fullnameController),  //Full Name TextField
            textFields('Username', usernameController),   //Username TextField
            textFields('Password', passwordController),   //Password TextField

            Padding(    //Register button
              padding: EdgeInsets.only(
                  bottom: 20.0, top: 20.0, left: 40.0, right: 40.0),
              child: FlatButton(
                onPressed: () async{
                  var newuser = await FirebaseAuthService().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  if(newuser != null){
                    Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),
                    ),
                  );
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Color(0xFF32A8CC),
                padding:
                    EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
              ),
            ),
            Center(   //Back button
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                  ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Color(0xFF32A8CC),
                padding:
                    EdgeInsets.symmetric(horizontal: 135.0, vertical: 20.0),
              ),
            ),
          ],
        ),
      ),
      );
  }
}

class HomePage extends StatefulWidget {     //Home Page
  final String name;
  HomePage({Key key, this.name}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() { 
    super.initState();
    getWeatherData();
  }

  WeatherData weatherData;
  void getWeatherData() async {
    weatherData = WeatherData();
    await weatherData.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){  
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme,
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Good day, $name!'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.logout, color:  Colors.white, size: 30.0),
                    onPressed: () async{
                      await FirebaseAuthService().signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.brightness_6, color: Colors.white, size: 30.0),
                    onPressed: () {
                      ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                      themeProvider.swapTheme();  
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person, color: Colors.white, size: 30.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile(),
                        ),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.info, color: Colors.yellowAccent[100],)),
                    Tab(icon: Icon(Icons.cloud, color: Colors.yellowAccent[100],)),
                    Tab(icon: Icon(Icons.brightness_4, color: Colors.yellowAccent[100],)),
                  ],
                ),
              ),

              body: Container(
                decoration: BoxDecoration(
                ),
                child: TabBarView(
                  children: [
                    AboutTab(),   //About Tab
                    
                    WeatherTab(weatherData: weatherData,),   //Weather Tab

                    TimeOfSun(weatherData: weatherData),    //Time Of Sunrise/Sunset Tab
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Profile extends StatelessWidget {   //Profile Page
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return MaterialApp(
          theme: themeProvider.getTheme,
          home: Scaffold(
              body: ListView(
                children: <Widget>[
                  Center(
                    child: Image.asset("images/logo.png"),
                  ),
                  Center(
                    child: Text('Profile', style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold))
                  ),
                  Padding(    //Profile Page
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 50.0, left: 50.0),
                    child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.white30,
                    ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Email: ' + emailController.text),
                            Text('Full Name: ' + fullnameController.text),
                            Text('Username: ' + usernameController.text),
                            Text('Password: ' + passwordController.text),
                          ],
                        ),
                        ),
                  ),
                  Padding(    //Back Button
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage())
                          );
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 20.0, color: Colors.white
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                          color: Color(0xFF32A8CC),
                          padding: EdgeInsets.symmetric(horizontal: 145.0, vertical: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        );
      }
    );
  }
}