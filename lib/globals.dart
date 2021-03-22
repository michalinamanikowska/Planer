import 'package:flutter/material.dart';
import 'task.dart';
import 'exam.dart';

List<Task> userTasks = [];
List<Exam> userExams = [];

const actions = ['ZADANIA', 'ZALICZENIA', 'PLAN'];

String chosen = 'ZADANIA';

const uni = 'INFORMATYKA';

const plan = 'PlanInf.pdf';

const subjects = [
    'Bioinformatyka',
    'Postawy aplikacji internetowych',
    'Systemy i aplikacje bez granic (ubiquitous)',
    'Przetwarzanie języka naturalnego',
    'Informatyzacja przedsiębiorstw',
    'Przetwarzanie równoległe',
    'Przetwarzanie rozproszone'
  ];

const tooSmall = [2];

List<Color> colors = [Colors.grey[800], Colors.cyan[900], Colors.teal[900], Colors.blueGrey[900],
Colors.cyan[800], Colors.teal[700]];

// const uni = 'ELEKTROTECHNIKA';

// const plan = 'Plan.pdf';

// const subjects = [
//     'Bazy danych i technologie internetowe',
//     'Eksploatacja układów technicznych',
//     'Elektrodynamika techniczna',
//     'Ergonomia i bezpieczeństwo użytkownika urządzeń elektrycznych',
//     'Pomiary i automatyka w elektroenergetyce',
//     'Optoeletronika',
//     'Układy elektryczne i eletroniczne w przemyśle i pojazdach',
//     'Urządzenia elektryczne',
//     'Seminarium dyplomowe',
//     'Wprowadzenie do kompatybilności elektromagnetycznej'
//   ];

// const tooSmall = [3, 4, 6, 9];

// List<Color> colors = [Colors.grey[800], Colors.cyan[900], Colors.teal[900], Colors.blueGrey[900], Colors.lightBlue[900],
// Colors.grey[600], Colors.cyan[800], Colors.teal[700], Colors.blueGrey[800], Colors.lightBlue[800]];