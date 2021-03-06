<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'appliccrossreftable.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/applicCrossRefTable"/>
    </chapter>
  </xsl:template>

  <xsl:template match="applicCrossRefTable">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Applicability cross-reference table</bridgehead>
    </xsl:if>
    <xsl:apply-templates select="productAttributeList"/>
  </xsl:template>

  <xsl:template match="productAttributeList">
    <table pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <title>Product attribute list</title>
      <tgroup cols="3">
        <colspec colname="c1" colwidth="1*"/>
        <colspec colname="c2" colwidth="2*"/>
        <colspec colname="c3" colwidth="2*"/>
        <thead rowsep="1">
          <row>
            <entry>Name</entry>
            <entry>Description</entry>
            <entry>Values</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="productAttribute"/>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>

  <xsl:template match="productAttribute">
    <row>
      <entry>
        <xsl:value-of select="name"/>
      </entry>
      <entry>
        <xsl:value-of select="descr"/>
      </entry>
      <entry>
        <xsl:for-each select="enumeration">
          <xsl:value-of select="@applicPropertyValues"/>
          <xsl:if test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </entry>
    </row>
  </xsl:template>

</xsl:stylesheet>
