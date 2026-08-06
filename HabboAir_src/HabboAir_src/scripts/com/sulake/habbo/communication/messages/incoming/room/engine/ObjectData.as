package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   
   [SecureSWF(rename="true")]
   public class ObjectData
   {
      private var _id:int = 0;
      
      private var _state:int = 0;
      
      private var _data:IStuffData = new LegacyStuffData();
      
      public function ObjectData(param1:int, param2:int, param3:IStuffData)
      {
         super();
         _id = param1;
         _state = param2;
         _data = param3;
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
   }
}

