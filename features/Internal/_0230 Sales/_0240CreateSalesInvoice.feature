﻿#language: en
@tree
@Positive
@Sales

Feature: create document Sales invoice

As a sales manager
I want to create a Sales invoice document
To sell a product to a customer


Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _024000 preparation (Sales invoice)
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Partners objects (Ferron BP)
		When Create catalog Partners objects (Kalipso)
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create catalog Agreements objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When update ItemKeys
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company
		When Create document SalesOrder objects (check movements, SI before SC, not Use shipment sheduling)
		And I execute 1C:Enterprise script at server
 			| "Documents.SalesOrder.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |





Scenario: _024001 create document Sales Invoice based on sales order (partial quantity)
	* Select SO
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I go to line in "List" table
			| 'Number' | 'Partner'   | 'Date'                |
			| '3'      | 'Ferron BP' | '27.01.2021 19:50:45' |
	* Create SI
		And I click the button named "FormDocumentSalesInvoiceGenerate"
		Then "Add linked document rows" window is opened
		And I expand current line in "DocumentsTree" table
		And "DocumentsTree" table became equal
			| 'Row presentation'                        | 'Use'                                     | 'Basis unit' | 'Quantity' |
			| 'Sales order 3 dated 27.01.2021 19:50:45' | 'Sales order 3 dated 27.01.2021 19:50:45' | ''           | ''         |
			| 'Dress, XS/Blue, Store 02'                | 'Yes'                                     | 'pcs'        | '1,000'    |
			| 'Shirt, 36/Red, Store 02'                 | 'Yes'                                     | 'pcs'        | '10,000'   |
			| 'Service, Interner, Store 02'             | 'Yes'                                     | 'pcs'        | '1,000'    |
			| 'Boots, 36/18SD, Store 02'                | 'Yes'                                     | 'pcs'        | '60,000'   |
		And I go to line in "DocumentsTree" table
			| 'Row presentation'            |
			| 'Service, Interner, Store 02' |
		And I change "Use" checkbox in "DocumentsTree" table
		And I finish line editing in "DocumentsTree" table
		And I click "Ok" button
	* Check filling in SI
		Then the form attribute named "Partner" became equal to "Ferron BP"
		Then the form attribute named "LegalName" became equal to "Company Ferron BP"
		Then the form attribute named "Agreement" became equal to "Basic Partner terms, TRY"
		Then the form attribute named "Company" became equal to "Main Company"
		Then the form attribute named "Store" became equal to "Store 02"
		And "ItemList" table became equal
			| '#' | 'Business unit' | 'Price type'        | 'Item'  | 'Item key' | 'Dont calculate row' | 'Serial lot numbers' | 'Q'      | 'Unit'           | 'Tax amount' | 'Price'    | 'VAT' | 'Offers amount' | 'Net amount' | 'Total amount' | 'Additional analytic' | 'Store'    | 'Delivery date' | 'Use shipment confirmation' | 'Detail' | 'Sales order'                             | 'Revenue type' |
			| '1' | ''              | 'Basic Price Types' | 'Dress' | 'XS/Blue'  | 'No'                 | ''                   | '1,000'  | 'pcs'            | '75,36'      | '520,00'   | '18%' | '26,00'         | '418,64'     | '494,00'       | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | 'Sales order 3 dated 27.01.2021 19:50:45' | ''             |
			| '2' | ''              | 'Basic Price Types' | 'Shirt' | '36/Red'   | 'No'                 | ''                   | '10,000' | 'pcs'            | '507,20'     | '350,00'   | '18%' | '175,00'        | '2 817,80'   | '3 325,00'     | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | 'Sales order 3 dated 27.01.2021 19:50:45' | ''             |
			| '3' | ''              | 'Basic Price Types' | 'Boots' | '36/18SD'  | 'No'                 | ''                   | '5,000'  | 'Boots (12 pcs)' | '6 406,78'   | '8 400,00' | '18%' | ''              | '35 593,22'  | '42 000,00'    | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | 'Sales order 3 dated 27.01.2021 19:50:45' | ''             |

		And "SpecialOffers" table contains lines
			| '#' | 'Amount' |
			| '1' | '26,00'  |
			| '2' | '175,00' |

		Then the number of "PaymentTerms" table lines is "равно" 0
		And "ObjectCurrencies" table became equal
			| 'Movement type'      | 'Type'         | 'Currency from' | 'Currency' | 'Rate presentation' | 'Multiplicity' | 'Amount'   |
			| 'TRY'                | 'Partner term' | 'TRY'           | 'TRY'      | '1'                 | '1'            | '45 819'   |
			| 'Local currency'     | 'Legal'        | 'TRY'           | 'TRY'      | '1'                 | '1'            | '45 819'   |
			| 'Reporting currency' | 'Reporting'    | 'TRY'           | 'USD'      | '0,1712'            | '1'            | '7 844,21' |


		Then the number of "ShipmentConfirmationsTree" table lines is "равно" 0
		Then the form attribute named "ManagerSegment" became equal to "Region 1"
		Then the form attribute named "BusinessUnit" became equal to ""
		Then the form attribute named "Author" became equal to "en description is empty"
		Then the form attribute named "Manager" became equal to ""
		Then the form attribute named "PriceIncludeTax" became equal to "Yes"
		Then the form attribute named "Currency" became equal to "TRY"
		And the editing text of form attribute named "DeliveryDate" became equal to "27.01.2021"
		And the editing text of form attribute named "ItemListTotalOffersAmount" became equal to "201,00"
		Then the form attribute named "ItemListTotalNetAmount" became equal to "38 829,66"
		Then the form attribute named "ItemListTotalTaxAmount" became equal to "6 989,34"
		And the editing text of form attribute named "ItemListTotalTotalAmount" became equal to "45 819,00"
		Then the form attribute named "CurrencyTotalAmount" became equal to "TRY"
	* Change quantity
		And I go to line in "ItemList" table
			| 'Item'  | 'Item key' | 'Q'      |
			| 'Shirt' | '36/Red'   | '10,000' |
		And I activate field named "ItemListQuantity" in "ItemList" table
		And I select current line in "ItemList" table
		And I input "5,000" text in the field named "ItemListQuantity" of "ItemList" table
		And I finish line editing in "ItemList" table
		And I click the button named "FormPost"
		And I delete "$$SalesInvoice024008$$" variable
		And I delete "$$NumberSalesInvoice024008$$" variable
		And I save the window as "$$SalesInvoice024008$$"
		And I save the value of "Number" field as "$$NumberSalesInvoice024008$$"
		And I click the button named "FormPostAndClose"
  
		

