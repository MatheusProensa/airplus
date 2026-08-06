package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredUserPermanentVariablesMessageParser implements IMessageParser
   {
      private var _list:WiredUserPermanentVariablesList;
      
      public function WiredUserPermanentVariablesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _list = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _list = new WiredUserPermanentVariablesList(param1);
         return true;
      }
      
      public function get list() : WiredUserPermanentVariablesList
      {
         return _list;
      }
   }
}

