﻿#language: en
@tree
@Positive
@Group10

Feature: tax calculation check


# individually applying Tax types

Background:
	Given I launch TestClient opening script or connect the existing one



	
Scenario: _0902000 preparation
	* Constants
		When set True value to the constant
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
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog Countries objects
		When Create catalog BusinessUnits objects 
	* Tax settings
		When filling in Tax settings for company
	* Filling tax rates for Item key in the register
		Given I open hyperlink "e1cib/list/InformationRegister.TaxSettings"
		And I click the button named "FormCreate"
		And I change "RecordType" radio button value to "Item key"
		And I click Select button of "Company" field
		And I go to line in "List" table
			| 'Description'  |
			| 'Main Company' |
		And I select current line in "List" table
		And I click Select button of "Tax" field
		And I go to line in "List" table
			| 'Description' | 'Reference' |
			| 'VAT'         | 'VAT'       |
		And I select current line in "List" table
		And I click Select button of "Item key" field
		And I go to line in "List" table
			| 'Item' | 'Item key' |
			| 'Bag'  | 'ODS'      |
		And I select current line in "List" table
		And I select "0%" exact value from "Tax rate" drop-down list
		And I input "01.01.2020" text in "Period" field
		And I click "Save and close" button
	* Filling tax rates for Item in the register
		Given I open hyperlink "e1cib/list/InformationRegister.TaxSettings"
		And I click the button named "FormCreate"
		And I change "RecordType" radio button value to "Item"
		And I click Select button of "Company" field
		And I go to line in "List" table
			| 'Description'  |
			| 'Main Company' |
		And I select current line in "List" table
		And I click Select button of "Tax" field
		And I go to line in "List" table
			| 'Description' | 'Reference' |
			| 'VAT'         | 'VAT'       |
		And I select current line in "List" table
		And I click Select button of "Item" field
		And I go to line in "List" table
			| 'Description' |
			| 'Bag'         |
		And I select current line in "List" table
		And I select "18%" exact value from "Tax rate" drop-down list
		And I input "01.01.2020" text in "Period" field
		And I click "Save and close" button
	* Filling tax rates for Item type in the register
		Given I open hyperlink "e1cib/list/InformationRegister.TaxSettings"
		And I click the button named "FormCreate"
		And I change "RecordType" radio button value to "Item type"
		And I click Select button of "Company" field
		And I go to line in "List" table
			| 'Description'  |
			| 'Main Company' |
		And I select current line in "List" table
		And I click Select button of "Tax" field
		And I go to line in "List" table
			| 'Description' | 'Reference' |
			| 'VAT'         | 'VAT'       |
		And I select current line in "List" table
		And I click Select button of "Item type" field
		And I go to line in "List" table
			| 'Description' |
			| 'Bags'         |
		And I select current line in "List" table
		And I select "18%" exact value from "Tax rate" drop-down list
		And I input "01.01.2020" text in "Period" field
		And I click "Save and close" button
	And I close all client application windows


