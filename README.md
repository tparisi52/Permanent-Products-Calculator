## Permanent Products of Submatrices Calculator

This program calculates products of permanents (or determinants) of submatrices of unit-interval matrices. 
My intention is that this tool can be utilized by someone without any coding experience. All that is needed is a way to run MATLAB scripts, which can be done in the [online editor](https://matlab.mathworks.com/). See [this post](https://www.mathworks.com/help/matlabmobile/ug/use-files-on-the-cloud.html) for how to use files on the cloud.

## How to Use

To run the program, first download all the code (easily do so by clicking the green Code button and selecting Download ZIP) and move all nine .m files into the same directory. Open 'main.m' and follow the instructions at the top on how to select options. Then run the script by typing 'main' into the Command Window.

The program takes in some inputs, such the matrix size and some information on how it should partition submatrices, which can be specfied by selecting between a few options. The relevant outputs are stored in the 'formattedResultTable' and 'formattedPosetAdjMatrix' variables; they respectively are the table of all permanent/determinant products and the adjacency-matrix of the induced partially ordered set (including the in & out degrees of each element). These two outputs are also written to an excel file.

This tool was created with a specific use in mind of quickly generating posets, but it could be expanded upon by adding more matrix/partition options or more built-in analysis of the results. I've written the code as best as I could for it to be maintainable and improved upon/added to by others, so please read the details of the code if you are interested.


## Authors
- [Tommy Parisi](https://github.com/tparisi52)
