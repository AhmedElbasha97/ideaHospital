{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 ArialMT;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;\red27\green29\blue31;\red255\green255\blue255;\red222\green224\blue226;
}
{\*\expandedcolortbl;;\cssrgb\c14118\c15294\c16078;\cssrgb\c100000\c100000\c100000;\cssrgb\c89412\c90196\c90980;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs30 \cf2 \cb3 \expnd0\expndtw0\kerning0
projectfile=
\f1\fs26 \cb4 find -d . -name 'project.pbxproj'
\f0\fs30 \cb3  projectdir=
\f1\fs26 \cb4 echo *.xcodeproj
\f0\fs30 \cb3  projectfile="$\{projectdir\}/project.pbxproj" tempfile="$\{projectdir\}/project.pbxproj.out" savefile="$\{projectdir\}/project.pbxproj.mergesave"\cb1 \
\cb3 cat $projectfile | grep -v "<<<<<<< HEAD" | grep -v "=======" | grep -v "^>>>>>>> " > $tempfile mv $tempfile $projectfile}