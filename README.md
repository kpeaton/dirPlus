## `getAllFiles` ##

This code is an updated version of a utility function I originally posted as an answer to the following question on Stack Overflow:
["How to get all files under a specific directory in MATLAB?"](http://stackoverflow.com/q/2652630/52738) Although written in MATLAB version R2016b, I believe this should work for older versions as well (full testing still required).

`getAllFiles` will recursively collect files within a folder and its subfolders that match a certain set of criteria. `FILELIST = getAllFiles(ROOTPATH)` will search recursively through the folder tree beneath `ROOTPATH` and collect a cell array `FILELIST` of all files it finds. The list will contain the absolute paths to each file starting at `ROOTPATH`.
 
`FILELIST = getAllFiles(ROOTPATH, 'PropertyName', PropertyValue, ...)` will modify how files are selected based on the property/value pairs specified. Valid properties that the user can set are:
 
* **`'Struct'`** - A logical value determining if the output `FILELIST` should instead be a structure array of the form returned by the [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) function. If `TRUE`, `FILELIST` will be an N-by-1 structure array instead of a cell array of file names/paths.
* **`'Depth'`** - A non-negative integer value for the maximum folder tree depth that `getAllFiles` will search through. A value of 0 will only search in `ROOTPATH`, a value of 1 will search in `ROOTPATH` and its subfolders, etc. Default (and maximum allowable) value is the current recursion limit set on the [root object](https://www.mathworks.com/help/matlab/ref/groot.html) (i.e. `get(0, 'RecursionLimit')`).
* **`'FileFilter'`** - A string defining a regular-expression pattern that will be applied to the file name. Only files matching the pattern will be returned in `FILELIST`. Default is `''` (i.e. all files are returned).
* **`'PrependPath'`** - A logical value determining if the full path from `ROOTPATH` to the file is prepended to each file in `FILELIST`. The default `TRUE` will prepend the full path, otherwise just the file name is returned. This setting is ignored if the **`'Struct'`** argument is `TRUE`.
* **`'ValidateFcn'`** - A handle to a function that takes as input a structure of the form returned by the [`dir`](https://www.mathworks.com/help/matlab/ref/dir.html) function and returns a logical value. This function will be applied to all files found and only files that have a `TRUE` return value will be returned in `FILELIST`. Default is `[]` (i.e. no validation done).

Examples for how to use these options can be found in the demo script [getAllFiles_demo.m](https://github.com/kpeaton/getAllFiles/blob/master/getAllFiles_demo.m) or in published form in [getAllFiles_demo.html](https://github.com/kpeaton/getAllFiles/blob/master/html/getAllFiles_demo.html).

***Note:** The code in the master branch may not be fully tested or stable. Stable, tested releases appear in the [Releases tab](https://github.com/kpeaton/getAllFiles/releases). Additional information can be found on the [MathWorks File Exchange submission page](https://www.mathworks.com/matlabcentral/fileexchange/60716-getallfiles-utility).*
