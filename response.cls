% response.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{response}[2025/03/14 Response to Reviewers Class]

% 基础文档类选项继承
\LoadClass[twoside]{article}

% 宏包加载
\RequirePackage{etoolbox}
\RequirePackage{multicol}
\RequirePackage[style=ieee]{biblatex}
\RequirePackage{hyperref}
\RequirePackage{tabularx}
\RequirePackage{enumitem}
\RequirePackage{indentfirst}
\RequirePackage{eurosym}
\RequirePackage[dvipsnames,svgnames]{xcolor}
\RequirePackage{fontspec}
\RequirePackage{siunitx}
\RequirePackage{multirow}
\RequirePackage{algorithmic}
\RequirePackage[ruled,vlined,linesnumbered,lined]{algorithm2e}
\RequirePackage{tikz}
\RequirePackage{setspace}
\RequirePackage[caption=false,font=normalsize,labelfont=footnotesize,textfont=sf]{subfig}
\RequirePackage[table,xcdraw,dvipsnames,svgnames]{xcolor}
\RequirePackage{tcolorbox}
\RequirePackage[strict]{changepage}
\RequirePackage{framed}
\RequirePackage{booktabs}
\RequirePackage{soul}
\RequirePackage{physics}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
% \RequirePackage{ctex}
\RequirePackage[margin=1.25in]{geometry}
\RequirePackage{fancyhdr}

% Theorem-like environments and a lightweight IEEEproof clone so that
% response letters can include formal statements / proofs without
% pulling in amsthm (which conflicts with response.cls's \openbox).
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}{Lemma}
\newtheorem{proposition}{Proposition}
\newtheorem{corollary}{Corollary}
\newtheorem{definition}{Definition}
\newtheorem{remark}{Remark}
\newenvironment{IEEEproof}{\par\noindent\textit{Proof.}\quad\ignorespaces}{\hfill$\blacksquare$\par\medskip}

% 通用设置
\sisetup{detect-all}
\allowdisplaybreaks
\graphicspath{{figure/}}

% 计数器配置
\newcounter{Reviewer}
\newcounter{Comment}[Reviewer]
\newcounter{Response}[Reviewer]

% 编号格式重定义
\renewcommand{\theequation}{R.\arabic{equation}}
\renewcommand{\thefigure}{R-\arabic{figure}}
\renewcommand{\thetable}{R-\arabic{table}}

% Font family used by ModiPaste — matches the manuscript body font.
% Can be overridden in the document preamble with
% \newfontfamily\manuscriptfont{<font name>} if needed.
\AtEndPreamble{%
  \@ifundefined{manuscriptfont}{%
    \newfontfamily\manuscriptfont{Times New Roman}%
  }{}%
}

% 颜色定义
\definecolor{redshade1}{rgb}{1,0.8,0.8}
\definecolor{formalshade}{rgb}{0.95,0.95,1}
\definecolor{greenshade}{rgb}{0.90,0.99,0.91}
\definecolor{redshade}{rgb}{1.00,0.90,0.90}

% 列表样式
\setlist[description]{
    labelwidth=2.5cm,
    labelsep=2ex,
    leftmargin=\labelwidth,
    font=\bfseries\Large
}

% 自定义命令
\newcommand{\papertitle}{000}
\providecommand{\paperid}{000}

% 环境定义
\newenvironment{R2ER}[1][Response to the editor and reviewers]{%
    \vspace{2ex}\noindent\bfseries\Large #1\mdseries\large\par\vspace{2ex}
    \begin{spacing}{1.4}
}{%
    \end{spacing}\vspace{2ex}\par
}

