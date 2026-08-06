package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
   
   [SecureSWF(rename="true")]
   public class ItemUpdateMessageParser implements IMessageParser
   {
      private var UnknownVarFromItemUpdateMessageParser_ItemMessageData_1:ItemMessageData = null;
      
      public function ItemUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromItemUpdateMessageParser_ItemMessageData_1 = null;
         return true;
      }
      
      public function get data() : ItemMessageData
      {
         var _loc1_:ItemMessageData = UnknownVarFromItemUpdateMessageParser_ItemMessageData_1;
         if(_loc1_ != null)
         {
            _loc1_.setReadOnly();
         }
         return _loc1_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         UnknownVarFromItemUpdateMessageParser_ItemMessageData_1 = UnknownHabboCommunicationMessagesParserRoomEngine2.parseItemData(param1);
         return true;
      }
   }
}

