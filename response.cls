% response.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{response}[2025/03/14 Response to Reviewers Class]

% 基础文档类选项继承
\LoadClass[twoside]{article}

% 宏包加载
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

\newcommand{\responsetitle}{Response \ifnum\value{Reviewer}>0 \theReviewer-\theComment\else \theComment\fi}
\newenvironment{Response}{%
  \vspace{2ex}\noindent\bfseries\large\responsetitle%
  \mdseries\par\begin{spacing}{1.4}%
  \phantomsection\addcontentsline{toc}{subsection}{\responsetitle}%
}{%
  \end{spacing}\vspace{2ex}\par%
}

\newcommand{\modificationtitle}{Modification \ifnum\value{Reviewer}>0 \theReviewer-\theComment\else \theResponse\fi}
\newenvironment{Modi}{%
  \vspace{2ex}\noindent\bfseries\large\modificationtitle%
  \mdseries\par\begin{spacing}{1.4}\begin{redframe}%
  \phantomsection\addcontentsline{toc}{subsection}{\modificationtitle}%
}{%
  \end{redframe}\end{spacing}\vspace{2ex}\par%
}

% 框体环境配置
\tcbuselibrary{breakable}
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
