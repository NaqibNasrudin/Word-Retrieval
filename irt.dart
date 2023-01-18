import 'dart:collection';
import 'dart:io';
void main() {
  var number;
  Text text = new Text();
  text.setText();
  text.countchar();
  do {
    stdout.write("\n\nChoose (1= Word Frequency / 2=Term Occurence / 3=Index Positions) : ");
    number = stdin.readLineSync();

    if(number == '1'){
      text.wordfreq();
    }
    else if(number == '2'){
      text.invertindexoccurence();
    }
    else if(number == '3'){
      text.invertindexposition();
    }
  } while (int.parse(number) <= 3);
  
}


class Text{
  //properties
  dynamic textlist;
  var map = Map();
  var words = Map();
  // var possmap = <String, Map<int, List<String>>>{};
  dynamic count;
  dynamic poss;
  String t1 = 'When it is said to them, "Believe in what Allah Hath sent down, "they say, "We believe in what was sent down to us:" yet they reject all besides, even if it be Truth confirming what is with them. Say: "Why then have ye slain the prophets of Allah in times gone by, if ye did indeed believe?"';
  String t2 = 'There came to you Moses with clear (Signs); yet ye worshipped the calf (Even) after that, and ye did behave wrongfully.';
  String t3 = 'And remember We took your covenant and We raised above you (the towering height) of Mount (Sinai): (Saying): "Hold firmly to what We have given you, and hearken (to the Law)": They said:" We hear, and we disobey:" And they had to drink into their hearts (of the taint) of the calf because of their Faithlessness. Say: "Vile indeed are the behests of your Faith if ye have any faith!"';
  String t4 = 'Say: "If the last Home, with Allah, be for you specially, and not for anyone else, then seek ye for death, if ye are sincere."';
  String t5 = 'But they will never seek for death, on account of the (sins) which their hands have sent on before them. and Allah is well-acquainted with the wrong-doers.';
  String t6 = 'Thou wilt indeed find them, of all people, most greedy of life,-even more than the idolaters: Each one of them wishes He could be given a life of a thousand years: But the grant of such life will not save him from (due) punishment. For Allah sees well all that they do.';
  String t7 = 'Say: Whoever is an enemy to Gabriel-for he brings down the (revelation) to thy heart by Allah織s will, a confirmation of what went before, and guidance and glad tidings for those who believe,-';
  String t8 = 'Whoever is an enemy to Allah and His angels and messengers, to Gabriel and Michael,- Lo! Allah is an enemy to those who reject Faith.';
  String t9 = 'We have sent down to thee Manifest Signs (ayat); and none reject them but those who are perverse.';
  String t10 = 'Is it not (the case) that every time they make a covenant, some party among them throw it aside?- Nay, Most of them are faithless.';

  //constructor
  Text() {
    textlist = [];
    count = [];
    poss = [];
  }

  //Eliminate symbol and split text
  void setText(){
    eliminate(t1);
    eliminate(t2);
    eliminate(t3);
    eliminate(t4);
    eliminate(t5);
    eliminate(t6);
    eliminate(t7);
    eliminate(t8);
    eliminate(t9);
    eliminate(t10);
  }
  void eliminate(String txt){
    var elim =  txt.replaceAll(RegExp(r'[^A-Za-z0-9\s]'), "");
    elim = elim.toLowerCase();
    var txtsplit = elim.split(" ");
    textlist.add(txtsplit);
    
  }

  //count occurence
  void countchar(){
    for (var i = 0; i < 10; i++) {
      textlist[i].forEach((element) {
        if(!map.containsKey(element)) {
          map[element] = 1;
        } else {
          map[element] += 1;
        }
      });
      count.add(map);
      map = {};
    }
  }

  // Freq
  void wordfreq(){
    for (var i = 0; i < 10; i++) {
      textlist[i].forEach((element) {
        if(!words.containsKey(element)) {
          words[element] = 1;
        } else {
          words[element] += 1;
        }
      });
    }
    words = Map.fromEntries(words.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    print('\nWord Frequency: \n');
    for (var word in words.entries) {
      stdout.write(word.key);
      stdout.write("\t   (");
      stdout.write(word.value);
      stdout.write(") \n");
    }
  }


  // inverted index with occurence
  void invertindexoccurence(){
    for (var i = 0; i < 10; i++) {
      textlist[i].forEach((element) {
        if(!words.containsKey(element)) {
          words[element] = 1;
        } else {
          words[element] += 1;
        }
      });
    }
    words = Map.fromEntries(words.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    print('\nTerm Occurence/Term Frequency: \n');
    for (var entry in words.entries) {
      stdout.write(entry.key + " ");
      for (var i = 0; i < 10; i++) {
        if (count[i][entry.key] != null) {
          String occur = count[i][entry.key].toString();
          var realindex =i+1;
          String index = realindex.toString();
          stdout.write("($index, $occur)");
        }
      }
      stdout.write("\n");
    }
  }


  // Index with possition
  void invertindexposition(){
    // var possmap = Map();
    Map<String, List<int>> possmap = {};
    print("\nWords Possition : \n");
    for (var i = 0; i < 10; i++) {
      for (var entry in textlist[i].asMap().entries) {
        // possmap[entry.key + 1] = entry.value;
        // possmap[entry.value].add(entry.key + 1);
        if (possmap.containsKey(entry.value)) {
          possmap[entry.value]!.add(entry.key + 1);
        } else {
          possmap[entry.value] = [entry.key + 1];
        }
      }
      poss.add(possmap);
      possmap = {};
      var p = i+1;
      stdout.write('\nDOCUMENT $p : \n');
      // stdout.write(poss[i]);
      // stdout.write('\n\n');
      for (var x in poss[i].entries) {
        stdout.write(x.key);
        stdout.write('\t\t');
        stdout.write(x.value);
        stdout.write('\n');
      }
    }
  }
}