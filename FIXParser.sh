awk -F '|' '{
  for (i=1; i<=NF;i++){
    split($i, tag_value, "="); #Split field into tag and value
    tag = tag_value[1];
    value = tag_value[2];
    # Here you would use the information from the FIX44.xml (loaded into a data structure in awk) to interpret `tag` and `value`
    switch (tag) {
      case 35:
        if (value == 0) print "MsgType: Heartbeat";
        if (value == 8) print "MsgType: ExecutionReport";
        if (value == "A") print "MsgType: Logon";
        if (value == "D") print "MsgType: NewOrderSingle";
        if (value == "F") print "MsgType: OrderCancelRequest";
        if (value == "G") print "MsgType: OrderCancelReplaceRequest";
        if (value == "5") print "MsgType: Logout";
        if (value == "3") print "MsgType: Reject";
        if (value == "Z") print "MsgType: QuoteCancel";
        if (value == "4") print "MsgType: OrderStatusRequest";
        break;
      case 8:
        print "\nFIX Version: " value;
        break;
      case 49:
        print "Source ID: " value;
        break;
      case 56:
        print "Destination ID: " value;
        break;
      default:
        print "Unknown tag: " tag, value;
    }
    # ... Similar Processing for other tag ..
  }
}' input_fix_messages.txt