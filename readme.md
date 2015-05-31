#Description
## A command line tool that issues a query on Treasure Data using the Ruby Client. Queries user-specified database and table to retrieve the values of a specified set of columns in a specified date/time range.

#Usage
## set your TREASURE_DATA_API_KEY="your-master-key"

#Example
###$ query -f csv -e hive -c 'my_col1,my_col2,my_col5' -m 1427347140 -M 1427350725 my_db my_table
##where:
###-f / --format is optional and specifies the output format: tabular by default
###-c / --column is optional and specifies the comma separated list of columns: 'SELECT *' if not specified
###-m / --min is optional and specifies the minimum timestamp: NULL by default
###-M / --MAX is optional and specifies the maximum timestamp: NULL by default
###-e / --engine is optional and specifies the query engine: 'hive' by default


