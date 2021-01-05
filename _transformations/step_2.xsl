<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:s="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="TEI" xml:id="{/TEI/@xml:id}">
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
                <xsl:value-of select=".//num[not(@type)]"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="/TEI/@xml:id"/>
                <xsl:text>_e</xsl:text>
                <xsl:value-of select=".//num[not(@type)]"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="num[ancestor::text]">
        <xsl:choose>
            <xsl:when test="@type='price'">
                <xsl:element name="measure">
                    <xsl:attribute name="commodity">
                        <xsl:text>currency</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="unit">
                        <xsl:text>FRF</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="quantity">
                        <xsl:value-of select="translate(normalize-space(translate(.,' ','.')),' ','')"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="num">
                    <xsl:attribute name="type">
                        <xsl:text>lot</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="name[ancestor::text]">
        <xsl:element name="name">
            <xsl:if  test="./@type='author'">
                <xsl:attribute name="type">
                    <xsl:text>author</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="ends-with(.,',')">
                    <xsl:variable name="tokens" select="tokenize(.,',')"/>
                    <xsl:value-of select="$tokens[not(.=$tokens[last()])]" separator=" "/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="trait">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="p[parent::trait]">
        <xsl:element name="p">
            <xsl:choose>
                <xsl:when test="ends-with(.,'-')">
                    <xsl:variable name="tokens" select="tokenize(.,' -')"/>
                    <xsl:value-of select="$tokens[not(.=$tokens[last()])]" separator=" "/>
                </xsl:when>
                <xsl:when test="ends-with(.,'–')">
                    <xsl:variable name="tokens" select="tokenize(.,' –')"/>
                    <xsl:value-of select="$tokens[not(.=$tokens[last()])]" separator=" "/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="desc">
        <xsl:element name="desc">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="/TEI/@xml:id"/>
                <xsl:text>_e</xsl:text>
                <xsl:value-of select="../num[not(@type)]"/>
                <xsl:text>_d</xsl:text>
                <xsl:value-of select="count(./preceding-sibling::desc) + 1"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ends-with(.,' ')">
                    <xsl:variable name="tokens" select="tokenize(.,' ')"/>
                    <xsl:value-of select="$tokens[not(.=$tokens[last()])]" separator=" "/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    
    <xsl:template match="add">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>