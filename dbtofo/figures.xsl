<?xml version="1.0" encoding="UTF-8"?>

<!-- ********************************************************************

     This file is part of the S1000D XSL stylesheet distribution.
     
     Copyright (C) 2010-2011 Smart Avionics Ltd.
     
     See ../COPYING for copyright details and other information.

     ******************************************************************** -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:rx="http://www.renderx.com/XSL/Extensions" version="1.0">
  
  <!-- figures ********************************************************************** -->

  <xsl:param name="formal.title.placement">
    figure after
    example before
    equation after
    table before
    procedure before
  </xsl:param>
  
<!--  <xsl:template match="d:mediaobject|d:imageobject|d:imagedata">
    <fo:block border="black solid 1pt">
      <xsl:apply-imports/>
    </fo:block>
  </xsl:template>-->

  <xsl:template match="d:mediaobject/d:caption">
    <fo:block keep-with-previous="always">
      <xsl:choose>
        <xsl:when test="@role = 'title'">
          <xsl:attribute name="text-align">center</xsl:attribute>
          <xsl:attribute name="font-style">italic</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="text-align">right</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template name="image.content.width">
    <xsl:param name="scalefit" select="0"/>
    <xsl:param name="scale" select="'1.0'"/>

    <xsl:choose>
      <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
      <xsl:when test="contains(@contentwidth,'%')">
        <xsl:value-of select="@contentwidth"/>
      </xsl:when>
      <xsl:when test="@contentwidth">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@contentwidth"/>
          <xsl:with-param name="default.units" select="'px'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="number($scale) != 1.0">
        <xsl:value-of select="$scale * 100"/>
        <xsl:text>%</xsl:text>
      </xsl:when>
      <xsl:when test="$scalefit = 1">scale-down-to-fit</xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="image.content.height">
    <xsl:param name="scalefit" select="0"/>
    <xsl:param name="scale" select="0"/>

    <xsl:choose>
      <xsl:when test="$ignore.image.scaling != 0">auto</xsl:when>
      <xsl:when test="contains(@contentdepth,'%')">
        <xsl:value-of select="@contentdepth"/>
      </xsl:when>
      <xsl:when test="@contentdepth">
        <xsl:call-template name="length-spec">
          <xsl:with-param name="length" select="@contentdepth"/>
          <xsl:with-param name="default.units" select="'px'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="number($scale) != 1.0">
        <xsl:value-of select="$scale * 100"/>
        <xsl:text>%</xsl:text>
      </xsl:when>
      <xsl:when test="$scalefit = 1">scale-down-to-fit</xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="formal.object.heading">
    <xsl:param name="object" select="."/>
    <xsl:param name="placement" select="'before'"/>

    <xsl:if test="not($object/self::d:figure)">
      <fo:block xsl:use-attribute-sets="formal.title.properties">
        <xsl:choose>
          <xsl:when test="$placement = 'before'">
            <xsl:attribute
                   name="keep-with-next.within-column">always</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute
                   name="keep-with-previous.within-column">always</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="$object" mode="object.title.markup">
          <xsl:with-param name="allow-anchors" select="1"/>
        </xsl:apply-templates>
      </fo:block>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
