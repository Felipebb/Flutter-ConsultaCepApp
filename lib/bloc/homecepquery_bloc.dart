import 'dart:async';

import 'package:cep_buscador/models/endereco_model.dart';
import 'package:dio/dio.dart';

class HomeCepQueryBloc {
  final _streamController = StreamController<String>.broadcast();
  Sink<String> get input => _streamController.sink;
  Stream<EnderecoModel> get output => _streamController.stream
      .where((cep) => cep.length > 7)
      .asyncMap((cep) => searchCep(cep));

  //Url padrao do webservice concatenado com o cep que irei receber do usuario para consulta
  String url(String cep) => "https://viacep.com.br/ws/$cep/json/";

  Future<EnderecoModel> searchCep(String cep) async {
    //Dio usado para requisição http
    Response response = await Dio().get(url(cep));
    return EnderecoModel.fromJson(
        response.data); //Response.data que é o Json retornado da url
  }

  void dispose() {

  }
}
