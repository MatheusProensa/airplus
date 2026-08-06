package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class UserChatlogData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      private var _rooms:Array;
      
      public function UserChatlogData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _rooms = [];
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _rooms.push(new ChatRecordData(param1));
            _loc3_++;
         }
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get rooms() : Array
      {
         return _rooms;
      }
   }
}

