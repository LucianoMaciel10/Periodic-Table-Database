# Periodic Table Lookup Script

This script allows you to retrieve information about chemical elements from a PostgreSQL database.

## Usage

To use the script, run the following command:

```bash
./element.sh <element>
```

Where `<element>` can be:
- An atomic number (e.g., `1` for Hydrogen)
- A chemical symbol (e.g., `H` for Hydrogen)
- The full element name (e.g., `Hydrogen`)

## Example Outputs

```bash
./element.sh 1
```
```bash
./element.sh H
```
```bash
./element.sh Hydrogen
```

Each of these commands will return:

```
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
```

## Requirements

- PostgreSQL must be installed and running.
- The database should contain tables for elements, properties, and types.
- The script must have execution permissions. You can set it with:

```bash
chmod +x element.sh
```

## Notes

- If the element is not found in the database, the script will output:
  ```
  I could not find that element in the database.
  ```
- The script queries the database based on atomic number, symbol, or name and retrieves relevant properties.

## License

This script is provided as-is. Feel free to modify and use it as needed.

