package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectMessageData;
   
   [SecureSWF(rename="true")]
   public class ObjectsMessageParser implements IMessageParser
   {
      private var UnknownVarFromObjectsMessageParser_Array_1:Array = [];
      
      public function ObjectsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         UnknownVarFromObjectsMessageParser_Array_1 = [];
         return true;
      }
      
      public function getObjectCount() : int
      {
         return UnknownVarFromObjectsMessageParser_Array_1.length;
      }
      
      public function getObject(param1:int) : ObjectMessageData
      {
         if(param1 < 0 || param1 >= getObjectCount())
         {
            return null;
         }
         var _loc2_:ObjectMessageData = UnknownVarFromObjectsMessageParser_Array_1[param1] as ObjectMessageData;
         if(_loc2_ != null)
         {
            _loc2_.setReadOnly();
         }
         return _loc2_;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc8_:ObjectMessageData = null;
         if(param1 == null)
         {
            return false;
         }
         UnknownVarFromObjectsMessageParser_Array_1 = [];
         var _loc5_:Map = new Map();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = param1.readInteger();
            _loc2_ = param1.readString();
            _loc5_.add(_loc6_,_loc2_);
            _loc4_++;
         }
         var _loc7_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            _loc8_ = UnknownHabboCommunicationMessagesParserRoomEngine1.parseObjectData(param1);
            if(_loc8_ != null)
            {
               _loc8_.ownerName = _loc5_.getValue(_loc8_.ownerId);
               UnknownVarFromObjectsMessageParser_Array_1.push(_loc8_);
            }
            _loc4_++;
         }
         return true;
      }
   }
}

