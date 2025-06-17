import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(KalkulatorMini());

class KalkulatorMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

// ================= HALAMAN KALKULATOR =================
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';

  void numClick(String text) {
    setState(() => _expression += text);
  }

  void clear() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void evaluate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() => _result = eval.toString());
    } catch (e) {
      setState(() => _result = 'Error');
    }
  }

  Widget buildButton(String text,
      {Color bgColor = Colors.teal, Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () {
        if (text == '=') {
          evaluate();
        } else if (text == 'C') {
          clear();
        } else {
          numClick(text);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 12, color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '7', '8', '9', '/',
      '4', '5', '6', '*',
      '1', '2', '3', '-',
      '0', '.', '=', '+',
      'C'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator '),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfilePage()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression,
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                  Text(_result,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(_expression.isEmpty ? '0' : _expression,
                      style:
                          TextStyle(fontSize: 16, color: Colors.black87)),

                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 3.7,
                children: buttons.map((text) {
                  return buildButton(
                    text,
                    bgColor: text == '='
                        ? Colors.green
                        : (text == 'C' ? Colors.red : Colors.teal),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN PROFIL =================
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Pengguna"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
onBackgroundImageError: (_, __) {
  print('Gagal memuat gambar profil');
},
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 20),

            // Nama
            Text(
              "Alvino Nathan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            // Email
            Text(
              "alvino@gmail.com",
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 30),

            // Info tambahan
            
          ],
        ),
      ),
    );
  }
}
