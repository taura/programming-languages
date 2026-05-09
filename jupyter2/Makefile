#SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

nb_srcs :=
nb_srcs += $(wildcard nb/source/pl04_*/pl04_*.py)
aux_srcs :=
include ../../jupyter_tools/authoring/jupyter_tools.mk

in_dir:=ps
prob_dir:=problems
ans_dir:=../docs/html/answers

deploy :
check :

#
# ps/fundef/compound/go
#
define deploy_code_dir
$(prob_dir)/$(concept)/$(problem)/$(ext) :
	mkdir -p $$@
$(ans_dir)/$(concept)/$(problem)/$(ext) :
	mkdir -p $$@
endef

define deploy_code
#
# ps/fundef/compound/go/compound.go -> problems/fundef/compound/go/compound.go
#
# remove all lines between ... begin hidden ... and ... end hidden ... for problems
#
deploy : $(prob_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext)
$(prob_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) | $(prob_dir)/$(concept)/$(problem)/$(ext)
ifeq ($(ext),go)
	sed '/\/\*\* begin hidden \*\//,/\/\*\* end hidden \*\//d' $$< > $$@
endif
ifeq ($(ext),jl)
	sed '/### begin hidden/,/### end hidden/d' $$< > $$@
endif
ifeq ($(ext),ml)
	sed '/(\*\* begin hidden \*)/,/(\*\* end hidden \*)/d' $$< > $$@
endif
ifeq ($(ext),rs)
	sed '/\/\*\* begin hidden \*\//,/\/\*\* end hidden \*\//d' $$< > $$@
endif

#
# ps/fundef/compound/go/compound.go -> answers/fundef/compound/go/compound.go
#
# remove lines /** (begin|end) hidden **/
#
deploy : $(ans_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext)
$(ans_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) | $(ans_dir)/$(concept)/$(problem)/$(ext)
ifeq ($(ext),go)
	sed '/\/\*\* \(begin\|end\) hidden \*\//d' $$< > $$@
endif
ifeq ($(ext),jl)
	sed '/### \(begin\|end\) hidden/d' $$< > $$@
endif
ifeq ($(ext),ml)
	sed '/\(\*\* \(begin\|end\) hidden \*\)/d' $$< > $$@
endif
ifeq ($(ext),rs)
	sed '/\/\*\* \(begin\|end\) hidden \*\//d' $$< > $$@
endif

endef

define check_code
check : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok
#
# ps/fundef/compound/go/compound.go -> ps/fundef/compound/go/compound.exe
#
# compile the source code
#
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe
	$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe | grep OK && touch $$@
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext)
ifeq ($(ext),go)
	go build -o $$@ $$
endif
ifeq ($(ext),jl)
	echo '#!/usr/bin/env julia' | cat - $$< > $$@
	chmod +x $$@
endif
ifeq ($(ext),ml)
	ocamlc $$< -o $$@
endif
ifeq ($(ext),rs)
	rustc -C opt-level=3 $$< -o $$@
endif
endef

define deploy_md
#
# ps/fundef/compound/go/compound.md -> problems/fundef/compound/compound.md
#
# replace {...}
#
deploy : $(prob_dir)/$(concept)/$(problem)/$(base).md
$(prob_dir)/$(concept)/$(problem) :
	mkdir -p $$@
$(prob_dir)/$(concept)/$(problem)/$(base).md : $(in_dir)/$(concept)/$(problem)/$(base).md $(prob_dir)/$(concept)/$(problem)
	./format_string.py $$< out_dir=$(prob_dir) concept=$(concept) problem=$(problem) base=$(base) > $$@

#
# ps/fundef/compound/go/compound.md -> answers/fundef/compound/compound.md
#
# replace {...}
#
deploy : $(ans_dir)/$(concept)/$(problem)/$(base).md
$(ans_dir)/$(concept)/$(problem) :
	mkdir -p $$@
