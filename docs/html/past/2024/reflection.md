* 振り返りを見て, 
  * 個別的な返事を返した方が良い場合は返しています
  * 全員に質問・回答を共有したほうが良いと思ったものをここに書きます
* For reflective essays
  * I send feedbacks a few individual essays when necessary
  * I share questions/answers here when appropriate

* Q: (多くの人から) 関数型言語で何でも再帰を使って書くことについて「メモリをたくさん使うのでは」「スタックオーバーフローしないか」心配という振り返りでの感想がありました 
* Q: Many of you wonder in reflective essays that the problem solving using recursion may use too much memory or overflow stack
* A: これは実際そのとおりで, 今は時間の関係で端折ってますが, https://taura.github.io/programming-languages/gen/slides_old/pdf/02-ocaml.pdf の p115あたりから説明しているので見てみてください. 
  * 絶対にスタックオーバーフロー言語の実装(Standard ML New Jersey)もあります. その種明かしはスタックを使わない(全部ヒープを使う. そのメモリ管理はGC (この授業の後半で扱います)で行う)です
  * そうではない言語の実装ではスライドに説明している「末尾再帰」にするいうことで避けることができますが素直に書くよりも少しわかりにくいプログラムになります
* A: This is indeed true.  I am skipping this topic with the interest in time, but I used to explain it in https://taura.github.io/programming-languages/gen/slides_old/pdf/02-ocaml.pdf , starting from p115.
  * There is an implementatin of a language (Standard ML New Jersey) that never causes stack overflow.  The trick is not to use stack (always use heap instead, managed by garbage collection, which I will cover later in the course)
  * In other languages, stack overflow can be avoided by making them "tail-recursive", but the program is less easy to understand or reason about.

* Q: (OCamlに関して) 解決できていない疑問としては、スーパークラスを定義せずrectとellipseを同じリスト、arrayに格納することができたのはどうしてか良くわからなかった。今後も調べ続ける必要があると考えている。
* Q: (about OCaml) a remaining question is why you can put rect and ellipse in the same list or array without defining their superclass.
* A: 授業で述べた言葉で言うと OCaml は structural subtype に基づく (明示的な interafaceやtraitの implements, classの継承のような宣言がなくても, メソッドの名前や型の関係から勝手に subtype 関係が導かれる) から, ということになります. 特に, メソッド名とその型が同じだったりすると両者は型としては同じということになり, ひとりでに同じリストに入れたりできるようになります. OCaml の際立った特徴です.
* A: Using terminologies I mentioned in the lecture, that's because OCaml's type system is based on structural subtyping, where subtype relationship between two classes (more precisely, object types) is automatically inferred from their method names and types, without relying on explicit declarations such as "implements" for interfaces or traits, or extends/inherits for classes). In particular, if method names and their types are identical, both classes are exactly the same type and therefor their instances can be put in a list without any effort.  This is a remarkable feature of OCaml.



