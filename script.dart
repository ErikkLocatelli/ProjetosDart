class VetorDinamico<T> {
  List<T?> _dados;
  int _tamanho = 0;

  // Construtor
  VetorDinamico([int capacidadeInicial = 4])
      : assert(capacidadeInicial > 0),
        _dados = List<T?>.filled(capacidadeInicial, null);

  // Consultas
  int tamanho() => _tamanho;
  bool estaVazio() => _tamanho == 0;
  int capacidade() => _dados.length;

  // Acesso por índice
  T operator [](int indice) {
    if (indice < 0 || indice >= _tamanho) {
      throw RangeError.index(indice, _dados, 'indice');
    }
    return _dados[indice] as T;
  }

  void operator []=(int indice, T valor) {
    if (indice < 0 || indice >= _tamanho) {
      throw RangeError.index(indice, _dados, 'indice');
    }
    _dados[indice] = valor;
  }

  // Inserção e remoção
  void adicionar(T valor) {
    _garantirCapacidade(_tamanho + 1);
    _dados[_tamanho] = valor;
    _tamanho++;
  }

  void inserir(int indice, T valor) {
    if (indice < 0 || indice > _tamanho) {
      throw RangeError.index(indice, _dados, 'indice');
    }
    _garantirCapacidade(_tamanho + 1);
    for (int i = _tamanho; i > indice; i--) {
      _dados[i] = _dados[i - 1];
    }
    _dados[indice] = valor;
    _tamanho++;
  }

  T removerEm(int indice) {
    if (indice < 0 || indice >= _tamanho) {
      throw RangeError.index(indice, _dados, 'indice');
    }
    T valor = _dados[indice] as T;
    for (int i = indice; i < _tamanho - 1; i++) {
      _dados[i] = _dados[i + 1];
    }
    _dados[_tamanho - 1] = null; 
    _tamanho--;
    return valor;
  }

  void limpar() {
    for (int i = 0; i < _tamanho; i++) {
      _dados[i] = null;
    }
    _tamanho = 0;
  }

 
  int indiceDe(T valor) {
    for (int i = 0; i < _tamanho; i++) {
      if (_dados[i] == valor) return i;
    }
    return -1;
  }

  bool contem(T valor) => indiceDe(valor) != -1;

  @override
  String toString() {
    List<T> lista = [];
    for (int i = 0; i < _tamanho; i++) {
      lista.add(_dados[i] as T);
    }
    return lista.toString();
  }

 
  void _garantirCapacidade(int capacidadeMinima) {
    if (_dados.length >= capacidadeMinima) return;

    int novaCapacidade = _dados.length * 2;
    while (novaCapacidade < capacidadeMinima) {
      novaCapacidade *= 2;
    }

    List<T?> novosDados = List<T?>.filled(novaCapacidade, null);
    for (int i = 0; i < _tamanho; i++) {
      novosDados[i] = _dados[i];
    }
    _dados = novosDados;
  }
}

void main() {
  print("=== Testando VetorDinamico com int ===");
  var vetorInt = VetorDinamico<int>();
  vetorInt.adicionar(10);
  vetorInt.adicionar(20);
  vetorInt.adicionar(30);
  vetorInt.adicionar(40);
  print("Vetor inicial: $vetorInt"); // [10, 20, 30, 40]

  vetorInt.adicionar(50); // força aumento de capacidade
  print("Após adicionar 50: $vetorInt");

  vetorInt.inserir(2, 99);
  print("Após inserir 99 na posição 2: $vetorInt");

  vetorInt[0] = 111;
  print("Após atualizar índice 0 para 111: $vetorInt");

  print("Elemento no índice 3: ${vetorInt[3]}");

  int removido = vetorInt.removerEm(1);
  print("Removido índice 1 ($removido): $vetorInt");

  print("Contém 30? ${vetorInt.contem(30)}");
  print("Índice do 99: ${vetorInt.indiceDe(99)}");

  vetorInt.limpar();
  print("Após limpar: $vetorInt (tamanho=${vetorInt.tamanho()})");

  print("\n=== Testando VetorDinamico com String ===");
  var vetorStr = VetorDinamico<String>();
  vetorStr.adicionar("A");
  vetorStr.adicionar("B");
  vetorStr.adicionar("C");
  print("Vetor inicial: $vetorStr");

  vetorStr.inserir(1, "X");
  print("Após inserir 'X' na posição 1: $vetorStr");

  vetorStr[2] = "Y";
  print("Após atualizar índice 2 para 'Y': $vetorStr");

  String removidoStr = vetorStr.removerEm(0);
  print("Removido índice 0 ($removidoStr): $vetorStr");

  print("Contém 'B'? ${vetorStr.contem("B")}");
  print("Índice do 'Y': ${vetorStr.indiceDe("Y")}");
}

