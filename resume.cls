\ProvidesClass{resume}[2021 v0.1 resume class]

\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions
\LoadClass{article}

\RequirePackage{geometry}
\geometry{left = 2.0cm, top = 1.5cm, right = 2.0cm, bottom = 1.8cm, footskip = .5cm}

\RequirePackage{luacode} 

\RequirePackage{xcolor}
\RequirePackage{fontawesome5}
\RequirePackage[hidelinks, unicode]{hyperref}

\definecolor{red}{HTML}{A62515}
\definecolor{green}{HTML}{008013}

\begin{luacode}
	function color_segment(s, i, color1, color2)
		t = unicode.utf8.sub(s, 1, i)
		s = unicode.utf8.sub(s, i + 1)
		if (s == '') then
			tex.print(string.format('{\\color{%s}%s}', color1, t)) 
		else
			tex.print(string.format('{\\color{%s}%s}{\\color{%s}%s}', color1, t, color2, s)) 
		end
	end
\end{luacode}

%CV commands
\def\info#1#2{{\color{gray}\leaders\hbox{#1}\hfill}{\datestyle #2}}
\def\datestyle{\color{red}\slshape}

%CV custom itemize
\def\labelitemi{\labelitemfont \color{red}\faIcon[light]{fire-alt}}
\def\labelitemii{\labelitemfont \bfseries \color{green}\faIcon[light]{leaf}}
\def\labelitemiii{\labelitemfont \textasteriskcentered}
\def\labelitemiv{\labelitemfont \textperiodcentered}

%CV sections
\def\sectionColor#1{\directlua{color_segment("#1", 3, "red", "black")}}
\def\sectionRule{\color{gray}\leavevmode\leaders\hrule height 0.8pt\hfill\kern\z@}
\def\subsectionColor#1{\directlua{color_segment("#1", 3, "black", "gray")}}

\setcounter{secnumdepth}{0}

\def\cvsection#1{\section{\sectionColor{#1}\sectionRule}}
\def\cvsubsection#1{\subsection{\subsectionColor{#1}}}


%CV pagestyle
\def\ps@plain{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\def\@oddfoot{
		\slshape\tiny\color{gray}\@cvdate\hfil{\small\@namefont\@name\ \@surname\ - resume}\hfil\thepage
	}
	\def\@evenfoot{
		\slshape\tiny\color{gray}\thepage\hfil{\small\@namefont resume\ - \@name\ \@surname}\hfil\@cvdate
	}
}
\pagestyle{plain}

%Title
%%personal info
\def\namefont#1{\def\@namefont{#1}}

\def\name#1#2{\def\@name{#1}\def\@surname{#2}}
\def\date#1{\def\@cvdate{#1}}
\def\occupation#1{\def\@occupation{#1}}
\def\adress#1{\def\@adress{#1}}

\def\email#1{\def\@email{#1}}
\def\phone#1{\def\@phone{#1}}
\def\github#1{\def\@github{#1}}
\def\telegram#1{\def\@telegram{#1}}

%%@maketitle settings
\def\separator{\textbar\medskip}
\def\iconSeparator{\hspace{.4em}}

\def\separate#1{
	\ifcsname #1\endcsname
		\separator
		\expandafter\advance\csname #1\endcsname 1\relax 
	\else
		\expandafter\newcount\csname #1\endcsname
		\csname #1\endcsname 1\relax
	\fi
}
\def\itemStyle#1{
	\expandafter\ifodd\csname #1\endcsname
		\color{gray}
	\else 
		\color{black}
	\fi
}

\def\@maketitle{
	\newpage
	\null
	\begin{center}%
		\let \footnote \thanks
		\vskip -0.7em 
		{\fontsize{36pt}{1em}\bfseries \@namefont \@name\ \color{gray}\@surname \par}%
		\vskip 0.4em
		\lineskip .5em%
		\begin{tabular}{c}
			\ifcsname @occupation\endcsname 
				{\slshape\small\color{red}\@occupation}\\
			\fi	
			\ifcsname @adress\endcsname 
				{\small\color{gray}\href{adress: \@adress}{\@adress}}\\
			\fi
		\end{tabular}\par
		\begin{tabular}{c}
			{ 	
				\small				
				\color{gray}
				\itshape
				
				\ifcsname @email\endcsname
					\separate{@listSize}
					{\itemStyle{@listSize} \href{mailto: \@email}{\faIcon[light]{envelope}\iconSeparator\@email}}
				\fi					
				\ifcsname @phone\endcsname
					\separate{@listSize}
					{\itemStyle{@listSize} \href{tel: @phone}{\faIcon[light]{phone-square-alt}\iconSeparator\@phone}}
				\fi
					
				\ifcsname @telegram\endcsname
					\separate{@listSize}
					{\itemStyle{@listSize} \href{https://t.me/\@telegram}{\faIcon[light]{telegram}\iconSeparator\@telegram}}
				\fi
				
				\ifcsname @github\endcsname
					\separate{@listSize}
					{\itemStyle{@listSize} \href{https://github.com/\@github}{\faIcon[light]{github}\iconSeparator\@github}}
				\fi
			}
		\end{tabular}\par
		%{\normalsize \color{gray} \@cvdate}
	\end{center}\par
	\vspace{-3em}
}
