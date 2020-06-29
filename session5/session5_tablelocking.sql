USE parts;
SHOW TABLES;

# Place a READ lock
LOCK TABLE part READ;

# Unlock table
UNLOCK TABLE;

# Place a WRITE lock
LOCK TABLE supply WRITE;

# Unlock table
UNLOCK TABLE;

# Place a READ and WRITE lock
LOCK TABLES part READ, supplier WRITE;

# Unlock both tables
UNLOCK TABLES;