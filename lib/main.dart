import 'package:expensepaaner/widget/new_transaction.dart';
import 'package:expensepaaner/widget/transaction_list.dart';
import './widget/chart.dart';
import 'package:flutter/material.dart';
import 'models/transactions.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  /*final CollectionReference _products =
      FirebaseFirestore.instance.collection('product');*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(//Over All theming
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'QuickSand',//This font is added in pubspec.yaml
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(//This method override the default text theme.By this we can customize our own text theme
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white),//Text style for button
          ),
          appBarTheme: AppBarTheme(//specialy for appBar theming
              toolbarTextStyle: ThemeData.light().textTheme.copyWith(headline6: TextStyle(//From headline6 to textbody2 it is used for Title of the appBar
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )).headline6
          )

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Transaction> _userTransactions = [//This list has a Transaction Type Variable. Transaction Type variable is a class which we creat in model derectory.
    Transaction(
        id: 't1',
        title: 'Napa',
        amaunt: 69.99,
        dateTime: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Arin',
        amaunt: 19.99,
        dateTime: DateTime.now()),

  ];

  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx){
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amaunt: txAmount,
      dateTime: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deletTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }
  List<Transaction>transaction = List.from(_userTransactions,growable: true);
  void updateList(String value){
    setState(() {
      transaction = _userTransactions.where((element) => element.title.toLowerCase().contains
        (value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expense Planner'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*.4,
                child: Chart(_recentTransaction)),
            SizedBox(height: 20,),
            Container(
                height: (MediaQuery.of(context).size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top)*.6,
                child: Transactions(_userTransactions,_deletTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );

  }
}
