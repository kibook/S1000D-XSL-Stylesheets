<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:variable name="indenture">. . . . . . . .</xsl:variable>
 
  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'ipd.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/illustratedPartsCatalog"/>
    </chapter>
  </xsl:template>

  <xsl:template match="illustratedPartsCatalog">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Illustrated parts catalog</bridgehead>
    </xsl:if>
    <xsl:apply-templates select="figure"/>
    <informaltable pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <tgroup cols="6" align="left">
        <colspec colname="c1" colwidth="2*"/>
        <colspec colname="c2" colwidth="3*"/>
        <colspec colname="c3" colwidth="4*"/>
        <colspec colname="c4" colwidth="9*"/>
        <colspec colname="c5" colwidth="16*"/>
        <thead rowsep="1">
          <row>
            <entry>Fig</entry>
            <entry>Item</entry>
            <entry>QPNHA</entry>
            <entry>Part No.</entry>
            <entry>Nomenclature</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="catalogSeqNumber"/>
        </tbody>
      </tgroup>
    </informaltable>
  </xsl:template>

  <xsl:template match="catalogSeqNumber">
    <xsl:apply-templates select="itemSeqNumber"/>
  </xsl:template>

  <xsl:template match="itemSeqNumber">
    <row>
      <entry>
        <xsl:value-of select="parent::catalogSeqNumber/@figureNumber"/>
        <xsl:value-of select="parent::catalogSeqNumber/@figureNumberVariant"/>
      </entry>
      <entry>
        <xsl:value-of select="parent::catalogSeqNumber/@item"/>
        <xsl:value-of select="parent::catalogSeqNumber/@itemVariant"/>
      </entry>
      <entry>
        <xsl:value-of select="quantityPerNextHigherAssy"/>
      </entry>
      <entry>
        <xsl:apply-templates select="partRef"/>
      </entry>
      <entry>
        <xsl:value-of select="substring($indenture, 1, parent::catalogSeqNumber/@indenture * 2 - 2)"/>
        <xsl:value-of select="partSegment/itemIdentData/descrForPart"/>
      </entry>
    </row>
  </xsl:template>

</xsl:stylesheet>
