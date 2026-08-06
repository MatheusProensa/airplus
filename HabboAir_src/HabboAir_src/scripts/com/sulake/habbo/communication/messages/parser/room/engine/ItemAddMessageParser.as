package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ItemMessageData;
   
   [SecureSWF(rename="true")]
   public class ItemAddMessageParser implements IMessageParser
   {
      private var UnknownVarFromItemAddMessageParser_ItemMessageData_1:ItemMessageData = null;
      
      public function ItemAddMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromItemAddMessageParser_ItemMessageData_1 = null;
         return true;
      }
      
      public function get data() : ItemMessageData
      {
         var _loc1_:ItemMessageData = UnknownVarFromItemAddMessageParser_ItemMessageData_1;
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
         UnknownVarFromItemAddMessageParser_ItemMessageData_1 = UnknownHabboCommunicationMessagesParserRoomEngine2.parseItemData(param1);
         UnknownVarFromItemAddMessageParser_ItemMessageData_1.ownerName = param1.readString();
         return true;
      }
   }
}

