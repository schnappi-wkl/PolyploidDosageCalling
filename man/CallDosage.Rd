% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CallDosage.R
\name{CallDosage}
\alias{CallDosage}
\title{Calls dosage for a given input file}
\usage{
CallDosage(File, Control.File = "Controls.csv", Output.Dir = "Output",
  Directory = NULL, sheet = "Results", Console = F,
  Target.Column = "Target.Name", RQ.Threshold = 7,
  Output.File = "Dosage.csv", REF.Vars = c("CT"))
}
\arguments{
\item{File}{Name of the file containing the raw data from a Quant Studio qPCR run. The column Clone-plant_ID must be added.}

\item{Control.File}{Name of the file containing the controls. Must contain 2 columns, Name and Dosage, with Name matching the values in Clone-Plant_ID for control samples. (Default = Controls.csv)}

\item{Directory}{The directory containing the necessary files. Default to NULL which will use current directory.}

\item{sheet}{The name in File where Clone-Plant_ID and RQ values are stored. Default = "Results".}

\item{Console}{Should plots be printed to the console? Default is False which prints the plots to Output.Dir.}

\item{Target.Column}{Column containing the Target Assays. Default="Target.Name"}

\item{RQ.Threshold}{If RQ goes above this value we know something went wrong with the data. (Default = 7), since RQ should never be above 5.}

\item{Output.File}{The name of the output file containing the final dosage calls. Defaults to Dosage.csv.}

\item{REF.Vars}{REF.vars will be included in the output file with the reference assay values. (Default = CT)}
}
\value{
A dataset containing the dosage calls of each of the methods and a final determination of the dosage and likelihood.
}
\description{
Uses multiple models to fit the data, then uses each of these models to determine both the best fit, and liklihood of that fit.
}
\examples{
# Obtain the appropriate Control and Raw Data files. You can find these in the 
# data-raw/ folder of the Quadrophenia package files.They should match the data below.

# A 41 line header
# Followed by the output of QuantStudio's Results sheet
# Note that Clone-plant_ID must be added manually to this file

require(Quadrophenia)
RawData.Assay1CN[1:41,1] # Header
RawData.Assay1CN[42,]    # Columns of data

# The controls file has two columns: Name and Dosage. Name must 
# match the Clone-plant_ID column for the controls in the raw data file.

head(ControlsAssay1CN)

# Then run CallDosage() with these files as inputs

output = CallDosage(File='RawData.Assay1CN.xls',Control.File='ControlsAssay1CN.csv')

# The output directory Output/ should contain 1 .csv file and a Plots/ directory.
# The Plots/ directory contains two plots, one standard for manual calling, and 1
# plot showing the distribution of each class. The output file has columns for the
# Dosage calls as well as a likelihood for each call.

head(output)

## Other ways to run CallDosage()
# You could also specifiy an output file or a directory to look for the raw data files

dir.create('Files/')
file.copy(c('RawData.Assay1CN.xls','ControlsAssay1CN.csv'),'Files/')
output = CallDosage(File='RawData.Assay1CN.xls',
                    Control.File='ControlsAssay1CN.csv',
                    Directory='Files/',Output.Dir='NewOutput')

# Or specify the files in Files/ wihout specifying the directory. You can
# also change the name of the output file to something more informative.

output = CallDosage(File='Files/RawData.Assay1CN.xls',
                    Control.File='Files/ControlsAssay1CN.csv',
                    Output.Dir='ThirdOutput',
                    Output.File='ThirdOutputDosage.csv')

# Duplicates will automatically be renamed to avoid conflicts

output = CallDosage(File='Files/RawData.Assay1CN.xls',
                    Control.File='Files/ControlsAssay1CN.csv',
                    Output.Dir='ThirdOutput',
                    Output.File='ThirdOutputDosage.csv')

# Clean up the test files
unlink(c('Files','Output','ThirdOutput'),recursive=T)
}
\seealso{
\code{\link{?CallPA}} for calling the presence/absence of provided data
}
