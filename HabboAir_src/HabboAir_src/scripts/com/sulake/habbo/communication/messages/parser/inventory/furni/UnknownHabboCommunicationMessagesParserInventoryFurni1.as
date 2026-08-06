package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
   
   [SecureSWF(rename="true")]
   public class UnknownHabboCommunicationMessagesParserInventoryFurni1 implements IMessageParser
   {
      protected var _furni:Vector.<FurniData>;
      
      public function UnknownHabboCommunicationMessagesParserInventoryFurni1()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _furni = new Vector.<FurniData>(0);
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _furni.push(new FurniData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _furni = null;
         return true;
      }
      
      public function getFurni() : Vector.<FurniData>
      {
         return _furni;
      }
   }
}

