<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ns2="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlan-2"
    xmlns:ns3="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlanRequest-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    exclude-result-prefixes="xs xd ns2" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Jun 4, 2018</xd:p>
            <xd:p><xd:b>Author:</xd:b> tvil</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

	<!-- <xsl:import-schema schema-location="UBL-TransportExecutionPlan-2.2.xsd"/> -->


    <!--Indents the results to get the proper xml formatting-->
    <xsl:output media-type="text/xml" version="1.0" encoding="UTF-8" indent="yes"
        use-character-maps="xml"/>
    <xsl:strip-space elements="*"/>

    <xsl:character-map name="xml">
        <xsl:output-character character="&amp;" string="&amp;"/>
    </xsl:character-map>
    <xsl:template match="TransportRequestType">
	<!-- <xsl:result-document validate="strict"> -->
        
        <!--_If CBF-->
        <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'CBF') )">

            <ns2:TransportExecutionPlan xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlan-2 ../UBL-2.2/xsd/maindoc/UBL-TransportExecutionPlan-2.2.xsd"
            xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
            xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
            xmlns:xades="http://uri.etsi.org/01903/v1.3.2#"
            xmlns:udt="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
            xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
            xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
            xmlns:dsig11="http://www.w3.org/2009/xmldsig11#"
            xmlns:ns0="urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2"
            xmlns:ns2="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlan-2"
            xmlns:ns1="http://uri.etsi.org/01903/v1.4.1#" xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
            xmlns:ccts="urn:un:unece:uncefact:documentation:2"
            xmlns:sac="urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2"
            xmlns:sbc="urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2"
            xmlns:cct="urn:un:unece:uncefact:data:specification:CoreComponentTypeSchemaModule:2">

            <cbc:UBLVersionID>2.2</cbc:UBLVersionID>
            <cbc:CustomizationID>Common Framework</cbc:CustomizationID>

            <!--_Message-Type-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType != '') )">
            <cbc:ProfileID>
                <xsl:value-of select="MessageIdentification/MessageType"/>
            </cbc:ProfileID>
             </xsl:if>

            <!--_Booking-Number-->
            <xsl:if test="((/TransportRequestType/Identification/BookingNumber != '') )">
            <cbc:ID>
                <xsl:value-of select="Identification/BookingNumber"/>
            </cbc:ID>
            </xsl:if>

            <!--_Message-Identifier-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageIdentifier != '') )">
            <cbc:UUID>
                <xsl:value-of select="MessageIdentification/MessageIdentifier"/>
            </cbc:UUID>
			      </xsl:if>

            <!--_Message-DateTime-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageDateTime != '') )">
            <xsl:variable name="messageDateTime" select="MessageIdentification/MessageDateTime"/>
            <cbc:IssueDate>
                <xsl:value-of select="format-dateTime($messageDateTime, '[Y0001]-[M01]-[D01]')"/>
            </cbc:IssueDate>
            <cbc:IssueTime>
                <xsl:value-of select="format-dateTime($messageDateTime, '[H01]:[m01]:[s01].[f001]')"
                />
            </cbc:IssueTime>
            </xsl:if>

            <!--_Booking-Status-->
            <!-- !!!!Could not find on CBF example-->
            <xsl:if test="((/TransportRequestType/Identification/BookingStatus != '') )">
            <cbc:DocumentStatusCode>
                <xsl:value-of select="Identification/BookingStatus"/>
            </cbc:DocumentStatusCode>
            </xsl:if>

            <!--_Auto-Rejection-Comments OR Manual-Rejection-Comments-->
            <xsl:for-each select="Feedback/AutoRejectionComments[. != '']">
                <cbc:DocumentStatusReasonDescription>
                    <xsl:value-of select="."/>
                </cbc:DocumentStatusReasonDescription>
            </xsl:for-each>
            <xsl:for-each select="Feedback/ManualRejectionComments[. != '']">
                <cbc:DocumentStatusReasonDescription>
                    <xsl:value-of select="."/>
                </cbc:DocumentStatusReasonDescription>
            </xsl:for-each>

            <!--Action-->
            <xsl:if test="((/TransportRequestType/Action != '') )">
            <cbc:ActionCode>
                <xsl:value-of select="Action"/>
            </cbc:ActionCode>
			</xsl:if>

            <!--    Issueing-Party-->
            <xsl:if test="((/TransportRequestType/Identification/IssuingParty != '') or (/TransportRequestType/Identification/OperationsContact != ''))">
            <cac:SenderParty>
            	<xsl:if test="(/TransportRequestType/Identification/IssuingParty!= '')">
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/IssuingParty"/>
                    </cbc:ID>
                </cac:PartyIdentification>
				</xsl:if>
                <!-- Operations-Contact-->
                <xsl:if test="(/TransportRequestType/Identification/OperationsContact!= '')">
                <cac:Contact>
                    <cbc:ID>
                        <xsl:value-of
                            select="/TransportRequestType/Identification/OperationsContact"/>
                    </cbc:ID>
                </cac:Contact>
                </xsl:if>
            </cac:SenderParty>
			</xsl:if>


            <!--_Customer-->
            <!--_If PB-->
<!--            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'PB') )">
            <cac:TransportUserParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/ForwarderSending"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportUserParty>
             </xsl:if>-->
            
            
            <!--_If CBF-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'CBF') )">
            <cac:TransportUserParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/Customer"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportUserParty>
             </xsl:if>

            <!--_Provider-->
            <!--_If PB-->
