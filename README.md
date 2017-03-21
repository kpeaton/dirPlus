## `dirPlus` ##

This code is an updated version of a utility function I originally posted as an answer to the following question on Stack Overflow:
["How to get all files under a specific directory in MATLAB?"](http://stackoverflow.com/q/2652630/52738) Although written in MATLAB version R2016b, I believe this should work for older versions as well (full testing still required).

`dirPlus` will recursively collect files/subdirectories within a folder that match a certain set of criteria. `LIST = dirPlus(ROOTPATH)` will search recursively through the folder tree beneath `ROOTPATH` and collect a cell array `LIST` of all files it finds. The list will contain the absolute paths to each file starting at `ROOTPATH`.
 
`LIST = dirPlus(ROOTPATH, 'PropertyName', PropertyValue, ...)` will modify how files and directories are selected, as well as the format of LIST, based on the property/value pairs specified. Valid properties that the user can set are:

### GENERAL: ###
* **`'Struct'`** - A logical value determining if the output `LIST` should instead be a structure array of the form returned by the [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) function. If `TRUE`, `LIST` will be an N-by-1 structure array instead of a cell array.
* **`'Depth'`** - A non-negative integer value for the maximum folder tree depth that `dirPlus` will search through. A value of 0 will only search in `ROOTPATH`, a value of 1 will search in `ROOTPATH` and its subfolders, etc. Default (and maximum allowable) value is the current recursion limit set on the [root object](https://www.mathworks.com/help/matlab/ref/groot.html) (i.e. `get(0, 'RecursionLimit')`).
* **`'ReturnDirs'`** - A logical value determining if the output will be a list of files or subdirectories. If `TRUE`, `LIST` will be a cell array of subdirectory names/paths. Default is `FALSE`.
* **`'PrependPath'`** - A logical value determining if the full path from `ROOTPATH` to the file/subdirectory is prepended to each file in `LIST`. The default `TRUE` will prepend the full path, otherwise just the file/subdirectory name is returned. This setting is ignored if the **`'Struct'`** argument is `TRUE`.

### FILE-SPECIFIC: ###
* **`'FileFilter'`** - A string defining a regular-expression pattern that will be applied to the file name. Only files matching the pattern will be included in `LIST`. Default is `''` (i.e. all files are included).
* **`'ValidateFcn'`** - A handle to a function that takes as input a structure of the form returned by the [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) function and returns a logical value. This function will be applied to all files found and only files that have a `TRUE` return value will be included in `LIST`. Default is `[]` (i.e. all files are included).

### DIRECTORY-SPECIFIC: ###
* **`'DirFilter'`** - A string defining a regular-expression pattern that will be applied to the subdirectory name. Only subdirectories matching the pattern will be considered valid (i.e. included in `LIST` themselves or having their files included in `LIST`). Default is `''` (i.e. all subdirectories are valid). The setting of the **`'RecurseInvalid'`** argument determines if invalid subdirectories are still recursed down.
* **`'ValidateDirFcn'`** - A handle to a function that takes as input a structure of the form returned by the [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) function and returns a logical value. This function will be applied to all subdirectories found and only subdirectories that have a `TRUE` return value will be considered valid (i.e. included in `LIST` themselves or having their files included in `LIST`). Default is `[]` (i.e. all subdirectories are valid). The setting of the **`'RecurseInvalid'`** argument determines if invalid subdirectories are still recursed down.
* **`'RecurseInvalid'`** - A logical value determining if invalid subdirectories (as identified by the **`'DirFilter'`** and **`'ValidateDirFcn'`** arguments) should still be recursed down. Default is `FALSE` (i.e the recursive searching stops at invalid subdirectories).

Examples for how to use these options can be found in the demo script [dirPlus_demo.m](https://github.com/kpeaton/dirPlus/blob/master/dirPlus_demo.m) or in published form in [dirPlus_demo.html](https://github.com/kpeaton/dirPlus/blob/master/html/dirPlus_demo.html).

***Note:** The code in the master branch may not be fully tested or stable. Stable, tested releases appear in the [Releases tab](https://github.com/kpeaton/dirPlus/releases). Additional information can be found on the [MathWorks File Exchange submission page](https://www.mathworks.com/matlabcentral/fileexchange/60716-dirPlus).*
