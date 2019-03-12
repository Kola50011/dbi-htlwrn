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
</xsl:stylesheet>