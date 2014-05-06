import data
into table "FCTCUSTOMERORDER"
from 'FCTCUSTOMERORDER.csv'
    record delimited by '\n'
    field delimited by ','
    optionally enclosed by '"'
error log 'FCTCUSTOMERORDER.err'