Scenario: _024002 check filling in Row Id info table in the SI
	* Select SI
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number'                     |
			| '$$NumberSalesInvoice024008$$' |
		And I select current line in "List" table
		And I click "Show row key" button
		And I go to line in "ItemList" table
			| '#' |
			| '1' |
		And I activate "Key" field in "ItemList" table
		And I save the current field value as "$$Rov1SalesInvoice023002$$"
		And I go to line in "ItemList" table
			| '#' |
			| '2' |
		And I activate "Key" field in "ItemList" table
		And I save the current field value as "$$Rov2SalesInvoice023002$$"
		And I go to line in "ItemList" table
			| '#' |
			| '3' |
		And I activate "Key" field in "ItemList" table
		And I save the current field value as "$$Rov3SalesInvoice023002$$"
	* Check Row Id info table
		And I move to "Row ID" tab
		And "RowIDInfo" table contains lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'     | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '1,000' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | ''          | '60,000'| 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
		Then the number of "RowIDInfo" table lines is "равно" "3"
	* Copy string and check Row ID Info tab
		And I move to "Item list" tab
		And I go to line in "ItemList" table
			| '#' | 'Item'  | 'Item key' | 'Q'     |
			| '1' | 'Dress' | 'XS/Blue'  | '1,000' |
		And in the table "ItemList" I click "Copy" button
		And I activate field named "ItemListQuantity" in "ItemList" table
		And I input "8,000" text in the field named "ItemListQuantity" of "ItemList" table
		And I finish line editing in "ItemList" table
		And I go to line in "ItemList" table
			| '#' |
			| '4' |
		And I activate "Key" field in "ItemList" table
		And I save the current field value as "$$Rov4SalesInvoice023002$$"
		And I move to "Row ID" tab
		And I click the button named "FormPost"
		And "RowIDInfo" table contains lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'      | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '1,000'  | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000'  | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | ''          | '60,000' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
			| '$$Rov4SalesInvoice023002$$' | ''                                        | '$$Rov4SalesInvoice023002$$'           | ''          | '8,000'  | ''                                     | ''             | '$$Rov4SalesInvoice023002$$'           |
		Then the number of "RowIDInfo" table lines is "равно" "4"
		And "RowIDInfo" table does not contain lines
			| 'Key'                        | 'Q'     |
			| '$$Rov1SalesInvoice023002$$' | '8,000' |
	* Delete string and check Row ID Info tab
		And I move to "Item list" tab
		And I go to line in "ItemList" table
			| '#' | 'Item'  | 'Item key' | 'Q'     |
			| '4' | 'Dress' | 'XS/Blue'  | '8,000' |
		And in the table "ItemList" I click "Delete" button
		And I move to "Row ID" tab
		And "RowIDInfo" table contains lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'      | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '1,000'  | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000'  | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | ''          | '60,000' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
		Then the number of "RowIDInfo" table lines is "равно" "3"
	* Change quantity and check  Row ID Info tab
		And I move to "Item list" tab
		And I go to line in "ItemList" table
			| '#' | 'Item'  | 'Item key' | 'Q'     |
			| '1' | 'Dress' | 'XS/Blue'  | '1,000' |
		And I activate "Q" field in "ItemList" table
		And I select current line in "ItemList" table
		And I input "7,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And "RowIDInfo" table contains lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'      | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '7,000'  | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000'  | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | ''          | '60,000' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
		Then the number of "RowIDInfo" table lines is "равно" "3"
		And I move to "Item list" tab
		And I go to line in "ItemList" table
			| '#' | 'Item'  | 'Item key' | 'Q'     |
			| '1' | 'Dress' | 'XS/Blue'  | '7,000' |
		And I activate "Q" field in "ItemList" table
		And I select current line in "ItemList" table
		And I input "1,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
	* Change checkbox Use Shipment confirmation and check RowIDInfo
		And I move to "Item list" tab
		And I go to line in "ItemList" table
			| 'Item'  | 'Item key' | 'Q'     | 'Unit'           |
			| 'Boots' | '36/18SD'  | '5,000' | 'Boots (12 pcs)' |
		And I set "Use shipment confirmation" checkbox in "ItemList" table
		And I move to the tab named "GroupRowID"
		And I click "Post" button
		And "RowIDInfo" table contains lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'      | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '7,000'  | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000'  | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SC'        | '60,000' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
		Then the number of "RowIDInfo" table lines is "равно" "3"	
		And I click the button named "FormPostAndClose"





	
