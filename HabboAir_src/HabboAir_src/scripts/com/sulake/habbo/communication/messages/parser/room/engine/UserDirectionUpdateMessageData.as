package com.sulake.habbo.communication.messages.parser.room.engine
{
   [SecureSWF(rename="true")]
   public class UserDirectionUpdateMessageData
   {
      private var _userIndex:int;
      
      private var _bodyDirection:Number;
      
      private var _headDirection:Number;
      
      public function UserDirectionUpdateMessageData(param1:int, param2:Number, param3:Number)
      {
         super();
         _userIndex = param1;
         _bodyDirection = param2;
         _headDirection = param3;
      }
      
      public function get userIndex() : int
      {
         return _userIndex;
      }
      
      public function get bodyDirection() : Number
      {
         return _bodyDirection;
      }
      
      public function get headDirection() : Number
      {
         return _headDirection;
      }
   }
}

