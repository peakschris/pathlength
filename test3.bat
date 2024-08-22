set CWD=%CD%
mkdir det1
copy main.cxx det1
cd det1
cl.exe /I../normaldir /Z7 /experimental:deterministic /d1trimfile:%CWD%\\det1 /pathmap:%CWD%\\det1=pathlength /Femain3.exe main.cxx 
cd ..
mkdir det2
copy main.cxx det2
cd det2
cl.exe /I../normaldir /Z7 /experimental:deterministic /d1trimfile:%CWD%\\det2 /pathmap:%CWD%\\det2=pathlength /Femain3.exe main.cxx 
cd ..
@echo EXPECTED: exes are the same, even through compiled in different directories
diff det2/main3.exe det2/main3.exe
@echo ISSUE: pdbs are not the same, because pdb generation is not deterministic
diff det1/main3.pdb det2/main3.pdb
