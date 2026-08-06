package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   
   [SecureSWF(rename="true")]
   public class ObjectDataUpdateMessageParser implements IMessageParser
   {
      private var _id:int = 0;
      
      private var _state:int = 0;
      
      private var _data:IStuffData;
      
      public function ObjectDataUpdateMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get data() : IStuffData
      {
         return _data;
      }
      
      public function flush() : Boolean
      {
         _state = 0;
         _data = new LegacyStuffData() as IStuffData;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:String = param1.readString();
         _id = int(_loc3_);
         _data = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
         var _loc2_:Number = parseFloat(_data.getLegacyString());
         if(!isNaN(_loc2_))
         {
            _state = int(_data.getLegacyString());
         }
         return true;
      }
   }
}

