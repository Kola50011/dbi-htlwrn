java -jar  ../../tools/trang/trang.jar -I xml -O rnc trails.xml trails.rnc
java -jar  ../../tools/trang/trang.jar -I rnc -O dtd trails.rnc trails.dtd
java -jar ../../tools/trang/trang.jar -I rnc -O rng trails.rnc trails.rng
java -jar  ../../tools/trang/trang.jar -I rnc -O xsd trails.rnc trails.xsd

java -jar ../../tools/jing/bin/jing.jar -t -c trails.rnc trails.xml

xsltproc -o trails.html trails.xslt trails.xml