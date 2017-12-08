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
      <xsl:when test="not(@verbatimStyle)">
        <literal><xsl:apply-templates/></literal>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs11'">
        <programlisting><xsl:apply-templates/></programlisting>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs23'">
        <screen><xsl:apply-templates/></screen>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs24'">
        <programlisting><xsl:apply-templates/></programlisting>
      </xsl:when>
      <xsl:otherwise>
        <literal><xsl:apply-templates/></literal>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