Scenario: _090200 activating Sales Tax calculation in the Sales order and Sales invoice documents
	* Opening a tax creation form
		Given I open hyperlink "e1cib/list/Catalog.Taxes"
		If "List" table does not contain lines Then
				| "Description" |
				| "SalesTax" |
			And I click the button named "FormCreate"
		* Filling in Sales Tax rate settings
			And I input "SalesTax" text in the field named "Description_en"
			And I click Select button of "Plugins" field
			And I go to line in "List" table
				| 'Description'        |
				| 'TaxCalculateVAT_TR' |
			And I select current line in "List" table
			And in the table "TaxRates" I click the button named "TaxRatesAdd"
			And I click choice button of "Tax rate" attribute in "TaxRates" table
			And I click the button named "FormCreate"
			Then "Tax rate (create)" window is opened
			And I input "1%" text in "ENG" field
			And I input "1,000000000000" text in "Rate" field
			And I click "Save and close" button
			And I go to line in "List" table
				| 'Description' |
				| '1%'          |
			And I click the button named "FormChoose"
			And I finish line editing in "TaxRates" table
			And I click "Save" button
			And I click "Settings" button
			And I click "Ok" button
			And I move to "Use documents" tab
			And in the table "UseDocuments" I click the button named "UseDocumentsAdd"
			And I select "Sales order" exact value from "Document name" drop-down list in "UseDocuments" table
			And I finish line editing in "UseDocuments" table
			And in the table "UseDocuments" I click the button named "UseDocumentsAdd"
			And I select "Sales invoice" exact value from "Document name" drop-down list in "UseDocuments" table
			And I finish line editing in "UseDocuments" table
			And I click "Save and close" button
	Given I open hyperlink "e1cib/list/InformationRegister.Taxes"
	If "List" table does not contain lines Then
		| 'Tax'      |
		| 'SalesTax' |
		And I click the button named "FormCreate"
		And I click Select button of "Company" field
		And I go to line in "List" table
			| 'Description'  |
			| 'Main Company' |
		And I select current line in "List" table
		And I input "01.01.2020" text in "Period" field
		And I click Select button of "Tax" field
		And I go to line in "List" table
			| 'Description' |
			| 'SalesTax'    |
		And I select current line in "List" table
		And I set checkbox "Use"
		And I input "8" text in "Priority" field
		And I click "Save and close" button
	Given I open hyperlink "e1cib/list/InformationRegister.TaxSettings"
	If "List" table does not contain lines Then
				| "Description" |
				| "SalesTax" |
			And I click the button named "FormCreate"
			And I click Select button of "Company" field
			And I go to line in "List" table
				| 'Description'  |
				| 'Main Company' |
			And I select current line in "List" table
			And I click Select button of "Tax" field
			And I go to line in "List" table
				| 'Description' |
				| 'SalesTax'    |
			And I select current line in "List" table
			And I click Select button of "Tax rate" field
			And I select "1%" exact value from "Tax rate" drop-down list	
			And I click "Save and close" button
	
		




Scenario: _090201 VAT and Sales Tax calculation in Sales order (Price include tax box is set)
	* Open the Sales order creation form
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I click the button named "FormCreate"
	* Filling in the details of the document
		And I click Select button of "Partner" field
		And I go to line in "List" table
			| 'Description' |
			| 'Ferron BP'   |
		And I select current line in "List" table
		And I click Select button of "Legal name" field
		And I go to line in "List" table
			| 'Description'       |
			| 'Company Ferron BP' |
		And I select current line in "List" table
		And I click Select button of "Partner term" field
		And I go to line in "List" table
			| 'Description'           |
			| 'Basic Partner terms, TRY' |
		And I select current line in "List" table
	* Adding items to Sales order
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Trousers'    |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '38/Yellow' |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I input "1,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
	* Check the calculation of VAT and Sales Tax
		And "ItemList" table contains lines
		| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Procurement method' | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
		| '400,00' | 'Trousers' | '18%' | '38/Yellow' | 'Stock'              | '1,000' | '64,98'      | '1%'       | 'pcs'  | '335,02'     | '400,00'       |
		And "TaxTree" table contains lines
		| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
		| 'VAT'      | ''         | ''         | ''          | ''          | '61,02'  | '61,02'         |
		| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '61,02'  | '61,02'         |
		| 'SalesTax' | ''         | ''         | ''          | ''          | '3,96'   | '3,96'          |
		| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '3,96'   | '3,96'          |
	* Add one more line and check the calculation of VAT and Sales Tax
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Boots'       |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'  | 'Item key' |
			| 'Boots' | '37/18SD'  |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I move to the next attribute
		And I input "2,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount' | 'SalesTax' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | '1,000' | '64,98'      | '1%'       | '335,02'     | '400,00'       |
			| '700,00' | 'Boots'    | '18%' | '37/18SD'   | '2,000' | '227,42'     | '1%'       | '1 172,58'   | '1 400,00'     |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '274,58' | '274,58'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '61,02'  | '61,02'         |
			| 'VAT'      | '18%'      | 'Boots'    | '37/18SD'   | ''          | '213,56' | '213,56'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '17,82'  | '17,82'         |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '3,96'   | '3,96'          |
			| 'SalesTax' | '1%'       | 'Boots'    | '37/18SD'   | ''          | '13,86'  | '13,86'         |
	* Deleting the row and checking the VAT and Sales Tax recalculation
		And I go to line in "ItemList" table
		| 'Item'     | 'Item key'  |
		| 'Trousers' | '38/Yellow' |
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I delete a line in "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'  | 'VAT' | 'Item key' | 'Q'     | 'Tax amount' | 'SalesTax' | 'Net amount' | 'Total amount' |
			| '700,00' | 'Boots' | '18%' | '37/18SD'  | '2,000' | '227,42'     | '1%'       | '1 172,58'   | '1 400,00'     |
		And "TaxTree" table became equal
			| 'Tax'      | 'Tax rate' | 'Item' | 'Item key' | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''     | ''         | ''          | '213,56' | '213,56'        |
			| 'SalesTax' | ''         | ''     | ''         | ''          | '13,86'  | '13,86'         |
		And I close all client application windows

