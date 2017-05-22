# FIX to Avro

Simple utility that creates an Avro Record Type for the supplied FIX message name and version.

## Usage

```
java -jar build/libs/fix-avro-all.jar NewOrderSingle FIX44 > NewOrderSingle.avsc
```

## Tests

A simple test using node.js is in the **test** directory. To run the test, after installing node.js:

```
cd test
npm i
node test.js
```

## Notes and To-Do

For example output check the test directory. Quick summary of dependencies and left to do:

* **fix-avro** currently uses the `DataDictionary` from QuickFixJ to create the schema
* Entire implementation is in **App.java**
* The FIX tag and type is generated as additional metadata on each field
* No support currently for custom field tags (this can be added to QuickFixJ)
* QuickFixJ has limited support for FIX schema data, the following features are missing:
  * Sub-record types are created using the field name and not the Repeating Group Name
  * Enumerated Types are currently unsupported
  * No schema documentation / comments are generated (they're not available in the DataDictionary in QuickFix)
  * No guarantees on field ordering for evolving schemas as QuickFixJ doesn't provide the Extension Pack that a field was added

The code will be migrated over to use the FIX Schema Repository in the near future to address these deficiencies.
