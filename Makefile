start:
	@rm -rf caxias
	@mix escript.build > /dev/null 2>&1
	./caxias $(args)

tests:
	@mix test