﻿#language: en
@tree
@Positive
@Group11

Feature: check that the item marked for deletion is not displayed


As a developer
I want to hide the items marked for deletion from the product selection form.
So the user can't select it in the sales and purchase documents


Background:
	Given I launch TestClient opening script or connect the existing one


Scenario: _090201 check that the items marked for deletion is not displayed in the PurchaseOrder
	* Temporary markup for deletion Item Box
		Given I open hyperlink "e1cib/list/Catalog.Items"
		And I go to line in "List" table
		| Description |
		| Box         |
		And in the table "List" I click the button named "ListContextMenuSetDeletionMark"
		Then "1C:Enterprise" window is opened
		And I click "Yes" button
	Given I open hyperlink "e1cib/list/Document.PurchaseOrder"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description          |
		| Box               |
	And I close all client application windows

Scenario: _090202 check that the items marked for deletion is not displayed in the Purchase invoice
	Given I open hyperlink "e1cib/list/Document.PurchaseInvoice"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090203 check that the items marked for deletion is not displayed in the Sales order
	Given I open hyperlink "e1cib/list/Document.SalesOrder"
	And I click the button named "FormCreate"
	And in the table "ItemList" I click the button named "ItemListAdd"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090204 check that the items marked for deletion is not displayed in the Sales invoice
	Given I open hyperlink "e1cib/list/Document.SalesInvoice"
	And I click the button named "FormCreate"
	And in the table "ItemList" I click the button named "ItemListAdd"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows


Scenario: _090205 check that the items marked for deletion is not displayed in the Inventory transfer
	Given I open hyperlink "e1cib/list/Document.InventoryTransfer"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090206 check that the items marked for deletion is not displayed in the Inventory transfer order
	Given I open hyperlink "e1cib/list/Document.InventoryTransferOrder"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090207 check that the items marked for deletion is not displayed in the Internal Supply Request
	Given I open hyperlink "e1cib/list/Document.InternalSupplyRequest"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090208 check that the items marked for deletion is not displayed in the Purchase return order
	Given I open hyperlink "e1cib/list/Document.PurchaseReturnOrder"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090209 check that the items marked for deletion is not displayed in the Purchase return
	Given I open hyperlink "e1cib/list/Document.PurchaseReturn"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090210 check that the items marked for deletion is not displayed in the Sales Return
	Given I open hyperlink "e1cib/list/Document.SalesReturn"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090211 check that the items marked for deletion is not displayed in the Sales return order
	Given I open hyperlink "e1cib/list/Document.SalesReturnOrder"
	And I click the button named "FormCreate"
	And in the table "ItemList" I click the button named "ItemListAdd"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090212 check that the items marked for deletion is not displayed in the GoodsReceipt
	Given I open hyperlink "e1cib/list/Document.GoodsReceipt"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090213 check that the items marked for deletion is not displayed in the Shipment Confirmation
	Given I open hyperlink "e1cib/list/Document.ShipmentConfirmation"
	And I click the button named "FormCreate"
	And I click the button named "Add"
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows


Scenario: _090216 check that the items marked for deletion is not displayed in the Bundling
	Given I open hyperlink "e1cib/list/Document.Bundling"
	And I click the button named "FormCreate"
	And I click Select button of "Item bundle" field
	Then "Items" window is opened
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close "Items" window
	And I move to "Item list" tab
	And in the table "ItemList" I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090217 check that the items marked for deletion is not displayed in the Unbundling
	Given I open hyperlink "e1cib/list/Document.Unbundling"
	And I click the button named "FormCreate"
	And I click Select button of "Item bundle" field
	Then "Items" window is opened
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close "Items" window
	And I move to "Item list" tab
	And in the table "ItemList" I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090218 check that the items marked for deletion is not displayed in the PhysicalInventory
	Given I open hyperlink "e1cib/list/Document.PhysicalInventory"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090219 check that the items marked for deletion is not displayed in the StockAdjustmentAsSurplus
	Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsSurplus"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows

Scenario: _090220 check that the items marked for deletion is not displayed in the StockAdjustmentAsWriteOff
	Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsWriteOff"
	And I click the button named "FormCreate"
	And I click "Add" button
	And I click choice button of "Item" attribute in "ItemList" table
	And "List" table does not contain lines
		| Description       |
		| Box               |
	And I close all client application windows