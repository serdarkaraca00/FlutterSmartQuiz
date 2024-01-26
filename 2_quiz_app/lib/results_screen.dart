import 'package:flutter/material.dart';

import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {//eşleşen cevap sayısında doğru cevap sayısına ulaştık
      return data['user_answer'] == data['correct_answer'];
    }).length;//eşleşen dataları değil. eşleşenlen dataların sayısını aldık

    return SizedBox(
      width: double.infinity,//genişlik tüm telefonu kaplasın
      child: Container(
        margin: const EdgeInsets.all(40),//40 40 hereyerden mesafe olsun
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//tüm herşeyi ortaladık
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(//araya boş kutu
              height: 30,
            ),
            QuestionsSummary(summaryData),//cevaplanan sorulların vs. düzenlenmiş hali
            const SizedBox(//buton ve cevaplar arasına boş kutu
              height: 30,
            ),
            TextButton.icon(//buton stili burda yapılıyo ama oluşcak eylem quiz.dart da olcak
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}