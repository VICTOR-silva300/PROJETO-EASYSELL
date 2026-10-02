import 'package:flutter/material.dart';

import 'tema.dart';

class EasyChat extends StatefulWidget {
  const EasyChat({super.key});

  @override
  State<EasyChat> createState() => _EasyChatState();
}

class _EasyChatState extends State<EasyChat> {
  // Cores sempre vindas do tema atual
  AppCores get c => context.cores;

  // =========================
  // CONTROLLERS
  // =========================

  final TextEditingController pesquisaController = TextEditingController();
  final TextEditingController mensagemController = TextEditingController();
  final TextEditingController novaConversaController = TextEditingController();
  final ScrollController mensagensScroll = ScrollController();

  // =========================
  // ESTADOS
  // =========================

  String conversaSelecionada = 'Mariana Costa';

  // =========================
  // CONVERSAS
  // =========================

  final List<Map<String, dynamic>> conversas = [
    {
      'nome': 'Mariana Costa',
      'cargo': 'Gerente',
      'mensagem': 'Conseguiu revisar as vendas?',
      'hora': '08:42',
      'naoLidas': 2,
      'online': true,
      'avatar': 'MC',
    },
    {
      'nome': 'Lucas Almeida',
      'cargo': 'Vendedor',
      'mensagem': 'O estoque já foi atualizado.',
      'hora': '08:25',
      'naoLidas': 0,
      'online': true,
      'avatar': 'LA',
    },
    {
      'nome': 'Ana Oliveira',
      'cargo': 'Atendimento',
      'mensagem': 'Temos três clientes aguardando.',
      'hora': 'Ontem',
      'naoLidas': 1,
      'online': true,
      'avatar': 'AO',
    },
    {
      'nome': 'Gabriel Santos',
      'cargo': 'Vendedor',
      'mensagem': 'Vou conferir os pedidos.',
      'hora': 'Ontem',
      'naoLidas': 0,
      'online': false,
      'avatar': 'GS',
    },
  ];

  // =========================
  // MENSAGENS
  // =========================

  final Map<String, List<Map<String, dynamic>>> mensagens = {
    'Mariana Costa': [
      {
        'texto': 'Bom dia! Como está o movimento hoje?',
        'minha': false,
        'hora': '08:31',
      },
      {
        'texto': 'Bom dia! Está tranquilo por enquanto.',
        'minha': true,
        'hora': '08:34',
      },
      {
        'texto': 'Conseguiu revisar as vendas?',
        'minha': false,
        'hora': '08:42',
      },
    ],
    'Lucas Almeida': [
      {
        'texto': 'Oi! Como está o estoque?',
        'minha': true,
        'hora': '08:18',
      },
      {
        'texto': 'O estoque já foi atualizado.',
        'minha': false,
        'hora': '08:25',
      },
    ],
    'Ana Oliveira': [
      {
        'texto': 'Ana, alguma novidade dos clientes?',
        'minha': true,
        'hora': 'Ontem',
      },
      {
        'texto': 'Temos três clientes aguardando.',
        'minha': false,
        'hora': 'Ontem',
      },
    ],
    'Gabriel Santos': [
      {
        'texto': 'Gabriel, conseguiu conferir os pedidos?',
        'minha': true,
        'hora': 'Ontem',
      },
      {
        'texto': 'Vou conferir os pedidos.',
        'minha': false,
        'hora': 'Ontem',
      },
    ],
  };

  @override
  void dispose() {
    pesquisaController.dispose();
    mensagemController.dispose();
    novaConversaController.dispose();
    mensagensScroll.dispose();
    super.dispose();
  }

  // =========================
  // CONVERSAS FILTRADAS
  // =========================

  List<Map<String, dynamic>> get conversasFiltradas {
    final pesquisa = pesquisaController.text.toLowerCase().trim();

    if (pesquisa.isEmpty) {
      return conversas;
    }

    return conversas.where((conversa) {
      final nome = conversa['nome'].toString().toLowerCase();
      final mensagem = conversa['mensagem'].toString().toLowerCase();
      final cargo = conversa['cargo'].toString().toLowerCase();

      return nome.contains(pesquisa) ||
          mensagem.contains(pesquisa) ||
          cargo.contains(pesquisa);
    }).toList();
  }

  List<Map<String, dynamic>> get mensagensAtuais {
    return mensagens[conversaSelecionada] ?? [];
  }

  // =========================
  // DECORAÇÕES REUTILIZÁVEIS
  // =========================

