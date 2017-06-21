const avro = require('avsc');

const newOrderSingleType = avro.parse(
    "./NewOrderSingle.avsc"
)


console.log("Schema Type",newOrderSingleType);
const buffer = newOrderSingleType.toBuffer(
{
    account:"DD",
    clOrdID:"OneTwoThree",
    symbol:"MSFT.OQ",
    ordType:"LIMIT",
    side:"0",
    commission:1,
    currency:0.89,
    commType:"A",
    transactTime:"2017-02-01T13:01:01Z"
});

console.log("Buffer",buffer)

const deserialize = newOrderSingleType.fromBuffer(buffer);
console.log("FromBuffer",deserialize);