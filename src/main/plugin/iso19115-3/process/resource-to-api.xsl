<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<!--
Stylesheet used to update metadata for a service and
attached it to the metadata for data.
-->
<xsl:stylesheet xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
                xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
                xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:param name="nodeUrl"/>

  <xsl:variable name="uuid"
                select="//mdb:metadataIdentifier[position() = 1]/mcc:MD_Identifier
              /mcc:code/gco:CharacterString"/>

  <!--
  http://metawal.wallonie.be/geonetwork/srv/eng/resources.get?uuid=c75b182d-9d14-4fde-b94f-0e8b8e0afa79&fname=NO3_600_600.png
  -->
  <xsl:template match="*[contains(text(), 'resources.get')]">
    <xsl:copy>
     <xsl:value-of select="concat($nodeUrl,
                              'api/records/', $uuid,
                               '/attachements/',
                               replace(text(), '.*fname=([^&amp;]*)', '$1'))"/>
      <!--
                  onlineSrcParams.put("url", sm.getNodeURL() + String.format("api/records/%s/attachments/%s", uuid, filename));

      -->
    </xsl:copy>
  </xsl:template>


  <!-- Do a copy of every nodes and attributes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Always remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>

</xsl:stylesheet>
