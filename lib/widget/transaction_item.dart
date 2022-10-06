import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 100,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15,),
            decoration: BoxDecoration(border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,)),
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Text('\$ ${transaction.amaunt.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(transaction.title,
                    style: Theme.of(context).textTheme.headline6,),
                ),

                Text(DateFormat().format(transaction.dateTime), style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: ()=> deleteTx(transaction.id,)
          ),
        ],
      ),
    );
  }
}