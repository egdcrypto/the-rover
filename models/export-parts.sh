#!/bin/bash

# Export key prototype parts to STL

echo "Exporting prototype chassis..."
echo "include <prototype-detailed.scad>; chassis_base();" > temp.scad
openscad -o prototype-chassis.stl temp.scad 2>/dev/null

echo "Exporting collection scoop..."
echo "include <prototype-detailed.scad>; collection_scoop();" > temp.scad
openscad -o prototype-scoop.stl temp.scad 2>/dev/null

echo "Exporting wheel..."
echo "include <prototype-detailed.scad>; wheel_assembly();" > temp.scad
openscad -o prototype-wheel.stl temp.scad 2>/dev/null

echo "Exporting mini basket..."
echo "include <prototype-detailed.scad>; mini_basket();" > temp.scad
openscad -o prototype-basket.stl temp.scad 2>/dev/null

echo "Exporting top cover..."
echo "include <prototype-detailed.scad>; top_cover();" > temp.scad
openscad -o prototype-top-cover.stl temp.scad 2>/dev/null

echo "Exporting tennis ball..."
echo "include <mini-tennis-court-environment.scad>; mini_tennis_ball();" > temp.scad
openscad -o mini-tennis-ball.stl temp.scad 2>/dev/null

echo "Exporting net post..."
echo "include <mini-tennis-court-environment.scad>; net_post();" > temp.scad
openscad -o net-post.stl temp.scad 2>/dev/null

echo "Exporting fence section..."
echo "include <mini-tennis-court-environment.scad>; fence_section();" > temp.scad
openscad -o fence-section.stl temp.scad 2>/dev/null

rm temp.scad
echo "All parts exported!"