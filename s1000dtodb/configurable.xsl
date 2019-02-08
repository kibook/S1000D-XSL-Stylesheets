<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <!-- This file contains templates for elements with project configurable
       attribute values, defined in Chap 3.9.6.1 of the S1000D Issue 4.2 spec.

       Since these are more likely to be customized by a project, they are
       placed separately from the other templates. -->

  <!-- inlineSignificantData: significantParaDataType

       "psd01"          Ammunition
       "psd02"          Instruction disposition
       "psd03"          Lubricant
       "psd04"          Maintenance level
       "psd05"          Manufacturer code
       "psd06"          Manufacturers recommendation
       "psd07"          Modification code
       "psd08"          Qualification code
       "psd09"          Training level
       "psd10"          Control or indicator value
       "psd51"-"psd99"  Available for projects -->
  <xsl:template match="inlineSignificantData">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- emphasis: emphasisType

       "em01"         Bold (default)
       "em02"         Italic
       "em03"         Underline
       "em04"         Overline
       "em05"         Strikethrough
       "em51"-"em99"  Available for projects -->
  <xsl:template match="emphasis">
    <xsl:element name="emphasis">
      <xsl:attribute name="role">
        <xsl:choose>
          <xsl:when test="@emphasisType = 'em02'">italic</xsl:when>
          <xsl:when test="@emphasisType = 'em03'">underline</xsl:when>
          <xsl:when test="@emphasisType = 'em04'">overline</xsl:when>
          <xsl:when test="@emphasisType = 'em05'">strikethrough</xsl:when>
          <xsl:otherwise>bold</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- verbatimText: verbatimStyle

       "vs01"         Generic verbatim (default)
       "vs02"         Filename
       "vs11"         XML/SGML markup
       "vs12"         XML/SGML element name
       "vs13"         XML/SGML attribute name
       "vs14"         XML/SGML attribute value
       "vs15"         XML/SGML entity name
       "vs16"         XML/SGML processing instruction
       "vs21"         Program prompt
       "vs22"         User input
       "vs23"         Computer output
       "vs24"         Program listing
       "vs25"         Program variable name
       "vs26"         Program variable value
       "vs27"         Constant
       "vs28"         Class name
       "vs29"         Parameter name
       "vs51"-"vs99"  Available for projects -->
  <xsl:template match="verbatimText">
    <xsl:choose>
      <!-- Block verbatim text types -->
      <xsl:when test="@verbatimStyle = 'vs11'">
        <programlisting>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </programlisting>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs23'">
        <screen>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </screen>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs24'">
        <programlisting>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </programlisting>
      </xsl:when>
      <!-- Inline verbatim text types -->
      <xsl:otherwise>
        <phrase>
          <xsl:call-template name="revisionflag"/>
          <literal>
            <xsl:apply-templates/>
          </literal>
        </phrase>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- caption: color

       "co00"         None
       "co01"         Green
       "co02"         Amber
       "co03"         Yellow
       "co04"         Red
       "co07"         White
       "co08"         Grey
       "co09"         Clear (default)
       "co10"         Black
       "co51"-"co99"  Available for projects -->
  <xsl:template match="@color">
    <xsl:choose>
      <xsl:when test=". = 'co01'">#00FF00</xsl:when>
      <xsl:when test=". = 'co02'">#FF9900</xsl:when>
      <xsl:when test=". = 'co03'">#FFFF00</xsl:when>
      <xsl:when test=". = 'co04'">#FF0000</xsl:when>
      <xsl:when test=". = 'co07'">#FFFFFF</xsl:when>
      <xsl:when test=". = 'co08'">#CCCCCC</xsl:when>
      <xsl:when test=". = 'co10'">#000000</xsl:when>
      <xsl:otherwise>inherit</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@color" mode="text.color">
    <xsl:choose>
      <xsl:when test=". = 'co04'">#FFFFFF</xsl:when>
      <xsl:when test=". = 'co10'">#FFFFFF</xsl:when>
      <xsl:otherwise>inherit</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- quantityUnitOfMeasure

       Determines the display of each of the standard UoM.

       "um51"-"um99" are also available for projects. -->
  <xsl:template match="@quantityUnitOfMeasure">
    <xsl:choose>
      <xsl:when test=". = '%'">%</xsl:when>
      <xsl:when test=". = 'dega'">°</xsl:when>
      <xsl:when test=". = 'degC'"> °C</xsl:when>
      <xsl:when test=". = 'degF'"> °F</xsl:when>
      <xsl:when test=". = 'degR'"> °R</xsl:when>
      <xsl:when test=". = 'in2'"> in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'in3'"> in<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'in4'"> in<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'km2'"> km<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'km3'"> km<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm2'"> m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3'"> m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mina'">′</xsl:when>
      <xsl:when test=". = 'N.m'"> Nm</xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- accessPointType -->
  <xsl:template match="@accessPointType">
    <xsl:choose>
      <xsl:when test=". = 'accpnl01'">door</xsl:when>
      <xsl:when test=". = 'accpnl02'">panel</xsl:when>
      <xsl:when test=". = 'accpnl03'">electrical panel</xsl:when>
      <xsl:when test=". = 'accpnl04'">hatch</xsl:when>
      <xsl:when test=". = 'accpnl05'">fillet</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="security">
    <xsl:choose>
      <xsl:when test="@securityClassification = '01'">
        <xsl:choose>
          <xsl:when test="$show.unclassified != 0">
            <xsl:text>UNCLASSIFIED</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#160;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>CLASSIFIED: <xsl:value-of select="@securityClassification"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
