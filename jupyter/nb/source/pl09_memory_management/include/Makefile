langs:=go jl ml rs cc
prob_nos:=$(shell seq 1 4)
out:=out
S:=100000
M:=100
N:=1000

define prob_name
$(strip \
$(if $(filter $(prob_no),1),alloc_arrays,\
$(if $(filter $(prob_no),2),show_addr_no_gc,\
$(if $(filter $(prob_no),3),show_addr,\
$(if $(filter $(prob_no),4),measure_time,unknown)))))
endef

#.DEFAULT_GOAL := dir
#.DEFAULT_GOAL := src
#.DEFAULT_GOAL := exe
.DEFAULT_GOAL := out

define cc_rule
dir : $(out)/p$(prob_no)/cc/$(call prob_name)/_
$(out)/p$(prob_no)/cc/$(call prob_name)/_ :
	mkdir -p $(out)/p$(prob_no)/cc/$(call prob_name)
	touch $$@

# pl07.LANG -> out/pN/LANG/pName/pName.LANG
src : $(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name).cc
$(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name).cc : pl07.cc $(out)/p$(prob_no)/cc/$(call prob_name)/_
	./mk_version.py -D label="$(call prob_name)" $$< > $$@

# out/pN/LANG/pName/pName.LANG -> executable
exe : $(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name)
$(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name) : $(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name).cc
	gcc -O3 -Wall -Wextra -o $$@ $$< $(if $(or $(filter $(prob_no),1),$(filter $(prob_no),2)),,-lgc)

# executable -> out.csv
out : $(out)/p$(prob_no)/cc/$(call prob_name)/out.csv
$(out)/p$(prob_no)/cc/$(call prob_name)/out.csv : $(out)/p$(prob_no)/cc/$(call prob_name)/$(call prob_name)
	/usr/bin/time $$< $(S) $(M) $(N) > $$@
endef

define go_rule
# go mod init EX -> out/pN/LANG/pName
dir : $(out)/p$(prob_no)/go/$(call prob_name)/go.mod
$(out)/p$(prob_no)/go/$(call prob_name)/go.mod :
	mkdir -p $(out)/p$(prob_no)/go/$(call prob_name)
	cd $(out)/p$(prob_no)/go/$(call prob_name) && go mod init $(call prob_name)
	$(if $(filter $(call prob_name),measure_time),cd $(out)/p$(prob_no)/go/$(call prob_name) && go get github.com/loov/hrtime)

# pl07.LANG -> out/pN/LANG/pName/pName.LANG
src : $(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name).go
$(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name).go : pl07.go $(out)/p$(prob_no)/go/$(call prob_name)/go.mod
	./mk_version.py -D label="$(call prob_name)" $$< > $$@

# out/pN/LANG/pName/pName.LANG -> executable
exe : $(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name)
$(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name) : $(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name).go
	cd $(out)/p$(prob_no)/go/$(call prob_name) && go build

# executable -> out.csv
out : $(out)/p$(prob_no)/go/$(call prob_name)/out.csv
$(out)/p$(prob_no)/go/$(call prob_name)/out.csv : $(out)/p$(prob_no)/go/$(call prob_name)/$(call prob_name)
	GOMAXPROCS=1 /usr/bin/time $$< $(S) $(M) $(N) > $$@
endef

define jl_rule
dir : $(out)/p$(prob_no)/jl/$(call prob_name)/_
$(out)/p$(prob_no)/jl/$(call prob_name)/_ : 
	mkdir -p $(out)/p$(prob_no)/jl/$(call prob_name)
	touch $$@

# pl07.LANG -> out/pN/LANG/pName/pName.LANG
src : $(out)/p$(prob_no)/jl/$(call prob_name)/$(call prob_name).jl 
exe : $(out)/p$(prob_no)/jl/$(call prob_name)/$(call prob_name).jl 
$(out)/p$(prob_no)/jl/$(call prob_name)/$(call prob_name).jl : pl07.jl $(out)/p$(prob_no)/jl/$(call prob_name)/_
	./mk_version.py -D label="$(call prob_name)" $$< > $$@