<!--            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'PB') )">
            <cac:TransportServiceProviderParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="Identification/Provider"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportServiceProviderParty>
            </xsl:if>-->

            <!--_If CBF-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'CBF') )">
            <cac:TransportServiceProviderParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="Identification/ForwarderReceiving"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportServiceProviderParty>
            </xsl:if>


            <!--_Service-Reference-->
            <xsl:if test="(Contract/ServiceReference!= '')">
            <cac:TransportServiceDescriptionDocumentReference>
                <cbc:ID>
                    <xsl:value-of select="Contract/ServiceReference"/>
                </cbc:ID>
            </cac:TransportServiceDescriptionDocumentReference>
			</xsl:if>

            <!--_Quotation-->
            <xsl:if test="((/TransportRequestType/Identification/Quotation != '') or (/TransportRequestType/Offer/Quotation != ''))">
            <cac:AdditionalDocumentReference>
            	<xsl:if test="((/TransportRequestType/Identification/Quotation != '') )">
                <cbc:ID>
                    <xsl:value-of select="Identification/Quotation"/>
                </cbc:ID>
                </xsl:if>

                <!--Ref DocumentTypeCode codelist-->
                <!-- !!! where do I get this one from-->
                <xsl:if test="( (/TransportRequestType/Offer/Quotation != ''))">
                <cbc:DocumentTypeCode>Offer/Quotation</cbc:DocumentTypeCode>
                </xsl:if>
            </cac:AdditionalDocumentReference>
            </xsl:if>

            <!--_Customs-Handling-Type-->
            <xsl:if test="((Customs/CustomsHandlingDocRef != '') or (Customs/CustomsHandlingType != '') or (Customs/CustomsHandlingDocument != '') )">
            <cac:AdditionalDocumentReference>

                <!--_Customs-Handling-Doc-Ref-->
                <xsl:if test="((/TransportRequestType/Customs/CustomsHandlingDocRef != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Customs/CustomsHandlingDocRef"/>
                </cbc:ID>
                </xsl:if>

                <!--_Customs-Handling-Type-->
                <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingType != '')  )">
                <cbc:DocumentTypeCode>
                    <xsl:value-of select="Customs/CustomsHandlingType"/>
                </cbc:DocumentTypeCode>
                </xsl:if>

                <!--_Customs-Handling-Document-->
                <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingDocument != '') )">
                <cac:Attachment>
                    <cbc:EmbeddedDocumentBinaryObject mimeCode="">
                        <xsl:value-of select="Customs/CustomsHandlingDocument"/>
                    </cbc:EmbeddedDocumentBinaryObject>
                </cac:Attachment>
                </xsl:if>
            </cac:AdditionalDocumentReference>
            </xsl:if>

            <!-- !!! should we just have the string as the ID and ignore the other fields?-->
            <!--_TR-Attachment-->
            <xsl:for-each select="Attachment/TR-Attachment">
                <cac:AdditionalDocumentReference>
    
                    <!--ID IS MANDATORY, SO SUCH ADD "TR-Attachment" AS A FIXED VALUE-->
                    <cbc:ID>TR-Attachment</cbc:ID>
                    <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingDocument != '') )">
                    <cac:Attachment>
                        <cbc:EmbeddedDocumentBinaryObject mimeCode="">
                            <xsl:value-of select="/TransportRequestType/Customs/CustomsHandlingDocument"/>
                        </cbc:EmbeddedDocumentBinaryObject>
                    </cac:Attachment>
                    </xsl:if>
                </cac:AdditionalDocumentReference>
            </xsl:for-each>

            <!--Contract-Reference-->
            <xsl:if test="(Contract/ContractReference!= '')">
            <cac:TransportContract>
                <cbc:ID>
                    <xsl:value-of select="Contract/ContractReference"/>
                </cbc:ID>
            </cac:TransportContract>
            </xsl:if>

            <xsl:if test="((Identification/TransportRequestType != '') or (Identification/MainModeofTransport != '')  )">
            <cac:MainTransportationService>

                <!--_Transport-Request-Type-->
                <xsl:if test="((Identification/TransportRequestType != '')  )">
                <cbc:TransportServiceCode>
                    <xsl:value-of select="Identification/TransportRequestType"/>
                </cbc:TransportServiceCode>
                </xsl:if>
                
                <xsl:if test="((Identification/MainModeofTransport != '')  )">
                <cac:ShipmentStage>
                    <!--Main-Mode-of-Transport-->
                    <cbc:TransportModeCode>
                        <xsl:value-of select="Identification/MainModeofTransport"/>
                    </cbc:TransportModeCode>
                </cac:ShipmentStage>
                </xsl:if>
            </cac:MainTransportationService>
            </xsl:if>

            <!-- MULTI-STOP & WEIGHING-->
            <!--Multistop and weighing are additional services that can be charged. It is important to indicate that
    such additional services are requested, but not a lot of details need to be associated with them.-->
 
                <!--Instead of a boolean attribute we could indicate that this is a weighing service by simply
        including "Weighing" as value in the TransportServiceCode-->
                <xsl:if test="MultistopAndWeighing/Weighing = 'true'">
                <cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Weighing</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>
                <xsl:if test="MultistopAndWeighing/OriginMultistop = 'true'">
               	<cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Origin Multistop</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>
                <xsl:if test="MultistopAndWeighing/DestinationMultistop = 'true'">
               	<cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Destination Multistop</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>


            <!--_ORIGIN-->
            <cac:FromLocation>

                <!--_Origin-Terminal-Code-->
                <xsl:if test="((Origin/TerminalCode != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Origin/TerminalCode"/>
                </cbc:ID>
                </xsl:if>
                
                <!--_Origin-Time-Type-->
                <!--NB: Probably not ideal, since Origin-Time-Type is an enumeration, but need a better understanding of what this element really means in the TransportRequest-->
                <xsl:if test="((Origin/TimeType != '')  )">
                <cbc:Description>
                    <xsl:value-of select="Origin/TimeType"/>
                </cbc:Description>
                </xsl:if>
                
                <!--_Origin-Empty-Container-Type-->
                <xsl:if test="((Origin/EmptyContainerType != '')  )">
                <cbc:Conditions>
                    <xsl:value-of select="Origin/EmptyContainerType"/>
                </cbc:Conditions>
                </xsl:if>
                
                <!--_Origin-Type-->
                <xsl:if test="((Origin/Type != '')  )">
                <cbc:LocationTypeCode>
                    <xsl:value-of select="Origin/Type"/>
                </cbc:LocationTypeCode>
                </xsl:if>
                
                <!--_Origin-Pickup-Time-->
                <!-- !!! what should be the start time and end time?-->
                <xsl:if test="((Origin/PickupOrDeliveryTime != '')  )">
                <cac:ValidityPeriod>
                    <xsl:variable name="originDateTime" select="Origin/PickupOrDeliveryTime"/>
                    <cbc:StartDate>
                        <xsl:value-of select="format-dateTime($originDateTime, '[Y0001]-[M01]-[D01]')"/>
                    </cbc:StartDate>
                    <cbc:StartTime>
                        <xsl:value-of select="format-dateTime($originDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                    </cbc:StartTime>
                    <cbc:EndDate><xsl:value-of select="format-dateTime($originDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EndDate>
                    <cbc:EndTime><xsl:value-of select="format-dateTime($originDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EndTime>

                </cac:ValidityPeriod>
                </xsl:if>


                <xsl:if test="((Origin/DoorStreet != '') or (Origin/DoorAddressee != '') or (Origin/DoorCity != '') or (Origin/DoorZipcode != '') or (Origin/DoorCountry != '') )">
                <cac:Address>

                    <!--_Origin-Door-Street-->
                    <xsl:if test="((Origin/DoorStreet != '')  )">
                    <cbc:StreetName>
                        <xsl:value-of select="Origin/DoorStreet"/>
                    </cbc:StreetName>
                    </xsl:if>

                    <!--_Origin-Door-Addressee-->
                    <xsl:if test="((Origin/DoorAddressee != '')  )">
                    <cbc:MarkAttention>
                        <xsl:value-of select="Origin/DoorAddressee"/>
                    </cbc:MarkAttention>
                    </xsl:if>

                    <!--_Origin-Door-City-->
                    <xsl:if test="( (Origin/DoorCity != '')  )">
                    <cbc:CityName>
                        <xsl:value-of select="Origin/DoorCity"/>
                    </cbc:CityName>
                    </xsl:if>

                    <!--_Origin-Door-Zipcode-->
                    <xsl:if test="( (Origin/DoorZipcode != '')  )">
                    <cbc:PostalZone>
                        <xsl:value-of select="Origin/DoorZipcode"/>
                    </cbc:PostalZone>
                    </xsl:if>

                    <!--_Origin-Door-Country-->
                    <xsl:if test="( (Origin/DoorCountry != '') )">
                    <cac:Country>
                        <cbc:Name><xsl:value-of select="Origin/DoorCountry"/></cbc:Name>
                    </cac:Country>
                    </xsl:if>


                </cac:Address>
                 </xsl:if>


                 <xsl:if test="((Origin/ContactName != '') or (Origin/ContactPhone != '') or (Origin/ContactEmail != '')  )">
                <cac:Contact>


                    <!--_Origin-Contact-Name-->
                    <xsl:if test="((Origin/ContactName != '')  )">
                    <cbc:Name>
                        <xsl:value-of select="Origin/ContactName"/>
                    </cbc:Name>
                    </xsl:if>

                    <!--_Origin-Contact-Telephone-->
                    <xsl:if test="((Origin/ContactPhone != '')  )">
                    <cbc:Telephone>
                        <xsl:value-of select="Origin/ContactPhone"/>
                    </cbc:Telephone>
                    </xsl:if>

                    <!--_Origin-Contact-Email-->
                    <xsl:if test="( (Origin/ContactEmail != '')  )">
                    <cbc:ElectronicMail>
                        <xsl:value-of select="Origin/ContactEmail"/>
                    </cbc:ElectronicMail>
                    </xsl:if>


                </cac:Contact>
                </xsl:if>


            </cac:FromLocation>
            <!-- END OF _ORIGIN-->

            <!-- DESTINATION-->
            <cac:ToLocation>

                <!--_Destination-Terminal-Code-->
                <xsl:if test="((Destination/TerminalCode != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Destination/TerminalCode"/>
                </cbc:ID>
                </xsl:if>

               <!--_Destination-Empty-Container-Type-->
                <xsl:if test="((Destination/EmptyContainerType != '')  )">
                <cbc:Conditions>
                    <xsl:value-of select="Destination/EmptyContainerType"/>
                </cbc:Conditions>
                </xsl:if>
                
                <!--_Destination-Type-->
                <xsl:if test="((Destination/Type != '')  )">
                <cbc:LocationTypeCode>
                    <xsl:value-of select="Destination/Type"/>
                </cbc:LocationTypeCode>
                </xsl:if>

                <!--_Destination-Delivery-Time-->
                <xsl:if test="((Destination/PickupOrDeliveryTime != '')  )">
                <cac:ValidityPeriod>
                    <xsl:variable name="destinationDateTime" select="Destination/PickupOrDeliveryTime"/>
                    <cbc:StartDate>
                        <xsl:value-of select="format-dateTime($destinationDateTime, '[Y0001]-[M01]-[D01]')"/>
                    </cbc:StartDate>
                    <cbc:StartTime>
                        <xsl:value-of select="format-dateTime($destinationDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                    </cbc:StartTime>

                    <cbc:EndDate><xsl:value-of select="format-dateTime($destinationDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EndDate>
                    <cbc:EndTime><xsl:value-of select="format-dateTime($destinationDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EndTime>

                </cac:ValidityPeriod>
                </xsl:if>
                
                <xsl:if test="((Destination/DoorStreet != '') or (Destination/DoorAddressee != '') or (Destination/DoorCity != '') or (Destination/DoorZipcode != '') or (Destination/DoorCountry != '') )">
                <cac:Address>

                    <!--_Destination-Door-Street-->
                    <xsl:if test="((Destination/DoorStreet != '')  )">
                    <cbc:StreetName>
                        <xsl:value-of select="Destination/DoorStreet"/>
                    </cbc:StreetName>
                    </xsl:if>

                    <!--_Destination-Door-Addressee-->
                    <xsl:if test="((Destination/DoorAddressee != '')  )">
                    <cbc:MarkAttention>
                        <xsl:value-of select="Destination/DoorAddressee"/>
                    </cbc:MarkAttention>
                    </xsl:if>

                    <!--_Destination-Door-City-->
                    <xsl:if test="( (Destination/DoorCity != '')  )">
                    <cbc:CityName>
                        <xsl:value-of select="Destination/DoorCity"/>
                    </cbc:CityName>
                    </xsl:if>

                    <!--_Destination-Door-Zipcode-->
                    <xsl:if test="( (Destination/DoorZipcode != '')  )">
                    <cbc:PostalZone>
                        <xsl:value-of select="Destination/DoorZipcode"/>
                    </cbc:PostalZone>
                    </xsl:if>

                    <!--_Destination-Door-Country-->
                    <xsl:if test="( (Destination/DoorCountry != '') )">
                    <cac:Country>
                        <cbc:Name><xsl:value-of select="Destination/DoorCountry"/></cbc:Name>
                    </cac:Country>
                    </xsl:if>


                </cac:Address>
                 </xsl:if>

                 <xsl:if test="((Destination/ContactName != '') or (Destination/ContactPhone != '') or (Destination/ContactEmail != '')  )">
                <cac:Contact>


                    <!--_Destination-Contact-Name-->
                    <xsl:if test="((Destination/ContactName != '')  )">
                    <cbc:Name>
                        <xsl:value-of select="Destination/ContactName"/>
                    </cbc:Name>
                    </xsl:if>

                    <!--_Destination-Contact-Telephone-->
                    <xsl:if test="((Destination/ContactPhone != '')  )">
                    <cbc:Telephone>
                        <xsl:value-of select="Destination/ContactPhone"/>
                    </cbc:Telephone>
                    </xsl:if>

                    <!--_Destination-Contact-Email-->
                    <xsl:if test="( (Destination/ContactEmail != '')  )">
                    <cbc:ElectronicMail>
                        <xsl:value-of select="Destination/ContactEmail"/>
                    </cbc:ElectronicMail>
                    </xsl:if>


                </cac:Contact>
                </xsl:if>

            </cac:ToLocation>
            <!-- END OF _DESTINATION-->


            <cac:TransportExecutionTerms>
                <!--EXTENSION ADDED 03.06.2018: _Selection-Of-Depot-Reuse-->
                <!-- !!! not in the example -->
                <xsl:if test="( (/TransportRequestType/Identification/SelectionOfDepotAndReuse != '')  )">
                <cbc:DepotSelectionCode>
                    <xsl:value-of select="/TransportRequestType/Identification/SelectionOfDepotAndReuse"/>
                </cbc:DepotSelectionCode>
                </xsl:if>
                
                <xsl:for-each select="/TransportRequestType/PriceDetail/PricePlan/PriceService/PriceLine">
                <xsl:variable name="currency" select="Currency"/>            
                <cac:PaymentTerms>
                    <!--_Plan-Number-->
                    <xsl:if test="( (../../PlanNumber != '')  )">
                    <cbc:ID>
                        <xsl:value-of select="../../PlanNumber"/>
                    </cbc:ID>
                    </xsl:if>
                    
                    
                    <xsl:if test="((../ServiceName != '') or (../Provider != '')   )">
                    <cac:TransportationService>
                        
                        <!--NB: THIS IS MANDATORY SO HAS TO BE INCLUDED WITH SOME VALUE-->
                        <cbc:TransportServiceCode>TransportServiceCode</cbc:TransportServiceCode>
                        
                        <xsl:if test="((../ServiceName != '')   )">
                        <!--_Service-Name-->
                        <cbc:Name>
                            <xsl:value-of select="../ServiceName"/>
                        </cbc:Name>
                        </xsl:if>
                        
                        <xsl:if test="( (../Provider != '')   )">
                        <!--_Provider-->
                        <cac:ResponsibleTransportServiceProviderParty>
                            <cac:PartyIdentification>
                                <cbc:ID>
                                    <xsl:value-of select="../Provider"/>
                                </cbc:ID>
                            </cac:PartyIdentification>
                        </cac:ResponsibleTransportServiceProviderParty>
                        </xsl:if>
                        
                    </cac:TransportationService>
                    </xsl:if>
                    
                    
                    <cac:DeliveryTerms>
                        <cac:AllowanceCharge>
                            
                            <cbc:ChargeIndicator>true </cbc:ChargeIndicator>
                            
                            <!--_Margin-->
                            <xsl:if test="( (Margin != '')   )">
                            <cbc:MultiplierFactorNumeric>
                                <xsl:value-of select="Margin"/>
                            </cbc:MultiplierFactorNumeric>
                             </xsl:if>
                             
                            <!--_Price (Currency is an attribute, not a separate element in UBL-->
                            <xsl:choose>
                                <xsl:when test="( (Price != '')   )">
                                    <cbc:Amount currencyID="{$currency}">
                                        <xsl:value-of select="Price"/>
                                    </cbc:Amount>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:comment>Amount is transformed from Price in Transport Request (which is mandatory) but there is no value present in the input Transport Request XML!</xsl:comment>
                                    <cbc:Amount currencyID="{$currency}">0</cbc:Amount>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <!--_Cost (Currency is an attribute, not a separate element in UBL-->
                            <xsl:if test="( (Cost != '')   )">
                            <cbc:BaseAmount currencyID="{$currency}">
                                <xsl:value-of select="Cost"/>
                            </cbc:BaseAmount>
                            </xsl:if>
                            
                            <!--_Cost-Code-->
                            <xsl:if test="( (CostCode != '')   )">
                            <cbc:AccountingCostCode>
                                <xsl:value-of select="CostCode"/>
                            </cbc:AccountingCostCode>
                            </xsl:if>
                            
                            
                            <!--_Unit-Price-->
                            <xsl:if test="( (UnitPrice != '')   )">
                            <cbc:PerUnitAmount currencyID="{$currency}">
                                <xsl:value-of select="UnitPrice"/>
                            </cbc:PerUnitAmount>
                            </xsl:if>
                            
                            <!--_Percentage-Value-->
                            <xsl:if test="( (PercentageValue != '')   )">
                            <cbc:Percent>
                                <xsl:value-of select="PercentageValue"/>
                            </cbc:Percent>
                            </xsl:if>
                            
                            <!--_Percentage-Base-Value-->
                            <xsl:if test="( (PercentageBaseValue != '')   )">
                            <cbc:BaseValueAmount currencyID="{$currency}"><xsl:value-of select="PercentageBaseValue"/></cbc:BaseValueAmount>
                            </xsl:if>
                            
                            <!-- _Percentage-Base-Cost-Code-->
                            <xsl:if test="( (PercentageBaseCostCode != '')   )">
                            <cbc:BaseCostID><xsl:value-of select="PercentageBaseCostCode"/></cbc:BaseCostID>
                            </xsl:if>
                            
                            <!--_Extra-Charges-->
                            <xsl:if test="( (ExtraCharges != '')   )">
                            <cbc:ExtraChargesIndicator>
                                <xsl:value-of select="ExtraCharges"/>
                            </cbc:ExtraChargesIndicator>
                            </xsl:if>
                            
                            
                        </cac:AllowanceCharge>
                        
                    </cac:DeliveryTerms>
                </cac:PaymentTerms>
                </xsl:for-each>
                
            </cac:TransportExecutionTerms>
            
            

            <!-- Consgnment-->
            <cac:Consignment>
                
                <cbc:ID>ID</cbc:ID>


                <!--_Carrier-Booking-->
                <xsl:if test="( (Carrier/CarrierBooking != '')   )">
                <cbc:CarrierAssignedID><xsl:value-of select="Carrier/CarrierBooking"/></cbc:CarrierAssignedID>
                </xsl:if>

                <!--EXTENSION ADDED 02.06.2018: _Carrier-Booking-Type-->
                <xsl:if test="( (Carrier/CarrierBookingType != '')   )">
                <cbc:CarrierBookingTypeCode><xsl:value-of select="Carrier/CarrierBookingType"/></cbc:CarrierBookingTypeCode>
                </xsl:if>


                <!--CARRIER-->
                <xsl:if test="( (Carrier/OceanSCACcode != '')   )">
                <cac:CarrierParty>

                    <!--Ocean-SCAC-code-->
                    <cac:PartyIdentification>
                        <cbc:ID><xsl:value-of select="Carrier/OceanSCACcode"/></cbc:ID>
                    </cac:PartyIdentification>

                </cac:CarrierParty>
                </xsl:if>

                <!--Forwarder-Reference-->
                <xsl:if test="( (Identification/ForwarderReference != '')   )">
                <cac:FreightForwarderParty>
                    <cac:PartyIdentification>
                        <cbc:ID>
                            <xsl:value-of select="Identification/ForwarderReference"/>
                        </cbc:ID>
                    </cac:PartyIdentification>
                </cac:FreightForwarderParty>
                </xsl:if>

                <cac:MainCarriageShipmentStage>

                    <xsl:if test="((Carrier/Voyage != '') or (Carrier/VesselIMO != '')  or (Carrier/VesselName != '')  )">
                    <cac:TransportMeans>

                        <!--_Voyage-->
                        <xsl:if test="((Carrier/Voyage != '')   )">
                        <cbc:JourneyID><xsl:value-of select="Carrier/Voyage"/></cbc:JourneyID>
                        </xsl:if>

                        <xsl:if test="( (Carrier/VesselIMO != '')  or (Carrier/VesselName != '')  )">
                        <cac:MaritimeTransport>

                            <!--_Vessel-IMO-->
                            <xsl:if test="( (Carrier/VesselIMO != '')    )">
                            <cbc:VesselID><xsl:value-of select="Carrier/VesselIMO"/></cbc:VesselID>
                            </xsl:if>
                            <!--_Vessel-Name-->
                            <xsl:if test="((Carrier/VesselName != '')  )">
                            <cbc:VesselName><xsl:value-of select="Carrier/VesselName"/></cbc:VesselName>
                            </xsl:if>
                        </cac:MaritimeTransport>
                        </xsl:if>
                    </cac:TransportMeans>
                    </xsl:if>

                    <xsl:if test="MultistopAndWeighing/OriginMultistop = 'true'">
                        <!--We use the PlannedWaypointTransportEvent structure to describe Multistop-->
                        <cac:PlannedWaypointTransportEvent>    
                            <cbc:TransportEventTypeCode>ORIGIN MULTISTOP</cbc:TransportEventTypeCode>
                            <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddressType != '')  or (MultistopAndWeighing/OriginMultistopAddress != '')  )">
                            <cac:Location>
                                <cac:Address>
                                    <!--Origin-Multistop-Address-Type-->
                                    <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddressType != '')   )">
                                    <cbc:AddressTypeCode>
                                        <xsl:value-of select="MultistopAndWeighing/OriginMultistopAddressType"/>
                                    </cbc:AddressTypeCode>
                                    </xsl:if>
                                    <!--Origin-Multistop-Address-->
                                    <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddress != '')   )">
                                    <cac:AddressLine>
                                        <cbc:Line>
                                            <xsl:value-of select="MultistopAndWeighing/OriginMultistopAddress"/>
                                        </cbc:Line>
                                    </cac:AddressLine>
                                    </xsl:if>
                                </cac:Address>
                            </cac:Location>
                            </xsl:if>    
                        </cac:PlannedWaypointTransportEvent>
                    </xsl:if>

                    <xsl:if test="MultistopAndWeighing/DestinationMultistop = 'true'">
                        <!--We use the PlannedWaypointTransportEvent structure to describe multistop-->
                        <cac:PlannedWaypointTransportEvent>                        
                            <cbc:TransportEventTypeCode>DESTINATION MULTISTOP</cbc:TransportEventTypeCode>
                            <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddressType != '')  or (MultistopAndWeighing/DestinationMultistopAddress != '')  )">
                            <cac:Location>
                                <cac:Address>
                                    <!--Destination-Multistop-Address-Type-->
                                    <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddressType != '')   )">
                                    <cbc:AddressTypeCode>
                                        <xsl:value-of select="MultistopAndWeighing/DestinationMultistopAddressType"/>
                                    </cbc:AddressTypeCode>
                                    </xsl:if>
                                    
                                    <!--Destination-Multistop-Address-->
                                    <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddress != '')   )">
                                    <cac:AddressLine>
                                        <cbc:Line>
                                            <xsl:value-of select="MultistopAndWeighing/DestinationMultistopAddress"/>
                                        </cbc:Line>
                                    </cac:AddressLine>
                                    </xsl:if>
                                </cac:Address>
                            </cac:Location>
                            </xsl:if>
                            
                        </cac:PlannedWaypointTransportEvent>
                    </xsl:if>

                    <xsl:if test="( (InlandTerminal/InlandTerminalCode != '')  or (InlandTerminal/TerminalArrivalTime != '')  )">
                    <cac:TransportEvent>
                    
                        <xsl:if test="( (InlandTerminal/InlandTerminalCode != '')  )">
                        <cac:Location>

                            <!--_Inland-Terminal-Code-->
                            <cbc:ID><xsl:value-of select="InlandTerminal/InlandTerminalCode"/></cbc:ID>

                            <!--Code that specifies that this is INLAND TERMINAL-->
                            <cbc:LocationTypeCode>INLAND TERMINAL</cbc:LocationTypeCode>

                        </cac:Location>
                        </xsl:if>

                        <!--_Terminal-Arrival-Time-->
                        <xsl:if test="(  (InlandTerminal/TerminalArrivalTime != '')  )">
                        <cac:Period>
                            <xsl:variable name="terminalArrivalDateTime" select="InlandTerminal/TerminalArrivalTime"/>
                            <cbc:StartDate>
                                <xsl:value-of select="format-dateTime($terminalArrivalDateTime, '[Y0001]-[M01]-[D01]')"/>
                            </cbc:StartDate>
                            <cbc:StartTime>
                                <xsl:value-of select="format-dateTime($terminalArrivalDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                            </cbc:StartTime>
                            
                        </cac:Period>
                        </xsl:if>
                    </cac:TransportEvent>
                    </xsl:if>


                    <!--ORIGIN DEPOT-->
                    
                    <xsl:if test="( (Depot/OriginDepotUsageType != '')  or (Depot/OriginDepotCode != '') or (Depot/OriginDepotReference != '') or (Depot/OriginDepotTime != '')  )">
                        <cac:TransportEvent>
                            <!--Code that specifies that this is an ORIGIN DEPOT-->
                            <cbc:TransportEventTypeCode>ORIGIN DEPOT</cbc:TransportEventTypeCode>
                            
                            <!--_Origin-Depot-Usage-Type-->
                            <xsl:if test="( (Depot/OriginDepotUsageType != '')   )">
                            <cbc:Description><xsl:value-of select="Depot/OriginDepotUsageType"/></cbc:Description>
                            </xsl:if>
                            
                            <xsl:if test="(  (Depot/OriginDepotCode != '')   )">
                            <cac:Location>  
                                <!--_Origin-Depot-Code-->
                                <cbc:ID> <xsl:value-of select="Depot/OriginDepotCode"/></cbc:ID>                                
                            </cac:Location>
                            </xsl:if>
                            
                            <!--Origin-Depot-Reference-->
                            <xsl:if test="( (Depot/OriginDepotReference != '')  )">
                            <cac:Signature>
                                <cbc:ID><xsl:value-of select="Depot/OriginDepotReference"/></cbc:ID>
                            </cac:Signature>
                            </xsl:if>
                            
                            <!--_Origin-Depot-Time-->
                            <xsl:if test="(  (Depot/OriginDepotTime != '')  )">
                            <cac:Period>
                                <xsl:variable name="originDepotDateTime" select="Depot/OriginDepotTime"/>
                                <cbc:StartDate>
                                    <xsl:value-of select="format-dateTime($originDepotDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:StartDate>
                                <cbc:StartTime>
                                    <xsl:value-of select="format-dateTime($originDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:StartTime>
                            </cac:Period>
                            </xsl:if>
                        </cac:TransportEvent>
                    </xsl:if>                    

                    <!--DESTINATION DEPOT-->
                    <xsl:if test="( (Depot/DestinationDepotUsageType != '')  or (Depot/DestinationDepotCode != '') or (Depot/DestinationDepotReference != '') or (Depot/DestinationDepotTime != '')  )">
                        <cac:TransportEvent>
                            <!--Code that specifies that this is an DESTINATION DEPOT-->
                            <cbc:TransportEventTypeCode>DESTINATION DEPOT</cbc:TransportEventTypeCode>

                            <!--_Destination-Depot-Usage-Type-->
                            <xsl:if test="( (Depot/DestinationDepotUsageType != '')   )">
                            <cbc:Description><xsl:value-of select="Depot/DestinationDepotUsageType"/></cbc:Description>
                            </xsl:if>
                            
                            <xsl:if test="(  (Depot/DestinationDepotCode != '')   )">
                            <cac:Location>  
                                <!--_Destination-Depot-Code-->
                                <cbc:ID> <xsl:value-of select="Depot/DestinationDepotCode"/></cbc:ID>                                
                            </cac:Location>
                            </xsl:if>
                            
                            <!--Destination-Depot-Reference-->
                            <xsl:if test="( (Depot/DestinationDepotReference != '')  )">
                            <cac:Signature>
                                <cbc:ID><xsl:value-of select="Depot/DestinationDepotReference"/></cbc:ID>
                            </cac:Signature>
                            </xsl:if>


                            <!--_Destination-Depot-Time-->
                            <xsl:if test="(  (Depot/DestinationDepotTime != '')  )">
                            <cac:Period>
                                <xsl:variable name="destinationDepotDateTime" select="Depot/DestinationDepotTime"/>
                                <cbc:StartDate>
                                    <xsl:value-of select="format-dateTime($destinationDepotDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:StartDate>
                                <cbc:StartTime>
                                    <xsl:value-of select="format-dateTime($destinationDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:StartTime>
                            </cac:Period>
                            </xsl:if>
                        </cac:TransportEvent>
                    </xsl:if>                    

                </cac:MainCarriageShipmentStage>

                <!--TRANSPORTHANDLINGUNIT ELEMENTS FOR EACH CONTAINER -->
                <xsl:for-each select="ContainerAndGoodsDetails/Container">

                    <cac:TransportHandlingUnit>
                        
                        <!--Marks-And-Numbers (under GOODS PLACEMENT TYPE)-->
                        <cbc:ShippingMarks>ShippingMarks11</cbc:ShippingMarks>
                        
                        <cac:TransportEquipment>
                            
                            <!--_Container-Number-->
                            <xsl:if test="(  Number != ''  )">
                            <cbc:ID><xsl:value-of select="Number"/></cbc:ID>
                            </xsl:if>
                            
                            <!--_Container : CONTAINER TYPE-->
                            <!--Container-Type-->
                            <xsl:if test="(  ContainerType != ''  )">
                            <cbc:TransportEquipmentTypeCode>
                                <xsl:value-of select="ContainerType"/>
                            </cbc:TransportEquipmentTypeCode>
                            </xsl:if>
                            
                            <!--Temperature-Range-Type-->
                            <xsl:if test="(  (TemperatureRangeType != '')  )">
                            <cbc:RefrigeratedIndicator><xsl:value-of select="TemperatureRangeType"/></cbc:RefrigeratedIndicator>
                            </xsl:if>
                            
                            <!--Weight-->
                            <xsl:if test="(  Weight != ''  )">
                            <cbc:GrossWeightMeasure unitCode="unitCode2479">
                                <xsl:value-of select="Weight"/>
                            </cbc:GrossWeightMeasure>
                            </xsl:if>
                            
                            <!--Volume-->
                            <xsl:if test="(  (Volume != '')  )">
                            <cbc:GrossVolumeMeasure unitCode="unitCode2480">
                                <xsl:value-of select="Volume"/>
                            </cbc:GrossVolumeMeasure>
                            </xsl:if>
                            
                            <cbc:TraceID>TraceID72</cbc:TraceID>
                            
                            <!--EXTENSION ADDED 04.06.2018: _Oversized-->
                            <xsl:if test="(  (Oversized != '')  )">
                            <cbc:OversizedIndicator><xsl:value-of select="Oversized"/></cbc:OversizedIndicator>
                            </xsl:if>
                            
                            <!--EXTENSION ADDED 04.06.2018: _Carrier-Booking-->
                            <xsl:if test="(  (CarrierEquipment != '')  )">
                            <cbc:CarrierAssignedID><xsl:value-of select="CarrierEquipment"/></cbc:CarrierAssignedID>
                            </xsl:if>
                            
                             <xsl:if test="(  (Length != '')  )">
                            <cac:MeasurementDimension>
                                
                                <!--Dimension-Length-->
                                <cbc:AttributeID>Length</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Length"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <!--Dimension-Height-->
                            <xsl:if test="(  (Height != '')  )">
                            <cac:MeasurementDimension>
                                <cbc:AttributeID>Height</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Height"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <!--Dimension-Width-->
                            <xsl:if test="(  (Width != '')  )">
                            <cac:MeasurementDimension>
                                <cbc:AttributeID>Width</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Width"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <xsl:if test="(  (SealShipper != '')  )">
                            <cac:TransportEquipmentSeal>
                                
                                <!-- _Seal-Shipper-->
                                <cbc:ID><xsl:value-of select="SealShipper"/></cbc:ID>
                                
                            </cac:TransportEquipmentSeal>
                            </xsl:if>
                            
                            <!--Temperature-Range-From-->
                            <xsl:if test="(  (TemperatureRangeFrom != '')  )">
                            <cac:MinimumTemperature>
                                <cbc:AttributeID>Temperature</cbc:AttributeID>
                                <cbc:Measure unitCode="CEL"><xsl:value-of select="TemperatureRangeFrom"/></cbc:Measure>
                            </cac:MinimumTemperature>
                            </xsl:if>
                            
                            <!--Temperature-Range-To-->
                            <xsl:if test="(  (TemperatureRangeTo != '')  )">
                            <cac:MaximumTemperature>
                                <cbc:AttributeID>Temperature</cbc:AttributeID>
                                <cbc:Measure unitCode="CEL"><xsl:value-of select="TemperatureRangeTo"/></cbc:Measure>
                            </cac:MaximumTemperature>
                            </xsl:if>
                            
                            
                            <xsl:if test="(  (CustomerDeliveryRef != '')  )">
                            <cac:DeliveryTransportEvent>
                                
                                <!--Customer-Delivery-Ref-->
                                <cac:Contact>
                                    <cbc:ID><xsl:value-of select="CustomerDeliveryRef"/></cbc:ID>
                                </cac:Contact>
                            </cac:DeliveryTransportEvent>
                            </xsl:if>
                            
                            <xsl:if test="(  (CustomerLoadRef != '')  )">
                            <cac:LoadingTransportEvent>
                                
                                <!--_Customer-Load-Ref-->
                                <cac:Contact>
                                    <cbc:ID><xsl:value-of select="CustomerLoadRef"/></cbc:ID>
                                </cac:Contact>
                                
                            </cac:LoadingTransportEvent>
                            </xsl:if>
                            
                            <!--Origin-Multistop-Address-->
                            <xsl:if test="OriginMultistopAddress">
                            <cac:TransportEvent>
                                
                                <!--Need to add ORIGIN-MULTISTOP to codelist-->
                                <cbc:TransportEventTypeCode>ORIGIN-MULTISTOP</cbc:TransportEventTypeCode>
                                <cac:Location>
                                    <cac:Address>
                                        <cac:AddressLine>
                                            <cbc:Line><xsl:value-of select="OriginMultistopAddress"/></cbc:Line>
                                        </cac:AddressLine>
                                    </cac:Address>
                                </cac:Location>
                            </cac:TransportEvent>
                            </xsl:if>
                            
                            <!--Destination-Multistop-Address-->
                            <xsl:if test="DestinationMultistopAddress">
                            <cac:TransportEvent>
                                <!-- Need to add DESTINATION-MULTISTOP to codelist-->
                                <cbc:TransportEventTypeCode>DESTINATION-MULTISTOP</cbc:TransportEventTypeCode>
                                <cac:Location>
                                    <cac:Address>
                                        <cac:AddressLine>
                                            <cbc:Line><xsl:value-of select="DestinationMultistopAddress"/></cbc:Line>
                                        </cac:AddressLine>
                                    </cac:Address>
                                </cac:Location>
                            </cac:TransportEvent>
                            </xsl:if>
                            
                            <!--APPLICABLETRANSPORTMEANS CONNECTS THE TRANSPORT EQUIPMENT (CONTAINER) WITH THE APPROPRIATE TRANSPORTMEANS (CARRIER)-->
                            <xsl:if test="((../../Carrier/Voyage != '') or (../../Carrier/VesselIMO != '')  or (../../Carrier/VesselName != '')  )">
                            <cac:ApplicableTransportMeans>
                                
                                <!--SHOULD BE SAME JOURNEYID AS ONE OF THE JOURNEYIDÂ´S FROM THE MAINCARRIAGESHIPMENTSTAGE ELEMENT-->
                                <xsl:if test="((../../Carrier/Voyage != '')   )">
                                <cbc:JourneyID><xsl:value-of select="../../Carrier/Voyage"/></cbc:JourneyID>
                                </xsl:if>
                                
                                <xsl:if test="( (../../Carrier/VesselIMO != '')  or (../../Carrier/VesselName != '')  )">
                                <cac:MaritimeTransport>
                                    <!--_Vessel-IMO-->
                                    <xsl:if test="( (../../Carrier/VesselIMO != '')    )">
                                    <cbc:VesselID><xsl:value-of select="../../Carrier/VesselIMO"/></cbc:VesselID>
                                    </xsl:if>
                                    <!--_Vessel-Name-->
                                    <xsl:if test="((../../Carrier/VesselName != '')  )">
                                    <cbc:VesselName><xsl:value-of select="../../Carrier/VesselName"/></cbc:VesselName>
                                    </xsl:if>
                                </cac:MaritimeTransport>
                                </xsl:if>
                                
                                
                            </cac:ApplicableTransportMeans>
                             </xsl:if>
                            
                            
                            <xsl:if test="((DestinationDepotReference != '') or (../../Destination/PickupOrDeliveryTime != '')  or (PIN != '') or (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                            <cac:Delivery>
                                
                                <!--Destination-Depot-Reference-->
                                <xsl:if test="((DestinationDepotReference != '') )">
                                <cbc:ID><xsl:value-of select="DestinationDepotReference"/></cbc:ID>
                                </xsl:if>
                                
                                <xsl:if test="( (../../Destination/PickupOrDeliveryTime != ''))"/>  
                                <xsl:variable name="latestDeliveryDateTime" select="../../Destination/PickupOrDeliveryTime"/>
                                <!--Delivery-Time-->
                                <xsl:if test="((DestinationDepotReference != '') or (../../Destination/PickupOrDeliveryTime != '')  or (PIN != '') or (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                                <cbc:LatestDeliveryDate><xsl:value-of select="format-dateTime($latestDeliveryDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:LatestDeliveryDate>
                                <cbc:LatestDeliveryTime><xsl:value-of select="format-dateTime($latestDeliveryDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:LatestDeliveryTime>
                                </xsl:if>
                                
                                <!--PIN-->
                                <xsl:if test="( (PIN != '')  )">
                                <cbc:ReleaseID><xsl:value-of select="PIN"/></cbc:ReleaseID>
                                </xsl:if>
                                
                                <xsl:if test="( (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                                <cac:DeliveryLocation>
                                    <!--Destination-Depot-Code-->
                                    <xsl:if test="( (DestinationDepotCode != '')  )">
                                    <cbc:ID><xsl:value-of select="DestinationDepotCode"/></cbc:ID>
                                    </xsl:if>
                                    
                                    <!--Destination-Depot-Time-->
                                    <xsl:if test="(  (DestinationDepotTime != '') )">
                                    <cac:ValidityPeriod>
                                        <xsl:variable name="destinationDepotDateTime" select="DestinationDepotTime"/>
                                        <cbc:StartDate><xsl:value-of select="format-dateTime($destinationDepotDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                                        <cbc:StartTime><xsl:value-of select="format-dateTime($destinationDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                                    </cac:ValidityPeriod>
                                    </xsl:if>
                                    
                                </cac:DeliveryLocation>
                                </xsl:if>
                            </cac:Delivery>
                            </xsl:if>
                            
                            <xsl:if test="((OriginDepotReference != '') or (../../Origin/PickupOrDeliveryTime != '')  or (PIN != '') or (OriginDepotCode != '') or (OriginDepotTime != '') )">
                            <cac:Pickup>
                                
                                
                                <!--Origin-Depot-Reference-->
                                <xsl:if test="((OriginDepotReference != '')  )">
                                <cbc:ID><xsl:value-of select="OriginDepotReference"/></cbc:ID>
                                </xsl:if>
                                
                                
                                <xsl:if test="( (../../Origin/PickupOrDeliveryTime != '')   )">
                                <xsl:variable name="pickupDateTime" select="../../Origin/PickupOrDeliveryTime"/>
                                
                                <!--Pickup-Time-->
                                <cbc:EarliestPickupDate><xsl:value-of select="format-dateTime($pickupDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EarliestPickupDate>
                                <cbc:EarliestPickupTime><xsl:value-of select="format-dateTime($pickupDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EarliestPickupTime>
                                </xsl:if>
                                
                                
                                <xsl:if test="( (OriginDepotCode != '') or (OriginDepotTime != '') )">
                                <cac:PickupLocation>
                                    
                                    <xsl:if test="((OriginDepotCode != '')  )">
                                    <!--Origin-Depot-Code-->
                                    <cbc:ID><xsl:value-of select="OriginDepotCode"/></cbc:ID>
                                    </xsl:if>
                                    
                                    <xsl:if test="( (OriginDepotTime != '') )">
                                    <!--Origin-Depot-Time-->
                                    <cac:ValidityPeriod>
                                        <xsl:variable name="originDepotDateTime" select="OriginDepotTime"/>
                                        <cbc:StartDate><xsl:value-of select="format-dateTime($originDepotDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                                        <cbc:StartTime><xsl:value-of select="format-dateTime($originDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                                        
                                    </cac:ValidityPeriod>
                                    </xsl:if>
                                    
                                </cac:PickupLocation>
                                </xsl:if>
                                
                            </cac:Pickup>
                            </xsl:if>
                            
                            
                        </cac:TransportEquipment>
                        
                    </cac:TransportHandlingUnit>

                </xsl:for-each>


                <xsl:for-each select="ContainerAndGoodsDetails/GoodsItem">
                <cac:TransportHandlingUnit>
 

                    <!--Marks-And-Numbers (GoodsItem)-->
                    <xsl:if test="( (MarksAndNumbers != '') )">
                    <cbc:ShippingMarks><xsl:value-of select="MarksAndNumbers"/></cbc:ShippingMarks>
                    </xsl:if>

                    <cac:GoodsItem>

                        <!--GID-nr-->
                        <xsl:if test="( (GID-nr != '') )">
                        <cbc:ID><xsl:value-of select="GID-nr"/></cbc:ID>
                        </xsl:if>

                        <!--Goods-Description-->
                        <xsl:if test="( (GoodsDescription != '') )">
                        <cbc:Description><xsl:value-of select="GoodsDescription"/></cbc:Description>
                        </xsl:if>

                        <!--DG-->
                        <xsl:if test="( (DG != '') )">
                        <cbc:HazardousRiskIndicator>
                            <xsl:value-of select="DG"/>
                        </cbc:HazardousRiskIndicator>
                        </xsl:if>

                        <xsl:if test="( (DGUNDG != '') or (DGIMO != '') or (DGMSDS != '') or (Commodity != '') or (HSCodes != ''))">
                        <cac:Item>
                            <xsl:if test="( (HSCodes != '') or (Commodity != ''))">
                            <cac:CommodityClassification>

                                <!--HS-Codes-->
                                <xsl:if test="( (HSCodes != '')  )">
                                <cbc:NatureCode><xsl:value-of select="HSCodes"/></cbc:NatureCode>
                                </xsl:if>

                                <!--Goods-Item : GOODS ITEM TYPE-->
                                <!--Commodity-->
                                <xsl:if test="( (Commodity != '') )">
                                <cbc:CommodityCode><xsl:value-of select="Commodity"/></cbc:CommodityCode>
                                </xsl:if>
                            </cac:CommodityClassification>
                            </xsl:if>

                            

                                <!--DG-UNDG-->
                                <xsl:for-each select="DGUNDG">
                               	<cac:HazardousItem>
                                <cbc:UNDGCode><xsl:value-of select="."/></cbc:UNDGCode>
                                </cac:HazardousItem>
                                </xsl:for-each>
                                    
                                <!--DG-IMO-->
                                <xsl:for-each select="DGIMO">
                                <cac:HazardousItem>
                                <cbc:HazardClassID><xsl:value-of select="."/></cbc:HazardClassID>
                                </cac:HazardousItem>
                                </xsl:for-each>
                                
                                
                                <xsl:for-each select="DGMSDS">
                                <cac:HazardousItem>
                                <!--EXTENSION ADDED 04.06.2018: _DG-MSDS-->
                                <cac:HazardousItemDocumentReference>
                                    <!--ID is mandatory in Document Reference, hence some identifier must be added even if this is not included in the Transport Request
                            Alternatively, we could add the filename in the ID tag and omit the <cac:Attachment> tag which is optional-->
                                    <!-- !!! so far Im adding both-->
                                    <cbc:ID><xsl:value-of select="."/></cbc:ID>

                                    <!--_DG-MSDS-->
                                    <cac:Attachment>
                                        <cbc:EmbeddedDocumentBinaryObject mimeCode=""><xsl:value-of select="."/></cbc:EmbeddedDocumentBinaryObject>
                                    </cac:Attachment>

                                </cac:HazardousItemDocumentReference>
                                </cac:HazardousItem>
                                </xsl:for-each>

                            
                            
                        </cac:Item>
                        </xsl:if>

                        <!--REFERS TO THE TRANSPORTEQUIPMENT (CONTAINER) CONTAINING THIS GOODS ITEM AND MUST REFER TO ONE OF THE TRANSPORTEQUIPMENTS LISTED IN THIS XML MESSAGE-->
                        <xsl:if test="( (GoodsPlacement/ContainerNumber != '') )">
                        <cac:GoodsItemContainer>
                            <cbc:ID>
                                <xsl:value-of select="GoodsPlacement/ContainerNumber"/>
                            </cbc:ID>
                        </cac:GoodsItemContainer>
                         </xsl:if>

                        <xsl:if test="( (GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage != '') or (GoodsPlacement/GoodsPackage/PackageType != ''))">
                        <cac:ContainingPackage>

                            <!--Number-And-Type-Of-Package-->
                            <xsl:if test="( (GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage != '') )">
                            <cbc:Quantity><xsl:value-of select="GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage"/></cbc:Quantity>
                            </xsl:if>

                            <!--Goods-Package : GOODS PACKAGE TYPE-->
                            <xsl:if test="(  (GoodsPlacement/GoodsPackage/PackageType != ''))">
                            <cbc:PackagingTypeCode>
                                <xsl:value-of select="GoodsPlacement/GoodsPackage/PackageType"/>
                            </cbc:PackagingTypeCode>
                            </xsl:if>

                        </cac:ContainingPackage>
                        </xsl:if>
                        
                    </cac:GoodsItem>

                </cac:TransportHandlingUnit>
                </xsl:for-each>

                <xsl:if test="( (Carrier/OriginPort != '') or (Carrier/ETD != ''))">
                <cac:FirstArrivalPortLocation>
                    <!-- _Origin-Port-->
                    <xsl:if test="( (Carrier/OriginPort != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/OriginPort"/></cbc:ID>
                    </xsl:if>

                    <!--ETD-->
                    <xsl:if test="(  (Carrier/ETD != ''))">
                    <xsl:variable name="etdDateTime" select="Carrier/ETD"/>
                                        
                    <cac:ValidityPeriod>
                        <cbc:StartDate><xsl:value-of select="format-dateTime($etdDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                        <cbc:StartTime><xsl:value-of select="format-dateTime($etdDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                    </cac:ValidityPeriod>
                    </xsl:if>

                </cac:FirstArrivalPortLocation>
                </xsl:if>

                <xsl:if test="( (Carrier/DestinationPort != '') or (Carrier/ETA != ''))">
                <cac:LastExitPortLocation>
                    <!--_Destination-Port-->
                    <xsl:if test="( (Carrier/DestinationPort != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/DestinationPort"/></cbc:ID>
                    </xsl:if>

                    <!--ETA-->
                    <xsl:if test="(  (Carrier/ETA != ''))">
                    <xsl:variable name="etaDateTime" select="Carrier/ETA"/>
                    <cac:ValidityPeriod>
                        <cbc:StartDate><xsl:value-of select="format-dateTime($etaDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                        <cbc:StartTime><xsl:value-of select="format-dateTime($etaDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                    </cac:ValidityPeriod>
                    </xsl:if>
                </cac:LastExitPortLocation>
                </xsl:if>

                <!--EXTENSION ADDED 04.06.2018: _Bill-Of-Lading-->
                <xsl:if test="( (Carrier/BillOfLanding != '') or (Carrier/BillOfLadingDate != ''))">
                <cac:BillOfLadingDocumentReference>
                    <xsl:if test="( (Carrier/BillOfLanding != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/BillOfLanding"/></cbc:ID>
                    </xsl:if>
                    
                    <!--_B/L date-->
                    <xsl:if test="(  (Carrier/BillOfLadingDate != ''))">
                    <xsl:variable name="billOfLandingDateTime" select="Carrier/BillOfLadingDate"/>
                    <cbc:IssueDate><xsl:value-of select="format-dateTime($billOfLandingDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:IssueDate>
                    </xsl:if>
                </cac:BillOfLadingDocumentReference>
                </xsl:if>
                

            </cac:Consignment>

        </ns2:TransportExecutionPlan>

        </xsl:if>


        <!--_If PB-->
        <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'PB') )">
         <ns3:TransportExecutionPlanRequest xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlan-2 ../UBL-2.2/xsd/maindoc/UBL-TransportExecutionPlanRequest-2.2.xsd"
            xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDataTypes-2"
            xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
            xmlns:xades="http://uri.etsi.org/01903/v1.3.2#"
            xmlns:udt="urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
            xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
            xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
            xmlns:dsig11="http://www.w3.org/2009/xmldsig11#"
            xmlns:ns0="urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2"
            xmlns:ns3="urn:oasis:names:specification:ubl:schema:xsd:TransportExecutionPlanRequest-2"
            xmlns:ns1="http://uri.etsi.org/01903/v1.4.1#" xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
            xmlns:ccts="urn:un:unece:uncefact:documentation:2"
            xmlns:sac="urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2"
            xmlns:sbc="urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2"
            xmlns:cct="urn:un:unece:uncefact:data:specification:CoreComponentTypeSchemaModule:2">

            <cbc:UBLVersionID>2.2</cbc:UBLVersionID>
            <cbc:CustomizationID>Common Framework</cbc:CustomizationID>

            <!--_Message-Type-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType != '') )">
            <cbc:ProfileID>
                <xsl:value-of select="MessageIdentification/MessageType"/>
            </cbc:ProfileID>
             </xsl:if>

            <!--_Booking-Number-->
            <xsl:if test="((/TransportRequestType/Identification/BookingNumber != '') )">
            <cbc:ID>
                <xsl:value-of select="Identification/BookingNumber"/>
            </cbc:ID>
            </xsl:if>

            <!--_Message-Identifier-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageIdentifier != '') )">
            <cbc:UUID>
                <xsl:value-of select="MessageIdentification/MessageIdentifier"/>
            </cbc:UUID>
			      </xsl:if>

            <!--_Message-DateTime-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageDateTime != '') )">
            <xsl:variable name="messageDateTime" select="MessageIdentification/MessageDateTime"/>
            <cbc:IssueDate>
                <xsl:value-of select="format-dateTime($messageDateTime, '[Y0001]-[M01]-[D01]')"/>
            </cbc:IssueDate>
            <cbc:IssueTime>
                <xsl:value-of select="format-dateTime($messageDateTime, '[H01]:[m01]:[s01].[f001]')"
                />
            </cbc:IssueTime>
            </xsl:if>

            <!--_Booking-Status-->
            <!-- !!!!Could not find on CBF example-->
            <xsl:if test="((/TransportRequestType/Identification/BookingStatus != '') )">
            <cbc:DocumentStatusCode>
                <xsl:value-of select="Identification/BookingStatus"/>
            </cbc:DocumentStatusCode>
            </xsl:if>

            <!--Not relevant in a CB or PB-->
            <!--_Auto-Rejection-Comments OR Manual-Rejection-Comments-->
