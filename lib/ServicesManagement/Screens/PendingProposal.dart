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
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  PendingProposal(this.userProfile, this.businessProfile, {Key? key})
      : super(key: key);

  @override
  _PendingProposalState createState() => _PendingProposalState();
}

class _PendingProposalState extends State<PendingProposal> {
  List<Proposal>? proposalsPending;
  HttpProposal? httpProposal;
  Proposal? proposal;
  List<Proposal>? proposals;
  
  @override
  void initState() {
    httpProposal = HttpProposal();
    getProposal();
    super.initState();
  }
  Future getProposal() async{
    proposals = await httpProposal?.getProposals();
    setState(() {
      proposals = proposals;
    });
  }
  Future changeStatus(Proposal proposalInterface, String status) async {
    proposal = await httpProposal?.changeStatus(proposalInterface.id!, status);
    print(proposal?.status);
    if (proposal != null) {
      proposalsPending = await httpProposal?.getProposalsByStatus();
      setState(() {
        proposal = proposal;
        proposals = proposalsPending;
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
          if (widget.userProfile != null && proposals != null)
            Expanded(
              child: ListView.builder(
                itemCount: proposals!.length,
                itemBuilder: (context, index) {
                  var status = proposals![index].status;
                  if (status == 'Enviado') {
                    return RequestCard(
                      '${proposals![index].name}',
                      '${proposals![index].description}',
                      Container(),
                      AcceptRejectButtons(onAcceptPressed: () {
                        changeStatus(proposals![index], "Aprobado");
                      }, onRejectPressed: () {
                        changeStatus(proposals![index], "Cancelado");
                      }),
                    );
                  } else if (status == 'Pendiente') {
                    return RequestCard(
                      '${proposals![index].name}',
                      '${proposals![index].description}',
                      Container(),
                      const Text('Waiting for an answer', style: TextStyle(color: Color(0XFFECA11E), fontWeight: FontWeight.bold))
                    );
                  }
                  return SizedBox.shrink(); // No matching condition, so hide the card.
                },
              ),
            ),
          if (widget.businessProfile != null && proposals != null)
            Expanded(
              child: ListView.builder(
                itemCount: proposals!.length,
                itemBuilder: (context, index) {
                  var status = proposals![index].status;
                  if (status == 'Pendiente') {
                    return RequestCard(
                      '${proposals![index].firstName} ${proposals![index].lastName}',
                      '${proposals![index].description}',
                      Container(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,  // Fondo blanco
                            borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
                            border: Border.all(color: Color(0XFF02AA8B), width: 2.0),  // Borde verde
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: TextButton(
                              onPressed: () {
                                  navigate(context, FormProposal(proposals![index].id!, widget.userProfile, widget.businessProfile));
                                // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                              },
                              style: TextButton.styleFrom(primary: Color(0XFF02AA8B)),  // Color del texto verde
                              child: Text('Elaborate Proposal'),  // Texto del botón
                            ),
                          ),
                        )
                    );
                  }
                  else if (status == 'Enviado') {
                    return RequestCard(
                        '${proposals![index].firstName} ${proposals![index].lastName}',
                        '${proposals![index].description}',
                        Container(),
                        const Text('Waiting for an answer', style: TextStyle(color: Color(0XFFECA11E), fontWeight: FontWeight.bold))
                    );
                  }
                  else if (status == 'Cancelado') {
                    return RequestCard(
                        '${proposals![index].firstName} ${proposals![index].lastName}',
                        '${proposals![index].description}',
                        Container(),
                        const Text('Canceled Proposal', style: TextStyle(color: Color(0XFFE91717), fontWeight: FontWeight.bold))
                    );
                  }
                  else if (status == 'Aprobado') {
                    return RequestCard(
                        '${proposals![index].firstName} ${proposals![index].lastName}',
                        '${proposals![index].description}',
                        Container(),
                        const Text('Accepted Proposal', style: TextStyle(color: Color(0XFF02AA8B), fontWeight: FontWeight.bold))
                    );
                  }
                  return SizedBox.shrink();
                }
            ),
            )
        ],
      ),
    );
  }
}
