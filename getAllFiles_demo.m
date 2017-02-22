%% _getAllFiles_ demo
% The _getAllFiles_ function recursively collects a list of files from a
% folder tree, allowing you to specify the selection criteria for which
% files are collected and how they are formatted. For these examples, we'll
% be using the Image Processing Toolbox path.
%%

rootPath = 'C:\Program Files\MATLAB\R2016b\toolbox\images';

%% The 'FileFilter' option
% We can specify a regular-expression pattern to filter the file names on,
% collecting a list of files that match. Here's an example that uses the
% 'FileFilter' option to recursively find every file with a '.m' extension
% in the Image Processing Toolbox:

fileList = getAllFiles(rootPath, 'FileFilter', '\.m$');
size(fileList)
display(fileList(1:5))

%%
% It's a pretty long list, so I've only shown the first 5 files it finds.
% Notice they are listed with the full path prepended by default.

%% The 'Depth' option
% If we don't want to search quite so far down the folder tree, we can
% limit the search depth with the 'Depth' option. Let's see how many '.m'
% files are in the root folder for the Image Processing Toolbox:

fileList = getAllFiles(rootPath, 'FileFilter', '\.m$', 'Depth', 0);
size(fileList)

%%
% Looks like none are. They are all contained in subfolders. Let's see how
% many are located in just the immediate subfolders of the root folder:

fileList = getAllFiles(rootPath, 'FileFilter', '\.m$', 'Depth', 1);
size(fileList)

%% The 'PrependPath' option
% Maybe we just want the file names, but don't care about the absolute
% paths. In this case, we just set the 'PrependPath' option to _false_:

fileList = getAllFiles(rootPath, 'FileFilter', '\.m$', ...
                                 'PrependPath', false);
display(fileList(1:5))

%% The 'ValidateFcn' option
% Sometimes we might want to select files based on a more complicated
% criteria than just what's in their names. In this case, we can use the
% 'ValidateFcn' option to specify a function that is to be run on each file
% found. This function should accept as input a structure of the form
% returned by the _dir_ function and return a logical value (_true_ to
% collect it in the list, _false_ to ignore it). First, let's find all the
% '.jpg' files in the Image Processing Toolbox:

fileList = getAllFiles(rootPath, 'FileFilter', '\.jpg$');
display(fileList)

%%
% Now, we can specify an anonymous function that gets the byte size of each
% file and returns _true_ for only those greater than 1MB:

bigFcn = @(s) (s.bytes > 1024^2);
fileList = getAllFiles(rootPath, 'FileFilter', '\.jpg$', ...
                                 'ValidateFcn', bigFcn);
display(fileList)

%%
% Just the two.