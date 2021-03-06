java -jar  ../../tools/trang/trang.jar -I xml -O rnc schulungsfirma.xml schulungsfirma.rnc
cat schulungsfirma.rnc | sed -i "s/NCName/string/"  schulungsfirma.rnc
cat schulungsfirma.rnc | sed -i "s/NMTOKEN/date/"  schulungsfirma.rnc

java -jar  ../../tools/trang/trang.jar -I rnc -O dtd schulungsfirma.rnc schulungsfirma.dtd
java -jar ../../tools/trang/trang.jar -I rnc -O rng schulungsfirma.rnc schulungsfirma.rng
java -jar  ../../tools/trang/trang.jar -I rnc -O xsd schulungsfirma.rnc schulungsfirma.xsd

java -jar ../../tools/jing/bin/jing.jar -t -c schulungsfirma.rnc schulungsfirma.xml

xsltproc -o kurslisten.xml schulungsfirma.xslt schulungsfirma.xml
xsltproc -o kurslisten.html kurslisten.xslt kurslisten.xml

java -jar  ../../tools/trang/trang.jar -I xml -O rnc kurslisten.xml kurslisten.rnc
cat kurslisten.rnc | sed -i "s/NCName/string/"  kurslisten.rnc
cat kurslisten.rnc | sed -i "s/NMTOKEN/date/"  kurslisten.rnc

java -jar  ../../tools/trang/trang.jar -I rnc -O dtd kurslisten.rnc kurslisten.dtd
java -jar ../../tools/trang/trang.jar -I rnc -O rng kurslisten.rnc kurslisten.rng
java -jar  ../../tools/trang/trang.jar -I rnc -O xsd kurslisten.rnc kurslisten.xsd

sed -i '2i <?xml-stylesheet type="text/xsl" href="kurslisten.xslt"?>' kurslisten.xml
google-chrome --allow-file-access-from-files kurslisten.xml