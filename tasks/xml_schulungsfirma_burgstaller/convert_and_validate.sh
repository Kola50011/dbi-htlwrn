java -jar  ../../tools/trang/trang.jar -I xml -O rnc schulungsfirma.xml schulungsfirma.rnc
cat schulungsfirma.rnc | sed -i "s/NCName/string/"  schulungsfirma.rnc
cat schulungsfirma.rnc | sed -i "s/NMTOKEN/date/"  schulungsfirma.rnc

java -jar  ../../tools/trang/trang.jar -I rnc -O dtd schulungsfirma.rnc schulungsfirma.dtd
java -jar ../../tools/trang/trang.jar -I rnc -O rng schulungsfirma.rnc schulungsfirma.rng
java -jar  ../../tools/trang/trang.jar -I rnc -O xsd schulungsfirma.rnc schulungsfirma.xsd

java -jar ../../tools/jing/bin/jing.jar -t -c schulungsfirma.rnc schulungsfirma.xml