# out/pN/LANG/pName/pName.LANG -> out.csv
out : $(out)/p$(prob_no)/jl/$(call prob_name)/out.csv
$(out)/p$(prob_no)/jl/$(call prob_name)/out.csv : $(out)/p$(prob_no)/jl/$(call prob_name)/$(call prob_name).jl
	/usr/bin/time julia $$< $(S) $(M) $(N) > $$@
endef

define ml_rule
# dune init project EX -> out/pN/LANG/pName
dir : $(out)/p$(prob_no)/ml/$(call prob_name)/bin/dune
$(out)/p$(prob_no)/ml/$(call prob_name)/bin/dune :
	mkdir -p $(out)/p$(prob_no)/ml
	cd $(out)/p$(prob_no)/ml && dune init project $(call prob_name)
	sed -i -e "s/libraries measure_time/libraries measure_time time_now/g" $$@

# pl07.LANG -> out/pN/LANG/pName/pName.LANG
src : $(out)/p$(prob_no)/ml/$(call prob_name)/bin/main.ml
$(out)/p$(prob_no)/ml/$(call prob_name)/bin/main.ml : pl07.ml $(out)/p$(prob_no)/ml/$(call prob_name)/bin/dune
	./mk_version.py -D label="$(call prob_name)" $$< > $$@

# canonical source name (not actually created)
#$(out)/p$(prob_no)/ml/$(call prob_name)/$(call prob_name).ml : $(out)/p$(prob_no)/ml/$(call prob_name)/bin/main.ml

# out/pN/LANG/pName/pName.LANG -> executable
exe : $(out)/p$(prob_no)/ml/$(call prob_name)/_build/default/bin/main.exe
$(out)/p$(prob_no)/ml/$(call prob_name)/_build/default/bin/main.exe : $(out)/p$(prob_no)/ml/$(call prob_name)/bin/main.ml
	cd $(out)/p$(prob_no)/ml/$(call prob_name) && dune build --profile release

# executable -> out.csv
out : $(out)/p$(prob_no)/ml/$(call prob_name)/out.csv
$(out)/p$(prob_no)/ml/$(call prob_name)/out.csv : $(out)/p$(prob_no)/ml/$(call prob_name)/_build/default/bin/main.exe
	/usr/bin/time $$< $(S) $(M) $(N) > $$@
endef

define rs_rule
# cargo new EX -> out/pN/LANG/pName
dir : $(out)/p$(prob_no)/rs/$(call prob_name)/Cargo.toml
$(out)/p$(prob_no)/rs/$(call prob_name)/Cargo.toml :
	mkdir -p $(out)/p$(prob_no)/rs
	cd $(out)/p$(prob_no)/rs && cargo new $(call prob_name)

# pl07.LANG -> out/pN/LANG/pName/pName.LANG
src : $(out)/p$(prob_no)/rs/$(call prob_name)/src/main.rs
$(out)/p$(prob_no)/rs/$(call prob_name)/src/main.rs : pl07.rs $(out)/p$(prob_no)/rs/$(call prob_name)/Cargo.toml
	./mk_version.py -D label="$(call prob_name)" $$< > $$@

# canonical source name (not actually created)
#$(out)/p$(prob_no)/rs/$(call prob_name)/$(call prob_name).rs : $(out)/p$(prob_no)/rs/$(call prob_name)/src/main.rs

# out/pN/LANG/pName/pName.LANG -> executable
exe : $(out)/p$(prob_no)/rs/$(call prob_name)/target/release/$(call prob_name)
$(out)/p$(prob_no)/rs/$(call prob_name)/target/release/$(call prob_name) : $(out)/p$(prob_no)/rs/$(call prob_name)/src/main.rs
	cd $(out)/p$(prob_no)/rs/$(call prob_name) && cargo build --release

# executable -> out.csv
out : $(out)/p$(prob_no)/rs/$(call prob_name)/out.csv
$(out)/p$(prob_no)/rs/$(call prob_name)/out.csv : $(out)/p$(prob_no)/rs/$(call prob_name)/target/release/$(call prob_name)
	/usr/bin/time $$< $(S) $(M) $(N) > $$@
endef

$(foreach prob_no,$(prob_nos),$(foreach lang,$(langs),$(eval $(call $(lang)_rule))))

.DELETE_ON_ERROR:
