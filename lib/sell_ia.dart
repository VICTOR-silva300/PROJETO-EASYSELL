import 'package:flutter/material.dart';

import 'tema.dart';

class SellIA extends StatefulWidget {
  const SellIA({super.key});

  @override
  State<SellIA> createState() => _SellIAState();
}

class _SellIAState extends State<SellIA> {
  AppCores get c => context.cores;

  final TextEditingController mensagemController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> mensagens = [
    {
      'tipo': 'ia',
      'texto':
          'Olá! Eu sou a Sell IA 👋\n\nPosso ajudar você a entender suas vendas, produtos, estoque e resultados do negócio.',
    },
  ];

  bool pensando = false;

  @override
  void dispose() {
    mensagemController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Color corClara(Color cor, int alpha) => cor.withAlpha(alpha);

  BoxDecoration _decoracaoCard({double raio = 24}) {
    return BoxDecoration(
      gradient: c.gradCard,
      borderRadius: BorderRadius.circular(raio),
      border: Border.all(color: c.bordaSutil),
    );
  }

  // ---------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c.fundo,
      body: Container(
        decoration: BoxDecoration(gradient: c.gradFundo),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 15, 19, 0),
                child: _cabecalho(),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(19, 22, 19, 16),
                  children: [
                    _cardApresentacao(),
                    const SizedBox(height: 20),
                    ...mensagens.map(_mensagem),
                    if (pensando) _indicadorPensando(),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
              _sugestoes(),
              _campoMensagem(),
            ],
          ),
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
            Icons.auto_awesome_rounded,
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
                'ASSISTENTE INTELIGENTE',
                style: TextStyle(
                  color: c.textoFraco,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Sell IA',
                    style: TextStyle(
                      color: c.texto,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: corClara(c.verde, 24),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: corClara(c.verde, 38)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: c.verde, size: 6),
                        const SizedBox(width: 4),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: c.verde,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _limparConversa,
          child: Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: c.superficie,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: c.bordaMedia),
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              color: c.texto,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Card de apresentação
  // ---------------------------------------------------------------
  Widget _cardApresentacao() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: c.gradDestaque,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: const Color(0x3A7C3AED)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x257C3AED),
            blurRadius: 30,
            offset: Offset(0, 13),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppCores.gradRoxo,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Seu negócio em um só lugar',
                  style: TextStyle(
                    color: c.texto,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Pergunte sobre suas vendas, produtos ou estoque. A Sell IA analisa as informações do seu sistema e ajuda você a tomar decisões.',
            style: TextStyle(
              color: c.textoSuave,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Container(height: 1, color: c.bordaSutil),
          const SizedBox(height: 16),
          Row(
            children: [
              _miniInfo(
                Icons.trending_up_rounded,
                'Vendas',
                '+12%',
                c.verde,
              ),
              _miniInfo(
                Icons.inventory_2_outlined,
                'Produtos',
                '246',
                c.azul,
              ),
              _miniInfo(
                Icons.warning_amber_rounded,
                'Alertas',
                '08',
                c.amarelo,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniInfo(IconData icone, String titulo, String valor, Color cor) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: corClara(cor, 24),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icone, color: cor, size: 13),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(color: c.textoFraco, fontSize: 9),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: TextStyle(
                    color: cor,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------
  // Mensagens
  // ---------------------------------------------------------------
  Widget _mensagem(Map<String, dynamic> mensagem) {
    final bool isIA = mensagem['tipo'] == 'ia';

    return Align(
      alignment: isIA ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        margin: EdgeInsets.only(
          bottom: 12,
          left: isIA ? 0 : 35,
          right: isIA ? 35 : 0,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: isIA ? c.gradCard : AppCores.gradRoxo,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(19),
            topRight: const Radius.circular(19),
            bottomLeft: Radius.circular(isIA ? 5 : 19),
            bottomRight: Radius.circular(isIA ? 19 : 5),
          ),
          border: isIA ? Border.all(color: c.bordaSutil) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isIA)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: c.roxoClaro,
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Sell IA',
                      style: TextStyle(
                        color: c.roxoClaro,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            Text(
              mensagem['texto'],
              style: TextStyle(
                color: isIA ? c.texto : Colors.white,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicadorPensando() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: _decoracaoCard(raio: 18),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: c.roxoClaro,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Analisando...',
              style: TextStyle(color: c.textoSuave, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Sugestões e campo
  // ---------------------------------------------------------------
  Widget _sugestoes() {
    const sugestoes = [
      {
        'texto': 'Como estão minhas vendas?',
        'icone': Icons.trending_up_rounded,
      },
      {
        'texto': 'Quais produtos estão vendendo mais?',
        'icone': Icons.star_outline_rounded,
      },
      {
        'texto': 'Tenho produtos com estoque baixo?',
        'icone': Icons.inventory_2_outlined,
      },
      {
        'texto': 'Analise meu faturamento',
        'icone': Icons.analytics_outlined,
      },
    ];

    return SizedBox(
      height: 46,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 19),
        itemCount: sugestoes.length,
        itemBuilder: (context, index) {
          final sugestao = sugestoes[index];

          return GestureDetector(
            onTap: () => _enviarMensagem(sugestao['texto'] as String),
            child: Container(
              margin: const EdgeInsets.only(right: 8, bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: c.superficie,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: c.bordaMedia),
              ),
              child: Row(
                children: [
                  Icon(
                    sugestao['icone'] as IconData,
                    color: c.roxoClaro,
                    size: 15,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    sugestao['texto'] as String,
                    style: TextStyle(color: c.textoSuave, fontSize: 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _campoMensagem() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 6, 19, 12),
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 7),
        decoration: BoxDecoration(
          color: c.superficie,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.bordaMedia),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: mensagemController,
                style: TextStyle(color: c.texto, fontSize: 12),
                cursorColor: c.roxoClaro,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _enviarMensagem(mensagemController.text),
                decoration: InputDecoration(
                  hintText: 'Pergunte algo para a Sell IA...',
                  hintStyle: TextStyle(color: c.textoFraco, fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _enviarMensagem(mensagemController.text),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: AppCores.gradRoxo,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------
  // Lógica
  // ---------------------------------------------------------------
  void _enviarMensagem(String texto) {
    texto = texto.trim();

    if (texto.isEmpty || pensando) return;

    setState(() {
      mensagens.add({'tipo': 'usuario', 'texto': texto});
      mensagemController.clear();
      pensando = true;
    });

    _irParaFinal();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      setState(() {
        pensando = false;
        mensagens.add({'tipo': 'ia', 'texto': _gerarResposta(texto)});
      });

      _irParaFinal();
    });
  }

  String _gerarResposta(String pergunta) {
    final texto = pergunta.toLowerCase();

    if (texto.contains('venda') || texto.contains('vendendo')) {
      return 'Analisando suas vendas atuais, você possui 128 vendas registradas e um faturamento mensal de R\$ 8.450,00. O ticket médio está em aproximadamente R\$ 66,00.\n\nPosso também ajudar a identificar os períodos ou produtos com maior desempenho.';
    }

    if (texto.contains('estoque') || texto.contains('produto')) {
      return 'Seu estoque possui 246 produtos cadastrados. Existem alguns itens que merecem atenção por estarem próximos do estoque mínimo.\n\nUma boa ideia é revisar esses produtos antes de realizar novas vendas.';
    }

    if (texto.contains('faturamento') ||
        texto.contains('dinheiro') ||
        texto.contains('receita')) {
      return 'Seu faturamento atual está em R\$ 8.450,00. O valor pode ser acompanhado pela tela de Vendas, onde você também consegue visualizar pedidos, pagamentos e status.';
    }

    if (texto.contains('preço')) {
      return 'Para analisar preços, compare o valor atual do produto com seu custo, margem desejada e volume de vendas. Produtos com alta procura podem ter uma estratégia de preço diferente dos produtos com baixa saída.';
    }

    if (texto.contains('olá') || texto.contains('oi') || texto.contains('ola')) {
      return 'Olá! 👋\n\nEstou pronta para ajudar você a analisar o seu negócio. Você pode perguntar sobre vendas, estoque, produtos ou faturamento.';
    }

    return 'Entendi sua pergunta. Posso ajudar com vendas, produtos, estoque, faturamento e análise do seu negócio.\n\nExperimente perguntar algo como “Como estão minhas vendas?” ou “Tenho produtos com estoque baixo?”.';
  }

  void _irParaFinal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _limparConversa() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 26),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: c.gradSheet,
              borderRadius: BorderRadius.circular(27),
              border: Border.all(color: c.bordaMedia),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: corClara(c.vermelho, 32),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: corClara(c.vermelho, 42)),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: c.vermelho,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Limpar conversa?',
                  style: TextStyle(
                    color: c.texto,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Todas as mensagens desta conversa serão removidas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: c.textoSuave,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: c.textoSuave,
                          side: BorderSide(color: c.bordaMedia),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            mensagens
                              ..clear()
                              ..add({
                                'tipo': 'ia',
                                'texto':
                                    'Conversa limpa. Como posso ajudar você agora? 👋',
                              });
                          });
                          Navigator.pop(dialogContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c.vermelho,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Limpar',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}