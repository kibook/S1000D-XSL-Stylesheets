<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'prdcrossreftable.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/productCrossRefTable"/>
    </chapter>
  </xsl:template>

  <xsl:template match="productCrossRefTable">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Product cross-reference table</bridgehead>
    </xsl:if>
    <table pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <title>Product instances</title>
      <tgroup cols="2">
        <colspec colname="c1" colwidth="1*"/>
        <colspec colname="c2" colwidth="2*"/>
        <thead rowsep="1">
          <row>
            <entry>ID</entry>
            <entry>Assign</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="product"/>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>

  <xsl:template match="product">
    <xsl:for-each select="assign">
      <row>
        <xsl:if test="position() = 1">
          <entry morerows="{count(parent::product/assign) - 1}">
            <xsl:value-of select="parent::product/@id"/>
          </entry>
        </xsl:if>
        <entry>
          <xsl:value-of select="@applicPropertyIdent"/>
          <xsl:text> = </xsl:text>
          <xsl:value-of select="@applicPropertyValue"/>
        </entry>
      </row>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
