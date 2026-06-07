#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
//#import themes.university: *
//#import themes.aqua: *
//#import themes.dewdrop: *
//#import themes.simple: *
//#import themes.stargazer: *
//#import themes.default: *
//#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Roadmap],
    author: [Kenjiro Taura],
    date: [2026/04/06],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 28pt)
#set quote(block: true)
#let ao(x) = text(blue)[#x]
#let aka(x) = text(red)[#x]
#let small(x) = text(size: 20pt)[#x]

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

#show raw.where(block: true): it => text(size: 20pt, pad(left: 0.7em, it))
#show raw.where(block: false): it => text(rgb(127,127,127), size: 20pt, it)

#title-slide()

== Objectives of programming languages

- easy to learn
- easy to get programs right
- execute fast
- safe (avoid disaster)

== The course objectives

- get how different programming languages approach these goals differently
- topics
  - types
  - code reusability (generics, subtyping, inheritance, etc.)
  - memory management/safety
  - performance
  - building compilers

- practices / exercises: you choose two languages from below and do course work in them
  - #ao[Go]
  - #ao[Julia]
  - #ao[OCaml]
  - #ao[Rust]
- choose one from {Julia, OCaml} and the other from {Go, Rust}

== The course format

- lecture + exercises (Jupyter, during class time and home work)
- after a few weeks, we group students
- each group will be two or three students, each working on two different languages
- we discuss approaches to the above objectives taken by different languages, within and across groups
- you are expected to engage in these discussions and other activities (not just to listen to talks and get things done)

== Evaluation

- small coding-centric assignments in Jupyter (a few times)
- reflective essays (every week, due the end of the next day)
- participations (esp. in discussions)
- a final report (building a simple compiler by default; other options are possible)
- no exams
- some Jupyter exercises are for self learning (no need to submit)
- #ao[_assignments / reports subject for evaluation/grading are indicated as assignments in UTOL_]

== Reflective essay

- every week, you write a short reflective essay that expresses such things as
  - what #ao[_you_] have learned (conceptualize/internalize experiences)
  - what came through #ao[_your_] mind while listening to the talk and working on assignments
  - how #ao[_you_] worked on the exercise (where you struggled, how you got help, how useful was AI, etc.)

== Today
- answer a survey on your programming language experiences and the preferred (natural) language
- play with the Jupyter environment
    - work on a language or two you choose (one from {Julia, OCaml}, one from {Go, Rust})
    - write a few programs in them
- practice submission (submit #ao[pl00\_intro] in Jupyter and UTOL (Assignment 1))
- work on assignment #ao[pl01\_basics]

== AI Tutor (Hey Tutor!)

- you can ask AI from Jupyter environment
- see #link("https://taura.github.io/programming-languages/index.html#ai_policy")[the course home page] and instructions in the notebook for details
- I encourage you to use AI to _help you learn effectively,_ not to delegate your work
- Guidelines are in the home page

== Good usage vs. bad usage

- objective of learning is making changes in your brain

#grid(columns: (0.45fr, 0.1fr, 0.45fr), align: bottom,
    [#images("svg/L/dialogue_tame", range(1,14), width: 90%)
        #only("14-")[#image("svg/L/dialogue_tame_L13.svg", width: 90%)]
    ],
    [#h(1em) vs. #h(1em)],
    [#only("1-13")[#image("svg/L/dialogue_dame_L1.svg", width: 90%)]
        #only("14")[#image("svg/L/dialogue_dame_L2.svg", width: 90%)]
        #only("15-")[#image("svg/L/dialogue_dame_L3.svg", width: 90%)]
    ]
)

#uncover(16)[
- good : many short interactions you actually absorb
- bad : large output you will not read
]

== Fragmented knowledge vs. structured knowledge

- A single interaction with AI only gives you an answer to a narrow question
- Repeated interactions only give you a collection of _disconnected_ knowledge and does not stick in memory

#grid(columns: (0.45fr, 0.05fr, 0.45fr), align: bottom+center,
    [#image("svg/fragmented_knowledge.svg", width: 40%)],
    [vs.],
    [#image("svg/structured_knowledge.svg", width: 40%)])

== Fragmented knowledge vs. structured knowledge


- Knowledge sticks in your brain when they are _connected_ and _structured_
- How to obtain a _connected/structured knowledge_? $=>$ (good) textbooks or books on a subject

#grid(columns: (0.45fr, 0.05fr, 0.45fr), align: bottom+center,
    [#image("svg/fragmented_knowledge.svg", width: 40%)],
    [vs.],
    [#image("svg/structured_knowledge.svg", width: 40%)])
    
