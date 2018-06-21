<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'comrep.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/commonRepository"/>
    </chapter>
  </xsl:template>

  <xsl:template match="commonRepository">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Common information repository</bridgehead>
    </xsl:if>
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="controlIndicatorRepository">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Controls and indicators</bridgehead>
    </xsl:if>
    <table pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <title>Controls and indicators</title>
      <tgroup cols="5">
        <colspec colname="c1" colwidth="2*"/>
        <colspec colname="c2" colwidth="1*"/>
        <colspec colname="c3" colwidth="1*"/>
        <colspec colname="c4" colwidth="3*"/>
        <colspec colname="c5" colwidth="4*"/>
        <thead rowsep="1">
          <row>
            <entry>CIN</entry>
            <entry>Fig</entry>
            <entry>Key</entry>
            <entry>Name</entry>
            <entry>Description</entry>
          </row>
        </thead>
        <tbody>     
          <xsl:apply-templates select="controlIndicatorGroup"/>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>

  <xsl:template match="controlIndicatorGroup">
    <xsl:apply-templates select="controlIndicatorSpec"/>
  </xsl:template>

  <xsl:template match="controlIndicatorSpec">
    <row>
      <entry>
        <xsl:value-of select="@controlIndicatorNumber"/>
      </entry>
      <entry>
        <xsl:apply-templates select="parent::controlIndicatorGroup/internalRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="controlIndicatorKey"/>
      </entry>
      <entry>
        <xsl:apply-templates select="controlIndicatorName"/>
      </entry>
      <entry>
        <xsl:apply-templates select="controlIndicatorDescr"/>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="controlIndicatorKey">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="controlIndicatorName">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="controlIndicatorDescr">
    <itemizedlist>
      <xsl:apply-templates select="controlIndicatorFunction"/>
    </itemizedlist>
  </xsl:template>

  <xsl:template match="controlIndicatorFunction">
    <listitem>
      <xsl:apply-templates/>
    </listitem>
  </xsl:template>
  
</xsl:stylesheet>
