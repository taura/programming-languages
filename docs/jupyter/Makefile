#
# compile
#
#mk_nb_flags := --dbg 2

nb_srcs :=
nb_srcs += $(wildcard nb/source/pl00_*/*.sos)

aux_srcs :=
aux_srcs += $(wildcard nb/source/pl04_standalone/00hello/??/hello.??)
aux_srcs += $(wildcard nb/source/pl04_standalone/01build_sys/??/_)
aux_srcs += $(wildcard nb/source/pl04_standalone/p?/??/_)
#aux_srcs += $(wildcard nb/source/*/img/*.png)
#aux_srcs += $(wildcard nb/source/*/img/*.svg)
#aux_srcs += $(wildcard nb/source/*/misc/*.html)

users_csv := users.csv

feedback_class := os
include ../../../jupyter_tools/authoring/jupyter_tools.mk
