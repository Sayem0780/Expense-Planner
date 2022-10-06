import 'package:expensepaaner/models/transactions.dart';
import 'package:flutter/cupertino.dart';
import './chart_Bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction>recentTransactions;//here the transaction come from the new transaction entered so that we can calculate the totalsum of the treansaction per day happened.For that we creat a List name groupedTransactoinValue (here we call get so that calculate dynamically) which provide us the day as index and for each index we will sum Up the total amount

  Chart(this.recentTransactions);

  List<Map<String,dynamic>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for(var i=0; i<recentTransactions.length; i++){
        if(recentTransactions[i].dateTime.day == weekDay.day &&
        recentTransactions[i].dateTime.month == weekDay.month &&
        recentTransactions[i].dateTime.year == weekDay.year){
          totalSum = totalSum + recentTransactions[i].amaunt;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }
  double get totalSpending{
    return groupedTransactionValues.fold(0.00, (sum, item) {
    return sum + item['amount'];
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0?0.0:(data['amount']as double)/totalSpending),
              );
            }).toList(),

        ),
      ),

    );
  }
}
