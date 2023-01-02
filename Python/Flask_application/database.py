from flask import g
import sqlite3

# Connect to the database
def connect_to_database():
    sql = sqlite3.connect('/home/ndomi/Documents/DevOps/Python/Flask_application/crudapplication.db')
    sql.row_factory = sqlite3.Row
    
    return sql


# Return to the database
def get_database():
    if not hasattr(g, 'crudapplication_db'):
        g.crudapplication_db = connect_to_database()
        
    return g.crudapplication_db