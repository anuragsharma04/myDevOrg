public class BookOrderHandler {
    public static void handleAfterUpdate(List<BookOrder__c> newbookorderlist) {
        Set<Id> bookOrderIds = new Set<Id>();
        Set<Id> processedBookOrderIds = new Set<Id>();
        List<BookInWarehouse__c> bookInWarehouseList = new List<BookInWarehouse__c>();
        Map<Id, Decimal> bookOrderLineMap = new Map<Id, Decimal>();
        Map<Id, BookOrder__c> orderUpdates = new Map<Id, BookOrder__c>();

        for (BookOrder__c b : newbookorderlist) {  
            if (b.Status__c == 'Ordered') {
                bookOrderIds.add(b.Id);
            }
        }
		
        for (BookOrderLine__c shippedBookOrderLine : [SELECT Id, BookOrder__c, Quantity__c FROM BookOrderLine__c WHERE BookOrder__c IN :bookOrderIds]) {
            bookOrderLineMap.put(shippedBookOrderLine.BookOrder__c, shippedBookOrderLine.Quantity__c);
        }

        for (BookOrderLine__c newBackorderedBookOrderLine : [SELECT Id, BookOrder__c, Quantity__c, Book__c FROM BookOrderLine__c WHERE BookOrder__c IN :bookOrderIds]) {
            if (processedBookOrderIds.contains(newBackorderedBookOrderLine.BookOrder__c)) {
                continue;
            }

            processedBookOrderIds.add(newBackorderedBookOrderLine.BookOrder__c);
            BookOrder__c bookOrder = new BookOrder__c(Id = newBackorderedBookOrderLine.BookOrder__c);

            if (isQuantityWithinWarehouse(newBackorderedBookOrderLine, bookOrderLineMap)) {
                bookOrder.Status__c = 'Shipped';
                BookInWarehouse__c relatedBookInWarehouse = [SELECT Id, Quantity__c FROM BookInWarehouse__c WHERE Book__c = :newBackorderedBookOrderLine.Book__c LIMIT 1];
                if (relatedBookInWarehouse != null) {
                    bookInWarehouseList.add(new BookInWarehouse__c(
                        Id = relatedBookInWarehouse.Id,
                        Quantity__c = relatedBookInWarehouse.Quantity__c - newBackorderedBookOrderLine.Quantity__c
                    ));
                }
            } else {
                bookOrder.Status__c = 'Backordered';
            }

            orderUpdates.put(bookOrder.Id, bookOrder);
        }

        if (!bookInWarehouseList.isEmpty()) {
            update bookInWarehouseList;
        }

        if (!orderUpdates.isEmpty()) {
            update orderUpdates.values();
        }
    }

    private static Boolean isQuantityWithinWarehouse(BookOrderLine__c orderLine, Map<Id, Decimal> bookOrderLineMap) {
        Decimal requiredQuantity = bookOrderLineMap.get(orderLine.BookOrder__c);
        BookInWarehouse__c warehouse = [SELECT Quantity__c FROM BookInWarehouse__c WHERE Book__c = :orderLine.Book__c LIMIT 1];
        
        Decimal availableQuantity = (warehouse != null) ? warehouse.Quantity__c : 0;
        return requiredQuantity <= availableQuantity;
    }
}