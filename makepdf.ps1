## Alex Casson
#
# Versions
# 12.09.14 - v1 - initial script
#
# Aim
# Compile an IEEE PDF express compatible LaTeX document using LuaLaTeX
# 
# Usage
# .\makepdf.ps1 -filename $filename.tex
#
# Notes
# BIBTeX is only run once regardless of whether updates are detected. The script may need to be run multiple times to ensure all references and cross references are up to date.
# -----------------------------------------------------------------------------

# Set up input arguments
param (
    [string]$FILENAME = $(throw "-filename is required.")
 )
# Convert file name to the required extensions
$INPUT = $FILENAME.Substring(0, $FILENAME.LastIndexOf('.'))
$INPUTPS = $INPUT + ".ps"
$INPUTPDF = $INPUT + ".pdf"


# Add the files to the search path
$TEXCURRENT = kpsewhich.exe -var-value=TEXINPUTS
$HERE = Get-Location
$TEXINPUTS = $HERE.Path + ";" + $TEXCURRENT
Write-Host $TEXINPUTS

# Set BIBTeX search path to be the same
$BIBCURRENT = kpsewhich.exe -var-value=BIBINPUTS
$BIBINPUTS = $TEXINPUTS + ";" + $BIBCURRENT
$BIBCURRENT = kpsewhich.exe -var-value=BSTINPUTS
$BSTINPUTS = $TEXINPUTS + ";" + $BSTCURRENT


# Run Biber
#bibtex.exe $INPUT
biber.exe $INPUT


# Run LuaLaTeX
lualatex.exe $FILENAME
#dvips -Ppdf -G0 -tletter $INPUT
#ps2pdf -dPDFSETTINGS=/printer -dMAxSubsetPct=100 -dSubsetFonts=true -dEmbedAllFonts=true -sPAPERSIZE=letter $INPUTPS $INPUTPDF


# Display output file
Start-Process "$INPUT.pdf"