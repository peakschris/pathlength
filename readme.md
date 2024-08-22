## Three issues with Visual Studio

### Setup
Install this folder in:
d:\workdir\pathlength

The resulting filenames are 271 and 273 characters respectively:

D:\workdir\pathlength\extraordinarilylongdirectoryname1\extraordinarilylongdirectoryname2\extraordinarilylongdirectoryname3\extraordinarilylongdirectoryname4\extraordinarilylongdirectoryname5\extraordinarilylongdirectoryname6\extraordinarilylongdirectoryname7\header.txt
D:\workdir\pathlength\extraordinarilylongdirectoryname1\extraordinarilylongdirectoryname2\extraordinarilylongdirectoryname3\extraordinarilylongdirectoryname4\extraordinarilylongdirectoryname5\extraordinarilylongdirectoryname6\extraordinarilylongdirectoryname7\test2.params

### Issue 1
```
test1.bat
```

This performs a compile where one of the header files has a total path length of 271 characters. The compile fails with:

```
main.cxx(1): fatal error C1083: Cannot open include file: 'header.hxx': No such file or directory
```

Other references to same issue:
- https://developercommunity.visualstudio.com/t/clexe-compiler-driver-cannot-handle-long-file-path/975889

### Issue 2
```
test2.bat
```

This performs a compile where parameters are supplied via a params file. The params filepath has total length 273 characters. The compile fails:

```
cl : Command line error D8022 : cannot open 'extraordinarilylongdirectoryname1/extraordinarilylongdirectoryname2/extraordinarilylongdirectoryname3/extraordinarilylongdirectoryname4/extraordinarilylongdirectoryname5/extraordinarilylongdirectoryname6/extraordinarilylongdirectoryname7/test2.params'
```

### Issue 3
This compiles a source file twice, in two separate subdirectories. All the deterministic command lines available are used.

- More on these flags: https://github.com/bazelbuild/bazel/issues/9466

#### Issue 3.1: /experimental:deterministic is experimental

It comes with this warning, which is concerning for us to rely on in production:

```
Experimental features are provided as a preview of proposed language features,
and we're eager to hear about bugs and suggestions for improvements. However,
note that these experimental features are non-standard, provided as-is without
support, and subject to breaking changes or removal without notice. See
http://go.microsoft.com/fwlink/?LinkID=691081 for details.
```

#### Issue3.2: /d1trimfile option is not documented

We require this option for deterministic builds, but it is not documented and therefore presumably is not supported.

#### Issue3.3: /Brepro option is not documented

We require this option for deterministic builds, but it is not documented and therefore presumably is not supported.

#### Issue3.4: pdb files are not deterministic

```
test3.bat
```
Note that dep1/test3.pdb is different to dep2/test3.pdb
