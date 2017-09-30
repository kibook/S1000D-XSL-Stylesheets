<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Associate certain info codes with 'types' of data modules.
       
       Override this template to customize per project.-->
  <xsl:template name="data.module.type">
    <xsl:param name="info.code"/>
    <xsl:choose>
      <xsl:when test="$info.code = '001' or
                      $info.code = '005' or
                      $info.code = '006' or
                      $info.code = '007' or
                      $info.code = '009' or
                      $info.code = '00A' or
                      $info.code = '00S' or
                      $info.code = '00U' or
                      $info.code = '00Z'">frontmatter</xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