$(ans_dir)/$(concept)/$(problem)/$(base).md : $(in_dir)/$(concept)/$(problem)/$(base).md $(ans_dir)/$(concept)/$(problem)
	./format_string.py $$< out_dir=$(ans_dir) concept=$(concept) problem=$(problem) base=$(base) > $$@
endef

define deploy_ipynb
#
# ps/fundef/compound/go/compound.py -> problems/fundef/compound/compound.ipynb
#
deploy : $(prob_dir)/$(concept)/$(problem)/$(base).ipynb
$(prob_dir)/$(concept)/$(problem)/$(base).ipynb : $(in_dir)/$(concept)/$(problem)/$(base).py $(prob_dir)/$(concept)/$(problem)/$(base).md $(prob_dir)/$(concept)/$(problem)/go/$(base).go $(prob_dir)/$(concept)/$(problem)/jl/$(base).jl $(prob_dir)/$(concept)/$(problem)/ml/$(base).ml $(prob_dir)/$(concept)/$(problem)/rs/$(base).rs
	./format_string.py $$< out_dir=$(prob_dir) concept=$(concept) problem=$(problem) base=$(base) | ../../jupyter_tools/authoring/mk_nb.py --syntax py - > $$@

#
# ps/fundef/compound/go/compound.py -> answers/fundef/compound/compound.ipynb
#
$(ans_dir)/$(concept)/$(problem)/$(base).ipynb : $(in_dir)/$(concept)/$(problem)/$(base).py $(ans_dir)/$(concept)/$(problem)/$(base).md $(ans_dir)/$(concept)/$(problem)/go/$(base).go $(ans_dir)/$(concept)/$(problem)/jl/$(base).jl $(ans_dir)/$(concept)/$(problem)/ml/$(base).ml $(ans_dir)/$(concept)/$(problem)/rs/$(base).rs
	./format_string.py $$< out_dir=$(ans_dir) concept=$(concept) problem=$(problem) base=$(base) | ../../jupyter_tools/authoring/mk_nb.py --syntax py - > $$@

deploy : $(ans_dir)/$(concept)/$(problem)/$(base).html
$(ans_dir)/$(concept)/$(problem)/$(base).html : $(ans_dir)/$(concept)/$(problem)/$(base).ipynb
	jupyter-nbconvert --to html $$<

endef

define deploy_svg_dirs
#
# problems/fundef/compound/svg
#
$(prob_dir)/$(concept)/$(problem)/svg/dir :
	mkdir -p $$@
$(prob_dir)/$(concept)/$(problem)/svg/L/dir :
	mkdir -p $$@

#
# answers/fundef/compound/svg
#
$(ans_dir)/$(concept)/$(problem)/svg/dir :
	mkdir -p $$@
$(ans_dir)/$(concept)/$(problem)/svg/L/dir :
	mkdir -p $$@
endef

define deploy_svg
#
# ps/fundef/compound/svg/*.svg -> problems/fundef/compound/svg/*.svg
#
deploy : $(prob_dir)/$(concept)/$(problem)/svg/$(base).svg
$(prob_dir)/$(concept)/$(problem)/svg/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/$(base).svg | $(prob_dir)/$(concept)/$(problem)/svg/dir
	cp $$< $$@

#
# ps/fundef/compound/svg/*.svg -> answers/fundef/compound/svg/*.svg
#
deploy : $(ans_dir)/$(concept)/$(problem)/svg/$(base).svg
$(ans_dir)/$(concept)/$(problem)/svg/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/$(base).svg | $(ans_dir)/$(concept)/$(problem)/svg/dir
	cp $$< $$@
endef

define deploy_svg_L
#
# ps/fundef/compound/svg/L/*.svg -> problems/fundef/compound/svg/L/*.svg
#
deploy : $(prob_dir)/$(concept)/$(problem)/svg/L/$(base).svg
$(prob_dir)/$(concept)/$(problem)/svg/L/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/L/$(base).svg | $(prob_dir)/$(concept)/$(problem)/svg/L/dir
	cp $$< $$@

