zip="$1"

## Utility functions

die() {
    echo
    echo "*** $@" 1>&2;
    exit 1;
}

## Checks on the variables

if test -z "$zip"; then
    die "The ZIP file is a mandatory option."
fi

if test \! -f "$zip"; then
    die "ZIP file '$zip' is not a regular file."
fi

if test \! -d garbage; then
    die "The 'garbage' dir does not exist.  Are you in the root dir?"
fi

## Unzip it

rm -rf garbage/*
unzip "$zip" -d garbage/ >/dev/null

src=`echo garbage/docbook-*/`
num=`echo "$src" | sed -e 's|garbage/docbook-xsl-\(.*\)/|\1|'`
dest=garbage/build

mkdir "$dest"
mkdir "$dest/content"

sed "s/{@VERSION}/$num/g" rsrc/docbook-xsl-cxan.xml > "$dest/cxan.xml"
cp "$src/VERSION" "$dest/content/"

ns=http://docbook.org/xsl
abbrev=docbook-xsl
pkg="$dest/expath-pkg.xml"

echo "<package xmlns='http://expath.org/ns/pkg'" > $pkg;
echo "         name='$ns'" >> $pkg;
echo "         version='$num'" >> $pkg;
echo "         abbrev='$abbrev'" >> $pkg;
echo "         spec='1.0'>" >> $pkg;
echo "   <title>XSLT stylesheets for DocBook $num.</title>" >> $pkg;
echo "   <home>http://docbook.sourceforge.net/</home>" >> $pkg;
echo "   <xslt>" >> $pkg;
echo "      <import-uri>$ns/VERSION</import-uri>" >> $pkg;
echo "      <file>VERSION</file>" >> $pkg;
echo "   </xslt>" >> $pkg;

for d in            \
    common          \
    epub            \
    epub3           \
    fo              \
    highlighting    \
    html            \
    lib             \
    manpages        \
    params          \
    profiling       \
    template        \
    website         \
    xhtml
do
    mkdir "$dest/content/$d";
    # dtd
    for f in "$src/$d"/*.dtd; do
        n=`basename $f`;
        if [[ "$n" != '*.dtd' ]]; then
            cp "$src/$d/$n" "$dest/content/$d/";
	fi
    done
    # ent
    for f in "$src/$d"/*.ent; do
        n=`basename $f`;
        if [[ "$n" != '*.ent' ]]; then
            cp "$src/$d/$n" "$dest/content/$d/";
	fi
    done
    # xml
    for f in "$src/$d"/*.xml; do
        n=`basename $f`;
        if [[ "$n" != '*.xml' ]]; then
            cp "$src/$d/$n" "$dest/content/$d/";
	fi
    done
    # xsl
    for f in "$src/$d"/*.xsl; do
        n=`basename $f`;
        if [[ "$n" != '*.xsl' ]]; then
            cp "$src/$d/$n" "$dest/content/$d/";
            echo "   <xslt>" >> $pkg;
            echo "      <import-uri>$ns/$d/$n</import-uri>" >> $pkg;
            echo "      <file>$d/$n</file>" >> $pkg;
            echo "   </xslt>" >> $pkg;
        fi
    done
done

echo "</package>" >> $pkg;

( cd "$dest"; zip -r "docbook-xsl-${num}.xar" . )

mv "$dest"/*.xar dist/
