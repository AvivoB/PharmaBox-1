/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmabox/bloc/pharmacie_bloc.dart';
import 'package:pharmabox/pharmacyProfile/pharmcie_header.dart';

class PharmaciesList extends StatefulWidget {
  const PharmaciesList({Key? key}) : super(key: key);

  @override
  State<PharmaciesList> createState() => _PharmaciesListState();
}

class _PharmaciesListState extends State<PharmaciesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PharmacieBloc>(context).add(GetAllPharmacies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Liste des pharmacies"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 67, 214, 158),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PharmacieEdit(myPharmacy: null)));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<PharmacieBloc, PharmacieState>(
            builder: (context, state) {
          if (state is PharmacieReady) {
            print(state);
            return ListView.builder(
              itemCount: state.pharmacies.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xfF161730)
.withOpacity(0.15),
                            offset: Offset(0, 1),
                            blurRadius: 2)
                      ]),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(state.pharmacies[index]!.nom),
                    leading: Image.network(
                      state.pharmacies[index]!.images[0],
                    ),
                    subtitle: Text(state.pharmacies[index]!.presentation),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PharmacieEdit(
                                  myPharmacy: state.pharmacies[index]))).then(
                          (value) => BlocProvider.of<PharmacieBloc>(context)
                              .add(GetAllPharmacies()));
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                  "Pas de pharmacies, clickez sur + pour ajouter une nouvelle pharmacie",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xfF161730)
)),
            );
          }
        }),
      ),
    );
  }
}
*/