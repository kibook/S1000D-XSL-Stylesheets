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
 
  <!-- change bars ********************************************************** -->

  <xsl:attribute-set name="change.bar.attributes">
    <xsl:attribute name="change-bar-color">black</xsl:attribute>
    <xsl:attribute name="change-bar-placement">left</xsl:attribute>
    <xsl:attribute name="change-bar-style">solid</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="custom.change.bar.attributes">
    <xsl:attribute name="border-start-color">black</xsl:attribute>
    <xsl:attribute name="border-start-style">solid</xsl:attribute>
    <xsl:attribute name="border-start-width">2pt</xsl:attribute>
    <xsl:attribute name="padding-start">21mm</xsl:attribute>
    <xsl:attribute name="space-before">8pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="make.change.bar">
    <xsl:param name="revisionflag">
      <xsl:value-of select="@revisionflag"/>
    </xsl:param>
    <xsl:param name="content">
      <xsl:apply-templates/>
    </xsl:param>
    <xsl:if test="$revisionflag != 'off'">
      <xsl:choose>
        <xsl:when test="$xep.extensions">
          <xsl:variable name="class" select="generate-id()"/>
          <rx:change-bar-begin change-bar-class="{$class}"
            xsl:use-attribute-sets="change.bar.attributes"/>
          <xsl:copy-of select="$content"/>
          <rx:change-bar-end change-bar-class="{$class}"/>
        </xsl:when>
        <xsl:otherwise>
          <fo:block xsl:use-attribute-sets="custom.change.bar.attributes">
            <xsl:copy-of select="$content"/>
          </fo:block>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

  <!-- match any element that has a revisionflag attribute -->  
  <xsl:template match="*[@revisionflag]">
    <xsl:call-template name="make.change.bar">
      <xsl:with-param name="content">
        <xsl:apply-imports/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="d:phrase[@revisionflag]">
    <fo:inline color="green">
      <xsl:apply-imports/>
    </fo:inline>
  </xsl:template>

</xsl:stylesheet>
