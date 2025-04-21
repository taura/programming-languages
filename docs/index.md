<link rel="stylesheet" href="scripts/style.css">

# Programming Languages Course Introduction<br/> Kenjiro Taura {.unnumbered}

# What's new

* <font color=blue>Blue letters in the beginning of a line</font> is the day the announcement was made
* <font color=red>Please reload the page</font> frequently as it will be updated during the course.

* <font color=blue>(2025/04/20)</font> Plan for April 21st
  1. Work on `pl01_basics` for 10 minutes and briefly review answers in [spreadsheet](https://univtokyo-my.sharepoint.com/:f:/g/personal/2615215597_utac_u-tokyo_ac_jp/EnuN7pra4klGozkzfTknOOwBkDAkdfMbMTxOaPS0qELq-Q?e=40ecSi)
  1. [Functional Programming Basics](slides/01-functional.pdf)
  1. Work on `pl02_fp_basics`, and share your answers in the same [spreadsheet](https://univtokyo-my.sharepoint.com/:f:/g/personal/2615215597_utac_u-tokyo_ac_jp/EnuN7pra4klGozkzfTknOOwBkDAkdfMbMTxOaPS0qELq-Q?e=40ecSi)
  1. Until the end of today's class, answer [language preference survey](https://forms.office.com/r/qnR50JQ6ZS)
     - <font color="red">Update after the class:</font> I will start grouping wednesday.  Please submit your survey no later than <font color="red">23:59, April 22nd</font>
* <font color=blue>(2025/04/20)</font> Lecture recordings available from the "Course Materials" section of [UTOL course page](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2025_0340_FEN-EE4d19L1_01)
* <font color=blue>(2025/03/29)</font> Home page for AY2025 is out. Welcome!
* <font color=blue>(2025/03/29)</font> We use PC during the class. Bring your device.
* <font color=blue>(2025/03/29)</font> We are going to use Jupyter environment for your work. See [How to access Jupyter environment](html/jupyter.html?lang=en)
* <font color=blue>(2025/03/29)</font> Your user name and password will be distributed via UTOL (see [How to access Jupyter environment](html/jupyter.html?lang=en) above). They are sent to the following people, so please make sure you will be included.
  * Those who already registered to this course via [UTAS](https://utas.adm.u-tokyo.ac.jp/) _before yesterday_
  * Those who bookmarked this course in [UTAS](https://utas.adm.u-tokyo.ac.jp/) _before yesterday_
  * Those who self-registered yourself, by pressing the "register a course" button on the upper right of the [UTOL course page](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2025_0340_FEN-EE4d19L1_01) _before around 9:30AM today_.  I will add those who did it later than that during the class.
    * note: registering to UTOL does not mean you register to the course for credit, which has to be done via [UTAS](https://utas.adm.u-tokyo.ac.jp/). If you want to join the first day but haven't decided to take the course for credit, use this UTOL option.
* <font color=blue>(2025/03/29)</font> Plan for the first day (April 7th)
  1. Course introduction ([Roadmap](slides/00-roadmap.pdf))
  1. Answer a [survey](https://forms.office.com/r/pXQ5WbvgBJ) during the class today (before 11:45AM if possible)
  1. Play with Jupyter; use `pl00_intro` to practice submitting your work, in [Jupyter](html/jupyter.html?lang=en) and [UTOL](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2025_0340_FEN-EE4d19L1_01) (Assignment 01 : `pl00_intro`)
    * Don't forget to play with the AI tutor in `pl00_intro/pl00_tutor.sos`
  1. Work on `pl01_basics`. Please share answer in this [spreadsheet](https://univtokyo-my.sharepoint.com/:f:/g/personal/2615215597_utac_u-tokyo_ac_jp/EnuN7pra4klGozkzfTknOOwBkDAkdfMbMTxOaPS0qELq-Q?e=40ecSi) after 11:15AM (whoever comes first)
  1. Submit a Reflective Essay to [UTOL](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2025_0340_FEN-EE4d19L1_01) after every lecture (due the next day).
* (optional) There is a UTokyo Slack / EEIC workspace / `#2025s-programming-languages` channel for mutual help on this course
  * To join it, find the [EEIC: 工学部 電子情報工学科・電気電子工学科](https://utokyo-eeic.slack.com) workspace (public) from the [UTokyo Slack directory page](https://utokyo.enterprise.slack.com/), join the workspace (anybody with access to UTokyo Slack can join the workspace), and then to the channel
  * For general instruction and prerequisites on UTokyo Slack, see [Joining an open workspace in UTokyo Slack](https://utelecon.adm.u-tokyo.ac.jp/en/slack/join) in utelecon (or Google "utokyo slack"); in particular, [Multi-Factor Authentication (MFA)](https://utelecon.adm.u-tokyo.ac.jp/en/utokyo_account/mfa/) is mandatory; if you haven't done it yet, do it later, not during the lecture
* How to reach me?
  * UTOL message
  * Email (`tau at eidos.ic.i.u-tokyo.ac.jp`)
  * UTokyo Slack / EEIC workspace / `#2025s-programming-languages` channel

# Slides and other materials

* [Roadmap](slides/00-roadmap.pdf)
* [Functional Programming Basics](slides/01-functional.pdf)
* [Essence of Object-Oriented Programming](slides/02-oop.pdf)
* [Going outside Jupyter and Using Libraries](slides/03-standalone-and-libraries.pdf)
* [Parametric Polymorphism (aka Generic Types/Functions)](slides/04-parametric.pdf)
* [Basics of programming language implementation](slides/05-implementation-basics.pdf)
* [Memory Management](slides/06-memory-management.pdf)
* [Garbage Collection (GC) : A Brief Introductions](slides/07-gc-basics.pdf)
* [Rust Memory Management](slides/08-rust.pdf)
* [Garbage Collection](slides/09-gc-adv.pdf)
* [Making a Compiler](slides/10-compiler.pdf )

# References

* [Compilers: Principles, Techniques, and Tools: International Edition](https://www.amazon.co.jp/Compilers-Principles-Techniques-Tools-International/dp/0321491696)
* Richard Jones and Rafael D Lins. [Garbage Collection: Algorithms for Automatic Dynamic Memory Management](https://www.amazon.co.jp/Programming-Rust-Fast-Systems-Development/dp/1492052590/ref=pd_lpo_1?pd_rd_i=1492052590&psc=1)
* Yaron Minsky, Anil Madhavapeddy, and Jason Hickey. [Real World OCaml: Functional programming for the masses.](http://www.amazon.com/Real-World-OCaml-Functional-programming/dp/144932391X/ref=tmm_pap_title_0?ie=UTF8&qid=1396268703&sr=8-1-spell)
* Benjamin Pierce. [Types and Programming Languages.](http://www.cis.upenn.edu/~bcpierce/tapl/)

# Links

* [Go](https://go.dev/)
* [Julia](https://julialang.org/)
* [OCaml](http://caml.inria.fr/)
* [Rust](https://www.rust-lang.org/)
* [Python](https://www.python.org/)
* [Conservative GC](http://valgrind.org/)
* [valgrind](http://valgrind.org/)
* [LLVM](http://llvm.org/)
* [COINS (in Japanese)](http://coins-compiler.sourceforge.jp/international/)

# Grading