Scenario: _024003 copy SI (based on SO) and check filling in Row Id info table
	* Copy SI
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number'                     |
			| '$$NumberSalesInvoice024008$$' |
		And in the table "List" I click the button named "ListContextMenuCopy"
	* Check copy info
		Then the form attribute named "Partner" became equal to "Ferron BP"
		Then the form attribute named "LegalName" became equal to "Company Ferron BP"
		Then the form attribute named "Agreement" became equal to "Basic Partner terms, TRY"
		Then the form attribute named "Description" became equal to "Click to enter description"
		Then the form attribute named "Company" became equal to "Main Company"
		Then the form attribute named "Store" became equal to "Store 02"
		And "ItemList" table became equal
			| '#' | 'Business unit' | 'Price type'        | 'Item'  | 'Item key' | 'Dont calculate row' | 'Serial lot numbers' | 'Q'     | 'Unit'           | 'Tax amount' | 'Price'    | 'VAT' | 'Offers amount' | 'Net amount' | 'Total amount' | 'Additional analytic' | 'Store'    | 'Delivery date' | 'Use shipment confirmation' | 'Detail' | 'Sales order' | 'Revenue type' |
			| '1' | ''              | 'Basic Price Types' | 'Dress' | 'XS/Blue'  | 'No'                 | ''                   | '1,000' | 'pcs'            | '79,32'      | '520,00'   | '18%' | ''              | '440,68'     | '520,00'       | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | ''            | ''             |
			| '2' | ''              | 'Basic Price Types' | 'Shirt' | '36/Red'   | 'No'                 | ''                   | '5,000' | 'pcs'            | '240,25'     | '350,00'   | '18%' | '175,00'        | '1 334,75'   | '1 575,00'     | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | ''            | ''             |
			| '3' | ''              | 'Basic Price Types' | 'Boots' | '36/18SD'  | 'No'                 | ''                   | '5,000' | 'Boots (12 pcs)' | '6 406,78'   | '8 400,00' | '18%' | ''              | '35 593,22'  | '42 000,00'    | ''                    | 'Store 02' | '27.01.2021'    | 'No'                        | ''       | ''            | ''             |

		And "ObjectCurrencies" table became equal
			| 'Movement type'      | 'Type'         | 'Currency from' | 'Currency' | 'Rate presentation' | 'Multiplicity' | 'Amount'   |
			| 'TRY'                | 'Partner term' | 'TRY'           | 'TRY'      | '1'                 | '1'            | '44 095'   |
			| 'Local currency'     | 'Legal'        | 'TRY'           | 'TRY'      | '1'                 | '1'            | '44 095'   |
			| 'Reporting currency' | 'Reporting'    | 'TRY'           | 'USD'      | '0,1712'            | '1'            | '7 549,06' |

		Then the form attribute named "BusinessUnit" became equal to ""
		Then the form attribute named "Author" became equal to "en description is empty"
		Then the form attribute named "PriceIncludeTax" became equal to "Yes"
		Then the form attribute named "Currency" became equal to "TRY"
		Then the form attribute named "ItemListTotalNetAmount" became equal to "37 368,65"
		Then the form attribute named "ItemListTotalTaxAmount" became equal to "6 726,35"
		And the editing text of form attribute named "ItemListTotalTotalAmount" became equal to "44 095,00"
		Then the form attribute named "CurrencyTotalAmount" became equal to "TRY"
	* Post SI and check Row ID Info tab
		And I click the button named "FormPost"
		And I move to "Row ID" tab
		And "RowIDInfo" table does not contain lines
			| 'Key'                        | 'Basis'                                   | 'Row ID'                               | 'Next step' | 'Q'      | 'Basis key'                            | 'Current step' | 'Row ref'                              |
			| '$$Rov1SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | ''          | '7,000'  | '0cb89084-5857-45fc-b333-4fbec2c2e90a' | 'SI&SC'        | '0cb89084-5857-45fc-b333-4fbec2c2e90a' |
			| '$$Rov2SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | ''          | '5,000'  | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' | 'SI&SC'        | '3a8fe357-b7bd-4d83-8816-c8348bbf4595' |
			| '$$Rov3SalesInvoice023002$$' | 'Sales order 3 dated 27.01.2021 19:50:45' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | ''          | '60,000' | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' | 'SI&SC'        | 'db32e58d-ac68-45b6-b0b5-b90d6c02fbff' |
		Then the number of "RowIDInfo" table lines is "равно" "3"
		And I close all client application windows			
		
