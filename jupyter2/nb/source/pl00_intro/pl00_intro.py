""" md
#* Programming Language (0) --- Introduction
"""

""" md w

Enter your name and student ID.

 * Name:
 * Student ID:

"""

""" md
# このnotebookの使い方 / How this notebook works

## セル / Cell

* 以下のような入力欄を「セル」という
* SHIFT+ENTERで実行できる

<br/>

* A textbox like below is called a "cell"
* Press SHIFT+ENTER to execute it

## Python セル / Python Cells

* 以下はPythonのコードを書いて実行するセル
* セル (またはセル左の余白) をクリックするとページ上部に「Code」, セルの右端上に「Python 3 (ipykernel)」と表示されることを確認せよ

<br/>

* The cell below is a Python cell, in which you can write and execute Python code
* Click on the cell (or somewhere its left) and confirm "Code" is selected near the top of the page and "Python 3 (ipykernel)" on the upper right end of the cell
"""

""" code w kernel=python """
def f(x):
  return x + 1

f(3)
""" """

""" md
* 実行中のセルは, 左に`[*]`と表示され, 終了すると`[2]`のような番号に変わる
* `[*]`が表示されている間は他のセルを実行できないことを覚えておこう
* 以下のセルを実行して`[*]`を観察しておくこと
<br/>

* While a cell is executing, `[*]` is shown on the left, which turns into a number like `[2]`
* Remember that you cannot execute other cells while `[*]` is shown
* Execute the cell below and observe `[*]`
"""

""" code w kernel=python """
import time
time.sleep(2.0)
""" """

""" md
* 実行中のセルを途中で止めたければタブ上部の■ボタンで止められることにはなっているが効かないことも多い
* その場合は, メニューの Kernel -&gt; Restart Kernel として **カーネルのリセット** をする
* より強力なリセット方法はメニューの File -&gt; Hub Control Panel -&gt; Stop Server ->&gt; Start Server として**サーバの再起動** をする
* 以下を実行し, 終了する前に■ボタンで止めてみよ
* カーネルのリセット, サーバの再起動も試してみよ
<br/>

* You should be able to stop an executing cell by ■ button at top of the tab, but do not expect it to work reliably
* If it doesn't work, **reset kernel** by going to menu and selecting Kernel -&gt; Restart Kernel
* Even more powerful method to reset everything is to **restart the server** by going to menu and selecting File -&gt; Hub Control Panel -&gt; Stop Server -&gt; Start Server
* Execute the cell below and stop it before it finishes by ■ button
* Also try to reset kernel and restart server
"""

""" code w kernel=python """
import time
time.sleep(6.0)
""" """

""" md
## `%%writefile` セル / `%%writefile` Cells 

* `%%writefile filename` で始まるセルは SHIFT + Enter でその中身を指定されたファイルに保存する
* Pythonセルの機能ではあるが, 保存するだけの機能なので中身はPythonコードでなくても良い
<br/>

* Pressing SHIFT + Enter on cells that begin with `%%writefile filename` save the contents of the cell into the specified file
* This is a function of Python cells, but as it only saves the contents, the contents can be anything (don't have to be Python code)
"""

""" codex w kernel=python
%%writefile hello.c
/* a Python cell that just saves the contents into a file (hello.c) */
#include <stdio.h>
int main() {
    printf("hello\n");
    return 0;
}
"""

""" md
## `%%bash` セル / `%%bash` Cells

* `%%bash` で始まるセルはシェルコマンドを実行できる

* In cells starting `%%bash`, you can execute shell commands
"""

""" codex w kernel=python
%%bash
pwd
"""

""" codex w kernel=python
%%bash
ls
"""

""" codex w kernel=python
%%bash
gcc hello.c -o hello
./hello
"""

""" md
## text (markdown)

* コードではなくテキスト(マークダウン形式)を書くためのセル
* セル (またはセル左の余白) をクリックするとページ上部に「Markdown」と表示されることを確認せよ

* There are cells for ordinary texts (markdown format), not code
* Click on the cell (or somewhere its left) and confirm "Markdown" is selected near the top of the page
"""

""" md w
* ここをダブルクリックして編集してみよ
  * 編集し終えたらSHIFT-ENTERで保存
* double-click this cell and edit
  * after done, press SHIFT-ENTER to save
"""

""" md
# この授業で使う言語の情報源 / Resources for programming languages covered in this lecture

* see [links section of the course home page](https://taura.github.io/programming-languages/index.html#links)

"""

""" md
# Jupyter 端末環境 / Jupyter Terminals

* Jupyterの典型的な環境はこのようなページ(ノートブック)にプログラムを書いてそれを実行するというものだが, 自分でコマンドを打ち込んで実行できる環境(端末)も用意されている
* メニュー直下の「+」アイコンをクリックしてlauncherを表示
* Terminal を選ぶとコマンドラインが開く
* 使いたくなるかも知れない場面
  * man pageを閲覧する
  * 暴走して, ■ボタンを押しても止まらないプログラムを kill コマンドで殺す
<br/>

* A typical Jupyter environment executes programs in a page like this (notebook).  There is, however, an environment you type arbitrary commands (terminal)
* Click the "+" icon right below the menu to show the launcher page
* Select "Terminal" to open the command line terminal
* Some circumstances in which you want to use it
  * You browse a man page
  * Use kill command to terminate a program that does not stop with ■ button
"""
  
""" md
# SSH でログイン / Login with SSH

* SSH で Jupyter サーバーにログインしたければ, [How to access Jupyter environment](https://taura.github.io/programming-languages/html/jupyter2.html#ssh) の "I want to work with command line (SSH), not within Jupyter (web browser) ..." 節の指示に従う
* SSH 公開鍵 (e.g., `id_ed25519.pub`) を Jupyter サーバーにアップロードした後, 以下を実行
* 注: 以下のファイル名部分 ("id_ed25519.pub") を自分のファイル名に合わせて変更せよ

<br/>

* If you want to login the Jupyter server with SSH, follow "I want to work with command line (SSH), not within Jupyter (web browser) ..." section in [How to access Jupyter environment](https://taura.github.io/programming-languages/html/jupyter2.html#ssh)
* After uploading your SSH public key (e.g., `id_ed25519.pub`), execute the following cell
* Note: change the file name below ("id_ed25519.pub") to appropriately reflect your file name
"""

""" codex w
%%bash
mkdir -p ~/.ssh/
cp ~/id_ed25519.pub ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
"""

""" md
* 以下を実行して確認

<br/>

* Execute the following to check
"""

""" codex w
%%bash
ls -ld ~/.ssh
ls -l ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
"""

