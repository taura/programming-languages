Rust の依存関係
===========

```
$ cargo new --bin foo
```

foo/Cargo.toml に

```
[dependency]
rand = "0.8.5"
```

のように書き足して,

```
$ cd foo
$ cargo build
```

とするとDLから何からやってくれるというのがRust (Cargo)

```
$ cargo build --verbose
```

で動いているコマンドラインを見られる

crates.io
=========

* [dependency] に書く際に必要になるバージョンは https://crates.io/ で該当のcrateを探すと見つかる
* 同様に crates.io の Documentation で定義されている関数やTrait などがわかる

Rust のedition
===========

Rust editionなるものがあり, 2015, 2018, 2021 があり, 外部モジュールを使う際の書き方が異なる

Rust 2015
```
extern crate rand;
use rand::xxxx;
```

Rust 2018, 2021
```
use rand::xxxx;
```

コマンドの方は2021になるが, どうやらJupyterのRustは2015のようだ.
ただし 2018, 2021 でも
```
extern crate rand;
```
をつけても問題はないようだ.
なおこれは
```
use rand;
```
の効果も兼ねているようで,
```
extern crate rand;
use rand;
```
は, 同じ名前を2度 import しているというエラーになる.

```
extern crate rand;
```
にせよ
```
use rand;
```
(Rust 2018/2021)にせよ, randが使える状態にしたら後は rand::関数名, rand::Trait名, rand::モジュール名::関数名 などで必要なものが使える.

使える関数名などは crates.io で見つかる.

使っている Trait は use しないといけない
===========

例えば必要なものが thread_rng という関数だけなら,

```
extern crate rand;

fn main() {
    let mut rng = rand::thread_rng();
    println!("{}", rng.gen::<f64>());
}
```

だけで済むと考えたくなるがこれをコンパイルすると

```
93 |     fn gen<T>(&mut self) -> T
   |        --- the method is available for `ThreadRng` here
```

みたいなエラーになる. どうやら作られる struct の Trait が明示的に use されていないといけないみたい. エラーメッセージには

```
help: the following trait is implemented but not in scope; perhaps add a `use` for it:
   |
4  | use crate::rand::Rng;
   |
```

みたいなことも考えるので素直にこれに従うのが良い. crate:: 部分は書かなくて良い. つまり以下を書き足す

```
use rand::Rng;
```

以下が動くプログラム
```
extern crate rand;
use rand::Rng;

fn main() {
    let mut rng = rand::thread_rng();
    println!("{}", rng.gen::<f64>());
}
```

Cargoを使わないコンパイル
===========

```
cargo build --verbose
```

でどんなコマンドを叩いているかがわかる. そこから不要なものを消すと, 以下が単独でこのプログラムをコンパイルする方法

```
rustc main.rs -L dependency=/home/tau/public_html/lecture/programming_languages/gen/jupyter/nb_src/source/pl03/include/foo/target/debug/deps --extern rand=/home/tau/public_html/lecture/programming_languages/gen/jupyter/nb_src/source/pl03/include/foo/target/debug/deps/librand-1648e0a71983440e.rlib
```

コマンドラインで指定されているフォルダや .rlib ファイルは cargo が複雑な方法で作っているので, 結局外部モジュールを使うプログラムを cargo なしにコンパイルする単純な方法はない

Rust のインストール方法
===========

* https://www.rust-lang.org/tools/install にある中の rustup で入れる方法だと ~/.cargo/ 下に入る. rustup update で新しくする. 最新1.60になる

* apt だと 1.57 になるようだ


