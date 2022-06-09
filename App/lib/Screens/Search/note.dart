class Note {
  String nome;
  int id;

  Note(this.nome, this.id);

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }
}
