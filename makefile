ODIN=odin
SRC=.
OUT=build

run:
	$(ODIN) run $(SRC) -out:$@ -file

build:
	$(ODIN) build $(SRC) -out:$(OUT)/game

clean:
	rm -rf $(OUT)/*
