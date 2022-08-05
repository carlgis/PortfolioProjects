SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
ORDER BY PO_NUMBER

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE INVOICE_ITEM_ID IS NOT NULL

--invoice item id is completely null--

ALTER TABLE [Portfolio Projects]..[Miami Dade POs 2022] DROP COLUMN invoice_item_id

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
ORDER BY PO_NUMBER


--correct supplier short name--

SELECT count(*)
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE Supplier_short_name is NULL

--records where supplier short name is null--

SELECT count(*)
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__')

--records where supplier short name does not match naming convention--

SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME, SUPPLIER_ADDRESS2, COUNTY, SUPPLIER_PHONE_TYPE
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__')

-- looking through the records its apparent that the supplier short name was entered into the wrong column for the majority of them--

UPDATE [Portfolio Projects]..[Miami Dade POs 2022]
SET SUPPLIER_SHORT_NAME = COUNTY
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__') AND COUNTY LIKE ('%-0__')



SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME, SUPPLIER_ADDRESS2, COUNTY, SUPPLIER_PHONE_TYPE
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__')


UPDATE [Portfolio Projects]..[Miami Dade POs 2022]
SET SUPPLIER_SHORT_NAME = SUPPLIER_PHONE_TYPE
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__') AND SUPPLIER_PHONE_TYPE LIKE ('%-0__')



SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME, SUPPLIER_ADDRESS2, COUNTY, SUPPLIER_PHONE_TYPE
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__')

SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE PO_NUMBER IN(1493, 6966)
ORDER BY 1

UPDATE [Portfolio Projects]..[Miami Dade POs 2022]
SET SUPPLIER_SHORT_NAME = 'F S D GROU-001'
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__') AND PO_NUMBER = 1493 AND SUPPLIER_NAME = 'F S D GROUP LLC'

SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE PO_NUMBER = 6966
ORDER BY 3

UPDATE [Portfolio Projects]..[Miami Dade POs 2022]
SET SUPPLIER_SHORT_NAME = 'PARAMOUNT-004'
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__') AND PO_NUMBER = 6966 AND SUPPLIER_NAME = 'PARAMOUNT ELECTRIC & LIGHTING INC'

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE('%-0__')

-- addressing null values in supplier short name--

SELECT PO_NUMBER, SUPPLIER_NAME, SUPPLIER_SHORT_NAME
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE Supplier_short_name is NULL

--creating a view with all the correct supplier names and short names to join to the main table--
CREATE VIEW supplier_view
AS(SELECT DISTINCT(SUPPLIER_NAME), SUPPLIER_SHORT_NAME
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME IS NOT NULL AND SUPPLIER_SHORT_NAME NOT LIKE('%PART%'))


SELECT DISTINCT(m.supplier_name), m.SUPPLIER_SHORT_NAME, sup.SUPPLIER_NAME, sup.SUPPLIER_SHORT_NAME
FROM [Portfolio Projects]..[Miami Dade POs 2022] m
INNER JOIN supplier_view sup on m.SUPPLIER_NAME = sup.SUPPLIER_NAME

UPDATE m
SET m.SUPPLIER_SHORT_NAME = sup.supplier_short_name
FROM [Portfolio Projects]..[Miami Dade POs 2022] as m
INNER JOIN supplier_view  as sup
ON m.SUPPLIER_NAME= sup.supplier_name

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME IS NULL

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE SUPPLIER_SHORT_NAME NOT LIKE ('%-0__%')

-- in retrospect updating and joining the table to the view would have solved both the instances where supplier short name was null wasn't the proper naming convention--

--coverting po_date from string to datetime--

SELECT PO_NUMBER, PO_DATE
FROM [Portfolio Projects]..[Miami Dade POs 2022]

--PO date is yyyymmdd--


SELECT PO_NUMBER, PARSE(po_date as date) as PO_DATE_trunc
FROM [Portfolio Projects]..[Miami Dade POs 2022]

ALTER TABLE [Portfolio Projects]..[Miami Dade POs 2022]
ADD PO_DATE_TRUNC date

UPDATE [Portfolio Projects]..[Miami Dade POs 2022]
SET PO_DATE_TRUNC = PARSE(po_date as date)

SELECT PO_NUMBER, PO_DATE, PO_DATE_TRUNC
FROM [Portfolio Projects]..[Miami Dade POs 2022]

ALTER TABLE [Portfolio Projects]..[Miami Dade POs 2022]
DROP COLUMN PO_DATE

-- fixing business unit nulls--

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE BUSINESS_UNIT IS NULL

SELECT *
FROM [Portfolio Projects]..[Miami Dade POs 2022]
WHERE BUSINESS_UNIT = 'PR33020100'