<!--            <xsl:for-each select="Feedback/AutoRejectionComments[. != '']">
                <cbc:DocumentStatusReasonDescription>
                    <xsl:value-of select="."/>
                </cbc:DocumentStatusReasonDescription>
            </xsl:for-each>
            <xsl:for-each select="Feedback/ManualRejectionComments[. != '']">
                <cbc:DocumentStatusReasonDescription>
                    <xsl:value-of select="."/>
                </cbc:DocumentStatusReasonDescription>
            </xsl:for-each>-->

            <!--Action-->
            <xsl:if test="((/TransportRequestType/Action != '') )">
            <cbc:ActionCode>
                <xsl:value-of select="Action"/>
            </cbc:ActionCode>
			</xsl:if>

            <!--    Issueing-Party-->
            <xsl:if test="((/TransportRequestType/Identification/IssuingParty != '') or (/TransportRequestType/Identification/OperationsContact != ''))">
            <cac:SenderParty>
            	<xsl:if test="(/TransportRequestType/Identification/IssuingParty!= '')">
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/IssuingParty"/>
                    </cbc:ID>
                </cac:PartyIdentification>
				</xsl:if>
                <!-- Operations-Contact-->
                <xsl:if test="(/TransportRequestType/Identification/OperationsContact!= '')">
                <cac:Contact>
                    <cbc:ID>
                        <xsl:value-of
                            select="/TransportRequestType/Identification/OperationsContact"/>
                    </cbc:ID>
                </cac:Contact>
                </xsl:if>
            </cac:SenderParty>
			</xsl:if>


            <!--_Customer-->
            <!--_If PB-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'PB') )">
            <cac:TransportUserParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/ForwarderSending"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportUserParty>
             </xsl:if>
            
            
            <!--_If CBF-->
