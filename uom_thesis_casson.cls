%% Alex Casson - alex.casson@manchester.ac.uk
%
% Aim
% A LaTeX class file for submitting University of Manchester thesis, particularly PhD ones
%
% Versions
% 07.06.17 - v1 - initial script
% 
% Notes
% - Assumes build with XeLaTeX or LuaLaTeX. Font setting is different for LaTeX or PDFLaTeX
% - On Linux systems requires ttf-mscorefonts-installer to be installed to have access to the correct fonts
% - Based upon June 2017 submission guidelines (http://documents.manchester.ac.uk/DocuInfo.aspx?DocID=7420)
% - Font options are: 10pt Arial, Verdana, Tahoma, Trebuchet OR 12pt Calibri, Times, Times New Roman, Palatino and Garamond. Calibri is preferred here.
% - Font size is changed via a \AtBeginDocument. Ideally would be done at \LoadClass, but get a loop as fontspec needs to know the font size to change the font. The current methods works, except that the main title size is always the same, regardless of the asked for font size. As choices are only 10pt or 12pt this doesn't make a big difference. It would be nice to fix!
% - There is a requirement of blank pages to say "Blank page". This is not done automatically
% - Adds a UoM logo. No requirement for this, but is nice. Note sizes are hand calculated. Won't be correct if change paper size
% - Assumes title page is only one page long!
% - Assumes not using subfigure. Tocloft has (easily fixed) issues if do.
% - Note that for the references font size it is set here to be one larger than that actually wanted. Not clear why, but then gives the correct size! Have to do this in main .tex
%
% To do
% - Remove indent at start of references
% - Make customisations/changes to the references global, and in class.
% - Add blank page to start appendix on to make more clear
% -----------------------------------------------------------------------------


%% Class definition - based upon report class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uom_thesis_casson}[2017/08/29 - Alex Casson - University of Manchester thesis format]
\LoadClass[a4paper, oneside]{report}


%% Load packages
\RequirePackage[explicit]{titlesec}      % re-format section titles
\RequirePackage{geometry}                % set paper margins
\RequirePackage{setspace}                % set line spacing
\RequirePackage[document]{ragged2e}      % set to be left aligned
\RequirePackage{pgfcore}                 % for logo positioning in fixed location
\RequirePackage{fontspec}                % for font setting
\RequirePackage{tocloft} % allows precise control over the table of contents and deals with subfigures properly
  \renewcommand{\listfigurename}{List of figures} 
  \renewcommand{\listtablename}{List of tables} 
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % add dots 
  \renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
\RequirePackage{hyperref}                % create internal hyperlinks, must be specified before cite package to work
  \hypersetup{hidelinks,colorlinks=false,breaklinks=true,bookmarksdepth=2}  % have no highlighting on links and break lines in the LOF and LOT
\RequirePackage{bookmark}                % for adding custom bookmarks
  \bookmarksetup{numbered}
