# Read input and output arguments from the command line
args <- commandArgs(trailingOnly=TRUE)
input_file <- args[1]
output_file <- args[2]

# Read the input file
data <- readLines(input_file)

# Count the number of characters in each string
char_counts <- nchar(data)

# Write the character counts to the output file
write.table(data.frame(String = data, Character_Count = char_counts), file=output_file, row.names=FALSE)