<!--            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'CBF') )">
            <cac:TransportUserParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="/TransportRequestType/Identification/Customer"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportUserParty>
             </xsl:if>-->

            <!--_Provider-->
            <!--_If PB-->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'PB') )">
            <cac:TransportServiceProviderParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="Identification/Provider"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportServiceProviderParty>
            </xsl:if>

<!--            <!-\-_If CBF-\->
            <xsl:if test="((/TransportRequestType/MessageIdentification/MessageType = 'CBF') )">
            <cac:TransportServiceProviderParty>
                <cac:PartyIdentification>
                    <cbc:ID>
                        <xsl:value-of select="Identification/ForwarderReceiving"/>
                    </cbc:ID>
                </cac:PartyIdentification>
            </cac:TransportServiceProviderParty>
            </xsl:if>-->


            <!--_Service-Reference-->
            <xsl:if test="(Contract/ServiceReference!= '')">
            <cac:TransportServiceDescriptionDocumentReference>
                <cbc:ID>
                    <xsl:value-of select="Contract/ServiceReference"/>
                </cbc:ID>
            </cac:TransportServiceDescriptionDocumentReference>
			</xsl:if>

            <!--_Quotation-->
            <xsl:if test="((/TransportRequestType/Identification/Quotation != '') or (/TransportRequestType/Offer/Quotation != ''))">
            <cac:AdditionalDocumentReference>
            	<xsl:if test="((/TransportRequestType/Identification/Quotation != '') )">
                <cbc:ID>
                    <xsl:value-of select="Identification/Quotation"/>
                </cbc:ID>
                </xsl:if>

                <!--Ref DocumentTypeCode codelist-->
                <!-- !!! where do I get this one from-->
                <xsl:if test="( (/TransportRequestType/Offer/Quotation != ''))">
                <cbc:DocumentTypeCode>Offer/Quotation</cbc:DocumentTypeCode>
                </xsl:if>
            </cac:AdditionalDocumentReference>
            </xsl:if>

            <!--_Customs-Handling-Type-->
            <xsl:if test="((Customs/CustomsHandlingDocRef != '') or (Customs/CustomsHandlingType != '') or (Customs/CustomsHandlingDocument != '') )">
            <cac:AdditionalDocumentReference>

                <!--_Customs-Handling-Doc-Ref-->
                <xsl:if test="((/TransportRequestType/Customs/CustomsHandlingDocRef != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Customs/CustomsHandlingDocRef"/>
                </cbc:ID>
                </xsl:if>

                <!--_Customs-Handling-Type-->
                <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingType != '')  )">
                <cbc:DocumentTypeCode>
                    <xsl:value-of select="Customs/CustomsHandlingType"/>
                </cbc:DocumentTypeCode>
                </xsl:if>

                <!--_Customs-Handling-Document-->
                <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingDocument != '') )">
                <cac:Attachment>
                    <cbc:EmbeddedDocumentBinaryObject mimeCode="">
                        <xsl:value-of select="Customs/CustomsHandlingDocument"/>
                    </cbc:EmbeddedDocumentBinaryObject>
                </cac:Attachment>
                </xsl:if>
            </cac:AdditionalDocumentReference>
            </xsl:if>

            <!-- !!! should we just have the string as the ID and ignore the other fields?-->
            <!--_TR-Attachment-->
            <xsl:for-each select="Attachment/TR-Attachment">
                <cac:AdditionalDocumentReference>
    
                    <!--ID IS MANDATORY, SO SUCH ADD "TR-Attachment" AS A FIXED VALUE-->
                    <cbc:ID>TR-Attachment</cbc:ID>
                    <xsl:if test="( (/TransportRequestType/Customs/CustomsHandlingDocument != '') )">
                    <cac:Attachment>
                        <cbc:EmbeddedDocumentBinaryObject mimeCode="">
                            <xsl:value-of select="/TransportRequestType/Customs/CustomsHandlingDocument"/>
                        </cbc:EmbeddedDocumentBinaryObject>
                    </cac:Attachment>
                    </xsl:if>
                </cac:AdditionalDocumentReference>
            </xsl:for-each>

            <!--Contract-Reference-->
            <xsl:if test="(Contract/ContractReference!= '')">
            <cac:TransportContract>
                <cbc:ID>
                    <xsl:value-of select="Contract/ContractReference"/>
                </cbc:ID>
            </cac:TransportContract>
            </xsl:if>

            <xsl:if test="((Identification/TransportRequestType != '') or (Identification/MainModeofTransport != '')  )">
            <cac:MainTransportationService>

                <!--_Transport-Request-Type-->
                <xsl:if test="((Identification/TransportRequestType != '')  )">
                <cbc:TransportServiceCode>
                    <xsl:value-of select="Identification/TransportRequestType"/>
                </cbc:TransportServiceCode>
                </xsl:if>
                
                <xsl:if test="((Identification/MainModeofTransport != '')  )">
                <cac:ShipmentStage>
                    <!--Main-Mode-of-Transport-->
                    <cbc:TransportModeCode>
                        <xsl:value-of select="Identification/MainModeofTransport"/>
                    </cbc:TransportModeCode>
                </cac:ShipmentStage>
                </xsl:if>
            </cac:MainTransportationService>
            </xsl:if>

            <!-- MULTI-STOP & WEIGHING-->
            <!--Multistop and weighing are additional services that can be charged. It is important to indicate that
    such additional services are requested, but not a lot of details need to be associated with them.-->
 
                <!--Instead of a boolean attribute we could indicate that this is a weighing service by simply
        including "Weighing" as value in the TransportServiceCode-->
                <xsl:if test="MultistopAndWeighing/Weighing = 'true'">
                <cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Weighing</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>
                <xsl:if test="MultistopAndWeighing/OriginMultistop = 'true'">
               	<cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Origin Multistop</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>
                <xsl:if test="MultistopAndWeighing/DestinationMultistop = 'true'">
               	<cac:AdditionalTransportationService>
                    <cbc:TransportServiceCode>Destination Multistop</cbc:TransportServiceCode>
                </cac:AdditionalTransportationService>
                </xsl:if>


            <!--_ORIGIN-->
            <cac:FromLocation>

                <!--_Origin-Terminal-Code-->
                <xsl:if test="((Origin/TerminalCode != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Origin/TerminalCode"/>
                </cbc:ID>
                </xsl:if>
                
                <!--_Origin-Time-Type-->
                <!--NB: Probably not ideal, since Origin-Time-Type is an enumeration, but need a better understanding of what this element really means in the TransportRequest-->
                <xsl:if test="((Origin/TimeType != '')  )">
                <cbc:Description>
                    <xsl:value-of select="Origin/TimeType"/>
                </cbc:Description>
                </xsl:if>
                
                <!--_Origin-Empty-Container-Type-->
                <xsl:if test="((Origin/EmptyContainerType != '')  )">
                <cbc:Conditions>
                    <xsl:value-of select="Origin/EmptyContainerType"/>
                </cbc:Conditions>
                </xsl:if>
                
                <!--_Origin-Type-->
                <xsl:if test="((Origin/Type != '')  )">
                <cbc:LocationTypeCode>
                    <xsl:value-of select="Origin/Type"/>
                </cbc:LocationTypeCode>
                </xsl:if>
                
                <!--_Origin-Pickup-Time-->
                <!-- !!! what should be the start time and end time?-->
                <xsl:if test="((Origin/PickupOrDeliveryTime != '')  )">
                <cac:ValidityPeriod>
                    <xsl:variable name="originDateTime" select="Origin/PickupOrDeliveryTime"/>
                    <cbc:StartDate>
                        <xsl:value-of select="format-dateTime($originDateTime, '[Y0001]-[M01]-[D01]')"/>
                    </cbc:StartDate>
                    <cbc:StartTime>
                        <xsl:value-of select="format-dateTime($originDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                    </cbc:StartTime>
                    <cbc:EndDate><xsl:value-of select="format-dateTime($originDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EndDate>
                    <cbc:EndTime><xsl:value-of select="format-dateTime($originDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EndTime>

                </cac:ValidityPeriod>
                </xsl:if>


                <xsl:if test="((Origin/DoorStreet != '') or (Origin/DoorAddressee != '') or (Origin/DoorCity != '') or (Origin/DoorZipcode != '') or (Origin/DoorCountry != '') )">
                <cac:Address>

                    <!--_Origin-Door-Street-->
                    <xsl:if test="((Origin/DoorStreet != '')  )">
                    <cbc:StreetName>
                        <xsl:value-of select="Origin/DoorStreet"/>
                    </cbc:StreetName>
                    </xsl:if>

                    <!--_Origin-Door-Addressee-->
                    <xsl:if test="((Origin/DoorAddressee != '')  )">
                    <cbc:MarkAttention>
                        <xsl:value-of select="Origin/DoorAddressee"/>
                    </cbc:MarkAttention>
                    </xsl:if>

                    <!--_Origin-Door-City-->
                    <xsl:if test="( (Origin/DoorCity != '')  )">
                    <cbc:CityName>
                        <xsl:value-of select="Origin/DoorCity"/>
                    </cbc:CityName>
                    </xsl:if>

                    <!--_Origin-Door-Zipcode-->
                    <xsl:if test="( (Origin/DoorZipcode != '')  )">
                    <cbc:PostalZone>
                        <xsl:value-of select="Origin/DoorZipcode"/>
                    </cbc:PostalZone>
                    </xsl:if>

                    <!--_Origin-Door-Country-->
                    <xsl:if test="( (Origin/DoorCountry != '') )">
                    <cac:Country>
                        <cbc:Name><xsl:value-of select="Origin/DoorCountry"/></cbc:Name>
                    </cac:Country>
                    </xsl:if>


                </cac:Address>
                 </xsl:if>


                 <xsl:if test="((Origin/ContactName != '') or (Origin/ContactPhone != '') or (Origin/ContactEmail != '')  )">
                <cac:Contact>


                    <!--_Origin-Contact-Name-->
                    <xsl:if test="((Origin/ContactName != '')  )">
                    <cbc:Name>
                        <xsl:value-of select="Origin/ContactName"/>
                    </cbc:Name>
                    </xsl:if>

                    <!--_Origin-Contact-Telephone-->
                    <xsl:if test="((Origin/ContactPhone != '')  )">
                    <cbc:Telephone>
                        <xsl:value-of select="Origin/ContactPhone"/>
                    </cbc:Telephone>
                    </xsl:if>

                    <!--_Origin-Contact-Email-->
                    <xsl:if test="( (Origin/ContactEmail != '')  )">
                    <cbc:ElectronicMail>
                        <xsl:value-of select="Origin/ContactEmail"/>
                    </cbc:ElectronicMail>
                    </xsl:if>


                </cac:Contact>
                </xsl:if>


            </cac:FromLocation>
            <!-- END OF _ORIGIN-->

            <!-- DESTINATION-->
            <cac:ToLocation>

                <!--_Destination-Terminal-Code-->
                <xsl:if test="((Destination/TerminalCode != '')  )">
                <cbc:ID>
                    <xsl:value-of select="Destination/TerminalCode"/>
                </cbc:ID>
                </xsl:if>

               <!--_Destination-Empty-Container-Type-->
                <xsl:if test="((Destination/EmptyContainerType != '')  )">
                <cbc:Conditions>
                    <xsl:value-of select="Destination/EmptyContainerType"/>
                </cbc:Conditions>
                </xsl:if>
                
                <!--_Destination-Type-->
                <xsl:if test="((Destination/Type != '')  )">
                <cbc:LocationTypeCode>
                    <xsl:value-of select="Destination/Type"/>
                </cbc:LocationTypeCode>
                </xsl:if>

                <!--_Destination-Delivery-Time-->
                <xsl:if test="((Destination/PickupOrDeliveryTime != '')  )">
                <cac:ValidityPeriod>
                    <xsl:variable name="destinationDateTime" select="Destination/PickupOrDeliveryTime"/>
                    <cbc:StartDate>
                        <xsl:value-of select="format-dateTime($destinationDateTime, '[Y0001]-[M01]-[D01]')"/>
                    </cbc:StartDate>
                    <cbc:StartTime>
                        <xsl:value-of select="format-dateTime($destinationDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                    </cbc:StartTime>

                    <cbc:EndDate><xsl:value-of select="format-dateTime($destinationDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EndDate>
                    <cbc:EndTime><xsl:value-of select="format-dateTime($destinationDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EndTime>

                </cac:ValidityPeriod>
                </xsl:if>
                
                <xsl:if test="((Destination/DoorStreet != '') or (Destination/DoorAddressee != '') or (Destination/DoorCity != '') or (Destination/DoorZipcode != '') or (Destination/DoorCountry != '') )">
                <cac:Address>

                    <!--_Destination-Door-Street-->
                    <xsl:if test="((Destination/DoorStreet != '')  )">
                    <cbc:StreetName>
                        <xsl:value-of select="Destination/DoorStreet"/>
                    </cbc:StreetName>
                    </xsl:if>

                    <!--_Destination-Door-Addressee-->
                    <xsl:if test="((Destination/DoorAddressee != '')  )">
                    <cbc:MarkAttention>
                        <xsl:value-of select="Destination/DoorAddressee"/>
                    </cbc:MarkAttention>
                    </xsl:if>

                    <!--_Destination-Door-City-->
                    <xsl:if test="( (Destination/DoorCity != '')  )">
                    <cbc:CityName>
                        <xsl:value-of select="Destination/DoorCity"/>
                    </cbc:CityName>
                    </xsl:if>

                    <!--_Destination-Door-Zipcode-->
                    <xsl:if test="( (Destination/DoorZipcode != '')  )">
                    <cbc:PostalZone>
                        <xsl:value-of select="Destination/DoorZipcode"/>
                    </cbc:PostalZone>
                    </xsl:if>

                    <!--_Destination-Door-Country-->
                    <xsl:if test="( (Destination/DoorCountry != '') )">
                    <cac:Country>
                        <cbc:Name><xsl:value-of select="Destination/DoorCountry"/></cbc:Name>
                    </cac:Country>
                    </xsl:if>


                </cac:Address>
                 </xsl:if>

                 <xsl:if test="((Destination/ContactName != '') or (Destination/ContactPhone != '') or (Destination/ContactEmail != '')  )">
                <cac:Contact>


                    <!--_Destination-Contact-Name-->
                    <xsl:if test="((Destination/ContactName != '')  )">
                    <cbc:Name>
                        <xsl:value-of select="Destination/ContactName"/>
                    </cbc:Name>
                    </xsl:if>

                    <!--_Destination-Contact-Telephone-->
                    <xsl:if test="((Destination/ContactPhone != '')  )">
                    <cbc:Telephone>
                        <xsl:value-of select="Destination/ContactPhone"/>
                    </cbc:Telephone>
                    </xsl:if>

                    <!--_Destination-Contact-Email-->
                    <xsl:if test="( (Destination/ContactEmail != '')  )">
                    <cbc:ElectronicMail>
                        <xsl:value-of select="Destination/ContactEmail"/>
                    </cbc:ElectronicMail>
                    </xsl:if>


                </cac:Contact>
                </xsl:if>

            </cac:ToLocation>
            <!-- END OF _DESTINATION-->


            <cac:TransportExecutionTerms>
                <!--EXTENSION ADDED 03.06.2018: _Selection-Of-Depot-Reuse-->
                <!-- !!! not in the example -->
                <xsl:if test="( (/TransportRequestType/Identification/SelectionOfDepotAndReuse != '')  )">
                <cbc:DepotSelectionCode>
                    <xsl:value-of select="/TransportRequestType/Identification/SelectionOfDepotAndReuse"/>
                </cbc:DepotSelectionCode>
                </xsl:if>
                
                <xsl:for-each select="/TransportRequestType/PriceDetail/PricePlan/PriceService/PriceLine">
                <xsl:variable name="currency" select="Currency"/>            
                <cac:PaymentTerms>
                    <!--_Plan-Number-->
                    <xsl:if test="( (../../PlanNumber != '')  )">
                    <cbc:ID>
                        <xsl:value-of select="../../PlanNumber"/>
                    </cbc:ID>
                    </xsl:if>
                    
                    
                    <xsl:if test="((../ServiceName != '') or (../Provider != '')   )">
                    <cac:TransportationService>
                        
                        <!--NB: THIS IS MANDATORY SO HAS TO BE INCLUDED WITH SOME VALUE-->
                        <cbc:TransportServiceCode>TransportServiceCode</cbc:TransportServiceCode>
                        
                        <xsl:if test="((../ServiceName != '')   )">
                        <!--_Service-Name-->
                        <cbc:Name>
                            <xsl:value-of select="../ServiceName"/>
                        </cbc:Name>
                        </xsl:if>
                        
                        <xsl:if test="( (../Provider != '')   )">
                        <!--_Provider-->
                        <cac:ResponsibleTransportServiceProviderParty>
                            <cac:PartyIdentification>
                                <cbc:ID>
                                    <xsl:value-of select="../Provider"/>
                                </cbc:ID>
                            </cac:PartyIdentification>
                        </cac:ResponsibleTransportServiceProviderParty>
                        </xsl:if>
                        
                    </cac:TransportationService>
                    </xsl:if>
                    
                    
                    <cac:DeliveryTerms>
                        <cac:AllowanceCharge>
                            
                            <cbc:ChargeIndicator>true </cbc:ChargeIndicator>
                            
                            <!--_Margin-->
                            <xsl:if test="( (Margin != '')   )">
                            <cbc:MultiplierFactorNumeric>
                                <xsl:value-of select="Margin"/>
                            </cbc:MultiplierFactorNumeric>
                             </xsl:if>
                             
                            <!--_Price (Currency is an attribute, not a separate element in UBL-->
                            <xsl:choose>
                                <xsl:when test="( (Price != '')   )">
                                    <cbc:Amount currencyID="{$currency}">
                                        <xsl:value-of select="Price"/>
                                    </cbc:Amount>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:comment>Amount is transformed from Price in Transport Request (which is mandatory) but there is no value present in the input Transport Request XML!</xsl:comment>
                                    <cbc:Amount currencyID="{$currency}">0</cbc:Amount>
                                </xsl:otherwise>
                            </xsl:choose>
                            
                            <!--_Cost (Currency is an attribute, not a separate element in UBL-->
                            <xsl:if test="( (Cost != '')   )">
                            <cbc:BaseAmount currencyID="{$currency}">
                                <xsl:value-of select="Cost"/>
                            </cbc:BaseAmount>
                            </xsl:if>
                            
                            <!--_Cost-Code-->
                            <xsl:if test="( (CostCode != '')   )">
                            <cbc:AccountingCostCode>
                                <xsl:value-of select="CostCode"/>
                            </cbc:AccountingCostCode>
                            </xsl:if>
                            
                            
                            <!--_Unit-Price-->
                            <xsl:if test="( (UnitPrice != '')   )">
                            <cbc:PerUnitAmount currencyID="{$currency}">
                                <xsl:value-of select="UnitPrice"/>
                            </cbc:PerUnitAmount>
                            </xsl:if>
                            
                            <!--_Percentage-Value-->
                            <xsl:if test="( (PercentageValue != '')   )">
                            <cbc:Percent>
                                <xsl:value-of select="PercentageValue"/>
                            </cbc:Percent>
                            </xsl:if>
                            
                            <!--_Percentage-Base-Value-->
                            <xsl:if test="( (PercentageBaseValue != '')   )">
                            <cbc:BaseValueAmount currencyID="{$currency}"><xsl:value-of select="PercentageBaseValue"/></cbc:BaseValueAmount>
                            </xsl:if>
                            
                            <!-- _Percentage-Base-Cost-Code-->
                            <xsl:if test="( (PercentageBaseCostCode != '')   )">
                            <cbc:BaseCostID><xsl:value-of select="PercentageBaseCostCode"/></cbc:BaseCostID>
                            </xsl:if>
                            
                            <!--_Extra-Charges-->
                            <xsl:if test="( (ExtraCharges != '')   )">
                            <cbc:ExtraChargesIndicator>
                                <xsl:value-of select="ExtraCharges"/>
                            </cbc:ExtraChargesIndicator>
                            </xsl:if>
                            
                            
                        </cac:AllowanceCharge>
                        
                    </cac:DeliveryTerms>
                </cac:PaymentTerms>
                </xsl:for-each>
                
            </cac:TransportExecutionTerms>
            
            

            <!-- Consignment-->
            <cac:Consignment>
                
                <cbc:ID>ID</cbc:ID>


                <!--_Carrier-Booking-->
                <xsl:if test="( (Carrier/CarrierBooking != '')   )">
                <cbc:CarrierAssignedID><xsl:value-of select="Carrier/CarrierBooking"/></cbc:CarrierAssignedID>
                </xsl:if>

                <!--EXTENSION ADDED 02.06.2018: _Carrier-Booking-Type-->
                <xsl:if test="( (Carrier/CarrierBookingType != '')   )">
                <cbc:CarrierBookingTypeCode><xsl:value-of select="Carrier/CarrierBookingType"/></cbc:CarrierBookingTypeCode>
                </xsl:if>


                <!--CARRIER-->
                <xsl:if test="( (Carrier/OceanSCACcode != '')   )">
                <cac:CarrierParty>

                    <!--Ocean-SCAC-code-->
                    <cac:PartyIdentification>
                        <cbc:ID><xsl:value-of select="Carrier/OceanSCACcode"/></cbc:ID>
                    </cac:PartyIdentification>

                </cac:CarrierParty>
                </xsl:if>

                <!--Forwarder-Reference-->
                <xsl:if test="( (Identification/ForwarderReference != '')   )">
                <cac:FreightForwarderParty>
                    <cac:PartyIdentification>
                        <cbc:ID>
                            <xsl:value-of select="Identification/ForwarderReference"/>
                        </cbc:ID>
                    </cac:PartyIdentification>
                </cac:FreightForwarderParty>
                </xsl:if>

                <cac:MainCarriageShipmentStage>

                    <xsl:if test="((Carrier/Voyage != '') or (Carrier/VesselIMO != '')  or (Carrier/VesselName != '')  )">
                    <cac:TransportMeans>

                        <!--_Voyage-->
                        <xsl:if test="((Carrier/Voyage != '')   )">
                        <cbc:JourneyID><xsl:value-of select="Carrier/Voyage"/></cbc:JourneyID>
                        </xsl:if>

                        <xsl:if test="( (Carrier/VesselIMO != '')  or (Carrier/VesselName != '')  )">
                        <cac:MaritimeTransport>

                            <!--_Vessel-IMO-->
                            <xsl:if test="( (Carrier/VesselIMO != '')    )">
                            <cbc:VesselID><xsl:value-of select="Carrier/VesselIMO"/></cbc:VesselID>
                            </xsl:if>
                            <!--_Vessel-Name-->
                            <xsl:if test="((Carrier/VesselName != '')  )">
                            <cbc:VesselName><xsl:value-of select="Carrier/VesselName"/></cbc:VesselName>
                            </xsl:if>
                        </cac:MaritimeTransport>
                        </xsl:if>
                    </cac:TransportMeans>
                    </xsl:if>

                    <xsl:if test="MultistopAndWeighing/OriginMultistop = 'true'">
                        <!--We use the PlannedWaypointTransportEvent structure to describe Multistop-->
                        <cac:PlannedWaypointTransportEvent>    
                            <cbc:TransportEventTypeCode>ORIGIN MULTISTOP</cbc:TransportEventTypeCode>
                            <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddressType != '')  or (MultistopAndWeighing/OriginMultistopAddress != '')  )">
                            <cac:Location>
                                <cac:Address>
                                    <!--Origin-Multistop-Address-Type-->
                                    <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddressType != '')   )">
                                    <cbc:AddressTypeCode>
                                        <xsl:value-of select="MultistopAndWeighing/OriginMultistopAddressType"/>
                                    </cbc:AddressTypeCode>
                                    </xsl:if>
                                    <!--Origin-Multistop-Address-->
                                    <xsl:if test="( (MultistopAndWeighing/OriginMultistopAddress != '')   )">
                                    <cac:AddressLine>
                                        <cbc:Line>
                                            <xsl:value-of select="MultistopAndWeighing/OriginMultistopAddress"/>
                                        </cbc:Line>
                                    </cac:AddressLine>
                                    </xsl:if>
                                </cac:Address>
                            </cac:Location>
                            </xsl:if>    
                        </cac:PlannedWaypointTransportEvent>
                    </xsl:if>

                    <xsl:if test="MultistopAndWeighing/DestinationMultistop = 'true'">
                        <!--We use the PlannedWaypointTransportEvent structure to describe multistop-->
                        <cac:PlannedWaypointTransportEvent>                        
                            <cbc:TransportEventTypeCode>DESTINATION MULTISTOP</cbc:TransportEventTypeCode>
                            <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddressType != '')  or (MultistopAndWeighing/DestinationMultistopAddress != '')  )">
                            <cac:Location>
                                <cac:Address>
                                    <!--Destination-Multistop-Address-Type-->
                                    <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddressType != '')   )">
                                    <cbc:AddressTypeCode>
                                        <xsl:value-of select="MultistopAndWeighing/DestinationMultistopAddressType"/>
                                    </cbc:AddressTypeCode>
                                    </xsl:if>
                                    
                                    <!--Destination-Multistop-Address-->
                                    <xsl:if test="( (MultistopAndWeighing/DestinationMultistopAddress != '')   )">
                                    <cac:AddressLine>
                                        <cbc:Line>
                                            <xsl:value-of select="MultistopAndWeighing/DestinationMultistopAddress"/>
                                        </cbc:Line>
                                    </cac:AddressLine>
                                    </xsl:if>
                                </cac:Address>
                            </cac:Location>
                            </xsl:if>
                            
                        </cac:PlannedWaypointTransportEvent>
                    </xsl:if>

                    <xsl:if test="( (InlandTerminal/InlandTerminalCode != '')  or (InlandTerminal/TerminalArrivalTime != '')  )">
                    <cac:TransportEvent>
                    
                        <xsl:if test="( (InlandTerminal/InlandTerminalCode != '')  )">
                        <cac:Location>

                            <!--_Inland-Terminal-Code-->
                            <cbc:ID><xsl:value-of select="InlandTerminal/InlandTerminalCode"/></cbc:ID>

                            <!--Code that specifies that this is INLAND TERMINAL-->
                            <cbc:LocationTypeCode>INLAND TERMINAL</cbc:LocationTypeCode>

                        </cac:Location>
                        </xsl:if>

                        <!--_Terminal-Arrival-Time-->
                        <xsl:if test="(  (InlandTerminal/TerminalArrivalTime != '')  )">
                        <cac:Period>
                            <xsl:variable name="terminalArrivalDateTime" select="InlandTerminal/TerminalArrivalTime"/>
                            <cbc:StartDate>
                                <xsl:value-of select="format-dateTime($terminalArrivalDateTime, '[Y0001]-[M01]-[D01]')"/>
                            </cbc:StartDate>
                            <cbc:StartTime>
                                <xsl:value-of select="format-dateTime($terminalArrivalDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                            </cbc:StartTime>
                            
                        </cac:Period>
                        </xsl:if>
                    </cac:TransportEvent>
                    </xsl:if>


                    <!--ORIGIN DEPOT-->
                    
                    <xsl:if test="( (Depot/OriginDepotUsageType != '')  or (Depot/OriginDepotCode != '') or (Depot/OriginDepotReference != '') or (Depot/OriginDepotTime != '')  )">
                        <cac:TransportEvent>
                            <!--Code that specifies that this is an ORIGIN DEPOT-->
                            <cbc:TransportEventTypeCode>ORIGIN DEPOT</cbc:TransportEventTypeCode>
                            
                            <!--_Origin-Depot-Usage-Type-->
                            <xsl:if test="( (Depot/OriginDepotUsageType != '')   )">
                            <cbc:Description><xsl:value-of select="Depot/OriginDepotUsageType"/></cbc:Description>
                            </xsl:if>
                            
                            <xsl:if test="(  (Depot/OriginDepotCode != '')   )">
                            <cac:Location>  
                                <!--_Origin-Depot-Code-->
                                <cbc:ID> <xsl:value-of select="Depot/OriginDepotCode"/></cbc:ID>                                
                            </cac:Location>
                            </xsl:if>
                            
                            <!--Origin-Depot-Reference-->
                            <xsl:if test="( (Depot/OriginDepotReference != '')  )">
                            <cac:Signature>
                                <cbc:ID><xsl:value-of select="Depot/OriginDepotReference"/></cbc:ID>
                            </cac:Signature>
                            </xsl:if>
                            
                            <!--_Origin-Depot-Time-->
                            <xsl:if test="(  (Depot/OriginDepotTime != '')  )">
                            <cac:Period>
                                <xsl:variable name="originDepotDateTime" select="Depot/OriginDepotTime"/>
                                <cbc:StartDate>
                                    <xsl:value-of select="format-dateTime($originDepotDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:StartDate>
                                <cbc:StartTime>
                                    <xsl:value-of select="format-dateTime($originDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:StartTime>
                            </cac:Period>
                            </xsl:if>
                        </cac:TransportEvent>
                    </xsl:if>                    

                    <!--DESTINATION DEPOT-->
                    <xsl:if test="( (Depot/DestinationDepotUsageType != '')  or (Depot/DestinationDepotCode != '') or (Depot/DestinationDepotReference != '') or (Depot/DestinationDepotTime != '')  )">
                        <cac:TransportEvent>
                            <!--Code that specifies that this is an DESTINATION DEPOT-->
                            <cbc:TransportEventTypeCode>DESTINATION DEPOT</cbc:TransportEventTypeCode>

                            <!--_Destination-Depot-Usage-Type-->
                            <xsl:if test="( (Depot/DestinationDepotUsageType != '')   )">
                            <cbc:Description><xsl:value-of select="Depot/DestinationDepotUsageType"/></cbc:Description>
                            </xsl:if>
                            
                            <xsl:if test="(  (Depot/DestinationDepotCode != '')   )">
                            <cac:Location>  
                                <!--_Destination-Depot-Code-->
                                <cbc:ID> <xsl:value-of select="Depot/DestinationDepotCode"/></cbc:ID>                                
                            </cac:Location>
                            </xsl:if>
                            
                            <!--Destination-Depot-Reference-->
                            <xsl:if test="( (Depot/DestinationDepotReference != '')  )">
                            <cac:Signature>
                                <cbc:ID><xsl:value-of select="Depot/DestinationDepotReference"/></cbc:ID>
                            </cac:Signature>
                            </xsl:if>


                            <!--_Destination-Depot-Time-->
                            <xsl:if test="(  (Depot/DestinationDepotTime != '')  )">
                            <cac:Period>
                                <xsl:variable name="destinationDepotDateTime" select="Depot/DestinationDepotTime"/>
                                <cbc:StartDate>
                                    <xsl:value-of select="format-dateTime($destinationDepotDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:StartDate>
                                <cbc:StartTime>
                                    <xsl:value-of select="format-dateTime($destinationDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:StartTime>
                            </cac:Period>
                            </xsl:if>
                        </cac:TransportEvent>
                    </xsl:if>                    

                </cac:MainCarriageShipmentStage>

                <!--TRANSPORTHANDLINGUNIT ELEMENTS FOR EACH CONTAINER -->
                <xsl:for-each select="ContainerAndGoodsDetails/Container">

                    <cac:TransportHandlingUnit>
                        
                        <!--Marks-And-Numbers (under GOODS PLACEMENT TYPE)-->
                        <cbc:ShippingMarks>ShippingMarks11</cbc:ShippingMarks>
                        
                        <cac:TransportEquipment>
                            
                            <!--_Container-Number-->
                            <xsl:if test="(  Number != ''  )">
                            <cbc:ID><xsl:value-of select="Number"/></cbc:ID>
                            </xsl:if>
                            
                            <!--_Container : CONTAINER TYPE-->
                            <!--Container-Type-->
                            <xsl:if test="(  ContainerType != ''  )">
                            <cbc:TransportEquipmentTypeCode>
                                <xsl:value-of select="ContainerType"/>
                            </cbc:TransportEquipmentTypeCode>
                            </xsl:if>
                            
                            <!--Temperature-Range-Type-->
                            <xsl:if test="(  (TemperatureRangeType != '')  )">
                            <cbc:RefrigeratedIndicator><xsl:value-of select="TemperatureRangeType"/></cbc:RefrigeratedIndicator>
                            </xsl:if>
                            
                            <!--Weight-->
                            <xsl:if test="(  Weight != ''  )">
                            <cbc:GrossWeightMeasure unitCode="unitCode2479">
                                <xsl:value-of select="Weight"/>
                            </cbc:GrossWeightMeasure>
                            </xsl:if>
                            
                            <!--Volume-->
                            <xsl:if test="(  (Volume != '')  )">
                            <cbc:GrossVolumeMeasure unitCode="unitCode2480">
                                <xsl:value-of select="Volume"/>
                            </cbc:GrossVolumeMeasure>
                            </xsl:if>
                            
                            <cbc:TraceID>TraceID72</cbc:TraceID>
                            
                            <!--EXTENSION ADDED 04.06.2018: _Oversized-->
                            <xsl:if test="(  (Oversized != '')  )">
                            <cbc:OversizedIndicator><xsl:value-of select="Oversized"/></cbc:OversizedIndicator>
                            </xsl:if>
                            
                            <!--EXTENSION ADDED 04.06.2018: _Carrier-Booking-->
                            <xsl:if test="(  (CarrierEquipment != '')  )">
                            <cbc:CarrierAssignedID><xsl:value-of select="CarrierEquipment"/></cbc:CarrierAssignedID>
                            </xsl:if>
                            
                             <xsl:if test="(  (Length != '')  )">
                            <cac:MeasurementDimension>
                                
                                <!--Dimension-Length-->
                                <cbc:AttributeID>Length</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Length"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <!--Dimension-Height-->
                            <xsl:if test="(  (Height != '')  )">
                            <cac:MeasurementDimension>
                                <cbc:AttributeID>Height</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Height"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <!--Dimension-Width-->
                            <xsl:if test="(  (Width != '')  )">
                            <cac:MeasurementDimension>
                                <cbc:AttributeID>Width</cbc:AttributeID>
                                <cbc:Measure unitCode="MTR"><xsl:value-of select="Width"/></cbc:Measure>
                            </cac:MeasurementDimension>
                            </xsl:if>
                            
                            <xsl:if test="(  (SealShipper != '')  )">
                            <cac:TransportEquipmentSeal>
                                
                                <!-- _Seal-Shipper-->
                                <cbc:ID><xsl:value-of select="SealShipper"/></cbc:ID>
                                
                            </cac:TransportEquipmentSeal>
                            </xsl:if>
                            
                            <!--Temperature-Range-From-->
                            <xsl:if test="(  (TemperatureRangeFrom != '')  )">
                            <cac:MinimumTemperature>
                                <cbc:AttributeID>Temperature</cbc:AttributeID>
                                <cbc:Measure unitCode="CEL"><xsl:value-of select="TemperatureRangeFrom"/></cbc:Measure>
                            </cac:MinimumTemperature>
                            </xsl:if>
                            
                            <!--Temperature-Range-To-->
                            <xsl:if test="(  (TemperatureRangeTo != '')  )">
                            <cac:MaximumTemperature>
                                <cbc:AttributeID>Temperature</cbc:AttributeID>
                                <cbc:Measure unitCode="CEL"><xsl:value-of select="TemperatureRangeTo"/></cbc:Measure>
                            </cac:MaximumTemperature>
                            </xsl:if>
                            
                            
                            <xsl:if test="(  (CustomerDeliveryRef != '')  )">
                            <cac:DeliveryTransportEvent>
                                
                                <!--Customer-Delivery-Ref-->
                                <cac:Contact>
                                    <cbc:ID><xsl:value-of select="CustomerDeliveryRef"/></cbc:ID>
                                </cac:Contact>
                            </cac:DeliveryTransportEvent>
                            </xsl:if>
                            
                            <xsl:if test="(  (CustomerLoadRef != '')  )">
                            <cac:LoadingTransportEvent>
                                
                                <!--_Customer-Load-Ref-->
                                <cac:Contact>
                                    <cbc:ID><xsl:value-of select="CustomerLoadRef"/></cbc:ID>
                                </cac:Contact>
                                
                            </cac:LoadingTransportEvent>
                            </xsl:if>
                            
                            <!--Origin-Multistop-Address-->
                            <xsl:if test="OriginMultistopAddress">
                            <cac:TransportEvent>
                                
                                <!--Need to add ORIGIN-MULTISTOP to codelist-->
                                <cbc:TransportEventTypeCode>ORIGIN-MULTISTOP</cbc:TransportEventTypeCode>
                                <cac:Location>
                                    <cac:Address>
                                        <cac:AddressLine>
                                            <cbc:Line><xsl:value-of select="OriginMultistopAddress"/></cbc:Line>
                                        </cac:AddressLine>
                                    </cac:Address>
                                </cac:Location>
                            </cac:TransportEvent>
                            </xsl:if>
                            
                            <!--Destination-Multistop-Address-->
                            <xsl:if test="DestinationMultistopAddress">
                            <cac:TransportEvent>
                                <!-- Need to add DESTINATION-MULTISTOP to codelist-->
                                <cbc:TransportEventTypeCode>DESTINATION-MULTISTOP</cbc:TransportEventTypeCode>
                                <cac:Location>
                                    <cac:Address>
                                        <cac:AddressLine>
                                            <cbc:Line><xsl:value-of select="DestinationMultistopAddress"/></cbc:Line>
                                        </cac:AddressLine>
                                    </cac:Address>
                                </cac:Location>
                            </cac:TransportEvent>
                            </xsl:if>
                            
                            <!--APPLICABLETRANSPORTMEANS CONNECTS THE TRANSPORT EQUIPMENT (CONTAINER) WITH THE APPROPRIATE TRANSPORTMEANS (CARRIER)-->
                            <xsl:if test="((../../Carrier/Voyage != '') or (../../Carrier/VesselIMO != '')  or (../../Carrier/VesselName != '')  )">
                            <cac:ApplicableTransportMeans>
                                
                                <!--SHOULD BE SAME JOURNEYID AS ONE OF THE JOURNEYIDÂ´S FROM THE MAINCARRIAGESHIPMENTSTAGE ELEMENT-->
                                <xsl:if test="((../../Carrier/Voyage != '')   )">
                                <cbc:JourneyID><xsl:value-of select="../../Carrier/Voyage"/></cbc:JourneyID>
                                </xsl:if>
                                
                                <xsl:if test="( (../../Carrier/VesselIMO != '')  or (../../Carrier/VesselName != '')  )">
                                <cac:MaritimeTransport>
                                    <!--_Vessel-IMO-->
                                    <xsl:if test="( (../../Carrier/VesselIMO != '')    )">
                                    <cbc:VesselID><xsl:value-of select="../../Carrier/VesselIMO"/></cbc:VesselID>
                                    </xsl:if>
                                    <!--_Vessel-Name-->
                                    <xsl:if test="((../../Carrier/VesselName != '')  )">
                                    <cbc:VesselName><xsl:value-of select="../../Carrier/VesselName"/></cbc:VesselName>
                                    </xsl:if>
                                </cac:MaritimeTransport>
                                </xsl:if>
                                
                                
                            </cac:ApplicableTransportMeans>
                             </xsl:if>
                            
                            
                            <xsl:if test="((DestinationDepotReference != '') or (../../Destination/PickupOrDeliveryTime != '')  or (PIN != '') or (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                            <cac:Delivery>
                                
                                <!--Destination-Depot-Reference-->
                                <xsl:if test="((DestinationDepotReference != '') )">
                                <cbc:ID><xsl:value-of select="DestinationDepotReference"/></cbc:ID>
                                </xsl:if>
                                
                                <xsl:if test="( (../../Destination/PickupOrDeliveryTime != ''))"/>  
                                <xsl:variable name="latestDeliveryDateTime" select="../../Destination/PickupOrDeliveryTime"/>
                                <!--Delivery-Time-->
                                <xsl:if test="((DestinationDepotReference != '') or (../../Destination/PickupOrDeliveryTime != '')  or (PIN != '') or (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                                <cbc:LatestDeliveryDate><xsl:value-of select="format-dateTime($latestDeliveryDateTime, '[Y0001]-[M01]-[D01]')"/>
                                </cbc:LatestDeliveryDate>
                                <cbc:LatestDeliveryTime><xsl:value-of select="format-dateTime($latestDeliveryDateTime, '[H01]:[m01]:[s01].[f001]')"/>
                                </cbc:LatestDeliveryTime>
                                </xsl:if>
                                
                                <!--PIN-->
                                <xsl:if test="( (PIN != '')  )">
                                <cbc:ReleaseID><xsl:value-of select="PIN"/></cbc:ReleaseID>
                                </xsl:if>
                                
                                <xsl:if test="( (DestinationDepotCode != '') or (DestinationDepotTime != '') )">
                                <cac:DeliveryLocation>
                                    <!--Destination-Depot-Code-->
                                    <xsl:if test="( (DestinationDepotCode != '')  )">
                                    <cbc:ID><xsl:value-of select="DestinationDepotCode"/></cbc:ID>
                                    </xsl:if>
                                    
                                    <!--Destination-Depot-Time-->
                                    <xsl:if test="(  (DestinationDepotTime != '') )">
                                    <cac:ValidityPeriod>
                                        <xsl:variable name="destinationDepotDateTime" select="DestinationDepotTime"/>
                                        <cbc:StartDate><xsl:value-of select="format-dateTime($destinationDepotDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                                        <cbc:StartTime><xsl:value-of select="format-dateTime($destinationDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                                    </cac:ValidityPeriod>
                                    </xsl:if>
                                    
                                </cac:DeliveryLocation>
                                </xsl:if>
                            </cac:Delivery>
                            </xsl:if>
                            
                            <xsl:if test="((OriginDepotReference != '') or (../../Origin/PickupOrDeliveryTime != '')  or (PIN != '') or (OriginDepotCode != '') or (OriginDepotTime != '') )">
                            <cac:Pickup>
                                
                                
                                <!--Origin-Depot-Reference-->
                                <xsl:if test="((OriginDepotReference != '')  )">
                                <cbc:ID><xsl:value-of select="OriginDepotReference"/></cbc:ID>
                                </xsl:if>
                                
                                
                                <xsl:if test="( (../../Origin/PickupOrDeliveryTime != '')   )">
                                <xsl:variable name="pickupDateTime" select="../../Origin/PickupOrDeliveryTime"/>
                                
                                <!--Pickup-Time-->
                                <cbc:EarliestPickupDate><xsl:value-of select="format-dateTime($pickupDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:EarliestPickupDate>
                                <cbc:EarliestPickupTime><xsl:value-of select="format-dateTime($pickupDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:EarliestPickupTime>
                                </xsl:if>
                                
                                
                                <xsl:if test="( (OriginDepotCode != '') or (OriginDepotTime != '') )">
                                <cac:PickupLocation>
                                    
                                    <xsl:if test="((OriginDepotCode != '')  )">
                                    <!--Origin-Depot-Code-->
                                    <cbc:ID><xsl:value-of select="OriginDepotCode"/></cbc:ID>
                                    </xsl:if>
                                    
                                    <xsl:if test="( (OriginDepotTime != '') )">
                                    <!--Origin-Depot-Time-->
                                    <cac:ValidityPeriod>
                                        <xsl:variable name="originDepotDateTime" select="OriginDepotTime"/>
                                        <cbc:StartDate><xsl:value-of select="format-dateTime($originDepotDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                                        <cbc:StartTime><xsl:value-of select="format-dateTime($originDepotDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                                        
                                    </cac:ValidityPeriod>
                                    </xsl:if>
                                    
                                </cac:PickupLocation>
                                </xsl:if>
                                
                            </cac:Pickup>
                            </xsl:if>
                            
                            
                        </cac:TransportEquipment>
                        
                    </cac:TransportHandlingUnit>

                </xsl:for-each>


                <xsl:for-each select="ContainerAndGoodsDetails/GoodsItem">
                <cac:TransportHandlingUnit>
 

                    <!--Marks-And-Numbers (GoodsItem)-->
                    <xsl:if test="( (MarksAndNumbers != '') )">
                    <cbc:ShippingMarks><xsl:value-of select="MarksAndNumbers"/></cbc:ShippingMarks>
                    </xsl:if>

                    <cac:GoodsItem>

                        <!--GID-nr-->
                        <xsl:if test="( (GID-nr != '') )">
                        <cbc:ID><xsl:value-of select="GID-nr"/></cbc:ID>
                        </xsl:if>

                        <!--Goods-Description-->
                        <xsl:if test="( (GoodsDescription != '') )">
                        <cbc:Description><xsl:value-of select="GoodsDescription"/></cbc:Description>
                        </xsl:if>

                        <!--DG-->
                        <xsl:if test="( (DG != '') )">
                        <cbc:HazardousRiskIndicator>
                            <xsl:value-of select="DG"/>
                        </cbc:HazardousRiskIndicator>
                        </xsl:if>

                        <xsl:if test="( (DGUNDG != '') or (DGIMO != '') or (DGMSDS != '') or (Commodity != '') or (HSCodes != ''))">
                        <cac:Item>
                            <xsl:if test="( (HSCodes != '') or (Commodity != ''))">
                            <cac:CommodityClassification>

                                <!--HS-Codes-->
                                <xsl:if test="( (HSCodes != '')  )">
                                <cbc:NatureCode><xsl:value-of select="HSCodes"/></cbc:NatureCode>
                                </xsl:if>

                                <!--Goods-Item : GOODS ITEM TYPE-->
                                <!--Commodity-->
                                <xsl:if test="( (Commodity != '') )">
                                <cbc:CommodityCode><xsl:value-of select="Commodity"/></cbc:CommodityCode>
                                </xsl:if>
                            </cac:CommodityClassification>
                            </xsl:if>

                            

                                <!--DG-UNDG-->
                                <xsl:for-each select="DGUNDG">
                               	<cac:HazardousItem>
                                <cbc:UNDGCode><xsl:value-of select="."/></cbc:UNDGCode>
                                </cac:HazardousItem>
                                </xsl:for-each>
                                    
                                <!--DG-IMO-->
                                <xsl:for-each select="DGIMO">
                                <cac:HazardousItem>
                                <cbc:HazardClassID><xsl:value-of select="."/></cbc:HazardClassID>
                                </cac:HazardousItem>
                                </xsl:for-each>
                                
                                
                                <xsl:for-each select="DGMSDS">
                                <cac:HazardousItem>
                                <!--EXTENSION ADDED 04.06.2018: _DG-MSDS-->
                                <cac:HazardousItemDocumentReference>
                                    <!--ID is mandatory in Document Reference, hence some identifier must be added even if this is not included in the Transport Request
                            Alternatively, we could add the filename in the ID tag and omit the <cac:Attachment> tag which is optional-->
                                    <!-- !!! so far Im adding both-->
                                    <cbc:ID><xsl:value-of select="."/></cbc:ID>

                                    <!--_DG-MSDS-->
                                    <cac:Attachment>
                                        <cbc:EmbeddedDocumentBinaryObject mimeCode=""><xsl:value-of select="."/></cbc:EmbeddedDocumentBinaryObject>
                                    </cac:Attachment>

                                </cac:HazardousItemDocumentReference>
                                </cac:HazardousItem>
                                </xsl:for-each>

                            
                            
                        </cac:Item>
                        </xsl:if>

                        <!--REFERS TO THE TRANSPORTEQUIPMENT (CONTAINER) CONTAINING THIS GOODS ITEM AND MUST REFER TO ONE OF THE TRANSPORTEQUIPMENTS LISTED IN THIS XML MESSAGE-->
                        <xsl:if test="( (GoodsPlacement/ContainerNumber != '') )">
                        <cac:GoodsItemContainer>
                            <cbc:ID>
                                <xsl:value-of select="GoodsPlacement/ContainerNumber"/>
                            </cbc:ID>
                        </cac:GoodsItemContainer>
                         </xsl:if>

                        <xsl:if test="( (GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage != '') or (GoodsPlacement/GoodsPackage/PackageType != ''))">
                        <cac:ContainingPackage>

                            <!--Number-And-Type-Of-Package-->
                            <xsl:if test="( (GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage != '') )">
                            <cbc:Quantity><xsl:value-of select="GoodsPlacement/GoodsPackage/NumberAndTypeOfPackage"/></cbc:Quantity>
                            </xsl:if>

                            <!--Goods-Package : GOODS PACKAGE TYPE-->
                            <xsl:if test="(  (GoodsPlacement/GoodsPackage/PackageType != ''))">
                            <cbc:PackagingTypeCode>
                                <xsl:value-of select="GoodsPlacement/GoodsPackage/PackageType"/>
                            </cbc:PackagingTypeCode>
                            </xsl:if>

                        </cac:ContainingPackage>
                        </xsl:if>
                        
                    </cac:GoodsItem>

                </cac:TransportHandlingUnit>
                </xsl:for-each>

                <xsl:if test="( (Carrier/OriginPort != '') or (Carrier/ETD != ''))">
                <cac:FirstArrivalPortLocation>
                    <!-- _Origin-Port-->
                    <xsl:if test="( (Carrier/OriginPort != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/OriginPort"/></cbc:ID>
                    </xsl:if>

                    <!--ETD-->
                    <xsl:if test="(  (Carrier/ETD != ''))">
                    <xsl:variable name="etdDateTime" select="Carrier/ETD"/>
                                        
                    <cac:ValidityPeriod>
                        <cbc:StartDate><xsl:value-of select="format-dateTime($etdDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                        <cbc:StartTime><xsl:value-of select="format-dateTime($etdDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                    </cac:ValidityPeriod>
                    </xsl:if>

                </cac:FirstArrivalPortLocation>
                </xsl:if>

                <xsl:if test="( (Carrier/DestinationPort != '') or (Carrier/ETA != ''))">
                <cac:LastExitPortLocation>
                    <!--_Destination-Port-->
                    <xsl:if test="( (Carrier/DestinationPort != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/DestinationPort"/></cbc:ID>
                    </xsl:if>

                    <!--ETA-->
                    <xsl:if test="(  (Carrier/ETA != ''))">
                    <xsl:variable name="etaDateTime" select="Carrier/ETA"/>
                    <cac:ValidityPeriod>
                        <cbc:StartDate><xsl:value-of select="format-dateTime($etaDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:StartDate>
                        <cbc:StartTime><xsl:value-of select="format-dateTime($etaDateTime, '[H01]:[m01]:[s01].[f001]')"/></cbc:StartTime>
                    </cac:ValidityPeriod>
                    </xsl:if>
                </cac:LastExitPortLocation>
                </xsl:if>

                <!--EXTENSION ADDED 04.06.2018: _Bill-Of-Lading-->
                <xsl:if test="( (Carrier/BillOfLanding != '') or (Carrier/BillOfLadingDate != ''))">
                <cac:BillOfLadingDocumentReference>
                    <xsl:if test="( (Carrier/BillOfLanding != '') )">
                    <cbc:ID><xsl:value-of select="Carrier/BillOfLanding"/></cbc:ID>
                    </xsl:if>
                    
                    <!--_B/L date-->
                    <xsl:if test="(  (Carrier/BillOfLadingDate != ''))">
                    <xsl:variable name="billOfLandingDateTime" select="Carrier/BillOfLadingDate"/>
                    <cbc:IssueDate><xsl:value-of select="format-dateTime($billOfLandingDateTime, '[Y0001]-[M01]-[D01]')"/></cbc:IssueDate>
                    </xsl:if>
                </cac:BillOfLadingDocumentReference>
                </xsl:if>
                

            </cac:Consignment>

        </ns3:TransportExecutionPlanRequest>
        </xsl:if>
        
   <!-- </xsl:result-document>-->
    </xsl:template>



</xsl:stylesheet>