\RequirePackage{enumitem}                % allow change of numbering style in enumeration
\RequirePackage{ifthen}                  % allow if then else statements
\RequirePackage{appendix}                % control over appendix
\RequirePackage{caption}                 % control figure captions
 
  
%% Handle options
\def\@@ptsize{12pt} % font size variable
\newcommand{\reportyear}{thesis} % set report type
\DeclareOption{calibri}{\setmainfont{Calibri} \def\@@ptsize{12pt}} 
\DeclareOption{times}{\setmainfont{TeX Gyre Termes} \def\@@ptsize{12pt}}
\DeclareOption{palatino}{\setmainfont{TeX Gyre Pagella} \def\@@ptsize{12pt}}
\DeclareOption{garamond}{\setmainfont{Adobe Garamond Pro} \def\@@ptsize{12pt}}
\DeclareOption{arial}{\setmainfont{Arial} \def\@@ptsize{10pt}}
\DeclareOption{tahoma}{\setmainfont{Tahoma} \def\@@ptsize{10pt}}
\DeclareOption{verdana}{\setmainfont{Verdana} \def\@@ptsize{10pt}}
\DeclareOption{trebuchet}{\setmainfont{Trebuchet MS} \def\@@ptsize{10pt}}
\DeclareOption{thesis}{\renewcommand{\reportyear}{thesis}}
\DeclareOption{first}{\renewcommand{\reportyear}{first}}
\DeclareOption{second}{\renewcommand{\reportyear}{second}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax


%% Set lengths - sizes for A4 paper from http://www.brand.manchester.ac.uk/visual-identity/print/
\newlength{\logowidth}    \setlength{\logowidth}{40.006mm}
\newlength{\logoheight}   \setlength{\logoheight}{19.454mm}
\newlength{\logopad}      \setlength{\logopad}{14.279mm}
\newlength{\marginleft}   \setlength{\marginleft}{4cm}   % Minimum margins are 1.5cm, 4cm, 1.5cm, 1.5cm
\newlength{\marginright}  \setlength{\marginright}{1.5cm} 
\newlength{\margintop}    \setlength{\margintop}{1.5cm}
\newlength{\marginbottom} \setlength{\marginbottom}{1.5cm}  



%% Set main font.
% If using LaTeX or PDFLaTeX comment out this line and revert to a Times text. This is acceptable. 
%\setmainfont{Calibri}
%\setmainfont{TeX Gyre Termes} % Times. Optional.


%% Set paper format
\geometry{a4paper, top=\margintop, left=\marginleft, right=\marginright, bottom=\marginbottom, nohead, nofoot, nomarginpar} 



%% Formatting options - mainly for font size
\setlength{\parskip}{2ex plus 0.5ex minus 0.2ex}
\setlength{\parindent}{0pt}
\linespread{1.5}
\pagestyle{plain} % simple page numbering
\AtBeginDocument{
  \fontsize{\@@ptsize}{\@@ptsize+1pt}\selectfont
}
\setcounter{tocdepth}{2}                % set toc depth. This is changed for the Appendix
\renewcommand{\topfraction}{0.85}       % depreciate use of full pages for images
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\setlength{\footskip}{26pt}
\DeclareCaptionFormat{myformat}{\fontsize{\@@ptsize}{\@@ptsize+1pt}\selectfont#1#2#3}
\captionsetup{justification=centering,format=myformat}



%% Format titles
\titleformat{\chapter}{\bfseries\Huge\raggedright}{\thechapter}{1ex}{#1} % default formatting for non-theses
\titlespacing{\chapter}{0pt}{\@@ptsize}{\baselineskip}
\ifthenelse{\equal{\reportyear}{thesis}}{\titleformat{\chapter}[display]{\bfseries\Huge\raggedright}{\chaptername~\thechapter}{0.5ex}{#1}}{}
\renewcommand{\contentsname}{\bfseries\Huge Contents}
\renewcommand{\listfigurename}{\bfseries\Huge List of figures}
\renewcommand{\listtablename}{\bfseries\Huge List of tables}
\titleformat{\section}{\bfseries\Large}{\thesection}{1ex}{#1}
\titlespacing{\section}{0pt}{\baselineskip}{0.2\baselineskip}
\titleformat{\subsection}{\bfseries\large}{\thesubsection}{1ex}{#1}


%% Title page
\makeatletter
\def\faculty#1{\gdef\@faculty{#1}}
\def\department#1{\gdef\@department{#1}}
\def\submitdate#1{\gdef\@submitdate{#1}}
\newcommand{\titletext}[1]
{
  \ifthenelse{\equal{#1}{thesis}}{A thesis submitted to the University of Manchester for the degree of\ \linebreak Doctor of Philosophy\ \linebreak in the Faculty of \@faculty}{}
  \ifthenelse{\equal{#1}{first}}{Nine month progress report}{}
  \ifthenelse{\equal{#1}{second}}{End of second year report}{}
}
\def\maketitle{
  \begin{titlepage}
    \bookmark[page=1,level=-1]{Front matter}
	\phantomsection \pdfbookmark[chapter]{Title page}{title}
  
    % Add logo. No requirement for this, but is nice. Note sizes are hand calculated. Won't be correct if change paper size
    \pgfdeclareimage[width=\logowidth]{uom_logo}{uom_logo}
    \pgftext[at=\pgfpoint{-\marginleft+\logopad}{\margintop+\parskip-\logopad}, top, left]{\pgfuseimage{uom_logo}}


    \begin{center}
	  \vspace*{\fill}
      {\Large \bf \@title}
      \vskip 3cm
      \titletext{\reportyear}
      \vskip 3cm
	  \@submitdate
	  \vskip 3cm
	  \@author\ \linebreak
	  Department of \@department
      \vspace*{\fill}
    \end{center}

	
  \end{titlepage}
  
  \setcounter{page}{2} % ensure no number on title page, numbers on other pages match those in the PDF
}
\makeatother  %to avoid error messages generated by "\@". Makes Latex treat "@" like a letter



%% Abstract
\renewenvironment{abstract}{%
  \clearpage\phantomsection
  \null\vfil
  \begin{center}%
      {\Large \bfseries \abstractname\vspace{-.5em}\vspace{0pt}}%
  \end{center}%
  \quotation
}
{\addcontentsline{toc}{chapter}{\abstractname}\endquotation\vfil\null\clearpage}



%% Lists and tables of contents
\newcommand{\uomtoc}{
  \phantomsection\addcontentsline{toc}{chapter}{Contents}
  \tableofcontents
  \clearpage
  }
\newcommand{\uomlof}{
  \phantomsection\addcontentsline{toc}{chapter}{List of figures}
  \listoffigures
  \clearpage
  }  
\newcommand{\uomlot}{
  \phantomsection\addcontentsline{toc}{chapter}{List of tables}
  \listoftables
  \clearpage
  }    
\newenvironment{uomlop}{
  \phantomsection\addcontentsline{toc}{chapter}{List of publications}
  \chapter*{List of publications}
}
{\clearpage}
  

  
%% Acknowledgements  
\newenvironment{uomacknowledgements}{
  \phantomsection\addcontentsline{toc}{chapter}{Acknowledgements}
  \chapter*{Acknowledgements}
}
{\clearpage}



%% Declarations
\newcommand{\uomdeclarations}{
  \phantomsection\addcontentsline{toc}{chapter}{Declaration of originality}
  \chapter*{Declaration of originality}
  I hereby confirm that no portion of the work referred to in the thesis has been submitted in support of an application for another degree or qualification of this or any other university or other institute of learning.
  \clearpage
  
  \phantomsection\addcontentsline{toc}{chapter}{Copyright statement}
  \chapter*{Copyright statement} 
  \begin{enumerate}[label=\roman*]
    \item The author of this thesis (including any appendices and/or schedules to this thesis) owns certain copyright or related rights in it (the ``Copyright'') and s/he has given The University of Manchester certain rights to use such Copyright, including for administrative purposes.
    \item Copies of this thesis, either in full or in extracts and whether in hard or electronic copy, may be made \emph{only} in accordance with the Copyright, Designs and Patents Act 1988 (as amended) and regulations issued under it or, where appropriate, in accordance with licensing agreements which the University has from time to time. This page must form part of any such copies made.
    \item The ownership of certain Copyright, patents, designs, trademarks and other intellectual property (the ``Intellectual Property'') and any reproductions of copyright works in the thesis, for example graphs and tables (``Reproductions''), which may be described in this thesis, may not be owned by the author and may be owned by third parties. Such Intellectual Property and Reproductions cannot and must not be made available for use without the prior written permission of the owner(s) of the relevant Intellectual Property and/or Reproductions.
	\item Further information on the conditions under which disclosure, publication and commercialisation of this thesis, the Copyright and any Intellectual Property and/or Reproductions described in it may take place is available in the University IP Policy (see \url{http://documents.manchester.ac.uk/DocuInfo.aspx?DocID=24420}), in any relevant Thesis restriction declarations deposited in the University Library, The University Library’s regulations (see \url{http://www.library.manchester.ac.uk/about/regulations/}) and in The University’s policy on Presentation of Theses.
  \end{enumerate}
  \bookmarksetup{startatroot}
  \clearpage
}



%% Appendix
\newenvironment{uomappendix}{
  \clearpage
  \bookmarksetupnext{level=part}
  \phantomsection\addcontentsline{toc}{chapter}{Appendices}
  \chapter*{Appendices} 
  \clearpage
  \renewcommand\chaptername{Appendix}
  \begin{appendices}
  \addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
}
{\end{appendices}}