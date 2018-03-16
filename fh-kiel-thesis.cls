\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fh-kiel-thesis}[2018/03/08 LaTeX class for a Thesis at FH Kiel]
\usepackage{morewrites}
\LoadClass[12pt,headsepline]{scrbook}
%%%%%%%%%%%%%%%%%%%%Options
\RequirePackage{kvoptions-patch}
\RequirePackage{xkeyval}
\RequirePackage{ifthen}
\RequirePackage{iflang}
\newboolean{useBib}

\def\fh@abstract{}
\DeclareOptionX{studentNumber}{\def\fh@studentNumber{#1}}
\DeclareOptionX{name}{\def\fh@name{#1}}
\DeclareOptionX{type}{\def\fh@type{#1}}
\DeclareOptionX{degree}{\def\fh@degree{#1}}
\DeclareOptionX{firstExaminer}{\def\fh@firstExaminer{#1}}
\DeclareOptionX{secondExaminer}{\def\fh@secondExaminer{#1}}

\DeclareOption{useBib}{
\setboolean{useBib}{true}
}
%\DeclareOptionX{title}{\def\fh@title{#1}}
%\DeclareOptionX{studentNumber}{\def\fh@studentNumber{#1}}

\ExecuteOptionsX{studentNumber=1234567}
\ExecuteOptionsX{name=John Doe}
\ExecuteOptionsX{type=Test Document}
\ExecuteOptionsX{degree=Master of Arts}
\ExecuteOptionsX{firstExaminer=Prof.\ Dr.\ John Doe}
\ExecuteOptionsX{secondExaminer=Prof.\ Dr.\ Jane Doe}

\ProcessOptionsX
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax

\ifthenelse{\boolean{useBib}}{
	\usepackage[style=authoryear,sorting=ynt]{biblatex}
	\DefineBibliographyStrings{english}{bibliography = {References}}
	\DefineBibliographyStrings{ngerman}{bibliography = {Quellenverzeichnis}}
}{}

\RequirePackage{fh-kiel-logo}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

\usepackage[ngerman,english]{babel}

\usepackage{blindtext}
\usepackage{hyperref}
\usepackage{tikz}
\newboolean{showAcknowledgements}

\newboolean{useMinted}



\RequirePackage{environ}

\newcommand{\germanOnly}[1]{\IfLanguageName{ngerman}{#1}{}}
\newcommand{\englishOnly}[1]{\IfLanguageName{english}{#1}{}}
\newcommand{\langVar}[2]{\IfLanguageName{english}{#1}{#2}}
\newcommand{\inputChapter}[1]{\input{content/chapters/#1}}

%%%%%%%%%%%%%%%%%%%%Spacing
%\setboolean{useBib}{true}%Bibliography
%\setboolean{useMinted}{false}%Use Codehighlighting
\usepackage{scrlayer-scrpage}
\rehead{}
\lohead{}

\lefoot{\thepage}
\rofoot{\thepage}
\renewcommand{\chaptermark}[1]{%
	\markboth{\scshape \chaptername\ \thechapter{}. #1}%
	{\scshape \chaptername\ \thechapter{}. #1}%
}
\renewcommand{\sectionmark}[1]{\markright{\rmfamily\upshape \thesection{} #1}{}}
\usepackage{graphicx}


\def\university{Fachbereich Informatik und Elektrotechnik \\ der Fachhochschule Kiel}

\def\thesisDate{\today}
\RequirePackage{etoolbox}



%\usekomavar[\edef\test]{subtitle}
\setboolean{showAcknowledgements}{true}
\usepackage{setspace}
\onehalfspacing
\def\@abstract{}
\def\@acknowledgements{}
\AtBeginDocument{%
	\@ifpackageloaded{minted}{\setboolean{useMinted}{true}}{\setboolean{useMinted}{false}}
	\frontmatter
\begin{titlepage}
	\begin{center}
		\vspace*{1cm}
		\university
		\\
		\vspace*{0.5cm}
	\definecolor{cfefefe}{RGB}{254,254,254}
	\definecolor{c34285e}{RGB}{52,40,94}
	
	                                       
	\resizebox{0.4\textwidth}{!}{\fhKielLogo}
		
		\vspace*{1.5cm}
		
		\large{\fh@type}
		
		\textbf{\@title}\\
		\large
		\ifdefempty{\@subtitle}{\vspace{0.5cm}}{\@subtitle\\}
		\vspace{0.5cm}
		 \small
		\langVar{submitted in fulfilment of the requirements for the degree of\\ \fh@degree}{zur Erlangung des akademischen Grades\\ \fh@degree}
		
		\vspace{1.5cm}
		\langVar{written by}{vorgelegt von}\\
		\textbf{\fh@name}\\
		\langVar{student number}{Matrikelnummer}: \fh@studentNumber
		\vfill
		
		\begin{tabular}{ l l }
			\langVar{first examiner}{Erstprüfer}: & \fh@firstExaminer \\
			\langVar{second examiner}{Zweitprüfer}: & \fh@secondExaminer \\
		\end{tabular}
		
		\vspace{0.8cm}
		\@date
		
	\end{center}
\end{titlepage}
	\cleardoublepage
	\setcounter{page}{1}
	\ifdefempty{\@abstract}{}{\input{abstract}}
	\chapter*{\langVar{Declaration}{Erklärung}}
	\langVar{
		I, \fh@name, declare that this thesis is my own work and has not been submitted in any form for another degree or diploma at any university or other institute of tertiary education. Information derived from the published and unpublished work of others has been acknowledged in the text and a list of references is given in the bibliography.
	}{
		Ich, \fh@name, versichere, dass ich diese Arbeit ohne fremde Hilfe selbständig verfasst und nur die angegebenen Quellen und Hilfsmittel benutzt habe. Wörtlich oder dem Sinn nach aus anderen Werken entnommene Stellen sind unter Angabe der Quellen kenntlich gemacht.
	}
	\vspace{2.5cm}
	\par\noindent\makebox[2.2in]{\hrulefill} \hfill\makebox[2.6in]{\hrulefill}%
	\par\noindent\makebox[2.0in][l]{\langVar{City, Date}{Ort, Datum}}\hfill\makebox[2.5in][l]{\fh@name}
	\ifdefempty{\@acknowledgements}{}{\chapter*{\langVar{Acknowledgements}{Danksagung}}\@acknowledgements}
 \tableofcontents
	\mainmatter
	
}
\NewEnviron{abstract}{\global\let\@abstract\BODY}
\NewEnviron{acknowledgements}{\global\let\@acknowledgements\BODY}

\AtEndDocument{
\clearpage
\appendix
\addcontentsline{toc}{chapter}{\langVar{Appendix}{Anhang}}
\addcontentsline{toc}{section}{\langVar{List of Tables}{Tabellenverzeichnis}}
%\pagenumbering{Alph}
\listoftables
\addcontentsline{toc}{section}{\langVar{List of Figures}{Bildverzeichnis}}
\listoffigures
\ifthenelse{\boolean{useBib}}{\printbibliography\addcontentsline{toc}{section}{\langVar{References}{Quellenverzeichnis}}}{}
\ifthenelse{\boolean{useMinted}}{\listoflistings\addcontentsline{toc}{section}{\langVar{Code Listings}{Quellcode}}}{}
}