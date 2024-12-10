import 'package:appdiario/servicos/lembrete_servico.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/drawer/configuracoes.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final kFirstDay = DateTime.utc(2000, 1, 1);
  final kLastDay = DateTime.utc(2100, 12, 31);
  final user = FirebaseAuth.instance.currentUser;

  Map<DateTime, List<String>> _tasks = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diário Pessoal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF32CD99),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF32CD99),
              ),
              child: Column(
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text('Bem-vindo, ${user?.displayName ?? 'Usuário'}!'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Telainicial()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Calendário'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Configuracoes()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Telacadastro()),
                );
              },
            ),
          ],
        ),
      ),
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiaDetalhado(data: selectedDay),
            ),
          );
        },
        eventLoader: (day) => _tasks[day] ?? [],
      ),
    );
  }
}

class DiaDetalhado extends StatelessWidget {
  final DateTime data;

  const DiaDetalhado({super.key, required this.data, required});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Dia'),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Selecionada: ${data.day}/${data.month.toString().padLeft(2, '0')}/${data.year.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.calendar_today),
              label: const Text('Agenda'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 235, 235, 235),
                backgroundColor: const Color(0xFF32CD99),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.note),
              label: const Text('Anotações'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 235, 235, 235),
                backgroundColor: const Color(0xFF32CD99),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaLembretes(dataSelecionada: data),
                  ),
                );
              },
              icon: const Icon(Icons.notifications),
              label: const Text('Adicionar Notificações'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 235, 235, 235),
                backgroundColor: const Color(0xFF32CD99),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaLembretes extends StatefulWidget {
  final DateTime dataSelecionada;

  const TelaLembretes({super.key, required this.dataSelecionada});

  @override
  State<TelaLembretes> createState() => _TelaLembretesState();
}

class _TelaLembretesState extends State<TelaLembretes> {
  final LembreteServico _lembreteServico = LembreteServico();

  void _adicionarAnotacao(DateTime dataSelecionada) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final String formattedTime =
          '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      final TextEditingController _controller = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Anotação para $formattedTime'),
            content: TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Digite sua anotação'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _lembreteServico.adicionarLembrete(
                      formattedTime,
                      _controller.text,
                      dataSelecionada,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lembretes'),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _lembreteServico.carregarLembretes(widget.dataSelecionada),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma anotação encontrada.'));
          }

          final lembretes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: lembretes.length,
            itemBuilder: (context, index) {
              final lembrete = lembretes[index];
              final data = lembrete.data() as Map<String, dynamic>?;

              final anotacao = data?['anotacao'] ?? 'Sem anotação';
              final horario = data?['horario'] ?? 'Sem horário';
              final dataFormatada = data?['data'] ?? '';

              final dataLocal = DateTime.parse(
                  '${dataFormatada.split('/')[2]}-${dataFormatada.split('/')[1]}-${dataFormatada.split('/')[0]}');

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                      '$horario (${dataLocal.day}/${dataLocal.month}/${dataLocal.year})'),
                  subtitle: Text(anotacao),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _lembreteServico.deletarLembrete(lembrete.id),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarAnotacao(widget.dataSelecionada);
        },
        backgroundColor: const Color(0xFF32CD99),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