  BoxDecoration _decoracaoCard({
    bool selecionada = false,
    double raio = 21,
  }) {
    return BoxDecoration(
      gradient: c.gradCard,
      borderRadius: BorderRadius.circular(raio),
      border: Border.all(
        color: selecionada ? c.roxo.withAlpha(90) : c.bordaSutil,
      ),
    );
  }

  Widget _alca() {
    return Center(
      child: Container(
        width: 45,
        height: 4,
        decoration: BoxDecoration(
          color: c.textoFraco,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

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
              const SizedBox(height: 20),
              _barraPesquisa(),
              _resumoChat(),
              Expanded(child: _listaConversas()),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // CABEÇALHO
  // =========================

  Widget _cabecalho() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: AppCores.gradRoxo,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: c.roxo.withAlpha(66),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.chat_bubble_outline_rounded,
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
                'MENSAGENS',
                style: TextStyle(
                  color: c.textoFraco,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'EasyChat',
                style: TextStyle(
                  color: c.texto,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _novoChat,
          child: Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: c.superficie,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: c.bordaMedia),
            ),
            child: Icon(
              Icons.edit_square,
              color: c.roxoClaro,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // PESQUISA
  // =========================

  Widget _barraPesquisa() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 0, 19, 12),
      child: Container(
        decoration: BoxDecoration(
          color: c.superficie,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.bordaMedia),
        ),
        child: TextField(
          controller: pesquisaController,
          onChanged: (_) => setState(() {}),
          cursorColor: c.roxoClaro,
          style: TextStyle(color: c.texto, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Pesquisar conversas...',
            hintStyle: TextStyle(color: c.textoFraco, fontSize: 11),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: c.textoSuave,
              size: 20,
            ),
            suffixIcon: pesquisaController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      pesquisaController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: c.textoSuave,
                      size: 18,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  // =========================
  // RESUMO
  // =========================

  Widget _resumoChat() {
    final online = conversas.where((conversa) {
      return conversa['online'] == true;
    }).length;

    final naoLidas = conversas.fold<int>(
      0,
      (total, conversa) => total + (conversa['naoLidas'] as int),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 0, 19, 14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: c.gradDestaque,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: c.roxo.withAlpha(58)),
          boxShadow: [
            BoxShadow(
              color: c.roxo.withAlpha(37),
              blurRadius: 30,
              offset: const Offset(0, 13),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppCores.gradRoxo,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.forum_rounded,
                color: Colors.white,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conversas da equipe',
                    style: TextStyle(
                      color: c.texto,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.circle, color: c.verde, size: 6),
                      const SizedBox(width: 5),
                      Text(
                        '$online pessoas online agora',
                        style: TextStyle(
                          color: c.textoSuave,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (naoLidas > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: c.roxo.withAlpha(40),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: c.roxo.withAlpha(80)),
                ),
                child: Text(
                  '$naoLidas novas',
                  style: TextStyle(
                    color: c.roxoClaro,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // =========================
  // LISTA DE CONVERSAS
  // =========================

  Widget _listaConversas() {
    final lista = conversasFiltradas;

    if (lista.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: c.roxo.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search_off_rounded,
                  color: c.roxoClaro,
                  size: 34,
                ),
              ),
              const SizedBox(height: 17),
              Text(
                'Nenhuma conversa encontrada',
                style: TextStyle(
                  color: c.texto,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Tente pesquisar outro nome.',
                style: TextStyle(color: c.textoSuave, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(19, 5, 19, 30),
      physics: const BouncingScrollPhysics(),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _cardConversa(lista[index]),
        );
      },
    );
  }

  // =========================
  // CARD CONVERSA
  // =========================

  Widget _cardConversa(Map<String, dynamic> conversa) {
    final bool selecionada = conversa['nome'] == conversaSelecionada;
    final bool online = conversa['online'] == true;
    final int naoLidas = conversa['naoLidas'] as int;

    return GestureDetector(
      onTap: () {
        setState(() {
          conversaSelecionada = conversa['nome'];
          conversa['naoLidas'] = 0;
        });

        _abrirConversa(conversa);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: _decoracaoCard(selecionada: selecionada),
        child: Row(
          children: [
            Stack(
              children: [
                _avatar(conversa['avatar'], 53),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: online ? c.verde : c.textoFraco,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: c.fundo2,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversa['nome'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: c.texto,
                            fontSize: 14,
                            fontWeight: naoLidas > 0
                                ? FontWeight.w900
                                : FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        conversa['hora'],
                        style: TextStyle(
                          color: naoLidas > 0 ? c.roxoClaro : c.textoFraco,
                          fontSize: 9,
                          fontWeight: naoLidas > 0
                              ? FontWeight.w800
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    conversa['cargo'],
                    style: TextStyle(
                      color: c.roxoClaro,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversa['mensagem'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: naoLidas > 0 ? c.texto : c.textoSuave,
                            fontSize: 11,
                            fontWeight: naoLidas > 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (naoLidas > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: AppCores.gradRoxo,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$naoLidas',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // ABRIR CONVERSA
  // =========================

  void _abrirConversa(Map<String, dynamic> conversa) {
    mensagemController.clear();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        // StatefulBuilder faz as mensagens enviadas aparecerem na hora.
        return StatefulBuilder(
          builder: (context, setModalState) {
            final cores = context.cores;

            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: BoxDecoration(
                gradient: cores.gradSheet,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  _cabecalhoConversa(conversa),
                  Expanded(child: _listaMensagens()),
                  _campoMensagem(() {
                    _enviarMensagem();
                    setModalState(() {});
                    _rolarParaFim();
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _rolarParaFim() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mensagensScroll.hasClients) return;

      mensagensScroll.animateTo(
        mensagensScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  // =========================
  // CABEÇALHO DO CHAT
  // =========================

  Widget _cabecalhoConversa(Map<String, dynamic> conversa) {
    final bool online = conversa['online'] == true;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 12, 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: c.bordaSutil),
        ),
      ),
      child: Column(
        children: [
          _alca(),
          const SizedBox(height: 16),
          Row(
            children: [
              _avatar(conversa['avatar'], 46),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversa['nome'],
                      style: TextStyle(
                        color: c.texto,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: online ? c.verde : c.textoFraco,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          online ? 'Online' : 'Offline',
                          style: TextStyle(
                            color: online ? c.verde : c.textoFraco,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '• ${conversa['cargo']}',
                          style: TextStyle(
                            color: c.textoFraco,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: c.superficie,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: c.bordaMedia),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: c.textoSuave,
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================
  // LISTA DE MENSAGENS
  // =========================

  Widget _listaMensagens() {
    final lista = mensagensAtuais;

    if (lista.isEmpty) {
      return Center(
        child: Text(
          'Comece uma conversa.',
          style: TextStyle(color: c.textoSuave, fontSize: 12),
        ),
      );
    }

    return ListView.builder(
      controller: mensagensScroll,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 15),
      physics: const BouncingScrollPhysics(),
      itemCount: lista.length,
      itemBuilder: (context, index) {
        final mensagem = lista[index];

        return _mensagemChat(
          mensagem['texto'],
          mensagem['hora'],
          mensagem['minha'],
        );
      },
    );
  }

  // =========================
  // BALÃO DE MENSAGEM
  // =========================

  Widget _mensagemChat(String texto, String hora, bool minha) {
    return Align(
      alignment: minha ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
        decoration: BoxDecoration(
          gradient: minha ? AppCores.gradRoxo : c.gradCard,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(minha ? 18 : 4),
            bottomRight: Radius.circular(minha ? 4 : 18),
          ),
          border: minha ? null : Border.all(color: c.bordaSutil),
        ),
        child: Column(
          crossAxisAlignment:
              minha ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              texto,
              style: TextStyle(
                color: minha ? Colors.white : c.texto,
                fontSize: 13,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              hora,
              style: TextStyle(
                color: minha ? Colors.white70 : c.textoFraco,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CAMPO DE MENSAGEM
  // =========================

  Widget _campoMensagem(VoidCallback aoEnviar) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        12,
        10,
        12,
        MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: c.bordaSutil),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _mensagem('Anexos em breve.'),
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: c.textoSuave,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: c.superficie,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: c.bordaMedia),
              ),
              child: TextField(
                controller: mensagemController,
                cursorColor: c.roxoClaro,
                style: TextStyle(color: c.texto, fontSize: 13),
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'Digite uma mensagem...',
                  hintStyle: TextStyle(color: c.textoFraco, fontSize: 12),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: aoEnviar,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: AppCores.gradRoxo,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: c.roxo.withAlpha(66),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ENVIAR MENSAGEM
  // =========================

  void _enviarMensagem() {
    final texto = mensagemController.text.trim();

    if (texto.isEmpty) {
      return;
    }

    final hora = _horaAtual();

    setState(() {
      mensagens.putIfAbsent(conversaSelecionada, () => []);

      mensagens[conversaSelecionada]!.add({
        'texto': texto,
        'minha': true,
        'hora': hora,
      });

      final conversa = conversas.firstWhere(
        (item) => item['nome'] == conversaSelecionada,
      );

      conversa['mensagem'] = texto;
      conversa['hora'] = hora;
    });

    mensagemController.clear();
  }

  // ============================================================
  // NOVA CONVERSA
  // ============================================================

  void _novoChat() {
    novaConversaController.clear();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final cores = context.cores;

            final pesquisa =
                novaConversaController.text.toLowerCase().trim();

            final pessoas = conversas.where((pessoa) {
              final nome = pessoa['nome'].toString().toLowerCase();
              final cargo = pessoa['cargo'].toString().toLowerCase();

              return nome.contains(pesquisa) || cargo.contains(pesquisa);
            }).toList();

            return Container(
              decoration: BoxDecoration(
                gradient: cores.gradSheet,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  22,
                  12,
                  22,
                  MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _alca(),
                      const SizedBox(height: 24),
                      Text(
                        'Nova conversa',
                        style: TextStyle(
                          color: c.texto,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Escolha alguém da sua equipe para conversar.',
                        style: TextStyle(
                          color: c.textoSuave,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: c.superficie,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: c.bordaMedia),
                        ),
                        child: TextField(
                          controller: novaConversaController,
                          onChanged: (_) => setModalState(() {}),
                          cursorColor: c.roxoClaro,
                          style: TextStyle(color: c.texto, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Pesquisar membro...',
                            hintStyle: TextStyle(
                              color: c.textoFraco,
                              fontSize: 11,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: c.textoSuave,
                              size: 19,
                            ),
                            suffixIcon:
                                novaConversaController.text.isNotEmpty
                                    ? IconButton(
                                        onPressed: () {
                                          novaConversaController.clear();
                                          setModalState(() {});
                                        },
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: c.textoSuave,
                                          size: 17,
                                        ),
                                      )
                                    : null,
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Sua equipe',
                        style: TextStyle(
                          color: c.texto,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: pessoas.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person_search_rounded,
                                      color: c.textoFraco,
                                      size: 38,
                                    ),
                                    const SizedBox(height: 9),
                                    Text(
                                      'Nenhum membro encontrado',
                                      style: TextStyle(
                                        color: c.texto,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tente outro nome ou função.',
                                      style: TextStyle(
                                        color: c.textoSuave,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: pessoas.length,
                                itemBuilder: (context, index) {
                                  return _pessoaNovaConversa(
                                    pessoas[index],
                                    context,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // =========================
  // PESSOA DA NOVA CONVERSA
  // =========================

  Widget _pessoaNovaConversa(
    Map<String, dynamic> pessoa,
    BuildContext modalContext,
  ) {
    final bool online = pessoa['online'] == true;

    return GestureDetector(
      onTap: () {
        Navigator.pop(modalContext);

        setState(() {
          conversaSelecionada = pessoa['nome'];
          pessoa['naoLidas'] = 0;
        });

        Future.delayed(
          const Duration(milliseconds: 150),
          () {
            if (!mounted) return;

            _abrirConversa(pessoa);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: c.fundo2,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: c.bordaSutil),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                _avatar(pessoa['avatar'], 46),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: online ? c.verde : c.textoFraco,
                      shape: BoxShape.circle,
                      border: Border.all(color: c.fundo2, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pessoa['nome'],
                    style: TextStyle(
                      color: c.texto,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pessoa['cargo'],
                    style: TextStyle(
                      color: c.textoSuave,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: online ? c.verde : c.textoFraco,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        online ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: online ? c.verde : c.textoFraco,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: c.textoFraco,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // AVATAR
  // =========================

  Widget _avatar(String iniciais, double tamanho) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: BoxDecoration(
        gradient: AppCores.gradRoxo,
        borderRadius: BorderRadius.circular(tamanho * 0.32),
      ),
      child: Center(
        child: Text(
          iniciais,
          style: TextStyle(
            color: Colors.white,
            fontSize: tamanho * 0.3,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // =========================
  // HORA
  // =========================

  String _horaAtual() {
    final agora = DateTime.now();

    final hora = agora.hour.toString().padLeft(2, '0');
    final minuto = agora.minute.toString().padLeft(2, '0');

    return '$hora:$minuto';
  }

  // =========================
  // SNACKBAR
  // =========================

  void _mensagem(String texto) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          texto,
          style: TextStyle(
            color: c.texto,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.superficie,
        duration: const Duration(milliseconds: 1400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: c.bordaMedia),
        ),
      ),
    );
  }
}