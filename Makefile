# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -n -j auto -w "build.log"
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
BUILDDIR      = build
GITDIR        = $(shell git rev-parse --abbrev-ref HEAD)
STAGINGURL    = http://192.241.195.202:9000/staging

# Platform and sed detection for cross-platform compatibility
UNAME_S := $(shell uname -s)
SED_IS_GNU := $(shell sed --version 2>/dev/null | grep -q "GNU sed" && echo "yes" || echo "no")

# Define the correct sed in-place command based on the system
ifeq ($(SED_IS_GNU),yes)
    SED_INPLACE := sed -i
else ifeq ($(UNAME_S),Darwin)
    SED_INPLACE := sed -i ''
else
    SED_INPLACE := sed -i
endif

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# dry-run build command to double check output build dirs
dryrun:
	@echo "$(SPHINXBUILD) -M $@ '$(SOURCEDIR)' '$(BUILDDIR)/$(GITDIR)' $(SPHINXOPTS) $(O)"

clean:
	@echo "Cleaning $(BUILDDIR)/$(GITDIR)"
	@rm -rf $(BUILDDIR)/$(GITDIR)

clean-%:
	@echo "Cleaning $(BUILDDIR)/$(GITDIR)/$*"
	@rm -rf $(BUILDDIR)/$(GITDIR)/$*

stage-%:
	@if [ ! -d "$(BUILDDIR)/$(GITDIR)/$*" ]; then \
		echo "$* build not found in $(BUILDDIR)/$(GITDIR)"; \
		exit 1; \
	fi


	@(./stage.sh)


# Commenting out the older method
# python -m http.server --directory $(BUILDDIR)/$(GITDIR)/$*/html/
# @echo "Visit http://localhost:8000 to view the staged output"

# Platform build commands
# All platforms follow the same general pattern:
#   - Rebuild source/conf.py
#   - Compile SCSS
#   - Build docs via Sphinx

docs:
	@echo "--------------------------------------"
	@echo "         Building for Buckit          "
	@echo "--------------------------------------"
	@cp source/default-conf.py source/conf.py
	@npm run build
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)/$(GITDIR)/$@" $(SPHINXOPTS) $(O) -t $@
	@echo -e "Building $@ Complete\n--------------------------------------\n"

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@echo -e "----------------------------------------"
	@echo -e "make docs"
	@echo -e "Clean targets with 'make clean-<target>'"
	@echo -e "Clean all targets with 'make clean'"
	@echo -e "----------------------------------------"
