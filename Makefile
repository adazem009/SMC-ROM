# OS dependencies
$(info Checking dependencies...)
ifeq ($(shell which git),)
    $(error "git not found in PATH, make sure it's installed")
endif
ifeq ($(shell which gcc),)
    $(error "gcc not found in PATH, make sure it's installed")
endif

# Targets
main: ./pwc
	$(info Building BIOS...)
	@./pwc main.pwsl -o image --string
	$(info Output: ./image)

./pwc:
	$(info Getting PowerSlash compiler...)
	@git clone https://github.com/adazem009/PowerSlash compiler
	@gcc compiler/pwc.c -o pwc
	@rm -rf compiler
