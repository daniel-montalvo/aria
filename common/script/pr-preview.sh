#!/bin/bash

# build relative links to ARIA spec
find . -maxdepth 1 -type f -name "index.html" -exec sed -i 's|ED: "https://w3c\.github\.io/|ED: "./|g' {} +

# build lins to ARIA from child specs
find . -mindepth 2 -type f -name "index.html" -exec sed -i 's|ED: "https://w3c\.github\.io/aria/|ED: "/|g' {} +

# build relative links for child specs
find . -mindepth 2 -type f -name "index.html" -exec perl -pi -e 's|ED: "https://w3c\.github\.io/(?!aria)|ED: "/|g' {} +

# make output directory
mkdir -p public/accname
mkdir -p public/core-aam
mkdir -p public/dpub-aam
mkdir -p public/dpub-aria
mkdir -p public/graphics-aam
mkdir -p public/graphics-aria
mkdir -p public/html-aam
mkdir -p public/svg-aam
mkdir -p public/mathml-aam
mkdir -p public/pdf-aam
mkdir -p public/css-aam

