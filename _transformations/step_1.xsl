<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:s="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes"></xsl:output>
    <xsl:strip-space elements="*"/>
    
<xsl:template match="TEI">
    <xsl:copy>
        <xsl:apply-templates/>
    </xsl:copy>
</xsl:template>
    
    <!-- The rule below ensures that the teiHeader of the final document is TEI P5 compliant (As of May 2019, it is not the case of the output provided by GROBID dictionaries output -->
    
    <xsl:template match="teiHeader">
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title>Titre du catalogue</title>
                    <respStmt>
                        <persName ref="#COL_000001">Simon Gabay</persName>
                        <resp><date when="2019">2019</date></resp>
                    </respStmt>
                </titleStmt>
                <extent></extent>
                <publicationStmt>
                    <publisher>Projet e-Ditiones, Université de Neuchâtel</publisher>
                    <availability status="restricted"> 
                        <licence  target="https://creativecommons.org/licenses/by/2.0">Attribution 2.0 Generic (CC BY 2.0)</licence>
                    </availability>
                </publicationStmt>
                <sourceDesc>
                    <bibl> <!-- bibliographical description of the print-->
                        <title>à renseigner</title>
                        <num>si nécessaire</num>
                        <editor></editor>
                        <publisher></publisher>
                        <pubPlace></pubPlace>
                        <date></date>
                    </bibl>
                    <listEvent>
                        <event> <!-- description of the related auction sale if necessary -->
                           <p> <address><addrLine></addrLine></address>

                            <persName type="auctioneer"></persName>                            

                            <persName type="expert"></persName>
                            
                            <date></date>
 </p>
                        </event>
                    </listEvent>
                    
                    <listWit><!-- list of the different instances of the catalog that were consulted / are known -->
                        <witness><ptr/></witness>
                        
                    </listWit> 
                    <listBibl> <!-- if applicable, a list of bibliographical references can be provided -->
                        <bibl></bibl>
                    </listBibl>
                </sourceDesc>
                
            </fileDesc>
            <profileDesc>
                <langUsage>
                    <language ident="fr">french</language>
                </langUsage>
            </profileDesc>
            
            <encodingDesc>
                <samplingDecl><p>This electronic version of the catalog only reproduces the entries that correspond to documents for sale. All text preceding or succeeding the list of documents for sale is not reproduced below.</p></samplingDecl>
                <appInfo>
                    <application version="1.6" ident="Transkribus" when="">
                        <label>Transkribus</label>
                        <ptr target="https://transkribus.eu/Transkribus/"/>
                    </application>
                    <application version="0.5.4" ident="GROBID" when="">
                        <label>GROBID_Dictionaries - A machine learning software for structuring digitized dictionaries</label>
                        <ptr target="https://github.com/MedKhem/grobid-dictionaries"/>
                    </application>
                </appInfo>
            </encodingDesc>
        </teiHeader>

    </xsl:template>
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:element name="gap"/>
           <xsl:element name="list">
               <xsl:apply-templates/>
           </xsl:element>
        </xsl:copy>
        <xsl:element name="gap"/>
    </xsl:template>
    
    <xsl:template match="entry">
        <xsl:element name="item">
            <xsl:attribute name="n">
                <xsl:value-of select=".//num"/>
           </xsl:attribute>
                <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pc"/>
 
    <xsl:template match="num">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="name">
        <xsl:element name="name">  
            <xsl:attribute name="type">
                <xsl:text>author</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="concat(., .//following-sibling::*[1])"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="desc">
        <xsl:element name="trait">
            <xsl:element name="p">
            <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="sense//sense">
        <xsl:element name="desc">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>

