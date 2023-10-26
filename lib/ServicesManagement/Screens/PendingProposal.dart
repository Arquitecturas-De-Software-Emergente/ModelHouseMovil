import 'package:flutter/material.dart';
import 'package:model_house/ServicesManagement/Interfaces/Proposal.dart';
import 'package:model_house/ServicesManagement/Screens/PendingRequest.dart';
import 'package:model_house/ServicesManagement/Screens/request/FormProposal.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Security/Interfaces/UserProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Proposal_Service.dart';
import '../Services/Request_Service.dart';

class PendingProposal extends StatefulWidget {
  late final List<Proposal>? proposals;
  final UserProfile? userProfile;
  final BusinessProfile? businessProfile;
  PendingProposal(this.proposals, this.userProfile, this.businessProfile, {Key? key})
      : super(key: key);

  @override
  _PendingProposalState createState() => _PendingProposalState();
}

class _PendingProposalState extends State<PendingProposal> {
  List<Proposal>? proposalsPending;
  HttpProposal? httpProposal;
  Proposal? proposal;

  @override
  void initState() {
    httpProposal = HttpProposal();
    print(widget.proposals?.length);
    super.initState();
  }

  Future changeStatus(Proposal proposalInterface, String status) async {
    proposal = await httpProposal?.changeStatus(proposalInterface.id!, status);
    if (proposal != null) {
      proposalsPending = await httpProposal?.getProposalsByStatus();
      setState(() {
        proposal = proposal;
        widget.proposals = proposalsPending;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Your Proposals"),
        backgroundColor: const Color(0xffffffff),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Column(
        children: [
          Container(),
          if (widget.userProfile != null && widget.proposals != null)
            Expanded(
              child: ListView.builder(
                itemCount: widget.proposals!.length,
                itemBuilder: (context, index) {
                  final status = widget.proposals![index].status;
                  if (widget.userProfile != null && status == 'Pendiente') {
                    return RequestCard(
                      '${widget.proposals![index].name}',
                      '${widget.proposals![index].description}',
                      Container(),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.green, width: 2.0),
                        ),
                        child: Card(
                          child: Text("En espera"),
                        ),
                      ),
                    );
                  } else if (widget.userProfile != null && status == 'Aprobado') {
                    return RequestCard(
                      '${widget.proposals![index].name}',
                      '${widget.proposals![index].description}',
                      Container(),
                      AcceptRejectButtons(onAcceptPressed: () {
                        changeStatus(widget.proposals![index], "Aprobado");
                      }, onRejectPressed: () {
                        changeStatus(widget.proposals![index], "Cancelado");
                      }),
                    );
                  }
                  return SizedBox.shrink(); // No matching condition, so hide the card.
                },
              ),
            ),
          if (widget.businessProfile != null && widget.proposals != null)
            Expanded(
              child: ListView.builder(
                itemCount: widget.proposals!.length,
                itemBuilder: (context, index) {
                  final status = widget.proposals![index].status;
                  if (widget.businessProfile != null && status == 'Pendiente') {
                    return RequestCard(
                      '${widget.proposals![index].firstName} ${widget.proposals![index].lastName}',
                      '${widget.proposals![index].description}',
                      Container(),
                      ElevatedButton(
                        onPressed: (){
                          navigate(context, FormProposal(widget.userProfile, widget.businessProfile));
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.green, width: 2.0),
                          ),
                          child: Card(
                            child: Text("En espera"),
                          ),
                        ),
                      ),
                    );
                  } else if (widget.businessProfile != null && status == 'Aprobado') {
                    return RequestCard(
                      '${widget.proposals![index].firstName} ${widget.proposals![index].lastName}',
                      '${widget.proposals![index].description}',
                      Container(),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.green, width: 2.0),
                        ),
                        child: Card(
                          child: Text("En espera"),
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink(); // No matching condition, so hide the card.
                },
              ),
            ),
        ],
      ),
    );
  }
}
