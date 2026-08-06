package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredObjectInspectionData;
   
   public class WiredVariablesForObjectMessageParser implements IMessageParser
   {
      private var _data:WiredObjectInspectionData;
      
      public function WiredVariablesForObjectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new WiredObjectInspectionData(param1);
         return true;
      }
      
      public function get data() : WiredObjectInspectionData
      {
         return _data;
      }
   }
}

