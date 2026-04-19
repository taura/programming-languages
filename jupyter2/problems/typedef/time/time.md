# <font color="green">Time</font>

* Define a data type `time` (or `Time`, depending on your language's naming convention) that represents a time of day, consisting of hours, minutes, and seconds.
* Then define the following two functions:
  * `second_of_time` (or `secondOfTime`): converts a `time` value to a floating-point number representing the elapsed seconds since the start of the same day. For example, given a time of 3:00 AM, it should return `10800.0`.
  * `time_diff` (or `timeDiff`): takes two `time` values $a$ and $b$, and returns the elapsed seconds from $b$ to $a$ (i.e., how many seconds after $b$ the time $a$ occurs).
  
* Boilerplate source files `{go,jl,ml,rs}/time.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