// Scenario: _024004 create SI based on SO, with SC




	

Scenario: _024025 create document Sales Invoice without Sales order and check Row ID
	When create SalesInvoice024025
	* Check Row Id
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number'                     |
			| '$$NumberSalesInvoice024008$$' |
		And I select current line in "List" table
		And I click "Show row key" button
		And I go to line in "ItemList" table
			| '#' |
			| '1' |
		And I activate "Key" field in "ItemList" table
		And I save the current field value as "$$Rov1SalesInvoice024025$$"
		And I move to "Row ID" tab
		And "RowIDInfo" table contains lines
			| '#' | 'Key'                    | 'Basis' | 'Row ID'                 | 'Next step' | 'Q'      | 'Basis key' | 'Current step' | 'Row ref'                |
			| '1' | 'Rov1SalesInvoice024025' | ''      | 'Rov1SalesInvoice024025' | ''          | '20,000' | ''          | ''             | 'Rov1SalesInvoice024025' |
		Then the number of "RowIDInfo" table lines is "равно" "1"
	* Check next step
		And I move to "Item list" tab
		And I activate "Use shipment confirmation" field in "ItemList" table
		And I change "Use shipment confirmation" checkbox in "ItemList" table
		And I finish line editing in "ItemList" table
		And I move to the tab named "GroupRowID"
		And I click "Post" button
		And "RowIDInfo" table contains lines
			| '#' | 'Key'                    | 'Basis' | 'Row ID'                 | 'Next step' | 'Q'      | 'Basis key' | 'Current step' | 'Row ref'                |
			| '1' | 'Rov1SalesInvoice024025' | ''      | 'Rov1SalesInvoice024025' | 'SC'        | '20,000' | ''          | ''             | 'Rov1SalesInvoice024025' |
		And I close all client application windows
		

		
				