\newenvironment{R2E}[1][Response to the editor and reviewers]{%
    \vspace{2ex}\noindent\bfseries\Large #1\mdseries\large\par\vspace{2ex}
    \addcontentsline{toc}{section}{#1}
    \begin{spacing}{1.4}
}{%
    \end{spacing}\vspace{2ex}\par
}

\newenvironment{R2R}{%
    \clearpage\stepcounter{Reviewer}
    \vspace{2ex}\noindent\bfseries\Large Response to reviewer \theReviewer
    \mdseries\normalsize\par\vspace{2ex}
    \addcontentsline{toc}{section}{Response to reviewer \theReviewer}
}{%
    \vspace{2ex}\par
}

% ========== 主要环境定义 ==========
\newcommand{\commenttitle}{Comment \ifnum\value{Reviewer}>0 \theReviewer-\theComment\else \theComment\fi}
\newenvironment{Comment}{%
  \stepcounter{Comment}%
  \vspace{2ex}\noindent\bfseries\large\commenttitle%
  \par\begin{spacing}{1.4}\mdseries\begin{formal}%
}{%
  \end{formal}\end{spacing}\vspace{2ex}\par%
}

% Intro env: like Comment but does NOT increment the Comment counter and
% does NOT print a numbered title. Use for the reviewer's / editor's overall
% summary block at the top of each section, so that numbered Comments start
% from 1 (not 2).
\newenvironment{Intro}{%
  \vspace{2ex}\noindent\bfseries\large Comment\mdseries%
  \par\begin{spacing}{1.4}\begin{formal}%
}{%
  \end{formal}\end{spacing}\vspace{2ex}\par%
}

% IntroResponse env: like Response but with a title-less ``Response'' header
% (no number) for the intro reply that goes with an Intro block. Keeps the
% Comment counter untouched so that the first numbered Response is N-1.
\newenvironment{IntroResponse}{%
  \vspace{2ex}\noindent\bfseries\large Response\mdseries%
  \par\begin{spacing}{1.4}%
}{%
  \end{spacing}\vspace{2ex}\par%
}

\newcommand{\responsetitle}{Response \ifnum\value{Reviewer}>0 \theReviewer-\theComment\else \theComment\fi}
\newenvironment{Response}[1][]{%
  \def\Resp@Subtitle{#1}%
  \vspace{2ex}\noindent\bfseries\large\responsetitle%
  \ifx\Resp@Subtitle\@empty\else\unskip\ : \Resp@Subtitle\fi%
  \mdseries\par\begin{spacing}{1.4}%
  \phantomsection
  \addcontentsline{toc}{subsection}{%
    \responsetitle\ifx\Resp@Subtitle\@empty\else\ : \Resp@Subtitle\fi%
  }%
}{%
  \end{spacing}\vspace{2ex}\par%
}

% Modi label: shares the same Comment counter as the Response above, so
% Modification N-K matches Response N-K. For the editor (Reviewer = 0),
% the label is "Modification K" without a reviewer prefix.
\newcommand{\modificationtitle}{%
  Modification \ifnum\value{Reviewer}>0 \theReviewer-\theComment\else \theComment\fi%
}

% Modi env: bold heading, no frame (so multicols inside can break across pages
% and start mid-page). Visual contrast lives only on the location paragraph
% via the \modiloc{...} helper.
\newenvironment{Modi}{%
  \vspace{2ex}\noindent\bfseries\large\modificationtitle%
  \mdseries\par\nopagebreak\begin{spacing}{1.4}%
  \phantomsection\addcontentsline{toc}{subsection}{\modificationtitle}%
}{%
  \end{spacing}\vspace{2ex}\par%
}

% ModiPaste: wrapper for manuscript-paste content inside a Modi block.
% Sets Times New Roman at the surrounding body fontsize (normalsize) and
% two-column flow. Must be used inside a Modi env. Figures/tables inside
% should use minipage instead of float envs so multicols can balance.
\newenvironment{ModiPaste}{%
  \manuscriptfont\small
  \begin{multicols}{2}%
}{%
  \end{multicols}%
}

% Location-paragraph helper: bold Maroon text with a LightCoral left bar.
% Use as \modiloc{Page X, Section Y.} inside a ModiPaste block.
\newcommand{\modiloc}[1]{%
  \par\noindent\hspace*{12pt}%
  \llap{\textcolor{LightCoral}{\rule[-2pt]{3pt}{\baselineskip}}\hspace{9pt}}%
  \textbf{\textcolor{Maroon}{#1}}\par
}

% 框体环境配置
\tcbuselibrary{breakable,skins}
\newtcolorbox{Original}[1]{
    colback=red!5!white,
    colframe=red!75!black,
    fonttitle=\bfseries,
    sharp corners,
    breakable,
    title=#1
}

% ========== 框架环境定义 ==========
\newenvironment{formal}{%
  \def\FrameCommand{%
    \hspace{1pt}%
    {\color{DarkBlue}\vrule width 2pt}%
    {\color{formalshade}\vrule width 4pt}%
    \colorbox{formalshade}%
  }%
  \MakeFramed{\advance\hsize-\width\FrameRestore}%
  \noindent\hspace{-4.55pt}%
}{%
  \endMakeFramed%
}

\newenvironment{redframe}{%
  \def\FrameCommand{%
    \hspace{1pt}%
    {\color{LightCoral}\vrule width 2pt}%
    {\color{redshade}\vrule width 4pt}%
    \colorbox{redshade}%
  }%
  \MakeFramed{\advance\hsize-\width\FrameRestore}%
}{%
  \endMakeFramed%
}

\newtcolorbox{Revised}[1]{
    colback=green!5!white,
    colframe=green!75!black,
    fonttitle=\bfseries,
    title=#1
}

% 其他环境配置
\sethlcolor{redshade1}
\pagestyle{fancy}
\fancyhf{} % 清除原有页眉页脚
\fancyhead[LE,RO]{\paperid} % 偶数页左/奇数页右
\fancyhead[RE,LO]{Response to the decision letter}
\fancyfoot[C]{\thepage} % 页脚居中显示页码
