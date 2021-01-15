# $Id$

# escape commas, backslashes, squotes, and ampersands for sed
define sed_escape
$(subst &,\&,$(subst $(comma),\$(comma),$(subst ','\'',$(subst \,\\,$(1)))))
endef
#'

ENV_GIT_DIR := $(wildcard $(TOPDIR)/env/.git)
ifneq ($(ENV_GIT_DIR),)
  ENV_DIR := $(wildcard $(TOPDIR)/env)
  ENV_REVISION:=$(shell $(TOPDIR)/scripts/getgitver.sh $(ENV_DIR))
  ENV_DATE:=$(shell $(TOPDIR)/scripts/getgitdate.sh $(ENV_DIR))
  ENV_ORIGIN:=$(shell $(TOPDIR)/scripts/getgitorigin.sh $(ENV_DIR))
  ENV_BRANCH:=$(shell $(TOPDIR)/scripts/getgitbranch.sh $(ENV_DIR))
  ENV_MOD:=$(shell $(TOPDIR)/scripts/getgitmodified.sh $(ENV_DIR))
endif

ENV_SED_SCRIPT:=$(SED) \
	's,%XEO,$(call sed_escape,$(ENV_ORIGIN)),g' \
	-e 's,%XET,$(call sed_escape,$(ENV_DATE)),g' \
	-e 's,%XEC,\L$(call sed_escape,$(subst $(space),_,$(ENV_REVISION))),g' \
	-e 's,%XEB,$(call sed_escape,$(ENV_BRANCH)),g' \
	-e 's,%XEM,$(call sed_escape,$(ENV_MOD)),g'
