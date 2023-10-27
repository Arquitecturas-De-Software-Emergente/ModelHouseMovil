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
  List<Proposal>? proposals;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
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
    print("PROPOSAL: ${widget.proposals![3].status}");
    super.initState();
  }

  Future changeStatus(Proposal proposalInterface, String status) async {
    proposal = await httpProposal?.changeStatus(proposalInterface.id!, status);
    print(proposal?.status);
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
                  var status = widget.proposals![index].status;
                  if (status == 'Enviado') {
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
                  } else if (status == 'Pendiente') {
                    return RequestCard(
                      '${widget.proposals![index].name}',
                      '${widget.proposals![index].description}',
                      Container(),
                      Text("En espera de una propuesta")
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
                  var status = widget.proposals![index].status;
                  if (status == 'Pendiente') {
                    return RequestCard(
                      '${widget.proposals![index].firstName} ${widget.proposals![index].lastName}',
                      '${widget.proposals![index].description}',
                      Container(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,  // Fondo blanco
                            borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
                            border: Border.all(color: Color(0XFF02AA8B), width: 2.0),  // Borde verde
                          ),
                          child: TextButton(
                            onPressed: () {
                              navigate(context, FormProposal(widget.proposals![index].id!, widget.userProfile, widget.businessProfile));
                              // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                            },
                            style: TextButton.styleFrom(primary: Color(0XFF02AA8B)),  // Color del texto verde
                            child: Text('Elaborate Proposal'),  // Texto del botón
                          ),
                        )
                    );
                  }
                  else if (status == 'Enviado') {
                    return RequestCard(
                        '${widget.proposals![index].name}',
                        '${widget.proposals![index].description}',
                        Container(),
                        Text("En espera de una respuesta")
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
