#SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c

nb_srcs :=
nb_srcs += $(wildcard nb/source/pl04_*/pl04_*.py)
aux_srcs :=
include ../../jupyter_tools/authoring/jupyter_tools.mk

in_dir:=ps
out_dir:=problems

deploy :
check :

#
# ps/fundef/compound/go/compound.go -> out/fundef/compound/go/compound.go
#
define deploy_code_dir
$(out_dir)/$(concept)/$(problem)/$(ext) :
	mkdir -p $$@
endef

define deploy_code
deploy : $(out_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext)
$(out_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) | $(out_dir)/$(concept)/$(problem)/$(ext)
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
endef

define check_code
check : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok
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

#
# ps/fundef/compound/go/compound.md -> out/fundef/compound/compound.md
#
define deploy_md
deploy : $(out_dir)/$(concept)/$(problem)/$(base).md
$(out_dir)/$(concept)/$(problem) :
	mkdir -p $$@
$(out_dir)/$(concept)/$(problem)/$(base).md : $(in_dir)/$(concept)/$(problem)/$(base).md $(out_dir)/$(concept)/$(problem)
	./format_string.py $$< out_dir=$(out_dir) concept=$(concept) problem=$(problem) base=$(base) > $$@
endef

#
# ps/fundef/compound/go/compound.md -> out/fundef/compound/compound.ipynb
#
define deploy_ipynb
deploy : $(out_dir)/$(concept)/$(problem)/$(base).ipynb
$(out_dir)/$(concept)/$(problem)/$(base).ipynb : $(in_dir)/$(concept)/$(problem)/$(base).py $(out_dir)/$(concept)/$(problem)/$(base).md $(out_dir)/$(concept)/$(problem)/go/$(base).go $(out_dir)/$(concept)/$(problem)/jl/$(base).jl $(out_dir)/$(concept)/$(problem)/ml/$(base).ml $(out_dir)/$(concept)/$(problem)/rs/$(base).rs
	./format_string.py $$< out_dir=$(out_dir) concept=$(concept) problem=$(problem) base=$(base) | ../../jupyter_tools/authoring/mk_nb.py --syntax py - > $$@
endef

define deploy_svg_dirs
$(out_dir)/$(concept)/$(problem)/svg/dir :
	mkdir -p $$@
$(out_dir)/$(concept)/$(problem)/svg/L/dir :
	mkdir -p $$@
endef

define deploy_svg
deploy : $(out_dir)/$(concept)/$(problem)/svg/$(base).svg
$(out_dir)/$(concept)/$(problem)/svg/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/$(base).svg | $(out_dir)/$(concept)/$(problem)/svg/dir
	cp $$< $$@
endef

define deploy_svg_L
deploy : $(out_dir)/$(concept)/$(problem)/svg/L/$(base).svg
$(out_dir)/$(concept)/$(problem)/svg/L/$(base).svg : $(in_dir)/$(concept)/$(problem)/svg/L/$(base).svg | $(out_dir)/$(concept)/$(problem)/svg/L/dir
	cp $$< $$@
endef

#
# compile and run ps/fundef/compound/go/compound.go
#
define check_code
check : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).ok : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe
	$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe | grep OK && touch $$@
$(in_dir)/$(concept)/$(problem)/$(ext)/$(base).exe : $(in_dir)/$(concept)/$(problem)/$(ext)/$(base).$(ext) $(out_dir)/$(concept)/$(problem)/$(ext)
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

deploy : $(out_dir)/problem_index.py
$(out_dir)/problem_index.py : $(in_dir)/problem_index.py
	cp $< $@

clean:
	rm -f ps/*/*/*/*~ ps/*/*/*~ ps/*/*/*/*.exe ps/*/*/*/*.cmi ps/*/*/*/*.cmo ps/*/*/*/*.ok

.DELETE_ON_ERROR:
