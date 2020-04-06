<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'frontmatter.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:variable name="info.code">
        <xsl:call-template name="get.infocode"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$info.code = '001'">
          <xsl:apply-templates select="identAndStatusSection">
            <xsl:with-param name="show.producedby.blurb">
              <xsl:choose>
                <xsl:when test="$producedby.blurb.on.titlepage != 0">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="identAndStatusSection"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="content/frontMatter/*"/>
    </chapter>
  </xsl:template>

  <xsl:template match="frontMatterTitlePage">
    <xsl:call-template name="title.page"/>
  </xsl:template>

  <xsl:template match="productIntroName">
    <fo:block font-size="18pt">
      <xsl:apply-templates select="name"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="productAndModel">
    <fo:block font-size="18pt">
      <xsl:apply-templates select="productName/name"/>
      <xsl:if test="productModel">
        <xsl:for-each select="productModel/modelName/name|productModel/natoStockNumber|productModel/identNumber|productModel/endItemCode">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="productIllustration">
    <xsl:apply-templates select="graphic">
      <xsl:with-param name="show.icn" select="0"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="frontMatterTableOfContent">
    <xsl:apply-templates select="reducedPara"/>
    <xsl:apply-templates select="tocList"/>
  </xsl:template>

  <xsl:template match="tocList">
    <informaltable pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <tgroup cols="5" align="left">
        <colspec colname="c1"/>
        <colspec colname="c2"/>
        <colspec colname="c3" colwidth="7em"/>
        <colspec colname="c4" colwidth="4em"/>
        <colspec colname="c5" colwidth="8em"/>
        <thead rowsep="1">
          <row>
            <entry>Document title</entry>
            <entry>Document identifier</entry>
            <entry>Issue date</entry>
            <entry>
              <xsl:choose>
                <xsl:when test="$running.pagination = 0">No. of pages</xsl:when>
                <xsl:otherwise>Page</xsl:otherwise>
              </xsl:choose>
            </entry>
            <entry>Applicable to</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="tocEntry" mode="TOC"/>
        </tbody>
      </tgroup>
    </informaltable>
  </xsl:template>

  <xsl:template match="tocEntry" mode="TOC">
    <xsl:if test="$hierarchical.table.of.contents = 1">
      <xsl:apply-templates select="title" mode="toc"/>
    </xsl:if>
    <xsl:apply-templates select="tocEntry|dmRef" mode="TOC"/>
  </xsl:template>

  <xsl:template match="dmRef" mode="TOC">
    <xsl:variable name="numberOfPages" select="following-sibling::*[1][self::numberOfPages]"/>
    <xsl:variable name="dm.code">
      <xsl:apply-templates select="dmRefIdent/dmCode"/>
    </xsl:variable>
    <xsl:variable name="applicRefId" select="@applicRefId"/>
    <row>
      <entry>
        <xsl:apply-templates select="dmRefAddressItems/dmTitle"/>
      </entry>
      <entry>
        <xsl:apply-templates select="."/>
      </entry>
      <entry>
        <xsl:apply-templates select="dmRefAddressItems/issueDate"/>
      </entry>
      <entry>
        <xsl:choose>
          <xsl:when test="$numberOfPages">
            <xsl:value-of select="$numberOfPages"/>
          </xsl:when>
          <xsl:when test="$running.pagination = 0">
            <fo:page-number-citation-last ref-id="ID_{$dm.code}-end"/>
          </xsl:when>
          <xsl:otherwise>
            <fo:page-number-citation ref-id="ID_{$dm.code}"/>
          </xsl:otherwise>
        </xsl:choose>
      </entry>
      <entry>
        <xsl:call-template name="fm.entry.applic">
          <xsl:with-param name="applicRefId" select="$applicRefId"/>
        </xsl:call-template>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterList">
    <xsl:apply-templates select="reducedPara"/>
    <xsl:choose>
      <xsl:when test="@frontMatterType = 'fm03'">
        <xsl:apply-templates select="frontMatterSubList" mode="HIGH"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="frontMatterSubList" mode="LOEDM"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="fm.entry.applic">
    <xsl:param name="applicRefId" select="@applicRefId"/>
    <xsl:choose>
      <xsl:when test="$applicRefId">
        <xsl:call-template name="get.applicability.string">
          <xsl:with-param name="applic" select="ancestor::dmodule//*[@id = $applicRefId]"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="get.applicability.string">
          <xsl:with-param name="applic" select="ancestor::dmodule/identAndStatusSection/dmStatus/applic"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="frontMatterSubList" mode="LOEDM">
    <informaltable pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <tgroup cols="6" align="left">
        <colspec colnum="3" colwidth="2em" align="center"/>
        <colspec colnum="4" colwidth="6em"/>
        <colspec colnum="5" colwidth="4em"/>
        <thead rowsep="1">
          <row>
            <entry>Document title</entry>
            <entry>Data module code</entry>
            <entry></entry>
            <entry>Issue date</entry>
            <entry>
              <xsl:choose>
                <xsl:when test="$running.pagination = 0">No. of pages</xsl:when>
                <xsl:otherwise>Page</xsl:otherwise>
              </xsl:choose>
            </entry>
            <entry>Applicable to</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="*" mode="LOEDM"/>
        </tbody>
      </tgroup>
    </informaltable>
  </xsl:template>

  <xsl:template match="frontMatterDmEntry" mode="LOEDM">
    <xsl:variable name="dm.code">
      <xsl:apply-templates select="dmRef/dmRefIdent/dmCode"/>
    </xsl:variable>
    <xsl:variable name="applicRefId" select="(@applicRefId|dmRef/@applicRefId)[1]"/>
    <row>
      <entry>
        <xsl:apply-templates select="dmRef/dmRefAddressItems/dmTitle"/>
      </entry>
      <entry>
        <xsl:apply-templates select="dmRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="@issueType" mode="lodm"/>
      </entry>
      <entry>
        <xsl:apply-templates select="dmRef/dmRefAddressItems/issueDate"/>
      </entry>
      <entry>
        <xsl:choose>
          <xsl:when test="numberOfPages">
            <xsl:value-of select="numberOfPages"/>
          </xsl:when>
          <xsl:when test="$running.pagination = 0">
            <fo:page-number-citation-last ref-id="ID_{$dm.code}-end"/>
          </xsl:when>
          <xsl:otherwise>
            <fo:page-number-citation ref-id="ID_{$dm.code}"/>
          </xsl:otherwise>
        </xsl:choose>
      </entry>
      <entry>
        <xsl:call-template name="fm.entry.applic">
          <xsl:with-param name="applicRefId" select="$applicRefId"/>
        </xsl:call-template>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterPmEntry" mode="LOEDM">
    <xsl:variable name="applicRefId" select="(@applicRefId|pmRef/@applicRefId)[1]"/>
    <row>
      <entry>
        <xsl:apply-templates select="pmRef/pmRefAddressItems/pmTitle"/>
      </entry>
      <entry>
        <xsl:apply-templates select="pmRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="@issueType" mode="lodm"/>
      </entry>
      <entry>
        <xsl:apply-templates select="pmRef/pmRefAddressItems/issueDate"/>
      </entry>
      <entry/>
      <entry>
        <xsl:call-template name="fm.entry.applic">
          <xsl:with-param name="applicRefId" select="$applicRefId"/>
        </xsl:call-template>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterExternalPubEntry" mode="LOEDM">
    <xsl:variable name="applicRefId" select="(@applicRefId|pmRef/@applicRefId)[1]"/>
    <row>
      <entry>
        <xsl:apply-templates select="externalPubRef/externalPubRefIdent/externalPubTitle"/>
      </entry>
      <entry>
        <xsl:apply-templates select="externalPubRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="@issueType" mode="lodm"/>
      </entry>
      <entry>
        <xsl:apply-templates select="externalPubRef/externalPubRefAddressItems/externalPubIssueDate"/>
      </entry>
      <entry/>
      <entry>
        <xsl:call-template name="fm.entry.applic">
          <xsl:with-param name="applicRefId" select="$applicRefId"/>
        </xsl:call-template>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterSubList" mode="HIGH">
    <informaltable pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <tgroup cols="2" align="left">
        <colspec colname="c1"/>
        <colspec colname="c2"/>
        <thead rowsep="1">
          <row>
            <entry>Data module</entry>
            <entry>Reason for update</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="*" mode="HIGH"/>
        </tbody>
      </tgroup>
    </informaltable>
  </xsl:template>

  <xsl:template match="frontMatterDmEntry" mode="HIGH">
    <row>
      <entry>
        <xsl:apply-templates select="dmRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="reasonForUpdate/simplePara"/>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterPmEntry" mode="HIGH">
    <row>
      <entry>
        <xsl:apply-templates select="pmRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="reasonForUpdate/simplePara"/>
      </entry>
    </row>
  </xsl:template>

  <xsl:template match="frontMatterExternalPubEntry">
    <row>
      <entry>
        <xsl:apply-templates select="externalPubRef"/>
      </entry>
      <entry>
        <xsl:apply-templates select="reasonForUpdate/simplePara"/>
      </entry>
    </row>
  </xsl:template>

</xsl:stylesheet>
