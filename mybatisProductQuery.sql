SELECT p.price
  FROM product p
 WHERE p.price
;

SELECT MAX(p.price)
  FROM product p
;

SELECT MAX(p.quantity)
  FROM product p 
;

SELECT p.code
     , p.name
     , p.price
     , p.quantity
     , p.reg_date
     , p.mod_date
  FROM product p
 WHERE p.price >= ( SELECT MAX(p.price)
                      FROM product p)
;