install:
	raco pkg install -i --auto sicp
	raco pkg install -i --auto review

test:
	raco test src

lint:
	@(for f in $$(find sicp -name '*.rkt'); do raco review $$f; done)

.PHONY: test
