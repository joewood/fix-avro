import quickfix.DataDictionary;
import quickfix.DataDictionary.Exception;
import quickfix.DataDictionary.GroupInfo;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.IntStream;
import java.util.Map;
import java.util.HashMap;
/*
 * This Java source file was generated by the Gradle 'init' task.
 */
public class App {

    public static boolean isArray(String fixType) {
        if (fixType == "MULTIPLEVALUESTRING")
            return true;
        return false;
    }

    public static String decodeType(String fixType) {
        switch (fixType) {
        case "PERCENTAGE":
        case "CURRENCY":
        case "FLOAT":
        case "PRICEOFFSET":
        case "QTY":
        case "PRICE":
        case "AMT":
            return "double";
        case "INT":
        case "LENGTH":
            return "long";
        case "BOOLEAN":
            return "boolean";
        case "UTCTIMESTAMP":
        case "LOCALMKTDATE":
            return "string";
        case "DATA":
            return "bytes";
        case "STRING":
        case "CHAR":
        case "MONTHYEAR":
        case "COUNTRY":
        case "MULTIPLEVALUESTRING":
            return "string";
        default:
            return "#ERR " + fixType;
        }
    }

    public static String getTabs(int indent) {
        StringBuilder sb = new StringBuilder();
        for(int n=0;n<indent; n++) {
            sb.append("\t");
        }
        return sb.toString();
    }

    public static String fieldLine(String fieldName, String fieldType, boolean optional, boolean array) {
        ArrayList<String> fields = new ArrayList<>();
        fields.add("\"name\": \"" + fieldName.charAt(0) + fieldName.substring(1) + "\" ");
        String type = (fieldType.charAt(0)=='{') ? fieldType :( "\"" + decodeType(fieldType) + "\"");
        if (array) {
            fields.add("\"items\": " + type);
            type = "\"array\"";
        }
        if (optional) {
            type = "[ null, " + type + " ]";
        }
        fields.add("\"type\": " + type);
        return "{ " + String.join(", ", fields) + " }";
    }

    private static java.util.List<String> createType(String name, quickfix.DataDictionary dict, int[] fields,
            String messageId, HashMap<String, String> typeCache,int indent) {
        java.util.List<String> output = new java.util.LinkedList<>();
        java.util.List<String> dependencies = new java.util.LinkedList<>();
        for (int i : fields) {
            String fieldName = dict.getFieldName(i);
            // int fieldType = dict.getFieldType(i);
            Boolean required = dict.isRequiredField(messageId, i);
            quickfix.FieldType ee = dict.getFieldTypeEnum(i);

            Boolean group = dict.isGroup("D", i);
            String fieldTypeName = ee == null ? "UNKNOWN" : ee.getName();
            boolean isArrayField = isArray(fieldTypeName);
            if (group) {
                GroupInfo groupInfo = dict.getGroup("D", i);
                fieldTypeName = fieldName + ee.getName();
                if (!typeCache.containsKey(fieldTypeName)) {
                    DataDictionary ddd = groupInfo.getDataDictionary();
                    String typeDef = String.join(",",createType(fieldTypeName, dict, ddd.getOrderedFields(), messageId, typeCache,indent+2));
                    typeCache.put(fieldTypeName, typeDef);
                    fieldTypeName = typeDef;
                }
            }
            String fieldLineDef = fieldLine(fieldName, fieldTypeName, !required, group || isArrayField);
            output.add(getTabs(indent+1)+fieldLineDef);
        }
    
        dependencies.add("{\n"+getTabs(indent)+"\"type\": \"record\",\n"+getTabs(indent)+"\"name\": \"" + name + "\",\n"+getTabs(indent)+"\"fields\": [\n"
                + String.join(",\n", output) + "\n"+getTabs(indent)+"]\n"+getTabs(indent-1)+"}");

        return dependencies;
    }

    public static void main(String[] args) {
        try {
            if (args.length == 0 || args[0] == "--help") {
                System.out.println("Use fix-avro <message-name> [FIX44|FIX50]");
                return;
            }
            final String vers = (args.length > 1) ? args[1] : "FIX50";
            final String messageName = args[0];
            quickfix.DataDictionary dict = new DataDictionary(vers + ".xml");
            HashMap<String, String> typeCache = new HashMap<>();
            final String messageId = dict.getMsgType(messageName);
            // quickfix.fix50sp2.NewOrderSingle dd = new quickfix.fix50sp2.NewOrderSingle();
            IntStream orderedFields = IntStream.of(dict.getOrderedFields());
            int[] filtered = orderedFields.filter(i -> dict.isMsgField(messageId, i)).toArray();

            List<String> output = createType(messageName, dict, filtered, messageId, typeCache,1);
            System.out.println(String.join(",\n", output));
        } catch (quickfix.ConfigError e) {
            System.out.format("Error " + e.getMessage());
        }

    }
}
