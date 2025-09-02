#!/bin/bash
# Script to export all robot parts as STL files
# Requires OpenSCAD command line tool

SCAD_FILE="../models/tennis-robot-printable-parts.scad"
OUTPUT_DIR="../models/stl"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Array of parts to export
parts=(
    "part_front_chassis"
    "part_rear_chassis"
    "part_ball_scoop"
    "part_wheel_hub"
    "part_wheel_tire"
    "part_basket_small"
    "part_basket_medium"
    "part_basket_large"
    "part_solar_mount"
    "part_battery_housing"
    "part_electronics_mount"
    "part_camera_mount"
    "part_bumper_corner"
)

# Export each part
for part in "${parts[@]}"; do
    echo "Exporting $part..."
    
    # Create temporary SCAD file with only the desired part
    temp_file="temp_${part}.scad"
    
    # Include the main file and call the specific part
    echo "include <${SCAD_FILE}>;" > "$temp_file"
    echo "${part}();" >> "$temp_file"
    
    # Export to STL
    openscad -o "${OUTPUT_DIR}/${part}.stl" "$temp_file" 2>/dev/null
    
    # Clean up temp file
    rm "$temp_file"
    
    echo "✓ Exported ${part}.stl"
done

echo "All parts exported to ${OUTPUT_DIR}/"