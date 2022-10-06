import 'package:flutter/material.dart';
import './transaction_item.dart';
import '../models/transactions.dart';
class Transactions extends StatelessWidget{

  late final List<Transaction> transactions;
  final Function deleteTx;
  Transactions(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 400,
      child: transactions.isEmpty?Column(
        children: [
          Text('No Transactions Yet',style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 10,),
          Container(
              height:200,
              child: Image.asset('assets/image/waiting.png',fit: BoxFit.cover,)),
        ],
      ):ListView.builder(
        itemBuilder:(ctx,index){
          return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);

        } ,
        itemCount: transactions.length,),


    );
  }
}

/*lass TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transactions,
    required this.deleteTx,
  }) : super(key: key);

  final List<Transaction> transactions;
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
              child: Text('\$ ${transactions[index].amaunt.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  FittedBox(
                    child: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,),
                  ),

                Text(DateFormat().format(transactions[index].dateTime), style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: ()=> deleteTx(transactions[index].id,)
            ),
        ],
      ),
    );
  }
}*/
