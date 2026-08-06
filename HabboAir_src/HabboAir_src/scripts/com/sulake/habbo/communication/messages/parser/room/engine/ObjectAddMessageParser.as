package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   
   [SecureSWF(rename="true")]
   public class ObjectAddMessageParser implements IMessageParser
   {
      private var UnknownVarFromObjectAddMessageParser_ObjectMessageData_1:ObjectMessageData;
      
      public function ObjectAddMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromObjectAddMessageParser_ObjectMessageData_1 = null;
         return true;
      }
      
      public function get data() : ObjectMessageData
      {
         var _loc1_:ObjectMessageData = UnknownVarFromObjectAddMessageParser_ObjectMessageData_1;
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
         UnknownVarFromObjectAddMessageParser_ObjectMessageData_1 = UnknownHabboCommunicationMessagesParserRoomEngine1.parseObjectData(param1);
         UnknownVarFromObjectAddMessageParser_ObjectMessageData_1.ownerName = param1.readString();
         return true;
      }
   }
}

