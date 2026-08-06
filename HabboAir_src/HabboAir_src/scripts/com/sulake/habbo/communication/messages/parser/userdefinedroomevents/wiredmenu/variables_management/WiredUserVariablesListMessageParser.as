package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredUserVariablesListMessageParser implements IMessageParser
   {
      private var _page:WiredUserVariablesPage;
      
      public function WiredUserVariablesListMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _page = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _page = new WiredUserVariablesPage(param1);
         return true;
      }
      
      public function get page() : WiredUserVariablesPage
      {
         return _page;
      }
   }
}

