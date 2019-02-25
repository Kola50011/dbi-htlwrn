java -jar  ../../tools/trang/trang.jar -I rnc -O dtd schulungsfirma.rnc schulungsfirma.dtd
java -jar ../../tools/trang/trang.jar -I rnc -O rng schulungsfirma.rnc schulungsfirma.rng
java -jar  ../../tools/trang/trang.jar -I rnc -O xsd schulungsfirma.rnc schulungsfirma.xsd

java -jar ../../tools/jing/bin/jing.jar -t -c schulungsfirma.rnc schulungsfirma.xml
