<link rel="stylesheet" href="scripts/style.css">

# Programming Languages Course Introduction<br/> Kenjiro Taura {.unnumbered}

# What's new

* <font color=blue>Blue letters in the beginning of a line</font> is the day the announcement was made
* <font color=red>Please reload the page</font> frequently as it will be updated during the course.

* <font color=blue>(2026/04/03)</font> Home page for AY2026 is out. Welcome!
* <font color=blue>(2026/04/03)</font> We use PC during the class. Bring your device.
* <font color=blue>(2026/04/03)</font> We are going to use Jupyter environment for your work. See [How to access Jupyter environment](html/jupyter2.html)
* <font color=blue>(2026/04/03)</font> Your user name and password will be distributed via UTOL (see [How to access Jupyter environment](html/jupyter2.html) above). 
* <font color=blue>(2026/04/03)</font> Accounts will be set up for the following people, so please make sure you will be included.
  * Those who already registered to this course via [UTAS](https://utas.adm.u-tokyo.ac.jp/) _by the day before the first class_
  * Those who bookmarked this course in [UTAS](https://utas.adm.u-tokyo.ac.jp/) _by the day before the first class_
  * Those who self-registered yourself, by pressing the "register a course" button on the upper right of the [UTOL course page](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2026_0340_FEN-EE4d19L1_01) _by now (the first class)_.  I will add those who did it later than that during the first class.
    * note: registering to UTOL does not mean you register to the course for credit, which has to be done via [UTAS](https://utas.adm.u-tokyo.ac.jp/). If you want to join the first day but haven't decided to take the course for credit, use this UTOL option.
* <font color=blue>(2026/04/03)</font> Plan for the first day (April 7th)
  1. Course introduction ([Roadmap](slides/00-roadmap.pdf))
  1. Answer a [survey](https://forms.office.com/r/pXQ5WbvgBJ) during the class today (before 11:45AM if possible)
  1. Play with Jupyter; use `pl00_intro` to practice submitting your work, in Jupyter and [UTOL](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2026_0340_FEN-EE4d19L1_01) (Assignment 01 : `pl00_intro`)
  1. Work on `pl01_basics` and submit it in Jupyter during the class by 11:45AM.  You don't have to complete everything (that's impossible); just submit the snapshot; you can continue working on it for your practice and submit it as many times as you want.  For today, no need to submit it to [UTOL](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2026_0340_FEN-EE4d19L1_01)
  1. Submit a Reflective Essay to [UTOL](https://utol.ecc.u-tokyo.ac.jp/lms/course?idnumber=2026_0340_FEN-EE4d19L1_01) after every class (due the next day).

<a name="ai_policy"> </a>

# AI Use Policy and Guideline

* In this course, we provide a dedicated Jupyter environment along with an AI tutor that you can interact with.
* You can use this tutor to ask questions or get feedback on your answers.
* If you are wondering what you can legitimately ask AI --- especially when it could solve many of the exercises perfectly --- that is exactly the kind of concern a serious learner should have.

* I will address this both as a general principle and as a more specific policy in this course.

## General Guideline

* To *learn effectively*, I recommend the following when using AI:
  * ask questions _<font color="blue">whose answers you can easily absorb and make your own</font>_
  * never ask a question whose answer you cannot make sense of
  * more generally, avoid asking questions _<font color="blue">whose answers would take significant effort just to parse and internalize</font>_

* A good rule of thumb is to _<font color="blue">interact with AI in small steps</font>_, reading and digesting each response as you go.
  * If you find yourself copying a chunk of text or code you are not willing to read, that is a sign you are using AI poorly.

* Another way to put it is:
  * _<span style="color:blue">"know what you need to know, and ask it"</span>_
  * rather than _<span style="color:red">"ask what you need to do"</span>_

* The <span style="color:red">worst</span> way to use AI for learning is to <span style="color:red">ask AI to do what you are asked to do</span>.
  * If you submit its response as your answer, it will quickly start to erode your ability to think and learn independently.
  * Even if you carefully read and try to follow the answer, this is still not an effective way to learn how things work; <span style="color:red">you cannot efficiently learn how compilers work just by reading their entire source code, can you?</span>

* For a simple example, suppose you are asked to write a function that takes $a$, $b$, and $c$ and computes $\cos(a + b + c)$, but you do not yet know the language you are using.  
* You should ask questions such as:
  * How do I define a function in language X?
  * How do I call the cosine function in language X?
  * Whatever you think you need to know along the way  
* instead of:
  * Write a function that takes $a$, $b$, and $c$ and returns $\cos(a + b + c)$ in language X.

* In this small example the difference may not matter much, but I hope you get the idea.

* Interestingly, this is almost the opposite of what is often called "advanced" use of AI for work productivity:
  * In that setting, the goal is to delegate as much work as possible to AI systems or agents with minimal human involvement.
  * Whether this vision is realistic or not, when work productivity is the goal, it often makes sense to issue large, outcome-oriented instructions rather than breaking work into small steps.
* In learning, however, the situation is fundamentally different:
  * breaking problems into small pieces and interacting with AI step by step is essential, because _<font color="blue">learning from each response is the point</font>_.
  * As a side benefit, you learn how to articulate questions clearly --- _<font color="blue">to know what you do not know</font>_.

* If you do not know how to decompose a problem, you may ask AI for help with that (e.g., <span style="color:blue">"I have no clue. What basics do I need to learn to approach this problem?"</span>).

* To be clear:
  * I am not against using AI for learning.
  * Nor is it that efficiency does not matter in learning.

* The point is that _<font color="blue">learning efficiently</font>_ is fundamentally different from simply _<font color="red">getting things done efficiently</font>_;
  learning is about _<span style="color:blue">making lasting changes to your brain</span>_.

## Specific Policy in This Course

* <span style="color:blue">[OK]</span> Ask general questions to help you solve a problem (e.g., how to write functions in Go)
* <span style="color:blue">[OK]</span> Ask for hints about how to decompose a problem into steps
* <span style="color:blue">[OK]</span> Ask what is wrong with your answer (e.g., debugging errors)
* <span style="color:blue">[OK]</span> Ask for feedback on your answer
* <span style="color:blue">[OK]</span> In larger problems later in the course, ask AI to generate small, well-defined components
* <span style="color:red">[NG]</span> In small problems in the early part of the course, ask AI to generate the full answer
* <span style="color:red">[NG]</span> Use auto-completion tools (e.g., GitHub Copilot) that effectively write the code for you
* <span style="color:red">[NG]</span> Ask AI to generate a substantial part of a project in a single prompt

* There will always be borderline cases, however. When unsure, get back to the principles or consult me.

# Data Sharing Request

* In this course, we provide a dedicated Jupyter environment along with an AI tutor that you can interact with.

* Within this environment, the following information will be recorded:
  * Your code editing, compilation, and execution history
  * Your questions to the AI and its responses
  * Outputs and error messages
* These data help us understand where students struggle, how they approach problem solving, and what kinds of questions they ask
* Our goal is to use this information to improve teaching and to conduct research on learning and education

## Purpose of Use

* The collected data may be used for:

  * Improving course materials and teaching methods
  * Designing and improving learning support tools
  * Research on learning and education

## Privacy Considerations

* When  used for research purposes, personally identifiable information will be  removed or anonymized as appropriate. 

* No information that could  identify an individual will be published or publicly released.
* The data will be handled in accordance with applicable regulations and university policies.
* Use  of data that identifies an individual is strictly limited to  pedagogical purposes within this course, for the benefit of that  student, such as providing feedback to them.
* _<font color=blue>In particular, we do _not_ use what you asked AI, let alone how it responded, for grading or cheat detection.</font>_  You can choose not to provide data; and we are fully aware that serious cheater could use other AIs.

## Voluntary Participation (Opt-in)

* Your participation is entirely voluntary (opt-in)

* If you choose not to consent: 
  * You will still be able to use the provided system
  * You will not be disadvantaged in grading or any aspect of the course
* You may also withdraw your consent later by sending this form again
* If you are willing to contribute your data, please indicate your consent using the form below:
* We appreciate your cooperation in helping us improve learning for future students.

<iframe width="640px" height="480px" src="https://forms.cloud.microsoft/r/ndZtbg9Lgs?embed=true" frameborder="0" marginwidth="0" marginheight="0" style="border: none; max-width:100%; max-height:100vh" allowfullscreen webkitallowfullscreen mozallowfullscreen msallowfullscreen> </iframe>

# Slides and other materials

* [Roadmap](slides/00-roadmap.pdf)
* [Functional Programming Basics](slides/01-functional.pdf)
* [Essence of Object-Oriented Programming](slides/02-oop.pdf)
* [Going outside Jupyter and Using Libraries](slides/03-standalone-and-libraries.pdf)
* [Parametric Polymorphism (aka Generic Types/Functions)](slides/04-parametric.pdf)
* [Basics of programming language implementation](slides/05-implementation-basics.pdf)
* [Memory Management](slides/06-memory-management.pdf)
* [Garbage Collection (GC) : A Brief Introductions](slides/07-gc-basics.pdf)
* [Writing Aseembly](slides/08-writing-assembly.pdf)
* [Writing a Compiler](slides/09-compiler.pdf )
* [Rust Memory Management](slides/10-rust.pdf)
* [Garbage Collection](slides/09-gc-adv.pdf)

# References

* [Compilers: Principles, Techniques, and Tools: International Edition](https://www.amazon.co.jp/Compilers-Principles-Techniques-Tools-International/dp/0321491696)
* Richard Jones and Rafael D Lins. [Garbage Collection: Algorithms for Automatic Dynamic Memory Management](https://www.amazon.co.jp/Programming-Rust-Fast-Systems-Development/dp/1492052590/ref=pd_lpo_1?pd_rd_i=1492052590&psc=1)
* Yaron Minsky, Anil Madhavapeddy, and Jason Hickey. [Real World OCaml: Functional programming for the masses.](http://www.amazon.com/Real-World-OCaml-Functional-programming/dp/144932391X/ref=tmm_pap_title_0?ie=UTF8&qid=1396268703&sr=8-1-spell)
* Benjamin Pierce. [Types and Programming Languages.](http://www.cis.upenn.edu/~bcpierce/tapl/)

# Links


* [Go](https://go.dev/)
  * [tutorial](https://www.tutorialspoint.com/go/go_basic_syntax.htm)
  * [cheatsheet](https://devhints.io/go)
  * [reference/spec](https://go.dev/ref/spec)
* [Julia](https://julialang.org/)
  * [tutorial](https://syl1.gitbook.io/julia-language-a-concise-tutorial)
  * [cheetsheet](https://cheatsheet.juliadocs.org/)
  * [reference](https://docs.julialang.org/en/v1/)
* [OCaml](http://caml.inria.fr/)
  * [tutorial](https://ocaml.org/docs/tour-of-ocaml)
  * [cheetsheet](https://ocamlpro.github.io/ocaml-cheat-sheets/ocaml-lang.pdf)
  * [reference](https://ocaml.org/manual/5.4/index.html)
* [Rust](https://www.rust-lang.org/)
  * [tutorial](https://www.tutorialspoint.com/rust/index.htm)
  * [cheetsheet](https://quickref.me/rust.html)
  * [reference](https://doc.rust-lang.org/reference/)
* [Python](https://www.python.org/)
* [Conservative GC](http://valgrind.org/)
* [valgrind](http://valgrind.org/)
* [LLVM](http://llvm.org/)
* [COINS (in Japanese)](http://coins-compiler.sourceforge.jp/international/)

# Grading

* Details will be described later, but it will be similar to the last year's
* See [Programming Languages: the Term Report (2025)](html/final_report.html)

