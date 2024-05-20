public class BookOrdersHandlerTrigger {
    public static void handleAfterUpdate(List<BookOrder__c> newbookorderlist) {
        Map<Id, BookOrder__c> uniqueBookOrders = new Map<Id, BookOrder__c>();
        List<BookInWarehouse__c> bookInWarehouseListToUpdate = new List<BookInWarehouse__c>();
        List<BookOrder__c> orderUpdatesToUpdate = new List<BookOrder__c>();
        Map<Id, Decimal> bookOrderLineMap = new Map<Id, Decimal>();

        for (BookOrder__c b : newbookorderlist) {
            if (b.Status__c == 'Ordered') {
                uniqueBookOrders.put(b.Id, b);
            }
        }

        for (BookOrderLine__c shippedBookOrderLine : [SELECT Id, BookOrder__c, Quantity__c FROM BookOrderLine__c WHERE BookOrder__c IN :uniqueBookOrders.keySet()]) {
            bookOrderLineMap.put(shippedBookOrderLine.BookOrder__c, shippedBookOrderLine.Quantity__c);
        }

        List<BookOrderLine__c> backorderedBookOrderLines = [SELECT Id, BookOrder__c, Quantity__c, Book__c FROM BookOrderLine__c WHERE BookOrder__c IN :uniqueBookOrders.keySet()];
        Map<Id, Decimal> newBackorderedQuantityMap = new Map<Id, Decimal>();

        for (BookOrderLine__c newBackorderedBookOrderLine : backorderedBookOrderLines) {
            if (!newBackorderedQuantityMap.containsKey(newBackorderedBookOrderLine.BookOrder__c)) {
                if (isQuantityWithinWarehouse(newBackorderedBookOrderLine, bookOrderLineMap)) {
                    newBackorderedQuantityMap.put(newBackorderedBookOrderLine.BookOrder__c, newBackorderedBookOrderLine.Quantity__c);
                }
            }
        }

        for (BookOrderLine__c newBackorderedBookOrderLine : backorderedBookOrderLines) {
            BookOrder__c bookOrder = new BookOrder__c(Id = newBackorderedBookOrderLine.BookOrder__c);

            if (newBackorderedQuantityMap.containsKey(newBackorderedBookOrderLine.BookOrder__c)) {
                bookOrder.Status__c = 'Shipped';
                BookInWarehouse__c relatedBookInWarehouse = getRelatedBookInWarehouse(newBackorderedBookOrderLine.Book__c);
                if (relatedBookInWarehouse != null) {
                    bookInWarehouseListToUpdate.add(new BookInWarehouse__c(
                        Id = relatedBookInWarehouse.Id,
                        Quantity__c = relatedBookInWarehouse.Quantity__c - newBackorderedQuantityMap.get(newBackorderedBookOrderLine.BookOrder__c)
                    ));
                }
            } else {
                bookOrder.Status__c = 'Backordered';
            }

            orderUpdatesToUpdate.add(bookOrder);
        }

        if (!bookInWarehouseListToUpdate.isEmpty()) {
            update bookInWarehouseListToUpdate;
        }

        if (!orderUpdatesToUpdate.isEmpty()) {
            update orderUpdatesToUpdate;
        }
    }

    private static Boolean isQuantityWithinWarehouse(BookOrderLine__c orderLine, Map<Id, Decimal> bookOrderLineMap) {
        Decimal requiredQuantity = bookOrderLineMap.get(orderLine.BookOrder__c);
        BookInWarehouse__c warehouse = getRelatedBookInWarehouse(orderLine.Book__c);
        
        Decimal availableQuantity = (warehouse != null) ? warehouse.Quantity__c : 0;
        return requiredQuantity <= availableQuantity;
    }

    private static BookInWarehouse__c getRelatedBookInWarehouse(Id bookId) {
        List<BookInWarehouse__c> warehouses = [SELECT Id, Quantity__c FROM BookInWarehouse__c WHERE Book__c = :bookId LIMIT 1];
        return (warehouses.isEmpty()) ? null : warehouses[0];
    }
}