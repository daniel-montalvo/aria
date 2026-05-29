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
LOGFILE="public/respec-errors.log"
: > "$LOGFILE"
failed=0

build_spec() {
	local src="$1"
	local out="$2"
	local name="$3"

	if respec -s "$src" -o "$out" --localhost --verbose >> "$LOGFILE" 2>&1; then
		echo "Built $name"
	else
		echo "Respec failed: $name ($src -> $out). See $LOGFILE" >&2
		failed=1
	fi
}

build_spec "index.html" "public/index.html" "ARIA"
build_spec "accname/index.html" "public/accname/index.html" "AccName"
build_spec "core-aam/index.html" "public/core-aam/index.html" "Core AAM"
build_spec "dpub-aam/index.html" "public/dpub-aam/index.html" "DPub AAM"
build_spec "dpub-aria/index.html" "public/dpub-aria/index.html" "DPUB ARIA"
build_spec "graphics-aam/index.html" "public/graphics-aam/index.html" "graphics AAM"
build_spec "graphics-aria/index.html" "public/graphics-aria/index.html" "graphics ARIA"
build_spec "html-aam/index.html" "public/html-aam/index.html" "HTML AAM"
build_spec "svg-aam/index.html" "public/svg-aam/index.html" "SVG AAM"
build_spec "mathml-aam/index.html" "public/mathml-aam/index.html" "mathml-aam"
build_spec "pdf-aam/index.html" "public/pdf-aam/index.html" "PDF AAM"
build_spec "css-aam/index.html" "public/css-aam/index.html" "CSS  AAM"

if [[ "$failed" -ne 0 ]]; then
	echo "One or more specs failed to build. See $LOGFILE" >&2
	exit 1
fi
