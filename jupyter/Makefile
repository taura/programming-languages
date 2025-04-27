#
# compile
#
#mk_nb_flags := --dbg 2

nb_srcs :=
nb_srcs += $(wildcard nb/source/pl03_*/*.sos)

aux_srcs :=
#aux_srcs += $(wildcard nb/source/pl06_*/??/Makefile)
#aux_srcs += $(wildcard nb/source/pl04_*/00hello/??/hello.??)
#aux_srcs += $(wildcard nb/source/pl04_*/01build_sys/??/_)
#aux_srcs += $(wildcard nb/source/pl04_*/p?/??/_)
#aux_srcs += $(wildcard nb/source/*/img/*.png)
aux_srcs += $(wildcard nb/source/*/img/*.svg)
#aux_srcs += $(wildcard nb/source/*/misc/*.html)
aux_srcs += $(wildcard nb/source/pl09_minc/parser/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/parser/Makefile)
aux_srcs += $(wildcard nb/source/pl09_minc/parser/example/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/go/minc/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/jl/minc/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/ml/minc/?????*)
aux_srcs += $(wildcard nb/source/pl09_minc/ml/minc/*/*)
aux_srcs += $(wildcard nb/source/pl09_minc/rs/minc/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/rs/minc/src/*.*)
aux_srcs += $(wildcard nb/source/pl09_minc/test/main.c)
aux_srcs += $(wildcard nb/source/pl09_minc/test/Makefile)
aux_srcs += $(wildcard nb/source/pl09_minc/test/src/*.c)
aux_srcs += $(wildcard nb/source/pl09_minc/test/src/src/fun.c)
aux_srcs += $(wildcard nb/source/pl09_minc/test/src/src/Makefile)

ans_aux_srcs :=
# ans_aux_srcs += $(wildcard nb/source/pl04_*/01build_sys/??/*/*/*)
# ans_aux_srcs += $(wildcard nb/source/pl04_*/01build_sys/??/*/*.*)
# ans_aux_srcs += $(wildcard nb/source/pl04_*/01build_sys/??/*/*-*)
# ans_aux_srcs += $(wildcard nb/source/pl04_*/p?/??/*/*/*)
# ans_aux_srcs += $(wildcard nb/source/pl04_*/p?/??/*/*.*)
# ans_aux_srcs += $(wildcard nb/source/pl04_*/p?/??/*/*-*)
# ans_aux_srcs += $(wildcard nb/source/pl05_*/p?/??/*/*/*)
# ans_aux_srcs += $(wildcard nb/source/pl05_*/p?/??/*/*.*)
# ans_aux_srcs += $(wildcard nb/source/pl05_*/p?/??/*/*-*)

users_csv := users.csv

feedback_class := pl
include ../../jupyter_tools/authoring/jupyter_tools.mk