Scenario: _090202 VAT and Sales Tax calculation in Sales order (Price include tax box isn't set)
	* Open the Sales order creation form
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I click the button named "FormCreate"
	* Filling in the details of the document
		And I click Select button of "Partner" field
		And I go to line in "List" table
			| 'Description' |
			| 'Ferron BP'   |
		And I select current line in "List" table
		And I click Select button of "Legal name" field
		And I go to line in "List" table
			| 'Description'       |
			| 'Company Ferron BP' |
		And I select current line in "List" table
		And I click Select button of "Partner term" field
		And I go to line in "List" table
			| 'Description'           |
			| 'Basic Partner terms, TRY' |
		And I select current line in "List" table
		And I move to "Other" tab
		And I expand "More" group
		And I remove checkbox "Price include tax"
	* Adding items to Sales order
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Trousers'    |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '38/Yellow' |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I input "1,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
	* Check the calculation of VAT and Sales Tax
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | '1,000' | '76,00'      | '1%'       | 'pcs'  | '400,00'     | '476,00'       |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '72,00'  | '72,00'         |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '72,00'  | '72,00'         |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '4,00'   | '4,00'          |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '4,00'   | '4,00'          |
	* Add one more line and check the calculation of VAT and Sales Tax
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Boots'       |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'  | 'Item key' |
			| 'Boots' | '37/18SD'  |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I move to the next attribute
		And I input "2,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Procurement method' | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | 'Stock'              | '1,000' | '76,00'      | '1%'       | 'pcs'  | '400,00'     | '476,00'       |
			| '700,00' | 'Boots'    | '18%' | '37/18SD'   | 'Stock'              | '2,000' | '266,00'     | '1%'       | 'pcs'  | '1 400,00'   | '1 666,00'     |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '324,00' | '324,00'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '72,00'  | '72,00'         |
			| 'VAT'      | '18%'      | 'Boots'    | '37/18SD'   | ''          | '252,00' | '252,00'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '18,00'  | '18,00'         |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '4,00'   | '4,00'          |
			| 'SalesTax' | '1%'       | 'Boots'    | '37/18SD'   | ''          | '14,00'  | '14,00'         |
	* Deleting the row and checking the VAT and Sales Tax recalculation
		And I go to line in "ItemList" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '38/Yellow' |
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I delete a line in "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Offers amount' | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '700,00' | 'Boots'    | '18%' | '37/18SD'   | '2,000' | ''              | '266,00'     | '1%'       | 'pcs'  | '1 400,00'   | '1 666,00'     |
		And "TaxTree" table became equal
			| 'Tax'      | 'Tax rate' | 'Item' | 'Item key' | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''     | ''         | ''          | '252,00' | '252,00'        |
			| 'SalesTax' | ''         | ''     | ''         | ''          | '14,00'  | '14,00'         |
		And I close all client application windows

Scenario: _090203 manual tax correction in Sales order
	* Open the Sales order creation form
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I click the button named "FormCreate"
	* Filling in the details of the document
		And I click Select button of "Partner" field
		And I go to line in "List" table
			| 'Description' |
			| 'Ferron BP'   |
		And I select current line in "List" table
		And I click Select button of "Legal name" field
		And I go to line in "List" table
			| 'Description'       |
			| 'Company Ferron BP' |
		And I select current line in "List" table
		And I click Select button of "Partner term" field
		And I go to line in "List" table
			| 'Description'           |
			| 'Basic Partner terms, TRY' |
		And I select current line in "List" table
		And I move to "Other" tab
		And I expand "More" group
		And I remove checkbox "Price include tax"
	* Adding items to Sales order
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Trousers'    |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '38/Yellow' |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I input "1,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
	* Manual tax correction and check display
		And I move to "Tax list" tab
		And I go to line in "TaxTree" table
			| 'Amount' | 'Item'     |
			| '72,00'  | 'Trousers' |
		And I select current line in "TaxTree" table
		And I input "71,00" text in "Manual amount" field of "TaxTree" table
		And Delay 60
		And I expand current line in "TaxTree" table
		And I move to "Item list" tab
	* Save verification
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | '1,000' | '75,00'      | '1%'       | 'pcs'  | '400,00'     | '475,00'       |
		And "TaxTree" table became equal
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '72,00'  | '71,00'         |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '72,00'  | '71,00'         |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '4,00'   | '4,00'          |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '4,00'   | '4,00'          |
	* Check deleting manual correction when quantity changes
		And I activate "Q" field in "ItemList" table
		And I select current line in "ItemList" table
		And I input "2,000" text in "Q" field of "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount'  | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | '2,000' | '152,00'      | '1%'       | 'pcs'   | '800,00'      | '952,00'     |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '144,00' | '144,00'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '144,00' | '144,00'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '8,00'   | '8,00'          |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '8,00'   | '8,00'          |
	* Check deleting manual correction when price changes
		And I move to "Tax list" tab
		And I go to line in "TaxTree" table
			| 'Item'     | 'Item key'  | 'Tax' | 'Tax rate' |
			| 'Trousers' | '38/Yellow' | 'VAT' | '18%'      |
		And I activate field named "TaxTreeAmount" in "TaxTree" table
		And I select current line in "TaxTree" table
		And I activate "Manual amount" field in "TaxTree" table
		And I select current line in "TaxTree" table
		And I input "142,00" text in "Manual amount" field of "TaxTree" table
		And I finish line editing in "TaxTree" table
		And "ItemList" table contains lines
			| 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| 'Trousers' | '18%' | '38/Yellow' | '2,000' | '150,00'     | '1%'       | 'pcs'  | '800,00'     | '950,00'     |
		And I move to "Item list" tab
		And I activate "Price" field in "ItemList" table
		And I select current line in "ItemList" table
		And I input "510,00" text in "Price" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '183,60' | '183,60'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '183,60' | '183,60'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '10,20'  | '10,20'         |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '10,20'  | '10,20'         |
	* Check deleting manual correction when iten key changes
		And I move to "Tax list" tab
		And I go to line in "TaxTree" table
			| 'Item'     | 'Item key'  | 'Tax' | 'Tax rate' |
			| 'Trousers' | '38/Yellow' | 'VAT' | '18%'      |
		And I activate field named "TaxTreeAmount" in "TaxTree" table
		And I select current line in "TaxTree" table
		And I activate "Manual amount" field in "TaxTree" table
		And I select current line in "TaxTree" table
		And I input "182,00" text in "Manual amount" field of "TaxTree" table
		And I finish line editing in "TaxTree" table
		And I move to "Item list" tab
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Tax amount' | 'SalesTax' | 'Unit' | 'Net amount' | 'Total amount' |
			| '510,00' | 'Trousers' | '18%' | '38/Yellow' | '2,000' | '192,20'     | '1%'       | 'pcs'  | '1 020,00'   | '1 212,20'     |
		And I activate "Item key" field in "ItemList" table
		And I select current line in "ItemList" table
		And I click choice button of "Item key" attribute in "ItemList" table
		And I go to line in "List" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '36/Yellow' |
		And I select current line in "List" table
		And "TaxTree" table contains lines
		| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
		| 'VAT'      | ''         | ''         | ''          | ''          | '144,00' | '144,00'        |
		| 'VAT'      | '18%'      | 'Trousers' | '36/Yellow' | ''          | '144,00' | '144,00'        |
		| 'SalesTax' | ''         | ''         | ''          | ''          | '8,00'   | '8,00'          |
		| 'SalesTax' | '1%'       | 'Trousers' | '36/Yellow' | ''          | '8,00'   | '8,00'          |
	* Manual selection of tax rate
		And I activate "VAT" field in "ItemList" table
		And I select "0%" exact value from "VAT" drop-down list in "ItemList" table
		And "TaxTree" table became equal
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | ''       | ''              |
			| 'VAT'      | '0%'       | 'Trousers' | '36/Yellow' | ''          | ''       | ''              |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '8,00'   | '8,00'          |
			| 'SalesTax' | '1%'       | 'Trousers' | '36/Yellow' | ''          | '8,00'   | '8,00'          |
	And I close all client application windows


Scenario: _090204 check tax transfer in Sales invoice when it is created based on
	* Create Sales order
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I click the button named "FormCreate"
		And I click Select button of "Partner" field
		And I go to line in "List" table
			| 'Description' |
			| 'Ferron BP'   |
		And I select current line in "List" table
		And I click Select button of "Legal name" field
		And I go to line in "List" table
			| 'Description'       |
			| 'Company Ferron BP' |
		And I select current line in "List" table
		And I click Select button of "Partner term" field
		And I go to line in "List" table
			| 'Description'           |
			| 'Basic Partner terms, TRY' |
		And I select current line in "List" table
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Trousers'    |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'     | 'Item key'  |
			| 'Trousers' | '38/Yellow' |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I input "1,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Boots'       |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item'  | 'Item key' |
			| 'Boots' | '37/18SD'  |
		And I select current line in "List" table
		And I activate "Procurement method" field in "ItemList" table
		And I select "Stock" exact value from "Procurement method" drop-down list in "ItemList" table
		And I move to the next attribute
		And I input "2,000" text in "Q" field of "ItemList" table
		And I finish line editing in "ItemList" table
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Price type'        | 'Q'     | 'Unit' | 'SalesTax' | 'Tax amount' | 'Net amount' | 'Total amount' |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | 'Basic Price Types' | '1,000' | 'pcs'  | '1%'       | '64,98'      | '335,02'     | '400,00'       |
			| '700,00' | 'Boots'    | '18%' | '37/18SD'   | 'Basic Price Types' | '2,000' | 'pcs'  | '1%'       | '227,42'     | '1 172,58'   | '1 400,00'     |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '274,58' | '274,58'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '61,02'  | '61,02'         |
			| 'VAT'      | '18%'      | 'Boots'    | '37/18SD'   | ''          | '213,56' | '213,56'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '17,82'  | '17,82'         |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '3,96'   | '3,96'          |
			| 'SalesTax' | '1%'       | 'Boots'    | '37/18SD'   | ''          | '13,86'  | '13,86'         |
		And I go to line in "TaxTree" table
			| 'Item'     | 'Item key'  | 'Tax' | 'Tax rate' |
			| 'Trousers' | '38/Yellow' | 'VAT' | '18%'      |
		And I activate field named "TaxTreeAmount" in "TaxTree" table
		And I select current line in "TaxTree" table
		And I activate "Manual amount" field in "TaxTree" table
		And I select current line in "TaxTree" table
		And I input "62,00" text in "Manual amount" field of "TaxTree" table
		And I finish line editing in "TaxTree" table
		// And I move to "Other" tab
		// And I expand "More" group
		// And I input "0" text in "Number" field
		// Then "1C:Enterprise" window is opened
		// And I click "Yes" button
		// And I input "3 000" text in "Number" field
		And I click "Post" button
		And I save the value of "Number" field as "$$NumberSalesInvoice090204$$"
		And I save the window as "$$SalesInvoice090204$$"
		And I click "Post" button
	* Create Sales invoice based on Sales order and check filling Tax types
		And I click "Sales invoice" button
		And "ItemList" table contains lines
			| 'Price'  | 'Item'     | 'VAT' | 'Item key'  | 'Q'     | 'Unit' | 'SalesTax' | 'Tax amount' | 'Net amount' | 'Total amount' | 'Store'    |
			| '400,00' | 'Trousers' | '18%' | '38/Yellow' | '1,000' | 'pcs'  | '1%'       | '65,96'      | '334,04'     | '400,00'       | 'Store 01' |
			| '700,00' | 'Boots'    | '18%' | '37/18SD'   | '2,000' | 'pcs'  | '1%'       | '227,42'     | '1 172,58'   | '1 400,00'     | 'Store 01' |
		And "TaxTree" table contains lines
			| 'Tax'      | 'Tax rate' | 'Item'     | 'Item key'  | 'Analytics' | 'Amount' | 'Manual amount' |
			| 'VAT'      | ''         | ''         | ''          | ''          | '274,58' | '275,56'        |
			| 'VAT'      | '18%'      | 'Trousers' | '38/Yellow' | ''          | '61,02'  | '62,00'         |
			| 'VAT'      | '18%'      | 'Boots'    | '37/18SD'   | ''          | '213,56' | '213,56'        |
			| 'SalesTax' | ''         | ''         | ''          | ''          | '17,82'  | '17,82'         |
			| 'SalesTax' | '1%'       | 'Trousers' | '38/Yellow' | ''          | '3,96'   | '3,96'          |
			| 'SalesTax' | '1%'       | 'Boots'    | '37/18SD'   | ''          | '13,86'  | '13,86'         |
		And I click "Post and close" button
		And I close all client application windows

Scenario: _090205 priority tax rate check on the example of Sales order
	Given I open hyperlink "e1cib/list/Document.SalesOrder"
	And I click the button named "FormCreate"
	* Filling in the details of the document Sales order
		And I click Select button of "Partner" field
		And I go to line in "List" table
			| 'Description' |
			| 'Kalipso'     |
		And I select current line in "List" table
		And I click Select button of "Partner term" field
		And I go to line in "List" table
			| 'Description'           |
			| 'Basic Partner terms, TRY' |
		And I select current line in "List" table
		And I click Select button of "Company" field
		And I go to line in "List" table
			| 'Description'  |
			| 'Main Company' |
		And I select current line in "List" table
	* Check the tax rate for Item key Bag ODS
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Bag'         |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item' | 'Item key' |
			| 'Bag'  | 'ODS'      |
		And I select current line in "List" table
		And "ItemList" table contains lines
			| 'Item' | 'VAT' | 'Item key' | 'Q'     |
			| 'Bag'  | '0%'  | 'ODS'      | '1,000' |
	* Check the tax rate by item
		And in the table "ItemList" I click the button named "ItemListAdd"
		And I click choice button of the attribute named "ItemListItem" in "ItemList" table
		And I go to line in "List" table
			| 'Description' |
			| 'Bag'         |
		And I select current line in "List" table
		And I activate field named "ItemListItemKey" in "ItemList" table
		And I click choice button of the attribute named "ItemListItemKey" in "ItemList" table
		And I go to line in "List" table
			| 'Item' | 'Item key' |
			| 'Bag'  | 'PZU'      |
		And I select current line in "List" table
		And "ItemList" table contains lines
			| 'Item' | 'VAT' | 'Item key' | 'Q'     |
			| 'Bag'  | '18%'  | 'PZU'      | '1,000' |
	And I close all client application windows
		




	




