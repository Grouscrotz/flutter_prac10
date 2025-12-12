import '../models/topic.dart';
import '../models/word.dart';

class TopicsRepository {
  static final TopicsRepository _instance = TopicsRepository._internal();
  factory TopicsRepository() => _instance;
  TopicsRepository._internal();

  List<Topic> _topics = _getInitialTopics();

  List<Topic> get topics => List.unmodifiable(_topics);
  Topic get selectedTopic => _topics.firstWhere((t) => t.selected, orElse: () => _topics.first);

  void addTopic(String name) {
    _topics = [..._topics, Topic(name: name, words: [])];
  }

  void selectTopic(Topic topic) {
    _topics = _topics.map((t) => t.copyWith(selected: t == topic)).toList();
  }

  void addWord(Topic topic, String word, String translation) {
    final index = _topics.indexOf(topic);
    final newWord = Word(word: word, translation: translation);
    final updatedWords = [..._topics[index].words, newWord];
    _topics[index] = _topics[index].copyWith(words: updatedWords);
    _topics = List.from(_topics);
  }

  void deleteWord(Topic topic, int wordIndex) {
    final index = _topics.indexOf(topic);
    final updatedWords = [..._topics[index].words]..removeAt(wordIndex);
    _topics[index] = _topics[index].copyWith(words: updatedWords);
    _topics = List.from(_topics);
  }

  void resetProgress(Topic topic) {
    final index = _topics.indexOf(topic);
    final updatedWords = _topics[index].words.map((w) => w.copyWith(learned: false)).toList();
    _topics[index] = _topics[index].copyWith(words: updatedWords);
    _topics = List.from(_topics);
  }

  void toggleLearned(Topic topic, Word word, bool learned) {
    final tIndex = _topics.indexOf(topic);
    final wIndex = _topics[tIndex].words.indexOf(word);
    final updatedWord = word.copyWith(learned: learned);
    final updatedWords = [..._topics[tIndex].words]..[wIndex] = updatedWord;
    _topics[tIndex] = _topics[tIndex].copyWith(words: updatedWords);
    _topics = List.from(_topics);
  }

  static List<Topic> _getInitialTopics() {
    return [
      Topic(name: 'Фрукты', words: [
        Word(word: 'Apple', translation: 'Яблоко', url: 'https://www.applesfromny.com/wp-content/uploads/2020/06/SnapdragonNEW.png'),
        Word(word: 'Banana', translation: 'Банан', url: 'https://img.freepik.com/free-psd/fresh-fruits-composition_23-2151371971.jpg?semt=ais_hybrid&w=740&q=80'),
        Word(word: 'Cherry', translation: 'Вишня', url: 'https://rainierfruit.com/wp-content/uploads/2021/11/Rainier-Fruit-Cherries.png'),
        Word(word: 'Orange', translation: 'Апельсин', url: 'https://lh3.googleusercontent.com/proxy/L5cilbcVrbLsGoMipa4F2W6OYFrp-xelWPCg7C_5sLdjLY-rrBhDB1SVU0W7iajUTtUO0NP5rF9uQnQvKZK72GJNasauveg0aLIkaZHp1nz730UWoS4CSZmC-jwTxrhy6bqA9kLQH49CTw'),
        Word(word: 'Grape', translation: 'Виноград'),
        Word(word: 'Pineapple', translation: 'Ананас'),
        Word(word: 'Mango', translation: 'Манго'),
        Word(word: 'Peach', translation: 'Персик'),
        Word(word: 'Strawberry', translation: 'Клубника'),
        Word(word: 'Lemon', translation: 'Лимон'),
      ]),
      Topic(name: 'Животные', words: [
        Word(word: 'Dog', translation: 'Собака'),
        Word(word: 'Cat', translation: 'Кошка'),
        Word(word: 'Elephant', translation: 'Слон'),
        Word(word: 'Tiger', translation: 'Тигр'),
        Word(word: 'Lion', translation: 'Лев'),
        Word(word: 'Bear', translation: 'Медведь'),
        Word(word: 'Wolf', translation: 'Волк'),
        Word(word: 'Fox', translation: 'Лиса'),
        Word(word: 'Rabbit', translation: 'Кролик'),
        Word(word: 'Horse', translation: 'Лошадь'),
      ]),
      Topic(name: 'Цвета', words: [
        Word(word: 'Red', translation: 'Красный'),
        Word(word: 'Blue', translation: 'Синий'),
        Word(word: 'Green', translation: 'Зелёный'),
        Word(word: 'Yellow', translation: 'Жёлтый'),
        Word(word: 'Black', translation: 'Чёрный'),
        Word(word: 'White', translation: 'Белый'),
        Word(word: 'Orange', translation: 'Оранжевый'),
        Word(word: 'Purple', translation: 'Фиолетовый'),
        Word(word: 'Pink', translation: 'Розовый'),
        Word(word: 'Brown', translation: 'Коричневый'),
      ]),
      Topic(name: 'Одежда', words: [
        Word(word: 'Shirt', translation: 'Рубашка'),
        Word(word: 'Pants', translation: 'Брюки'),
        Word(word: 'Shoes', translation: 'Обувь'),
        Word(word: 'Hat', translation: 'Шляпа'),
        Word(word: 'Coat', translation: 'Пальто'),
        Word(word: 'Skirt', translation: 'Юбка'),
        Word(word: 'Dress', translation: 'Платье'),
        Word(word: 'Socks', translation: 'Носки'),
        Word(word: 'Gloves', translation: 'Перчатки'),
        Word(word: 'Scarf', translation: 'Шарф'),
      ]),
      Topic(name: 'Транспорт', words: [
        Word(word: 'Car', translation: 'Машина'),
        Word(word: 'Bus', translation: 'Автобус'),
        Word(word: 'Train', translation: 'Поезд'),
        Word(word: 'Bicycle', translation: 'Велосипед'),
        Word(word: 'Plane', translation: 'Самолёт'),
        Word(word: 'Boat', translation: 'Лодка'),
        Word(word: 'Motorcycle', translation: 'Мотоцикл'),
        Word(word: 'Taxi', translation: 'Такси'),
        Word(word: 'Truck', translation: 'Грузовик'),
        Word(word: 'Subway', translation: 'Метро'),
      ]),
    ];
  }
}