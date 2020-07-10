<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:s="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes"></xsl:output>
    
    <xsl:template match="TEI">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="teiHeader">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="gap">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="list">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    

    
    <xsl:template match="item">
        <xsl:element name="item">
            <xsl:attribute name="n">
                <xsl:value-of select=".//num"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="//titleStmt/title"/>
                <xsl:text>_e</xsl:text>
                <xsl:value-of select=".//num"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="num">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="name">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    
    <xsl:template match="trait">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="desc">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    
    <xsl:template match="add">
        <xsl:copy-of select="."/>
    </xsl:template>
    

</xsl:stylesheet>