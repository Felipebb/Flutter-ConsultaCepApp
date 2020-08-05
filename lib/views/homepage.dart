import 'package:cep_buscador/bloc/homecepquery_bloc.dart';
import 'package:cep_buscador/util/constants.dart';
import 'package:cep_buscador/models/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCepQuery extends StatefulWidget {
  HomeCepQuery({Key key}) : super(key: key);

  @override
  _HomeCepQueryState createState() => _HomeCepQueryState();
}

class _HomeCepQueryState extends State<HomeCepQuery> {
  final bloc = HomeCepQueryBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: buildAppBar(),
        body: SafeArea(
            bottom: false,
            child: Column(
              children: <Widget>[
                buildSearch(),
                SizedBox(height: kDefaultPadding / 2),
                buildCard(),
              ],
            )));
  }


  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text("Buscador de Cep"),
      centerTitle: false,
    );
  }

  Column buildSearch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(kDefaultPadding),
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
              WhitelistingTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            onChanged: (value) {
              bloc.input.add(value);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: SvgPicture.asset("assets/icons/search.svg"),
              hintText: "Digite um CEP",
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Expanded buildCard() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            height: 160,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: 136,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: [kDefaultShadow],
                  ),
                ),
                StreamBuilder<EnderecoModel>(
                    initialData: EnderecoModel(
                        bairro: "", localidade: "", uf: "", logradouro: ""),
                    stream: bloc.output,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Erro de dados"));
                      }
                      //if(snapshot.hasData){
                        //return Center(child: CircularProgressIndicator());
                     // }
                      EnderecoModel model = snapshot.data;
                      if (model.erro == true) {
                        return Center(
                            child: Text("Cep inválido!",
                                style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)));
                      } else {
                        return buildCepInfo(model);
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildCepInfo(EnderecoModel model) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        child: SizedBox(
      height: 125,
      width: size.width - 200,
      child: Column(
        children: <Widget>[
          Text("Bairro: " + model.bairro,
              style: GoogleFonts.notoSans(fontSize: 16)),
          Text("Rua: " + model.logradouro,
              style: GoogleFonts.notoSans(fontSize: 16)),
          Text("Cidade: " + model.localidade,
              style: GoogleFonts.notoSans(fontSize: 16)),
          Text("UF: " + model.uf, style: GoogleFonts.notoSans(fontSize: 16)),
        ],
      ),
    ));
  }
}
