<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Kurslisten</title>
            </head>
            <body>
                <xsl:apply-templates select="kurslisten/kurstermin" />
            </body>
        </html>
    </xsl:template>
    <xsl:template match="//kurstermin">
        <h1>
            <xsl:value-of select="@bezeichn" />
            <xsl:text> | </xsl:text>
            <xsl:value-of select="@von" />
        </h1>
        <ul>
            <xsl:for-each select="./person">
                <li>
                    <xsl:value-of select="@fname" />
                    <xsl:text> | </xsl:text>
                    <xsl:value-of select="@vname" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
</xsl:stylesheet> <!-- <kurslisten>
    <kurstermin name="Notenkunde" datum="2003-04-07">
        <teilnehmer fname="Liszt" vname="Franz" />
        <teilnehmer fname="Tschaikowskij" vname="Peter" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Notenkunde" datum="2004-06-23">
        <teilnehmer fname="Bizet" vname="Georges" />
        <teilnehmer fname="Brahms" vname="Johannes" />
        <teilnehmer fname="Strauss" vname="Richard" />
        <teilnehmer fname="Verdi" vname="Giuseppe" />
    </kurstermin>
    <kurstermin name="Notenkunde" datum="2005-04-10">
        <teilnehmer fname="Verdi" vname="Giuseppe" />
    </kurstermin>
    <kurstermin name="Harmonielehre" datum="2003-10-09">
        <teilnehmer fname="Beethoven" vname="Ludwig van" />
        <teilnehmer fname="Brahms" vname="Johannes" />
        <teilnehmer fname="Strauss" vname="Richard" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Rhythmik" datum="2003-11-17">
        <teilnehmer fname="Bach" vname="Johann Sebastian" />
        <teilnehmer fname="Schönberg" vname="Arnold" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Instrumentenkunde" datum="2004-01-12">
        <teilnehmer fname="Berlioz" vname="Hector" />
        <teilnehmer fname="Bruckner" vname="Anton" />
        <teilnehmer fname="Händel" vname="Georg Friedrich" />
    </kurstermin>
    <kurstermin name="Instrumentenkunde" datum="2004-03-28">
        <teilnehmer fname="Schubert" vname="Franz" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Dirigieren" datum="2004-05-18">
        <teilnehmer fname="Haydn" vname="Joseph" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Dirigieren" datum="2004-09-23">
        <teilnehmer fname="Puccini" vname="Giacomo" />
        <teilnehmer fname="Strauss" vname="Richard" />
    </kurstermin>
    <kurstermin name="Dirigieren" datum="2005-03-30" />
    <kurstermin name="Komposition" datum="2005-03-09">
        <teilnehmer fname="Bizet" vname="Georges" />
        <teilnehmer fname="Schönberg" vname="Arnold" />
        <teilnehmer fname="Wagner" vname="Richard" />
    </kurstermin>
    <kurstermin name="Komposition" datum="2005-09-14" />
</kurslisten> -->
