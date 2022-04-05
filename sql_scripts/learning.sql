SELECT 
    *,
    COALESCE(product.name,'[product name not found]'),
    COALESCE(card_name,'[card name not found]')
FROM product
WHERE price IS NOT NULL AND price>50;