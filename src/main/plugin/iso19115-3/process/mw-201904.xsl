<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
                xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0"
                xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0"
                xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
                xmlns:mrc="http://standards.iso.org/iso/19115/-3/mrc/1.0"
                xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                exclude-result-prefixes="#all">

  <xsl:variable name="uuid"
                select="//mdb:metadataIdentifier[1]/
                            mcc:MD_Identifier/mcc:code/*"/>

  <!--
  Remove mdb:resourceScope.

  Before
          <mmi:maintenanceScope>
            <mcc:MD_Scope>
               <mcc:level>
                  <mdb:resourceScope>
                     <mcc:MD_ScopeCode codeList="https://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#MD_ScopeCode"
                                       codeListValue="dataset"/>
                  </mdb:resourceScope>
               </mcc:level>
            </mcc:MD_Scope>
         </mmi:maintenanceScope>
  After
         <mmi:maintenanceScope>
            <mcc:MD_Scope>
               <mcc:level>
                  <mcc:MD_ScopeCode codeList="https://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#MD_ScopeCode"
                                    codeListValue="dataset"/>
               </mcc:level>
            </mcc:MD_Scope>
         </mmi:maintenanceScope>
  -->
  <xsl:template match="mmi:maintenanceScope/mcc:MD_Scope/mcc:level/mdb:resourceScope">
    <xsl:apply-templates select="*"/>
  </xsl:template>


  <xsl:template match="gco:Date[contains(., 'T')]">
    <xsl:message>Record <xsl:value-of select="$uuid"/> ;[FIX]; Date time encoded in a date field.</xsl:message>
    <gco:DateTime><xsl:value-of select="."/></gco:DateTime>
  </xsl:template>

  <xsl:template match="gco:DateTime[not(contains(., 'T'))]">
    <xsl:message>Record <xsl:value-of select="$uuid"/> ;[FIX]; Date encoded in a date time field.</xsl:message>
    <gco:Date><xsl:value-of select="."/></gco:Date>
  </xsl:template>

  <!-- Remove geonet:* elements. -->
  <xsl:template match="gn:*" priority="2"/>

  <!-- Copy everything. -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
