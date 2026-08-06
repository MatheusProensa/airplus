package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.TradeRequirement;
   
   [SecureSWF(rename="true")]
   public class WiredTradeInitiateMessageParser implements IMessageParser
   {
      private var _requirement:TradeRequirement;
      
      private var _showRequirementsImmediate:Boolean;
      
      private var _overridePreviousTrade:Boolean;
      
      private var _timeoutSeconds:int;
      
      public function WiredTradeInitiateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _requirement = null;
         _showRequirementsImmediate = false;
         _overridePreviousTrade = false;
         _timeoutSeconds = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requirement = new TradeRequirement(param1);
         _showRequirementsImmediate = param1.readBoolean();
         _overridePreviousTrade = param1.readBoolean();
         _timeoutSeconds = param1.readInteger();
         return true;
      }
      
      public function get requirement() : TradeRequirement
      {
         return _requirement;
      }
      
      public function get showRequirementsImmediate() : Boolean
      {
         return _showRequirementsImmediate;
      }
      
      public function get overridePreviousTrade() : Boolean
      {
         return _overridePreviousTrade;
      }
      
      public function get timeoutSeconds() : int
      {
         return _timeoutSeconds;
      }
   }
}

