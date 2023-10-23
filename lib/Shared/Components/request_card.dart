import 'package:flutter/material.dart';
import 'package:model_house/ServicesManagement/Screens/request/request_option.dart';
import 'package:model_house/Shared/Components/navigate.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String description;
  // final VoidCallback onPressed;
  final Widget destinationWidget;
  final Widget actions;
  const RequestCard(
      this.title, this.description, this.destinationWidget, this.actions,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                      width: 300.0,
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )),
                  const SizedBox(height: 16.0),
                  actions,
                ],
              ),
              Container(
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('See Details'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF02AA8B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    navigate(context, destinationWidget);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
