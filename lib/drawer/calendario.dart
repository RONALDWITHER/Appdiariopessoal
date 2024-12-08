import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/paginas/telacadastro.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<DateTime, List<String>> _tasks = {};

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    if (user != null) {
      final snapshot = await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('tasks')
          .get();

      setState(() {
        for (var doc in snapshot.docs) {
          DateTime date = DateTime.parse(doc.id);
          _tasks[date] = List<String>.from(doc['tasks']);
        }
      });
    }
  }

  Future<void> _addTask(String task) async {
    if (_selectedDay != null && user != null) {
      setState(() {
        _tasks[_selectedDay!] = _tasks[_selectedDay!] ?? [];
        _tasks[_selectedDay!]!.add(task);
      });

      // Salvar no Firestore
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('tasks')
          .doc(_selectedDay!.toIso8601String())
          .set({
        'tasks': _tasks[_selectedDay!],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diário Pessoal'),
        backgroundColor: const Color(0xFF32CD99),
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

  const DiaDetalhado({super.key, required this.data});

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
              'Data Selecionada: ${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaLembretes(),
                  ),
                );
              },
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
              onPressed: () {},
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
  const TelaLembretes({super.key});

  @override
  _TelaLembretesState createState() => _TelaLembretesState();
}

class _TelaLembretesState extends State<TelaLembretes> {
  final Map<int, String> _anotacoes = {}; 

  void _adicionarAnotacao(int horario) {
    TextEditingController _controller = TextEditingController();

    if (_anotacoes.containsKey(horario)) {
      _controller.text = _anotacoes[horario]!;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Anotação para $horario:00'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Digite sua anotação'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            if (_anotacoes.containsKey(horario)) 
              TextButton(
                onPressed: () {
                  setState(() {
                    _anotacoes.remove(horario);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  _anotacoes[horario] = _controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarme'),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 24, 
        itemBuilder: (context, index) {
          final horario = index.toString().padLeft(2, '0');
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(
                  '$horario:00', 
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _adicionarAnotacao(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _anotacoes[index] ?? '', 
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 