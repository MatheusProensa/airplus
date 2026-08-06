package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   
   [SecureSWF(rename="true")]
   public class ObjectUpdateMessageParser implements IMessageParser
   {
      private var UnknownVarFromObjectUpdateMessageParser_ObjectMessageData_1:ObjectMessageData = null;
      
      public function ObjectUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromObjectUpdateMessageParser_ObjectMessageData_1 = null;
         return true;
      }
      
      public function get data() : ObjectMessageData
      {
         var _loc1_:ObjectMessageData = UnknownVarFromObjectUpdateMessageParser_ObjectMessageData_1;
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
         UnknownVarFromObjectUpdateMessageParser_ObjectMessageData_1 = UnknownHabboCommunicationMessagesParserRoomEngine1.parseObjectData(param1);
         return true;
      }
   }
}

