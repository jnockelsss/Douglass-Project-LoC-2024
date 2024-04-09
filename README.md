## Douglass-Project-LoC-2024 ##

# Project Description

We aim to display how Automated Text Recognition (ATR) datasets, once made accessible and accurate,
can open up scholarship through text analysis techniques. The abolitionist and social reformer Frederick Douglass (1818-1895) is used as a case study, 
especially his travel diary (1886-1894) (https://www.loc.gov/collections/frederick-douglass-papers/?fa=partof:frederick+douglass+papers:+diary,+1886-1894)
which forms part of the Frederick Douglass Papers at the Library of Congress. The resulting output is a paper entitled: 

"Leveraging Accurate and Accessible Texts at the Library of Congress. A Study of Frederick Douglass’s Travel Writing (1845 - 1895)"

# Workflow

The Douglass transcription was reached through the semi-automatic training of an ATR model in Transkribus (https://readcoop.eu/transkribus/), 
while at the Library of Congress Kluge Centre between April - July 2024. This model, "Late Douglass (1886-1887) M3" remains private though can 
be shared by contacting j.h.nockels@sms.ed.ac.uk. The model achieved a 11.40% Character Error Rate (CER) due to the limited 
size of the diary and subsequent Ground Truth (GT). Transkribus was chosen due to its clean user interface and ability to train accurate custom models. 

See: https://readcoop.eu/transkribus/download/ to download the Java-based downloadable client or set up an acocunt for the web version.

![image](https://github.com/jnockelsss/Douglass-Project-LoC-2024/assets/166405243/3b70a8a4-62ad-454e-8e23-7bb5656a7bc2)

[Late Douglass Model description within Transkribus environment]

<img width="713" alt="7A9831AB-F852-4CD3-8B5D-D9EB72AA5517" src="https://github.com/jnockelsss/Douglass-Project-LoC-2024/assets/166405243/9f6e7785-6f45-4b0b-b95a-8f33f8f51507">

[Late Douglass Model training sits, showing decreasing CER per epoch of training]

R, through R Studio, was then used to interrogate the transcription and remained a logical choice through its supporting of text analysis packages (tm, 
quanteda, syuzhet). See: https://posit.co/download/rstudio-desktop/ for installation. The use of dtm and tidytext formats interchanged creating 
a flexible way of analysing the resulting text.

By demonstrating the ability of distant reading approaches, coinciding with traditional scholarship, this project serves as an example of leveraging 
automation for historical research on text-based library collections. 

# Credits

Much of this work is informed by Julia Silge and David Robinson, *Text Mining with R* (https://www.tidytextmining.com), as well tutorials by Greg Martin 
(https://www.youtube.com/@RProgramming101) and Kasper Welbers (https://www.youtube.com/@kasperwelbers). 

We also acknowledge the contributions of Dr Jess Witte, University of Edinburgh, Centre for Data, Culture and Society (CDCS) (jessica.witte@ed.ac.uk) for troubleshooting R when needed. 
