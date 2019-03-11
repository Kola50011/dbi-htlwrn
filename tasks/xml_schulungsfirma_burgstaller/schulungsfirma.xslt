<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" />
    <xsl:template match="/">
        <kurslisten>
            <xsl:apply-templates select="schulungsfirma/kurs" />
        </kurslisten>
    </xsl:template>
    <xsl:template match="//kurs">
        <xsl:variable name="kurs" select="."></xsl:variable>
        <xsl:for-each select="./kveranst">
            <xsl:variable name="kveranst" select="."></xsl:variable>
            <kurstermin>
                <xsl:attribute name="bezeichn">
                    <xsl:value-of select="../@bezeichn" />
                </xsl:attribute>
                <xsl:attribute name="von">
                    <xsl:value-of select="@von" />
                </xsl:attribute>
                <xsl:for-each select="//person/besucht[@knr = $kurs/@knr][@knrlfnd = $kveranst/@knrlfnd]/..">
                    <xsl:sort select="@fname"></xsl:sort>
                    <xsl:sort select="@vname"></xsl:sort>
                    <person>
                        <xsl:attribute name="fname">
                            <xsl:value-of select="@fname" />
                        </xsl:attribute>
                        <xsl:attribute name="vname">
                            <xsl:value-of select="@vname"></xsl:value-of>
                        </xsl:attribute>
                    </person>
                </xsl:for-each>
            </kurstermin>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet> <!-- <kurslisten>
    {
  for $kurs in //kurs
  for $kveranst in $kurs/kveranst
  return
    <kurstermin name="{$kurs/@bezeichn}" datum="{$kveranst/@von}">
        {
            for $person in //person/besucht[@knr = $kurs/@knr]
                              [@knrlfnd = $kveranst/@knrlfnd]/..
           order by $person/@fname, $person/@vname
           return
        <teilnehmer fname="{$person/@fname}" vname="{$person/@vname}"></teilnehmer>
        }
    </kurstermin>
    }
</kurslisten> -->
<!-- <kurslisten>
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
