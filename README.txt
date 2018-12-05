


Read me file for the software created by Micro Imaging Technology - M.I.T.
in the course TBMT14 Project course in Biomedical engineering at Linköping
University.

The GUI folder is the folder in where the GUI of the software is placed. The 
GUI uses the functions placed in other folders to process either acquired or
loaded files. 

The General folder contains functions used by both the Vessel and Apexes tab,
although detectBoundaries function is not called but the code is rather copied 
from that function to the GUI due to compability problems.

The Apexes and Vessels folders contains functions used by only one of the tabs
in the GUI. The applyGrid functions is, like detectBoundaries, ot called by
the GUI but the code have been copied from that functino to the GUI

The functions and scripts that were used during early development but then was
scrapped can be found in the Obsolete folder.

Test scripts for checking if the software can fulfill the requirements can be 
found in the Tests folder.

Acquired and given images and videos can be found in the VIDEOS and IMAGES folders

Some functions have been acquired from MATHWORKS page and, when the contributor 
have said so, there is a license file called license_functionname.txt in the 
same folder as the function
