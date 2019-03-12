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
</xsl:stylesheet>