#
# ps/fundef/compound/svg/L/*.svg -> answers/fundef/compound/svg/L/*.svg
#
deploy : $(ans_dir)/$(concept)/$(problem)/svg/L/$(base).svg
$(ans_dir)/$(concept)/$(problem)/svg/L/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/L/$(base).svg | $(ans_dir)/$(concept)/$(problem)/svg/L/dir
	cp $$< $$@
endef

#
# compile and run ps/fundef/compound/go/compound.go
#
define check_code_xxxx
check : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe
	$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe | grep OK && touch $$@
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) $(prob_dir)/$(concept)/$(problem)/$(ext)
ifeq ($(ext),go)
	go build -o $$@ $$<
endif
ifeq ($(ext),jl)
	echo '#!/usr/bin/env julia' | cat - $$< > $$@
	chmod +x $$@
endif
ifeq ($(ext),ml)
	ocamlc $$< -o $$@
endif
ifeq ($(ext),rs)
	rustc -C opt-level=3 $$< -o $$@
endif
endef

#
# $(call dir_in,D) -> Dの中のdirectory
# D/{a,b,c} -> a b c
#
define dir_in
$(shell find $(1) -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
endef

define lang_in
$(shell find $(1) -mindepth 1 -maxdepth 1 -type d -name '??' -printf "%f\n")
endef

#
# $(call dir_in,D,ext) -> Dの中の *.ext の base部分
# D/{a,b,c}.ext -> a b c
#
define ext_in
$(shell test -d $(1) && find $(1) -mindepth 1 -maxdepth 1 -name '*.$(2)' -exec basename -s .$(2) {} +)
endef

EVAL=$(eval $(1))
#EVAL=$(info $(1))

ifeq (a,a)
$(foreach concept,$(call dir_in,$(in_dir)), \
 $(foreach problem,$(call dir_in,$(in_dir)/$(concept)), \
  $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem),md),$(call EVAL,$(call deploy_md))) \
  $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem),py),$(call EVAL,$(call deploy_ipynb))) \
  $(if $(call ext_in,$(in_dir)/$(concept)/$(problem)/svg,svg), $(call EVAL,$(call deploy_svg_dirs)) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/svg,svg),$(call EVAL,$(call deploy_svg)))) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/svg/L,svg),$(call EVAL,$(call deploy_svg_L))) \
  $(foreach ext,$(call lang_in,$(in_dir)/$(concept)/$(problem)), \
   $(call EVAL,$(call deploy_code_dir)) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/$(ext),$(ext)),$(call EVAL,$(call deploy_code))) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/$(ext),$(ext)),$(call EVAL,$(call check_code)))) \
))
endif

ifeq (a,b)
$(eval $(foreach concept,$(call dir_in,$(in_dir)), \
 $(foreach problem,$(call dir_in,$(in_dir)/$(concept)), \
  $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem),md),$(call deploy_md)) \
  $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem),py),$(call deploy_ipynb)) \
  $(if $(call ext_in,$(in_dir)/$(concept)/$(problem)/svg,svg),$(call deploy_svg_dirs) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/svg,svg),$(call deploy_svg))) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/svg/L,svg),$(call deploy_svg_L)) \
  $(foreach ext,$(call lang_in,$(in_dir)/$(concept)/$(problem)), \
   $(call deploy_code_dir) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/$(ext),$(ext)),$(call deploy_code)) \
   $(foreach base,$(call ext_in,$(in_dir)/$(concept)/$(problem)/$(ext),$(ext)),$(call check_code))) \
)))
endif

deploy : $(prob_dir)/problem_index.py
$(prob_dir)/problem_index.py : $(in_dir)/problem_index.py
	cp $< $@

deploy : $(ans_dir)/problem_index.py
$(ans_dir)/problem_index.py : $(in_dir)/problem_index.py
	cp $< $@

clean:
	rm -f ps/*/*/*/*~ ps/*/*/*~ ps/*/*/*/*.exe ps/*/*/*/*.cmi ps/*/*/*/*.cmo ps/*/*/*/*.ok

.DELETE_ON_ERROR:
