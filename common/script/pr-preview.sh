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

# build all specs
respec -s index.html -o public/index.html --localhost
echo "Built ARIA"
respec -s accname/index.html -o public/accname/index.html --localhost
echo "Built AccName"
respec -s core-aam/index.html -o public/core-aam/index.html --localhost
echo "Built Core AAM"
respec -s dpub-aam/index.html -o public/dpub-aam/index.html --localhost
echo "Built DPub AAM"
respec -s dpub-aria/index.html -o public/dpub-aria/index.html --localhost
echo "Built DPUB ARIA"
respec -s graphics-aam/index.html -o public/graphics-aam/index.html --localhost
echo "Built graphics AAM"
respec -s graphics-aria/index.html -o public/graphics-aria/index.html --localhost
echo "Built graphics ARIA"
respec -s html-aam/index.html -o public/html-aam/index.html --localhost
echo "Built HTML AAM"
respec -s svg-aam/index.html -o public/svg-aam/index.html --localhost
echo "Built SVG AAM"
respec -s mathml-aam/index.html -o public/mathml-aam/index.html --localhost
echo "Built mathml-aam"
respec -s pdf-aam/index.html -o public/pdf-aam/index.html --localhost
echo "Built PDF AAM"
respec -s css-aam/index.html -o public/css-aam/index.html --localhost
echo "Built CSS  AAM"
