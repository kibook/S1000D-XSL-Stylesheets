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
    <xsl:attribute name="change-bar-color">
      <xsl:value-of select="$change.bar.color"/>
    </xsl:attribute>
    <xsl:attribute name="change-bar-placement">left</xsl:attribute>
    <xsl:attribute name="change-bar-style">
      <xsl:value-of select="$change.bar.style"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="custom.change.bar.attributes">
    <xsl:attribute name="border-start-color"><xsl:value-of select="$change.bar.color"/></xsl:attribute>
    <xsl:attribute name="border-start-style"><xsl:value-of select="$change.bar.style"/></xsl:attribute>
    <xsl:attribute name="border-start-width"><xsl:value-of select="$change.bar.width"/></xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="delete.change.bar.attributes" xsl:use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="text-decoration">line-through</xsl:attribute>
    <xsl:attribute name="color">red</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="make.change.bar">
    <xsl:param name="revisionflag">
      <xsl:value-of select="@revisionflag"/>
    </xsl:param>
    <xsl:param name="content">
      <xsl:apply-templates/>
    </xsl:param>
    <xsl:param name="padding">23mm</xsl:param>
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
          <xsl:choose>
            <xsl:when test="@revisionflag = 'deleted'">
              <xsl:if test="$hide.deleted.content = 0">
                <fo:block xsl:use-attribute-sets="delete.change.bar.attributes">
                  <xsl:copy-of select="$content"/>
                </fo:block>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <fo:block xsl:use-attribute-sets="normal.para.spacing">
                <fo:block xsl:use-attribute-sets="custom.change.bar.attributes" padding-start="{$padding}">
                  <xsl:copy-of select="$content"/>
                </fo:block>
              </fo:block>
            </xsl:otherwise>
          </xsl:choose>
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
    <xsl:choose>
      <xsl:when test="@revisionflag = 'deleted'">
        <xsl:if test="$hide.deleted.content = 0">
          <fo:inline text-decoration="line-through" color="red">
            <xsl:apply-imports/>
          </fo:inline>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <fo:inline color="green">
          <xsl:apply-imports/>
        </fo:inline>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
