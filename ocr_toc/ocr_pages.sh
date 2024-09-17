#!/bin/bash

# Output file
output_file="output_text.txt"

# Clear the output file if it already exists
> $output_file

# Loop through pages 165 to 171
for i in {165..171}; do
    image_path="data/book/oiseaux_de_senegambie_Page_${i}.png"
    
    # Run Tesseract on each image
    tesseract "$image_path" - --psm 1 -l eng >> $output_file
    
    # Add a page separator for clarity
    echo -e "\n--- End of Page $i ---\n" >> $output_file
done