import 'package:flutter/material.dart';

import 'tema.dart';
import 'produtos.dart';
import 'vendas.dart';
import 'easycrew.dart';
import 'equipe.dart';
import 'easychat.dart';
import 'easymarket.dart';
import 'opcoes.dart';
import 'sobre.dart';
import 'sell_ia.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int telaAtual = 0;

  AppCores get c => context.cores;

  void mudarTela(int index) {
    setState(() {
      telaAtual = index;
    });
  }

  Widget telaSelecionada() {
    switch (telaAtual) {
      case 1:
        return const Produtos();

      case 2:
        return const Vendas();

      case 3:
        return const Equipe();

      case 4:
        return const SellIA();

      case 5:
        return const EasyMarket();

      case 6:
        return const Sobre();

      case 7:
        return const Opcoes();

      case 8:
        return const EasyChat();

      case 9:
        return const EasyCrew();

      default:
        return DashboardHome(
          mudarTela: mudarTela,
          abrirMenu: abrirMenu,
          abrirNotificacoes: abrirNotificacoes,
        );
    }
  }

  // ============================================================
  // NOTIFICAÇÕES
  // ============================================================

  void abrirNotificacoes() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        final cores = context.cores;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.78,
          ),
          decoration: BoxDecoration(
            gradient: cores.gradSheet,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              child: Column(
                children: [
                  Container(
                    width: 45,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cores.textoFraco,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notificações',
                              style: TextStyle(
                                color: cores.texto,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Acompanhe as novidades do seu negócio',
                              style: TextStyle(
                                color: cores.textoSuave,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: cores.vermelho.withAlpha(36),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: cores.vermelho.withAlpha(55),
                          ),
                        ),
                        child: Text(
                          '3 novas',
                          style: TextStyle(
                            color: cores.vermelho,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _notificacao(
                    cores: cores,
                    icon: Icons.inventory_2_outlined,
                    titulo: 'Estoque baixo',
                    descricao: '12 produtos estão próximos de acabar.',
                    tempo: '10 min',
                    cor: cores.amarelo,
                  ),
                  _notificacao(
                    cores: cores,
                    icon: Icons.shopping_bag_outlined,
                    titulo: 'Nova venda realizada',
                    descricao: 'Venda #1028 no valor de R\$ 2.450,00.',
                    tempo: '25 min',
                    cor: cores.verde,
                  ),
                  _notificacao(
                    cores: cores,
                    icon: Icons.person_add_alt_1_outlined,
                    titulo: 'Novo funcionário',
                    descricao: 'Um novo membro foi adicionado à equipe.',
                    tempo: '1h',
                    cor: cores.azul,
                  ),
                  _notificacao(
                    cores: cores,
                    icon: Icons.auto_awesome_outlined,
                    titulo: 'Relatório disponível',
                    descricao: 'O relatório mensal já está disponível.',
                    tempo: '3h',
                    cor: cores.roxoClaro,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _notificacao({
    required AppCores cores,
    required IconData icon,
    required String titulo,
    required String descricao,
    required String tempo,
    required Color cor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cores.fundo2,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: cores.bordaSutil),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cor.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: cor, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    color: cores.texto,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  descricao,
                  style: TextStyle(
                    color: cores.textoSuave,
                    fontSize: 10,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Text(tempo, style: TextStyle(color: cores.textoFraco, fontSize: 8)),
        ],
      ),
    );
  }

  // ============================================================
  // MENU DE SERVIÇOS
  // ============================================================

  void abrirMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        final cores = context.cores;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.86,
          ),
          decoration: BoxDecoration(
            gradient: cores.gradSheet,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              child: Column(
                children: [
                  Container(
                    width: 45,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cores.textoFraco,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Serviços EasySell',
                      style: TextStyle(
                        color: cores.texto,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Acesse outras ferramentas do aplicativo',
                      style: TextStyle(color: cores.textoSuave, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 21),
                  _itemMenu(
                    cores: cores,
                    icon: Icons.storefront_rounded,
                    titulo: 'EasyMarket',
                    subtitulo: 'Produtos e oportunidades',
                    cor: cores.azul,
                    onTap: () {
                      Navigator.pop(context);
                      mudarTela(5);
                    },
                  ),
                  _itemMenu(
                    cores: cores,
                    icon: Icons.groups_rounded,
                    titulo: 'EasyCrew',
                    subtitulo: 'Equipe e colaboração',
                    cor: cores.roxoClaro,
                    onTap: () {
                      Navigator.pop(context);
                      mudarTela(9);
                    },
                  ),
                  _itemMenu(
                    cores: cores,
                    icon: Icons.chat_bubble_outline_rounded,
                    titulo: 'EasyChat',
                    subtitulo: 'Comunicação da equipe',
                    cor: cores.verde,
                    onTap: () {
                      Navigator.pop(context);
                      mudarTela(8);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: cores.bordaSutil),
                  ),
                  _itemMenu(
                    cores: cores,
                    icon: Icons.settings_outlined,
                    titulo: 'Opções',
                    subtitulo: 'Configurações do aplicativo',
                    cor: cores.amarelo,
                    onTap: () {
                      Navigator.pop(context);
                      mudarTela(7);
                    },
                  ),
                  _itemMenu(
                    cores: cores,
                    icon: Icons.info_outline_rounded,
                    titulo: 'Sobre',
                    subtitulo: 'Conheça o EasySell',
                    cor: cores.textoSuave,
                    onTap: () {
                      Navigator.pop(context);
                      mudarTela(6);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _itemMenu({
    required AppCores cores,
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required Color cor,
    required VoidCallback onTap,
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
              color: cores.fundo2,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: cores.bordaSutil),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: cor.withAlpha(28),
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
                          color: cores.texto,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitulo,
                        style: TextStyle(color: cores.textoSuave, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: cores.textoFraco,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final int bottomIndex = telaAtual <= 4 ? telaAtual : 0;

    return Scaffold(
      backgroundColor: c.fundo,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(telaAtual), child: telaSelecionada()),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: c.navBar,
          border: Border(top: BorderSide(color: c.bordaSutil)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_rounded,
                  label: 'Início',
                  ativo: bottomIndex == 0,
                ),
                _bottomItem(
                  index: 1,
                  icon: Icons.inventory_2_outlined,
                  selectedIcon: Icons.inventory_2_rounded,
                  label: 'Produtos',
                  ativo: bottomIndex == 1,
                ),
                _bottomItem(
                  index: 2,
                  icon: Icons.receipt_long_outlined,
                  selectedIcon: Icons.receipt_long_rounded,
                  label: 'Vendas',
                  ativo: bottomIndex == 2,
                ),
                _bottomItem(
                  index: 3,
                  icon: Icons.groups_outlined,
                  selectedIcon: Icons.groups_rounded,
                  label: 'Equipe',
                  ativo: bottomIndex == 3,
                ),
                _bottomItem(
                  index: 4,
                  icon: Icons.auto_awesome_outlined,
                  selectedIcon: Icons.auto_awesome_rounded,
                  label: 'Sell IA',
                  ativo: bottomIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomItem({
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool ativo,
  }) {
    return GestureDetector(
      onTap: () => mudarTela(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        decoration: BoxDecoration(
          gradient: ativo
              ? LinearGradient(
                  colors: [c.roxo.withAlpha(50), c.roxo.withAlpha(24)],
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ativo ? c.roxo.withAlpha(53) : Colors.transparent,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              ativo ? selectedIcon : icon,
              color: ativo ? c.roxoClaro : c.textoSuave,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: ativo ? c.texto : c.textoSuave,
                fontSize: 9,
                fontWeight: ativo ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardHome extends StatelessWidget {
  final Function(int) mudarTela;
  final VoidCallback abrirMenu;
  final VoidCallback abrirNotificacoes;

  const DashboardHome({
    super.key,
    required this.mudarTela,
    required this.abrirMenu,
    required this.abrirNotificacoes,
  });

  @override
  Widget build(BuildContext context) {
    final cores = context.cores;

    return Container(
      // CORREÇÃO: antes estava Colors.red (sobra de debug).
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(cores.roxo.withAlpha(22), cores.fundo),
            cores.fundo,
            cores.fundo,
          ],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(19, 15, 19, 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _cabecalho(cores),
                  const SizedBox(height: 27),
                  _mensagemBoasVindas(cores),
                  const SizedBox(height: 21),
                  _faturamento(cores),
                  const SizedBox(height: 22),
                  _indicadores(cores),
                  const SizedBox(height: 29),
                  _titulo(
                    cores,
                    'Desempenho',
                    'Acompanhe suas vendas durante a semana',
                  ),
                  const SizedBox(height: 13),
                  _graficoDesempenho(cores),
                  const SizedBox(height: 29),
                  _titulo(
                    cores,
                    'Vendas recentes',
                    'Últimas movimentações realizadas',
                  ),
                  const SizedBox(height: 13),
                  _vendasRecentes(cores),
                  const SizedBox(height: 22),
                  _estoque(cores),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CABEÇALHO
  // ============================================================

  Widget _cabecalho(AppCores cores) {
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
                color: cores.roxo.withAlpha(66),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'E',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PAINEL PRINCIPAL',
                style: TextStyle(
                  color: cores.textoFraco,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'EasySell',
                style: TextStyle(
                  color: cores.texto,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        _botaoCabecalho(
          cores: cores,
          icon: Icons.notifications_none_rounded,
          notificacao: true,
          onTap: abrirNotificacoes,
        ),
        const SizedBox(width: 8),
        _botaoCabecalho(
          cores: cores,
          icon: Icons.more_horiz_rounded,
          onTap: abrirMenu,
        ),
      ],
    );
  }

  Widget _botaoCabecalho({
    required AppCores cores,
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
              color: cores.superficie,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cores.bordaMedia),
            ),
            child: Icon(icon, color: cores.texto, size: 20),
          ),
          if (notificacao)
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: cores.vermelho,
                  shape: BoxShape.circle,
                  border: Border.all(color: cores.superficie, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // BOAS-VINDAS
  // ============================================================

  Widget _mensagemBoasVindas(AppCores cores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Bom dia, Administrador 👋',
                style: TextStyle(
                  color: cores.texto,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.7,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: cores.verde.withAlpha(24),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: cores.verde.withAlpha(38)),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, color: cores.verde, size: 6),
                  const SizedBox(width: 5),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: cores.verde,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          'Veja como está o seu negócio hoje.',
          style: TextStyle(color: cores.textoSuave, fontSize: 12),
        ),
        const SizedBox(height: 15),
        Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [cores.roxo, cores.roxoClaro]),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FATURAMENTO
  // ============================================================

  Widget _faturamento(AppCores cores) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: cores.gradDestaque,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: cores.roxo.withAlpha(58)),
        boxShadow: [
          BoxShadow(
            color: cores.roxo.withAlpha(37),
            blurRadius: 30,
            offset: const Offset(0, 13),
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
                  Icons.account_balance_wallet_rounded,
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
                      'Faturamento',
                      style: TextStyle(
                        color: cores.texto,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Setembro de 2026',
                      style: TextStyle(color: cores.textoFraco, fontSize: 9),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: cores.verde.withAlpha(28),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: cores.verde,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '12,5%',
                      style: TextStyle(
                        color: cores.verde,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            'R\$ 8.450,00',
            style: TextStyle(
              color: cores.texto,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.4,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Total faturado neste mês',
            style: TextStyle(color: cores.textoSuave, fontSize: 10),
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: cores.roxo.withAlpha(24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.78,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [cores.roxo, cores.roxoClaro],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '78% da meta',
                style: TextStyle(
                  color: cores.roxoClaro,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(height: 1, color: cores.bordaSutil),
          const SizedBox(height: 16),
          Row(
            children: [
              _faturamentoInfo(
                cores,
                'Hoje',
                'R\$ 640,00',
                cores.verde,
                Icons.today_rounded,
              ),
              _faturamentoInfo(
                cores,
                'Ontem',
                'R\$ 520,00',
                cores.azul,
                Icons.history_rounded,
              ),
              _faturamentoInfo(
                cores,
                'Meta',
                '78%',
                cores.roxoClaro,
                Icons.flag_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _faturamentoInfo(
    AppCores cores,
    String titulo,
    String valor,
    Color cor,
    IconData icon,
  ) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: cor.withAlpha(24),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: cor, size: 13),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(color: cores.textoFraco, fontSize: 8),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cor,
                    fontSize: 10,
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

  // ============================================================
  // INDICADORES
  // ============================================================

  Widget _indicadores(AppCores cores) {
    return Row(
      children: [
        Expanded(
          child: _indicador(
            cores: cores,
            icon: Icons.shopping_bag_outlined,
            titulo: 'Vendas',
            valor: '128',
            detalhe: '+8,2%',
            cor: cores.azul,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _indicador(
            cores: cores,
            icon: Icons.inventory_2_outlined,
            titulo: 'Produtos',
            valor: '64',
            detalhe: '+4',
            cor: cores.roxoClaro,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _indicador(
            cores: cores,
            icon: Icons.groups_outlined,
            titulo: 'Equipe',
            valor: '08',
            detalhe: '+1',
            cor: cores.verde,
          ),
        ),
      ],
    );
  }

  Widget _indicador({
    required AppCores cores,
    required IconData icon,
    required String titulo,
    required String valor,
    required String detalhe,
    required Color cor,
  }) {
    return Container(
      height: 133,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: cores.gradCard,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: cores.bordaSutil),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: cor.withAlpha(27),
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
              color: cores.texto,
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
                  style: TextStyle(color: cores.textoSuave, fontSize: 9),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: cor.withAlpha(25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  detalhe,
                  style: TextStyle(
                    color: cor,
                    fontSize: 7,
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

  // ============================================================
  // TÍTULOS
  // ============================================================

  Widget _titulo(AppCores cores, String titulo, String subtitulo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 4,
          height: 34,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [cores.roxoClaro, cores.roxo]),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  color: cores.texto,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitulo,
                style: TextStyle(color: cores.textoFraco, fontSize: 10),
              ),
            ],
          ),
        ),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: cores.roxoClaro,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // GRÁFICO
  // ============================================================

  Widget _graficoDesempenho(AppCores cores) {
    return Container(
      height: 270,
      padding: const EdgeInsets.fromLTRB(17, 18, 17, 14),
      decoration: BoxDecoration(
        gradient: cores.gradCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cores.bordaSutil),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: cores.roxo.withAlpha(31),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: cores.roxoClaro,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vendas da semana',
                    style: TextStyle(
                      color: cores.texto,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Volume de vendas por dia',
                    style: TextStyle(color: cores.textoFraco, fontSize: 8),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: cores.roxo.withAlpha(24),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      color: cores.roxoClaro,
                      size: 12,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '128 vendas',
                      style: TextStyle(
                        color: cores.roxoClaro,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Expanded(
            child: CustomPaint(
              painter: _GraficoSemanalPainter(cores),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _diaGrafico(cores, 'Seg'),
              _diaGrafico(cores, 'Ter'),
              _diaGrafico(cores, 'Qua'),
              _diaGrafico(cores, 'Qui'),
              _diaGrafico(cores, 'Sex', ativo: true),
              _diaGrafico(cores, 'Sáb'),
              _diaGrafico(cores, 'Dom'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diaGrafico(AppCores cores, String texto, {bool ativo = false}) {
    return Text(
      texto,
      style: TextStyle(
        color: ativo ? cores.roxoClaro : cores.textoFraco,
        fontSize: 8,
        fontWeight: ativo ? FontWeight.w900 : FontWeight.w500,
      ),
    );
  }

  // ============================================================
  // VENDAS RECENTES
  // ============================================================

  Widget _vendasRecentes(AppCores cores) {
    return Container(
      decoration: BoxDecoration(
        gradient: cores.gradCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cores.bordaSutil),
      ),
      child: Column(
        children: [
          _venda(
            cores: cores,
            numero: '#1028',
            produto: 'Notebook Pro',
            cliente: 'Carlos Mendes',
            valor: 'R\$ 2.450,00',
            tempo: '10 min',
            cor: cores.verde,
            icon: Icons.laptop_mac_rounded,
          ),
          _divisor(cores),
          _venda(
            cores: cores,
            numero: '#1027',
            produto: 'Monitor Ultra 24"',
            cliente: 'Mariana Silva',
            valor: 'R\$ 890,00',
            tempo: '35 min',
            cor: cores.azul,
            icon: Icons.desktop_windows_rounded,
          ),
          _divisor(cores),
          _venda(
            cores: cores,
            numero: '#1026',
            produto: 'Teclado Mecânico',
            cliente: 'João Pedro',
            valor: 'R\$ 420,00',
            tempo: '1h',
            cor: cores.roxoClaro,
            icon: Icons.keyboard_rounded,
          ),
          _divisor(cores),
          _venda(
            cores: cores,
            numero: '#1025',
            produto: 'Mouse Gamer',
            cliente: 'Lucas Andrade',
            valor: 'R\$ 280,00',
            tempo: '2h',
            cor: cores.amarelo,
            icon: Icons.mouse_rounded,
          ),
        ],
      ),
    );
  }

  Widget _venda({
    required AppCores cores,
    required String numero,
    required String produto,
    required String cliente,
    required String valor,
    required String tempo,
    required Color cor,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: cor.withAlpha(30),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cor.withAlpha(38)),
            ),
            child: Icon(icon, color: cor, size: 19),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cores.texto,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$numero • $cliente',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: cores.textoFraco, fontSize: 9),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                valor,
                style: TextStyle(
                  color: cores.texto,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: cores.texto.withAlpha(15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tempo,
                  style: TextStyle(
                    color: cores.textoFraco,
                    fontSize: 7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divisor(AppCores cores) {
    return Padding(
      padding: const EdgeInsets.only(left: 73),
      child: Divider(color: cores.bordaSutil, height: 1),
    );
  }

  // ============================================================
  // ESTOQUE
  // ============================================================

  Widget _estoque(AppCores cores) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cores.amarelo.withAlpha(48), cores.fundo2.withAlpha(18)],
        ),
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: cores.amarelo.withAlpha(56)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cores.amarelo.withAlpha(32),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: cores.amarelo.withAlpha(42)),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: cores.amarelo,
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atenção ao estoque',
                  style: TextStyle(
                    color: cores.texto,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '12 produtos estão com estoque baixo.',
                  style: TextStyle(color: cores.textoSuave, fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => mudarTela(1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cores.amarelo.withAlpha(32),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: cores.amarelo.withAlpha(53)),
              ),
              child: Row(
                children: [
                  Text(
                    'Ver estoque',
                    style: TextStyle(
                      color: cores.amarelo,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: cores.amarelo,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GRÁFICO SEMANAL
// ============================================================

class _GraficoSemanalPainter extends CustomPainter {
  final AppCores cores;

  _GraficoSemanalPainter(this.cores);

  final List<double> valores = [0.48, 0.65, 0.52, 0.78, 0.91, 0.72, 0.84];

  @override
  void paint(Canvas canvas, Size size) {
    final largura = size.width / valores.length;

    final grade = Paint()
      ..color = cores.bordaSutil
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;

      canvas.drawLine(Offset(0, y), Offset(size.width, y), grade);
    }

    for (int i = 0; i < valores.length; i++) {
      final x = largura * i + largura / 2;
      final altura = size.height * valores[i];

      final sombra = Paint()
        ..color = cores.roxo.withAlpha(36)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(x, size.height - altura / 2),
            width: 19,
            height: altura,
          ),
          const Radius.circular(8),
        ),
        sombra,
      );

      final barra = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(x, size.height - altura / 2),
          width: 23,
          height: altura,
        ),
        const Radius.circular(9),
      );

      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [cores.roxoClaro, cores.roxo, cores.roxo.withAlpha(190)],
        ).createShader(Rect.fromLTWH(x - 12, size.height - altura, 24, altura));

      canvas.drawRRect(barra, paint);

      if (i == 4) {
        final destaque = Paint()..color = cores.verde;

        canvas.drawCircle(Offset(x, size.height - altura), 4, destaque);

        final anel = Paint()
          ..color = cores.verde.withAlpha(64)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        canvas.drawCircle(Offset(x, size.height - altura), 7, anel);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GraficoSemanalPainter oldDelegate) {
    return oldDelegate.cores != cores;
  }
}