# Scenario: _024035 check the form of selection of items (sales invoice)
# 	Given I open hyperlink "e1cib/list/Document.SalesInvoice"
# 	And I click the button named "FormCreate"
# 	* Filling in the main details of the document
# 		And I click Select button of "Partner" field
# 		And I go to line in "List" table
# 			| 'Description' |
# 			| 'Ferron BP'  |
# 		And I select current line in "List" table
# 		And I click Select button of "Partner term" field
# 		And I go to line in "List" table
# 			| 'Description'       |
# 			| 'Basic Partner terms, TRY' |
# 		And I select current line in "List" table
# 		And I click Select button of "Legal name" field
# 		And I go to line in "List" table
# 			| 'Description' |
# 			| 'Company Ferron BP'  |
# 		And I select current line in "List" table
# 	* Select Store
# 		And I click Select button of "Store" field
# 		And I go to line in "List" table
# 			| 'Description' |
# 			| 'Store 01'  |
# 		And I select current line in "List" table
# 	When check the product selection form with price information in Sales invoice
# 	And I click the button named "FormPostAndClose"
# 	* Save check
# 		And "List" table contains lines
# 			| 'Partner'     |'Σ'          |
# 			| 'Ferron BP'   | '2 050,00'  |
# 	And I close all client application windows



Scenario: _024042 check totals in the document Sales invoice
	Given I open hyperlink "e1cib/list/Document.SalesInvoice"
	* Select Sales invoice
		And I go to line in "List" table
		| 'Number' |
		| '$$NumberSalesInvoice024008$$'      |
		And I select current line in "List" table
	* Check totals
		Then the form attribute named "ItemListTotalOffersAmount" became equal to "175,00"
		Then the form attribute named "ItemListTotalNetAmount" became equal to "37 368,65"
		Then the form attribute named "ItemListTotalTaxAmount" became equal to "6 726,35"
		Then the form attribute named "ItemListTotalTotalAmount" became equal to "44 095,00"
		Then the form attribute named "CurrencyTotalAmount" became equal to "TRY"




Scenario: _300505 check connection to Sales invoice report "Related documents"
	Given I open hyperlink "e1cib/list/Document.SalesInvoice"
	* Form report Related documents
		And I go to line in "List" table
		| 'Number' |
		| '$$NumberSalesInvoice024008$$'      |
		And I click the button named "FormFilterCriterionRelatedDocumentsRelatedDocuments"
		And Delay 1
	Then "Related documents" window is opened
	And I close all client application windows







	
















	




