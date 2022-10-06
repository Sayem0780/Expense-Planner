import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData(){
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null ){
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(decoration:InputDecoration(labelText: 'Title',),
              controller: titleController,
              onSubmitted: (_)=>submitData(),
            ),

            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_)=>submitData(),),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_selectedDate == null?' No Date Chosen ':
                'picked date: ${DateFormat.yMd().format(_selectedDate!)}'),
                FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: _presentDatePicker)
              ],
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('Add Transaction',style: TextStyle(fontWeight: FontWeight.bold),),
             textColor: Theme.of(context).textTheme.button?.color,
             onPressed: submitData,
            )],
        ),
      ),
    );
  }
}
