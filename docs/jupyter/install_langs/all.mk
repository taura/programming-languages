langs:=go julia ocaml rust

inst_start:=23220
inst_end:=23249
inst_users:=$(addprefix u,$(shell seq $(inst_start) $(inst_end))) pl0
inst_targets:=$(foreach user,$(inst_users),$(foreach lang,$(langs),inst/$(user)/$(lang)))

uninst_start:=23200
uninst_end:=23249
uninst_users:=$(addprefix u,$(shell seq $(uninst_start) $(uninst_end))) share
uninst_targets:=$(foreach user,$(uninst_users),$(foreach lang,$(langs),uninst/$(user)/$(lang)))

install : $(inst_targets)
uninstall : $(uninst_targets)

define inst_rule
inst/$(user)/$(lang) :
	sudo -u $(user) $(MAKE) -f $(lang).mk install
	mkdir -p $$@
endef

define uninst_rule
uninst/$(user)/$(lang) :
	sudo -u $(user) $(MAKE) -f $(lang).mk uninstall
endef

$(foreach user,$(inst_users),$(foreach lang,$(langs),$(eval $(call inst_rule))))
$(foreach user,$(uninst_users),$(foreach lang,$(langs),$(eval $(call uninst_rule))))
