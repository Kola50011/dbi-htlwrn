<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Local Hiking Trails</title>
            </head>
            <body>
                <ul>
                    <xsl:apply-templates select="park/trail" />
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="trail">
        <li>
            <xsl:value-of select="." />
            <xsl:text>: </xsl:text>
            <xsl:value-of select="@dist" />
            <xsl:text> feet, climb </xsl:text>
            <xsl:value-of select="@climb" />
        </li>
    </xsl:template>
</xsl:stylesheet>