import 'package:flutter/material.dart';

import 'tema.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  AppCores get c => context.cores;

  static const int limiteEstoque = 8;

  static const List<String> categorias = [
    'Eletrônicos',
    'Periféricos',
    'Outros',
  ];

  static const List<String> filtros = [
    'Todos',
    'Ativos',
    'Estoque baixo',
    'Eletrônicos',
    'Periféricos',
  ];

  final TextEditingController pesquisaController = TextEditingController();

  String filtro = 'Todos';

  // 'cor' guarda uma chave (e não uma Color) para acompanhar o tema.
  final List<Map<String, dynamic>> produtos = [
    {
      'nome': 'Notebook Pro',
      'categoria': 'Eletrônicos',
      'preco': 2450.00,
      'estoque': 32,
      'cor': 'azul',
      'icon': Icons.laptop_mac_rounded,
      'ativo': true,
    },
    {
      'nome': 'Monitor Ultra 24"',
      'categoria': 'Eletrônicos',
      'preco': 890.00,
      'estoque': 24,
      'cor': 'verde',
      'icon': Icons.desktop_windows_rounded,
      'ativo': true,
    },
    {
      'nome': 'Teclado Mecânico',
      'categoria': 'Periféricos',
      'preco': 420.00,
      'estoque': 18,
      'cor': 'roxo',
      'icon': Icons.keyboard_rounded,
      'ativo': true,
    },
    {
      'nome': 'Mouse Gamer',
      'categoria': 'Periféricos',
      'preco': 280.00,
      'estoque': 7,
      'cor': 'amarelo',
      'icon': Icons.mouse_rounded,
      'ativo': true,
    },
    {
      'nome': 'Headset Pro',
      'categoria': 'Periféricos',
      'preco': 350.00,
      'estoque': 5,
      'cor': 'vermelho',
      'icon': Icons.headset_rounded,
      'ativo': true,
    },
    {
      'nome': 'Webcam Full HD',
      'categoria': 'Eletrônicos',
      'preco': 299.00,
      'estoque': 14,
      'cor': 'azul',
      'icon': Icons.videocam_outlined,
      'ativo': true,
    },
  ];

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------
  Color corClara(Color cor, int alpha) => cor.withAlpha(alpha);

  Color _cor(String chave) {
    switch (chave) {
      case 'azul':
        return c.azul;
      case 'verde':
        return c.verde;
      case 'amarelo':
        return c.amarelo;
      case 'vermelho':
        return c.vermelho;
      default:
        return c.roxoClaro;
    }
  }

  BoxDecoration _decoracaoCard({double raio = 24}) {
    return BoxDecoration(
      gradient: c.gradCard,
      borderRadius: BorderRadius.circular(raio),
      border: Border.all(color: c.bordaSutil),
    );
  }

  List<Map<String, dynamic>> get produtosFiltrados {
    final pesquisa = pesquisaController.text.toLowerCase().trim();

    return produtos.where((produto) {
      final nome = produto['nome'].toString().toLowerCase();
      final categoria = produto['categoria'].toString().toLowerCase();
      final estoque = produto['estoque'] as int;

      final correspondePesquisa =
          nome.contains(pesquisa) || categoria.contains(pesquisa);

      bool correspondeFiltro = true;

      if (filtro == 'Ativos') {
        correspondeFiltro = produto['ativo'] == true;
      } else if (filtro == 'Estoque baixo') {
        correspondeFiltro = estoque <= limiteEstoque;
      } else if (filtro == 'Eletrônicos' || filtro == 'Periféricos') {
        correspondeFiltro = produto['categoria'] == filtro;
      }

      return correspondePesquisa && correspondeFiltro;
    }).toList();
  }

  int get totalProdutos => produtos.length;

  int get produtosAtivos => produtos.where((p) => p['ativo'] == true).length;

  int get estoqueBaixo =>
      produtos.where((p) => (p['estoque'] as int) <= limiteEstoque).length;

  /// 2450.0 -> "R$ 2.450,00"
  String _preco(dynamic valor) {
    final partes = (valor as num).toStringAsFixed(2).split('.');
    final inteiro = partes[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => '.',
    );

    return 'R\$ $inteiro,${partes[1]}';
  }

  // ---------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final lista = produtosFiltrados;

    return Container(
      decoration: BoxDecoration(gradient: c.gradFundo),
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(19, 15, 19, 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _cabecalho(),
                  const SizedBox(height: 27),
                  _tituloPagina(),
                  const SizedBox(height: 21),
                  _resumo(),
                  const SizedBox(height: 25),
                  _barraPesquisa(),
                  const SizedBox(height: 29),
                  _tituloSecao(lista.length),
                  const SizedBox(height: 13),
                  _listaProdutos(lista),
                  const SizedBox(height: 24),
                  _avisoEstoque(),
                  const SizedBox(height: 15),
                  _botaoAdicionar(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Cabeçalho
  // ---------------------------------------------------------------
  Widget _cabecalho() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: AppCores.gradRoxo,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x427C3AED),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.inventory_2_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GERENCIAMENTO',
                style: TextStyle(
                  color: c.textoFraco,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Produtos',
                style: TextStyle(
                  color: c.texto,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        _botaoCabecalho(
          icon: Icons.notifications_none_rounded,
          notificacao: estoqueBaixo > 0,
          onTap: _abrirNotificacoes,
        ),
        const SizedBox(width: 8),
        _botaoCabecalho(
          icon: Icons.more_horiz_rounded,
          onTap: _abrirMenu,
        ),
      ],
    );
  }

  Widget _botaoCabecalho({
    required IconData icon,
    required VoidCallback onTap,
    bool notificacao = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: c.superficie,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: c.bordaMedia),
            ),
            child: Icon(icon, color: c.texto, size: 20),
          ),
          if (notificacao)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: c.vermelho,
                  shape: BoxShape.circle,
                  border: Border.all(color: c.superficie, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tituloPagina() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seus produtos 📦',
          style: TextStyle(
            color: c.texto,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Acompanhe e gerencie todos os produtos do seu negócio.',
          style: TextStyle(color: c.textoSuave, fontSize: 12),
        ),
        const SizedBox(height: 15),
        Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [c.roxo, c.roxoClaro]),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Resumo
  // ---------------------------------------------------------------
  Widget _resumo() {
    return Row(
      children: [
        Expanded(
          child: _cardResumo(
            icon: Icons.inventory_2_outlined,
            titulo: 'Produtos',
            valor: totalProdutos.toString(),
            detalhe: 'total',
            cor: c.roxoClaro,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _cardResumo(
            icon: Icons.check_circle_outline_rounded,
            titulo: 'Ativos',
            valor: produtosAtivos.toString(),
            detalhe: 'em venda',
            cor: c.verde,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _cardResumo(
            icon: Icons.warning_amber_rounded,
            titulo: 'Estoque baixo',
            valor: estoqueBaixo.toString().padLeft(2, '0'),
            detalhe: 'atenção',
            cor: c.amarelo,
          ),
        ),
      ],
    );
  }

  Widget _cardResumo({
    required IconData icon,
    required String titulo,
    required String valor,
    required String detalhe,
    required Color cor,
  }) {
    return Container(
      height: 133,
      padding: const EdgeInsets.all(13),
      decoration: _decoracaoCard(raio: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: corClara(cor, 27),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: cor, size: 18),
              ),
              const Spacer(),
              Icon(Icons.arrow_upward_rounded, color: cor, size: 13),
            ],
          ),
          const Spacer(),
          Text(
            valor,
            style: TextStyle(
              color: c.texto,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  titulo,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: c.textoSuave, fontSize: 9),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: corClara(cor, 25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  detalhe,
                  style: TextStyle(
                    color: cor,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------
  // Pesquisa
  // ---------------------------------------------------------------
  Widget _barraPesquisa() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: c.superficie,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: c.bordaMedia),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: c.textoFraco, size: 21),
          const SizedBox(width: 11),
          Expanded(
            child: TextField(
              controller: pesquisaController,
              onChanged: (_) => setState(() {}),
              style: TextStyle(color: c.texto, fontSize: 12),
              cursorColor: c.roxoClaro,
              decoration: InputDecoration(
                hintText: 'Pesquisar produto...',
                hintStyle: TextStyle(color: c.textoFraco, fontSize: 12),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (pesquisaController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                pesquisaController.clear();
                setState(() {});
              },
              child: Icon(Icons.close_rounded, color: c.textoSuave, size: 19),
            ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _abrirFiltros,
            child: Icon(
              Icons.tune_rounded,
              color: filtro == 'Todos' ? c.roxoClaro : c.verde,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tituloSecao(int quantidade) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 4,
          height: 34,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [c.roxoClaro, c.roxo]),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Produtos',
                style: TextStyle(
                  color: c.texto,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                filtro == 'Todos'
                    ? '$quantidade produtos encontrados'
                    : '$filtro • $quantidade encontrados',
                style: TextStyle(color: c.textoFraco, fontSize: 10),
              ),
            ],
          ),
        ),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: c.roxoClaro,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Lista
  // ---------------------------------------------------------------
  Widget _listaProdutos(List<Map<String, dynamic>> lista) {
    if (lista.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: _decoracaoCard(),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: corClara(c.roxoClaro, 27),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.search_off_rounded,
                color: c.roxoClaro,
                size: 28,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Nenhum produto encontrado',
              style: TextStyle(
                color: c.texto,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tente pesquisar outro produto.',
              style: TextStyle(color: c.textoSuave, fontSize: 10),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: _decoracaoCard(),
      child: Column(
        children: [
          for (int i = 0; i < lista.length; i++) ...[
            _produtoCard(lista[i]),
            if (i != lista.length - 1) _divisor(),
          ],
        ],
      ),
    );
  }

  Widget _produtoCard(Map<String, dynamic> produto) {
    final Color cor = _cor(produto['cor']);
    final int estoque = produto['estoque'];
    final bool ativo = produto['ativo'] == true;
    final Color corStatus = ativo ? c.verde : c.vermelho;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _abrirDetalhes(produto),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: corClara(cor, 30),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: corClara(cor, 38)),
                ),
                child: Icon(produto['icon'], color: cor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto['nome'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: c.texto,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      produto['categoria'],
                      style: TextStyle(color: c.textoFraco, fontSize: 10),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$estoque unidades',
                      style: TextStyle(
                        color: estoque <= limiteEstoque ? c.amarelo : cor,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _preco(produto['preco']),
                    style: TextStyle(
                      color: c.texto,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: corClara(corStatus, 24),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: corClara(corStatus, 40)),
                    ),
                    child: Text(
                      ativo ? 'Ativo' : 'Inativo',
                      style: TextStyle(
                        color: corStatus,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.chevron_right_rounded,
                color: c.textoFraco,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divisor() {
    return Padding(
      padding: const EdgeInsets.only(left: 75),
      child: Divider(color: c.bordaSutil, height: 1),
    );
  }

  // ---------------------------------------------------------------
  // Aviso de estoque e botão
  // ---------------------------------------------------------------
  Widget _avisoEstoque() {
    return GestureDetector(
      onTap: () => setState(() => filtro = 'Estoque baixo'),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              corClara(c.amarelo, 40),
              corClara(c.amarelo, 12),
            ],
          ),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: corClara(c.amarelo, 56)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: corClara(c.amarelo, 32),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: corClara(c.amarelo, 42)),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: c.amarelo,
                size: 22,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estoque baixo',
                    style: TextStyle(
                      color: c.texto,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$estoqueBaixo produtos precisam de atenção.',
                    style: TextStyle(color: c.textoSuave, fontSize: 10),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: corClara(c.amarelo, 32),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: corClara(c.amarelo, 53)),
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: c.amarelo,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoAdicionar() {
    return _botaoPrincipal(
      label: 'Adicionar produto',
      icon: Icons.add_rounded,
      onTap: _adicionarProduto,
    );
  }

  Widget _botaoPrincipal({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppCores.gradRoxo,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x357C3AED),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(17),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Sheet padrão (mesmo estilo da Home)
  // ---------------------------------------------------------------
  Future<void> _sheet({
    required Widget child,
    double alturaMaxima = 0.86,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * alturaMaxima,
          ),
          decoration: BoxDecoration(
            gradient: c.gradSheet,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                22,
                12,
                22,
                28 + MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Column(
                children: [
                  Container(
                    width: 45,
                    height: 4,
                    decoration: BoxDecoration(
                      color: c.textoFraco,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  child,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _tituloSheet(String titulo, String subtitulo) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: c.texto,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitulo,
            style: TextStyle(color: c.textoSuave, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _itemLista({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required Color cor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: c.fundo2,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: c.bordaSutil),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: corClara(cor, 28),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: cor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: TextStyle(
                          color: c.texto,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitulo,
                        style: TextStyle(color: c.textoSuave, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: c.textoFraco,
                    size: 15,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipSelecao(String label, bool selecionado, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          gradient: selecionado
              ? const LinearGradient(
                  colors: [
                    Color(0x327C3AED),
                    Color(0x187C3AED),
                  ],
                )
              : null,
          color: selecionado ? null : c.superficie,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selecionado ? const Color(0x357C3AED) : c.bordaSutil,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selecionado ? c.texto : c.textoSuave,
            fontSize: 10,
            fontWeight: selecionado ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Filtros
  // ---------------------------------------------------------------
  void _abrirFiltros() {
    _sheet(
      alturaMaxima: 0.8,
      child: Column(
        children: [
          _tituloSheet(
            'Filtrar produtos',
            'Escolha quais produtos deseja visualizar',
          ),
          const SizedBox(height: 21),
          ...filtros.map((item) => _opcaoFiltro(item)),
        ],
      ),
    );
  }

  Widget _opcaoFiltro(String texto) {
    final selecionado = texto == filtro;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          onTap: () {
            setState(() => filtro = texto);
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: c.fundo2,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: selecionado ? const Color(0x557C3AED) : c.bordaSutil,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  selecionado
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  color: selecionado ? c.roxoClaro : c.textoFraco,
                  size: 20,
                ),
                const SizedBox(width: 13),
                Text(
                  texto,
                  style: TextStyle(
                    color: selecionado ? c.texto : c.textoSuave,
                    fontSize: 13,
                    fontWeight:
                        selecionado ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Detalhes
  // ---------------------------------------------------------------
  void _abrirDetalhes(Map<String, dynamic> produto) {
    final Color cor = _cor(produto['cor']);

    _sheet(
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: corClara(cor, 30),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: corClara(cor, 38)),
            ),
            child: Icon(produto['icon'], color: cor, size: 30),
          ),
          const SizedBox(height: 14),
          Text(
            produto['nome'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: c.texto,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            produto['categoria'],
            style: TextStyle(color: c.textoSuave, fontSize: 12),
          ),
          const SizedBox(height: 22),
          _detalheLinha('Preço', _preco(produto['preco'])),
          _detalheLinha('Estoque', '${produto['estoque']} unidades'),
          _detalheLinha('Status', produto['ativo'] ? 'Ativo' : 'Inativo'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _botaoDetalhe(
                  texto: 'Diminuir estoque',
                  icon: Icons.remove_rounded,
                  onTap: () {
                    if (produto['estoque'] > 0) {
                      setState(() => produto['estoque']--);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _botaoDetalhe(
                  texto: 'Aumentar estoque',
                  icon: Icons.add_rounded,
                  onTap: () {
                    setState(() => produto['estoque']++);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detalheLinha(String titulo, String valor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: c.fundo2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.bordaSutil),
      ),
      child: Row(
        children: [
          Text(
            titulo,
            style: TextStyle(color: c.textoSuave, fontSize: 11),
          ),
          const Spacer(),
          Text(
            valor,
            style: TextStyle(
              color: c.texto,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoDetalhe({
    required String texto,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0x207C3AED),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0x357C3AED)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: c.roxoClaro, size: 17),
              const SizedBox(width: 6),
              Text(
                texto,
                style: TextStyle(
                  color: c.roxoClaro,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Notificações e menu
  // ---------------------------------------------------------------
  void _abrirNotificacoes() {
    _sheet(
      alturaMaxima: 0.7,
      child: Column(
        children: [
          _tituloSheet(
            'Notificações',
            'Avisos importantes dos seus produtos',
          ),
          const SizedBox(height: 20),
          _itemLista(
            icon: Icons.warning_amber_rounded,
            titulo: 'Estoque baixo',
            subtitulo: '$estoqueBaixo produtos precisam de atenção.',
            cor: c.amarelo,
          ),
          _itemLista(
            icon: Icons.inventory_2_outlined,
            titulo: 'Produtos ativos',
            subtitulo: '$produtosAtivos produtos estão ativos.',
            cor: c.verde,
          ),
        ],
      ),
    );
  }

  void _abrirMenu() {
    _sheet(
      alturaMaxima: 0.7,
      child: Builder(
        builder: (sheetContext) {
          return Column(
            children: [
              _tituloSheet('Ações', 'Gerencie seus produtos rapidamente'),
              const SizedBox(height: 21),
              _itemLista(
                icon: Icons.add_box_outlined,
                titulo: 'Adicionar produto',
                subtitulo: 'Cadastre um novo produto',
                cor: c.roxoClaro,
                onTap: () {
                  Navigator.pop(sheetContext);
                  _adicionarProduto();
                },
              ),
              _itemLista(
                icon: Icons.filter_alt_outlined,
                titulo: 'Filtrar produtos',
                subtitulo: 'Escolha o que deseja visualizar',
                cor: c.azul,
                onTap: () {
                  Navigator.pop(sheetContext);
                  _abrirFiltros();
                },
              ),
              _itemLista(
                icon: Icons.filter_alt_off_outlined,
                titulo: 'Limpar filtros',
                subtitulo: 'Voltar a mostrar todos os produtos',
                cor: c.verde,
                onTap: () {
                  Navigator.pop(sheetContext);
                  pesquisaController.clear();
                  setState(() => filtro = 'Todos');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------
  // Novo produto
  // ---------------------------------------------------------------
  void _adicionarProduto() {
    final nomeController = TextEditingController();
    final precoController = TextEditingController();
    final estoqueController = TextEditingController();

    String categoriaSel = categorias.first;
    String? erro;

    _sheet(
      alturaMaxima: 0.94,
      child: StatefulBuilder(
        builder: (context, setSheet) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tituloSheet('Novo produto', 'Cadastre um produto no EasySell'),
              const SizedBox(height: 21),
              _rotuloCampo('Nome do produto'),
              const SizedBox(height: 8),
              _campo(
                nomeController,
                'Ex.: Notebook Pro',
                Icons.inventory_2_outlined,
              ),
              const SizedBox(height: 16),
              _rotuloCampo('Preço'),
              const SizedBox(height: 8),
              _campo(
                precoController,
                'Ex.: 289,90',
                Icons.payments_outlined,
                teclado: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              _rotuloCampo('Quantidade em estoque'),
              const SizedBox(height: 8),
              _campo(
                estoqueController,
                'Ex.: 20',
                Icons.warehouse_outlined,
                teclado: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _rotuloCampo('Categoria'),
              const SizedBox(height: 10),
              Wrap(
                children: categorias
                    .map(
                      (cat) => _chipSelecao(
                        cat,
                        categoriaSel == cat,
                        () => setSheet(() => categoriaSel = cat),
                      ),
                    )
                    .toList(),
              ),
              if (erro != null) ...[
                const SizedBox(height: 4),
                Text(
                  erro!,
                  style: TextStyle(
                    color: c.vermelho,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              _botaoPrincipal(
                label: 'Adicionar produto',
                icon: Icons.check_rounded,
                onTap: () {
                  final nome = nomeController.text.trim();
                  final preco = _lerValor(precoController.text);
                  final estoque = int.tryParse(estoqueController.text.trim());

                  if (nome.isEmpty) {
                    setSheet(() => erro = 'Informe o nome do produto.');
                    return;
                  }

                  if (preco == null || preco < 0) {
                    setSheet(() => erro = 'Digite um preço válido.');
                    return;
                  }

                  if (estoque == null || estoque < 0) {
                    setSheet(() => erro = 'Informe a quantidade em estoque.');
                    return;
                  }

                  setState(() {
                    produtos.add({
                      'nome': nome,
                      'categoria': categoriaSel,
                      'preco': preco,
                      'estoque': estoque,
                      'cor': categoriaSel == 'Eletrônicos'
                          ? 'azul'
                          : categoriaSel == 'Periféricos'
                              ? 'verde'
                              : 'roxo',
                      'icon': categoriaSel == 'Eletrônicos'
                          ? Icons.devices_rounded
                          : categoriaSel == 'Periféricos'
                              ? Icons.keyboard_rounded
                              : Icons.inventory_2_outlined,
                      'ativo': true,
                    });
                  });

                  Navigator.pop(context);
                  _mensagem('Produto adicionado!');
                },
              ),
            ],
          );
        },
      ),
    ).whenComplete(() {
      nomeController.dispose();
      precoController.dispose();
      estoqueController.dispose();
    });
  }

  Widget _rotuloCampo(String texto) {
    return Text(
      texto.toUpperCase(),
      style: TextStyle(
        color: c.textoFraco,
        fontSize: 9,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _campo(
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType? teclado,
  }) {
    return TextField(
      controller: controller,
      keyboardType: teclado,
      cursorColor: c.roxoClaro,
      style: TextStyle(color: c.texto, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: c.textoFraco, fontSize: 12),
        prefixIcon: Icon(icon, color: c.roxoClaro, size: 19),
        filled: true,
        fillColor: c.fundo2,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: c.bordaSutil),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0x557C3AED)),
        ),
      ),
    );
  }

  /// Aceita "289,90", "289.90" e "1.250,50".
  double? _lerValor(String texto) {
    var t = texto.trim().replaceAll('R\$', '').replaceAll(' ', '');

    if (t.contains(',')) {
      t = t.replaceAll('.', '').replaceAll(',', '.');
    }

    return double.tryParse(t);
  }

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            texto,
            style: const TextStyle(color: Color(0xFFF8FAFC), fontSize: 12),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF181F31),
          duration: const Duration(milliseconds: 1600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0x18FFFFFF)),
          ),
        ),
      );
  }
}