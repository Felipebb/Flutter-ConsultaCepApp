class EnderecoModel {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;
  bool erro;

  EnderecoModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.unidade,
      this.ibge,
      this.gia,
      this.erro});

  EnderecoModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    unidade = json['unidade'];
    ibge = json['ibge'];
    gia = json['gia'];
    erro = json['erro'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['logradouro'] = this.logradouro;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['localidade'] = this.localidade;
    data['uf'] = this.uf;
    data['unidade'] = this.unidade;
    data['ibge'] = this.ibge;
    data['gia'] = this.gia;
    data['erro'] = this.erro;
    return data;
  }
}
