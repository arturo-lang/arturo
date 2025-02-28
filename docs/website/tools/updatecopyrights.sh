#!/bin/bash

# Set colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define the search and replace strings
SEARCH="Copyright \&copy; 2019-2023"
REPLACE="Copyright \&copy; 2019-2025"

# Counter for files
TOTAL_FILES=0
MATCHED_FILES=0
UPDATED_FILES=0

# Check mode by default
CHECK_MODE=true
SINGLE_FILE=false

# Process arguments and validate path is provided
if [ $# -lt 1 ]; then
    echo "Error: No path provided. Please specify a file or directory."
    echo "Usage: $0 [update] PATH"
    exit 1
fi

# Parse arguments
if [ "$1" = "update" ]; then
    CHECK_MODE=false
    shift
    
    if [ $# -lt 1 ]; then
        echo "Error: No path provided after 'update' parameter."
        echo "Usage: $0 update PATH"
        exit 1
    fi
fi

TARGET_PATH="$1"

# Check if the path exists
if [ ! -e "$TARGET_PATH" ]; then
    echo "Error: The path '$TARGET_PATH' does not exist."
    exit 1
fi

# Determine if it's a file or directory
if [ -f "$TARGET_PATH" ]; then
    SINGLE_FILE=true
    # Check if it's an HTML file
    if [[ "$TARGET_PATH" != *.html && "$TARGET_PATH" != *.htm ]]; then
        echo "Warning: The file '$TARGET_PATH' does not have an HTML extension."
        echo -n "Continue anyway? (y/n): "
        read -r CONFIRM
        if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
            echo "Operation cancelled."
            exit 0
        fi
    fi
elif [ ! -d "$TARGET_PATH" ]; then
    echo "Error: The path '$TARGET_PATH' is neither a file nor a directory."
    exit 1
fi

# Display mode information
if [ "$CHECK_MODE" = true ]; then
    echo -e "${BLUE}Copyright Update Check Script${NC}"
    echo "----------------------------"
    echo "This will search for '$SEARCH' in all HTML files"
    echo "and show which files would be modified (without making changes)."
else
    echo -e "${BLUE}Copyright Update Script${NC}"
    echo "----------------------------"
    echo -e "${YELLOW}!!! UPDATE MODE !!!${NC}"
    echo "This will replace '$SEARCH' with '$REPLACE'"
    echo "in all HTML files and save the changes."
    echo
    echo -n "Are you sure you want to proceed? (y/n): "
    read -r CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
fi
echo

# Get list of HTML files to process
if [ "$SINGLE_FILE" = true ]; then
    echo "Processing single file: ${TARGET_PATH}"
    HTML_FILES="$TARGET_PATH"
else
    echo "Searching for HTML files in ${TARGET_PATH}..."
    HTML_FILES=$(find "$TARGET_PATH" -type f -name "*.html")
fi

# Loop through each HTML file
for file in $HTML_FILES; do
    TOTAL_FILES=$((TOTAL_FILES + 1))
    
    # Check if the file contains the search string
    if grep -q "$SEARCH" "$file"; then
        MATCHED_FILES=$((MATCHED_FILES + 1))
        
        if [ "$CHECK_MODE" = true ]; then
            echo -e "${GREEN}FOUND:${NC} $file"
            
            # Get line numbers for context
            LINE_NUMBERS=$(grep -n "$SEARCH" "$file" | cut -d: -f1)
            
            # Show the matched lines with context
            for line_num in $LINE_NUMBERS; do
                # Extract a few lines around the match for context
                echo "   Line $line_num:"
                sed -n "$((line_num-1)),$((line_num+1))p" "$file" | sed "s/$SEARCH/${YELLOW}${SEARCH}${NC}/g"
                echo
            done
        else
            # Make a backup of the file
            cp "$file" "${file}.bak"
            
            # Perform the replacement
            sed -i.tmp "s/$SEARCH/$REPLACE/g" "$file"
            
            # Remove temporary file created by sed
            rm -f "${file}.tmp"
            
            # Check if the file was actually modified
            if cmp -s "$file" "${file}.bak"; then
                echo -e "${YELLOW}NO CHANGE:${NC} $file (unexpected error)"
                rm -f "${file}.bak"
            else
                UPDATED_FILES=$((UPDATED_FILES + 1))
                echo -e "${GREEN}UPDATED:${NC} $file"
                
                # Get line numbers for the updated content
                LINE_NUMBERS=$(grep -n "$REPLACE" "$file" | cut -d: -f1)
                
                # Show the first updated line with context
                if [ -n "$LINE_NUMBERS" ]; then
                    line_num=$(echo "$LINE_NUMBERS" | head -n 1)
                    echo "   Line $line_num (Updated):"
                    sed -n "$((line_num-1)),$((line_num+1))p" "$file" | sed "s/$REPLACE/${GREEN}${REPLACE}${NC}/g"
                    echo
                fi
            fi
        fi
    fi
done

echo "----------------------------"
echo "Summary:"
echo "Total HTML files scanned: $TOTAL_FILES"
echo "Files containing '$SEARCH': $MATCHED_FILES"

if [ "$CHECK_MODE" = false ]; then
    echo "Files updated: $UPDATED_FILES"
    echo
    echo -e "${GREEN}Backup files were created with .bak extension.${NC}"
    echo "Once you've verified the changes, you can remove them with:"
    if [ "$SINGLE_FILE" = true ]; then
        echo "rm \"${TARGET_PATH}.bak\""
    else
        echo "find \"$TARGET_PATH\" -name \"*.bak\" -delete"
    fi
else
    echo
    if [ $MATCHED_FILES -gt 0 ]; then
        echo -e "${YELLOW}To perform the actual update, run this script with the 'update' parameter:${NC}"
        echo "$ ./$(basename "$0") update \"$TARGET_PATH\""
    else
        echo -e "${RED}No files found containing the search string.${NC}"
    fi
fi