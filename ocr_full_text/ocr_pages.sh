#!/bin/bash

# Output file
output_file="output_text.txt"

# Clear the output file if it already exists
> $output_file

# Loop through pages 165 to 171
for i in {31..152}; do

    page_number=$(printf "%03d" $i)
    
    # Construct the image file path
    image_path="data/book/oiseaux_de_senegambie_Page_${page_number}.png"
    
    
    # Run Tesseract on each image
    tesseract "$image_path" - --psm 1 -l fra >> $output_file
    
    # Add a page separator for clarity
    echo -e "\n--- End of Page $i ---\n" >> $output_file
    echo "Page $i"
done