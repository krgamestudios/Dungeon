#Windows 7:
#RM=del /y

#Windows 8.1, Windows 10:
RM=del /S

OUTDIR=out
BINDIR=bin

all: $(OUTDIR) binary
	$(MAKE) -C TurtleGUI
	$(MAKE) -C TurtleMap
	$(MAKE) -C src

debug: export CXXFLAGS+=-g
debug: clean all

#For use on my machine ONLY
binary: $(OUTDIR)
ifeq ($(OS),Windows_NT)
	xcopy /Y $(BINDIR)\\*.dll $(OUTDIR)
endif

$(OUTDIR):
	mkdir $(OUTDIR)

clean:
ifeq ($(OS),Windows_NT)
	$(RM) *.o *.a *.exe $(OUTDIR)\*.dll
#	rmdir /S /Q $(OUTDIR)
else ifeq ($(shell uname), Linux)
	find . -type f -name '*.o' -exec rm -f -r -v {} \;
	find . -type f -name '*.a' -exec rm -f -r -v {} \;
#	rm $(OUTDIR)/* -f
	find . -empty -type d -delete
endif

rebuild: clean all