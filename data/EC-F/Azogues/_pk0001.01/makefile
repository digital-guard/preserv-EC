
## ############################ ##
## SELF-GENERATE MAKE (make me) ##
## ############################ ##

mkme_input    = $(shell ls -d "${PWD}/"make_conf.yaml)
country       = $(shell ls -d "${PWD}" | cut -d'-' -f2 | cut -d'/' -f1)
baseSrc       = /var/gits/_dg

mkme_input0   = $(baseSrc)/preserv-$(country)/src/maketemplates/commomFirst.yaml

ifeq ($(shell ls -d "${PWD}" | grep "-"),)
country       = INT
mkme_input0   = $(baseSrc)/preserv/src/maketemplates/commomFirst.yaml
endif

pg_io         = $(shell grep 'pg_io'   < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_uri        = $(shell grep 'pg_uri'  < $(mkme_input0) | cut -f2- -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pg_db         = $(shell grep 'pg_db'   < $(mkme_input0) | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')
pack_id       = $(shell grep 'pack_id' < $(mkme_input)  | cut -f2  -d':' | sed 's/^[ \t]*//' | sed 's/[\ \#].*//')

pg_uri_db     = $(pg_uri)/$(pg_db)

mkme_output   = $(pg_io)/makeme_$(country)$(pack_id)
readme_output = $(pg_io)/README-draft_$(country)$(pack_id)
conf_output   = $(pg_io)/make_conf_$(country)$(pack_id)

info:
	@echo "=== Targets ==="
	@printf "me: gera makefile para ingestão dos dados, a partir de make_conf.yaml.\n"
	@printf "info: exibe resumo de targes implementados.\n"
	@printf "readme: gera rascunho de Readme.md para conjunto de dados.\n"
	@printf "insert_size: Insere tamanho em bytes em files no arquivo make_conf.yaml.\n"
	@printf "insert_license: Insere detalhes sobre licenças no arquivo make_conf.yaml.\n"
	@printf "insert_make_conf: carrega na base de dados o arquivo make_conf.yaml.\n"
	@printf "delete_file: deleta arquivo ingestado, a partir do sha256.\n"

me: insert_make_conf
	@echo "-- Updating this make --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_makefile('$(country)','$(pack_id)');"
	sudo chmod 777 $(mkme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(mkme_output) ./makefile || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(mkme_output) ./makefile"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	mv $(mkme_output) ./makefile

readme:
	@echo "-- Create basic README-draft.md template --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_readme('$(country)','$(pack_id)');"
	sudo chmod 777 $(readme_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(readme_output) ./README-draft.md || :
	@echo "If some changes, and no error in the changes, move the readme:"
	@echo " mv $(readme_output) ./README-draft.md"
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	mv $(readme_output) ./README-draft.md

insert_size: insert_make_conf
	@echo "-- Updating make_conf with files size --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_make_conf_with_size('$(country)','$(pack_id)');"
	sudo chmod 777 $(conf_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(conf_output) ./make_conf.yaml || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(conf_output) ./make_conf.yaml"
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	mv $(conf_output) ./make_conf.yaml

insert_license: insert_make_conf
	@echo "-- Updating make_conf with files licenses --"
	psql $(pg_uri_db) -c "SELECT ingest.lix_generate_make_conf_with_license('$(country)','$(pack_id)');"
	sudo chmod 777 $(conf_output)
	@echo " Check diff, the '<' lines are the new ones... Something changed?"
	@diff $(conf_output) ./make_conf.yaml || :
	@echo "If some changes, and no error in the changes, move the script:"
	@echo " mv $(conf_output) ./make_conf.yaml"
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	mv $(conf_output) ./make_conf.yaml

insert_make_conf:
	@echo "-- Load make_conf.yaml into the database. --"
	@echo "Usage: make insert_make_conf"
	@echo "pack_id: $(pack_id)"
ifneq ($(nointeraction),y)
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
endif
	psql $(pg_uri_db) -c "SELECT ingest.lix_insert('$(mkme_input)');"

delete_file:
	@echo "Usage: make delete_file id=<id de donated_packcomponent>"
	@echo "id: $(id)"
	@read -p "[Press ENTER to continue or Ctrl+C to quit]" _press_enter_
	@[ "${id}" ] && psql $(pg_uri_db) -c "DELETE FROM ingest.donated_packcomponent WHERE id = $(id)" || ( echo "Unknown id.")
